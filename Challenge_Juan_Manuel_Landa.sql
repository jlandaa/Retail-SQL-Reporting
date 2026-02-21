/*
===============================================================================
RETAIL SALES ANALYTICS - CASO ÉXITO
===============================================================================
El área de Demand Planning requiere información con mayor frecuencia de las 
transacciones de venta y movimientos de mercadería realizadas. Para ello genera 
reportes comerciales a través del área de Reporting con diversos KPIs e 
indicadores segmentando por distintas categorías.

INTEGRANTE: Juan Manuel Landa
===============================================================================
*/

-- El modelo cuenta con las siguientes tablas:
-- ● Clientes: Listado de los clientes dados de alta en el sistema de ventas.
-- ● Empleados: Maestro de empleados, el mismo esta compuesto por el identificador, nombre, apellido y sucursal en la que trabaja.
-- ● Locales: Maestro de sucursales compuesta por el identificador, nombre y tipo de local.
-- ● Productos: Maestro de productos con su precio agrupados por familia de producto.
-- ● Facturas: Tabla que registra todas las transacciones (ventas). Contiene fecha, empleado, cliente y cantidad.

USE lab.ventas;

-- 1. Generar un listado de la cantidad de productos vendidos por año de manera descendente.

SELECT 
    YEAR(fecha_venta) AS anio, 
    SUM(cantidad) AS total_productos_vendidos
FROM facturas
GROUP BY anio
ORDER BY anio DESC;

-- 2. Top-5 de los empleados que menos vendieron según cantidad vendida, indicando apellido y nombre en un sólo campo. 

SELECT 
    CONCAT(COALESCE(NULLIF(e.apellido, 'null'), 'S/A'), ', ', e.nombre) AS vendedor_nombre_completo,
    COALESCE(SUM(f.cantidad), 0) AS total_unidades_vendidas
FROM empleados e
LEFT JOIN facturas f ON e.id_vendedor = f.vendedor
GROUP BY e.id_vendedor, e.apellido, e.nombre
ORDER BY total_unidades_vendidas ASC
LIMIT 5;

-- 3. ¿Cuántos clientes compraron mes anterior?

SELECT 
    COUNT(DISTINCT cliente) AS cantidad_clientes
FROM facturas
WHERE date_trunc('month', fecha_venta) = (
  SELECT add_months(date_trunc('month', MAX(fecha_venta)), -1)
  FROM facturas
);

-- 4. ¿Cuál fue el producto que se vendió mas en el año 2022? ¿A qué familia de producto pertenece?

SELECT 
    p.nombre AS nombre_producto,
    p.familia AS familia_producto,
    SUM(f.cantidad) AS total_unidades_vendidas
FROM facturas f
JOIN productos p ON f.producto = p.id_producto
WHERE YEAR(f.fecha_venta) = 2022
GROUP BY p.nombre, p.familia
ORDER BY total_unidades_vendidas DESC
LIMIT 1;

-- 5. Siguiendo con el punto anterior ¿Y cuál fue el más rentable?

SELECT 
    p.nombre AS nombre_producto,
    p.familia AS familia_producto,
    SUM(f.cantidad * p.precio_unitario) AS rentabilidad_total
FROM facturas f
JOIN productos p ON f.producto = p.id_producto
WHERE YEAR(f.fecha_venta) = 2022
GROUP BY p.nombre, p.familia
ORDER BY rentabilidad_total DESC
LIMIT 1;

-- 6. Top-10 de sucursales según monto vendido, indicando el monto, ordenado de mayor a menor. El informe debe mostrar:
-- ● Tipo de local
-- ● Nombre del local
-- ● Monto vendido

SELECT 
    l.tipo AS tipo_local,
    l.nombre AS nombre_local,
    SUM(f.cantidad * p.precio_unitario) AS monto_vendido
FROM facturas f
JOIN productos p ON f.producto = p.id_producto
JOIN empleados e ON f.vendedor = e.id_vendedor
JOIN locales l ON e.sucursal = l.id_sucursal
GROUP BY l.id_sucursal, l.tipo, l.nombre
ORDER BY monto_vendido DESC
LIMIT 10;

-- 7. Se detectaron ventas (facturas) realizadas por vendedores que no estan mas en la compañia (no estan en el maestro de empleados). Por lo tanto, nos solicitan un listado de dichos empleados con la cantidad de ventas (facturas). ¿Cuántos empleados son?

SELECT 
    vendedor AS id_vendedor_inexistente, 
    COUNT(num_factura) AS cantidad_ventas
FROM facturas
WHERE vendedor NOT IN (SELECT id_vendedor FROM empleados)
GROUP BY vendedor
ORDER BY cantidad_ventas DESC;

SELECT COUNT(DISTINCT vendedor) AS cantidad_vendedores_inexistentes
FROM facturas
WHERE vendedor NOT IN (SELECT id_vendedor FROM empleados);

-- 8. Nos piden clasificar a los vendedores en funcion de su rendimiento (facturación) para el año actual.
-- ● "Excelente" si el vendedor ha vendido por más de 10 millones de pesos en total.
-- ● "Bueno" si el vendedor ha vendido entre 5 y 10 millones de pesos en total.
-- ● "Regular" si el vendedor ha vendido menos de 5 millones de pesos en total.

WITH UltimoAnio AS (
    SELECT MAX(YEAR(fecha_venta)) AS anio FROM facturas
),
VentasConsolidadas AS (
    SELECT 
        f.vendedor AS id_vendedor,
        SUM(f.cantidad * p.precio_unitario) AS monto_total
    FROM facturas f
    INNER JOIN productos p ON f.producto = p.id_producto
    INNER JOIN UltimoAnio ua ON YEAR(f.fecha_venta) = ua.anio
    GROUP BY f.vendedor
)
SELECT 
    v.id_vendedor,
    CONCAT(COALESCE(NULLIF(e.apellido, 'null'), 'S/A'), ', ', e.nombre) AS vendedor_nombre_completo,
    v.monto_total AS facturacion_total,
    CASE 
        WHEN v.monto_total > 10000000 THEN 'Excelente'
        WHEN v.monto_total >= 5000000 THEN 'Bueno'
        ELSE 'Regular'
    END AS clasificacion_vendedor
FROM VentasConsolidadas v
JOIN empleados e ON v.id_vendedor = e.id_vendedor
ORDER BY v.monto_total DESC;

-- 9. Muestra el número total de facturas para cada vendedor que haya realizado más de 100 ventas el año anterior. Incluye el nombre del vendedor y la cantidad de facturas.

SELECT 
    CONCAT(COALESCE(NULLIF(e.apellido, 'null'), 'S/A'), ', ', e.nombre) AS vendedor_nombre_completo,
    COUNT(f.num_factura) AS total_facturas
FROM facturas f
JOIN empleados e ON f.vendedor = e.id_vendedor
WHERE YEAR(f.fecha_venta) = (SELECT MAX(YEAR(fecha_venta)) - 1 FROM facturas)
GROUP BY e.id_vendedor, e.nombre, e.apellido
HAVING COUNT(f.num_factura) > 100
ORDER BY total_facturas DESC;

-- 10. Generar un listado de los clientes que realizaron mas de 50 compras y que su edad sea mayor al premedio de edad del total de nuestra base de clientes. Ordenar el listado por edad de manera ascendente

WITH FechaReferencia AS (
    SELECT MAX(fecha_venta) AS ultima_fecha FROM facturas
),
EdadClientes AS (
    SELECT 
        id_cliente,
        nombre,
        apellido,
        CAST(DATEDIFF((SELECT ultima_fecha FROM FechaReferencia), CAST(fecha_nacimiento AS DATE)) / 365.25 AS INT) AS edad
    FROM clientes
),
ComprasClientes AS (
    SELECT 
        cliente AS id_cliente,
        COUNT(num_factura) AS total_compras
    FROM facturas
    GROUP BY cliente
    HAVING COUNT(num_factura) > 50
)
SELECT 
    CONCAT(COALESCE(NULLIF(ec.apellido, 'null'), 'S/A'), ', ', ec.nombre) AS cliente_nombre_completo,
    ec.edad,
    cc.total_compras
FROM ComprasClientes cc
JOIN EdadClientes ec ON cc.id_cliente = ec.id_cliente
WHERE ec.edad > (SELECT AVG(edad) FROM EdadClientes)
ORDER BY ec.edad ASC;