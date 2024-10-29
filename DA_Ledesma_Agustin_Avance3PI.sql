--Nos posicionamos en la base de datos para empezar a trabajar

USE FastFoodDB;

/*Total de ventas globales
1Pregunta: �Cu�l es el total de ventas (TotalCompra) a nivel global?*/

SELECT SUM(TotalCompra) TotalVentasGlobal
FROM Ordenes;


/*Promedio de precios de productos por categor�a
2Pregunta: �Cu�l es el precio promedio de los productos dentro de cada categor�a?*/

SELECT CategoriaID,
	FORMAT(AVG(Precio), '0.00') PrecioPromedio
FROM Productos
GROUP BY CategoriaID;

/*Orden m�nima y m�xima por sucursal
3Pregunta: �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?*/
 
SELECT SucursalID,
	MIN(TotalCompra) OrdenMin,
	MAX(TotalCompra) OrdenMax
FROM Ordenes
GROUP BY SucursalID;

/*Mayor n�mero de kil�metros recorridos para entrega
4Pregunta: �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?*/
 
SELECT MAX(KilometrosRecorrer) MayorKilometrosRecorridos
FROM Ordenes;

/*Promedio de cantidad de productos por orden
5Pregunta: �Cu�l es la cantidad promedio de productos por orden?*/

SELECT OrdenID, 
	AVG(Cantidad) PromedioProductosPorOrden
FROM DetalleOrdenes
GROUP BY OrdenID;

/*Total de ventas por tipo de pago
6Pregunta: �Cu�l es el total de ventas por cada tipo de pago?*/

SELECT TipoPagoID, 
	SUM(TotalCompra) TotalVenta
FROM Ordenes
GROUP BY TipoPagoID;

/*Sucursal con la venta promedio m�s alta
7Pregunta: �Cu�l sucursal tiene la venta promedio m�s alta?*/

SELECT TOP 1 SucursalID,
	FORMAT(AVG(TotalCompra),'0.00') PromedioVenta
FROM Ordenes
GROUP BY SucursalID
ORDER BY AVG(TotalCompra)DESC;

/*Sucursal con la mayor cantidad de ventas por encima de un umbral
8Pregunta: �Cu�les son las sucursales que han generado ventas por orden por encima de $50?*/

SELECT SucursalID,  
	SUM(TotalCompra) TotalVentas
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 50
ORDER BY TotalVentas DESC

/*Comparaci�n de ventas promedio antes y despu�s de una fecha espec�fica
9Pregunta: �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?*/

SELECT 'Antes del 1 de julio de 2023' Periodo,
	CAST(AVG(TotalCompra)AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada < '2023-07-01'
UNION
SELECT 'Despues del 1 de julio de 2023' Periodo,
	CAST(AVG(TotalCompra)AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada > '2023-07-01';

/*An�lisis de actividad de ventas por horario
10Pregunta: �Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas, cu�l es el valor promedio de estas ventas,
y cu�l ha sido la venta m�xima alcanzada?*/

SELECT HorarioVenta,
	COUNT(*) CantidadVentas, 
	CAST(AVG(TotalCompra) AS DECIMAL(10,2))PromedioVentas, 
	MAX(TotalCompra) MaxVentaAlcanzada
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY COUNT(*) desc