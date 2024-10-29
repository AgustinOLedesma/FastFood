--Nos posicionamos en la base de datos para empezar a trabajar

USE FastFoodDB;

/*Total de ventas globales
1Pregunta: ¿Cuál es el total de ventas (TotalCompra) a nivel global?*/

SELECT SUM(TotalCompra) TotalVentasGlobal
FROM Ordenes;


/*Promedio de precios de productos por categoría
2Pregunta: ¿Cuál es el precio promedio de los productos dentro de cada categoría?*/

SELECT CategoriaID,
	FORMAT(AVG(Precio), '0.00') PrecioPromedio
FROM Productos
GROUP BY CategoriaID;

/*Orden mínima y máxima por sucursal
3Pregunta: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?*/
 
SELECT SucursalID,
	MIN(TotalCompra) OrdenMin,
	MAX(TotalCompra) OrdenMax
FROM Ordenes
GROUP BY SucursalID;

/*Mayor número de kilómetros recorridos para entrega
4Pregunta: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?*/
 
SELECT MAX(KilometrosRecorrer) MayorKilometrosRecorridos
FROM Ordenes;

/*Promedio de cantidad de productos por orden
5Pregunta: ¿Cuál es la cantidad promedio de productos por orden?*/

SELECT OrdenID, 
	AVG(Cantidad) PromedioProductosPorOrden
FROM DetalleOrdenes
GROUP BY OrdenID;

/*Total de ventas por tipo de pago
6Pregunta: ¿Cuál es el total de ventas por cada tipo de pago?*/

SELECT TipoPagoID, 
	SUM(TotalCompra) TotalVenta
FROM Ordenes
GROUP BY TipoPagoID;

/*Sucursal con la venta promedio más alta
7Pregunta: ¿Cuál sucursal tiene la venta promedio más alta?*/

SELECT TOP 1 SucursalID,
	FORMAT(AVG(TotalCompra),'0.00') PromedioVenta
FROM Ordenes
GROUP BY SucursalID
ORDER BY AVG(TotalCompra)DESC;

/*Sucursal con la mayor cantidad de ventas por encima de un umbral
8Pregunta: ¿Cuáles son las sucursales que han generado ventas por orden por encima de $50?*/

SELECT SucursalID,  
	SUM(TotalCompra) TotalVentas
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 50
ORDER BY TotalVentas DESC

/*Comparación de ventas promedio antes y después de una fecha específica
9Pregunta: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?*/

SELECT 'Antes del 1 de julio de 2023' Periodo,
	CAST(AVG(TotalCompra)AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada < '2023-07-01'
UNION
SELECT 'Despues del 1 de julio de 2023' Periodo,
	CAST(AVG(TotalCompra)AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada > '2023-07-01';

/*Análisis de actividad de ventas por horario
10Pregunta: ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, cuál es el valor promedio de estas ventas,
y cuál ha sido la venta máxima alcanzada?*/

SELECT HorarioVenta,
	COUNT(*) CantidadVentas, 
	CAST(AVG(TotalCompra) AS DECIMAL(10,2))PromedioVentas, 
	MAX(TotalCompra) MaxVentaAlcanzada
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY COUNT(*) desc