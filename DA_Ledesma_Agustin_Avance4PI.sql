--nos posicionamos en la base de datos que vamos a utilizar

USE FastFoodDB

/*Listar todos los productos y sus categor�as
1Pregunta: �C�mo puedo obtener una lista de todos los productos junto con sus categor�as?*/

SELECT P.Nombre Producto, C.Nombre Categoria
FROM Productos P
INNER JOIN Categorias C ON (P.CategoriaID = C.CategoriaID);

/*Obtener empleados y su sucursal asignada
2Pregunta: �C�mo puedo saber a qu� sucursal est� asignado cada empleado?*/

SELECT E.Nombre Empleado, S.Nombre Sucursal
FROM Empleados E
INNER JOIN Sucursales S
ON (E.SucursalID = S.SucursalID)

/*Identificar productos sin categor�a asignada
3Pregunta: �Existen productos que no tienen una categor�a asignada?*/

SELECT P.Nombre Producto, C.Nombre Categoria
FROM Productos P
LEFT JOIN Categorias C
ON (P.CategoriaID = C.CategoriaID)--HASTA ACA PODEMOS VER TODOS LOS PRODUCTOS CON SUS CATEGORIAS
WHERE C.Nombre IS NULL /*Sumandole 'WHERE' muestra los productos en los que la categoria sea null
pero como no hay productos sin categoria no nos arroja resultado alguno*/


/*Detalle completo de �rdenes
4Pregunta: �C�mo puedo obtener un detalle completo de las �rdenes, incluyendo cliente, 
empleado que tom� la orden, y el mensajero que la entreg�?*/

SELECT O.OrdenID, C.Nombre Cliente, E.Nombre Empleado, M.Nombre
FROM Ordenes O
INNER JOIN Clientes C ON (O.ClienteID = C.ClienteID)
INNER JOIN Empleados E ON (O.EmpleadoID = E.EmpleadoID)
LEFT JOIN Mensajeros M ON (O.MensajeroID = M.MensajeroID)

/*Productos vendidos por sucursal
5Pregunta: �Cu�ntos productos de cada tipo se han vendido en cada sucursal? */

SELECT O.OrdenID,--Colocamos la ordenid solo para curiosiar a que orden pertenece 
	S.Nombre Sucursal,
	P.Nombre Producto, 
	SUM(DO.Cantidad) ProductosVendidos
FROM Ordenes O
INNER JOIN DetalleOrdenes DO ON (O.OrdenID = DO.OrdenID)
INNER JOIN Productos P ON (DO.ProductoID = P.ProductoID)
INNER JOIN Sucursales S ON (O.SucursalID = S.SucursalID)
GROUP BY O.OrdenID,S.Nombre,P.Nombre 
ORDER BY ProductosVendidos DESC --ordenamos por de mayor a menor