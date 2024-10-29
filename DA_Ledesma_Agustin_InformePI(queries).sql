USE FastFoodDB;

/*¿Cuál es el tiempo promedio desde el despacho 
hasta la entrega de los pedidos por los 
mensajeros?
*/

SELECT AVG(DATEDIFF (MINUTE, FechaDespacho, FechaEntrega))  PromedioTiempoEntrega 
FROM Ordenes
WHERE mensajeroID is not null;


 --¿Qué canal de ventas genera más ingresos?

SELECT TOP 1 OO.Descripcion Canal, SUM(O.TotalCompra) TotalVenta
FROM Ordenes O
INNER JOIN OrigenesOrden OO ON(O.OrigenID = OO.OrigenID)
GROUP BY OO.Descripcion
ORDER BY TotalVenta DESC;
;


/*¿Cuál es el volumen de ventas promedio 
gestionado por empleado?
*/

SELECT E.Nombre Empleado, CAST(AVG(TotalCompra) AS DECIMAL (10,2)) VolumenVentaPromedio
FROM Ordenes O
INNER JOIN Empleados E ON (O.EmpleadoID=E.EmpleadoID)
GROUP BY E.Nombre
ORDER BY VolumenVentaPromedio DESC;
;

/* ¿Cómo varía la demanda de productos a lo 
largo del día?
*/

SELECT O.HorarioVenta Horario, P.Nombre Producto, SUM(DO.Cantidad) Demanda
FROM Ordenes O
INNER JOIN DetalleOrdenes DO on (O.OrdenID = DO.OrdenID)
INNER JOIN Productos P ON (DO.ProductoID = P.ProductoID)
GROUP BY O.HorarioVenta, P.Nombre
ORDER BY O.HorarioVenta, Demanda DESC;
;


/* ¿Cómo se comparan las ventas mensuales 
de este año con el año anterior?
*/

SELECT YEAR(FechaOrdenTomada) 'Año', MONTH (FechaOrdenTomada) Mes,
 SUM (TotalCompra) Venta
FROM Ordenes
WHERE YEAR (FechaOrdenTomada) >= 2023 and YEAR (FechaOrdenTomada) <= 2024
GROUP BY YEAR (FechaOrdenTomada), MONTH (FechaOrdenTomada)
ORDER BY Venta DESC;


/* ¿Qué porcentaje de clientes son recurrentes 
versus nuevos clientes cada mes?
*/


SELECT C.Nombre, COUNT(*) NumeroOrdenes
FROM Ordenes O
INNER JOIN Clientes C ON (O.ClienteID = C.ClienteID)
GROUP BY C.Nombre
ORDER BY NumeroOrdenes DESC;