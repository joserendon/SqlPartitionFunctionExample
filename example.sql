-- Crear la función de partición (por año)
CREATE PARTITION FUNCTION pf_VentasPorAño (DATE) AS RANGE LEFT FOR VALUES ('2019-12-31', '2020-12-31', '2021-12-31', '2022-12-31', '2023-12-31', '2024-12-31');

-- Crear el esquema de partición
CREATE PARTITION SCHEME ps_VentasPorAño AS PARTITION pf_VentasPorAño TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY]);

--  Crear la tabla Ventas con particionamiento
CREATE TABLE Ventas (
    ID INT IDENTITY(1,1),
    FechaVenta DATE NOT NULL,
    ClienteID INT NOT NULL,
    Monto DECIMAL(18,2),
    CONSTRAINT PK_Ventas PRIMARY KEY (FechaVenta, ID)
) ON ps_VentasPorAño (FechaVenta);

-- Insertar 1 millón de registros por año

-- Año 2019
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2019-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2020
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2020-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B

-- Año 2021
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2021-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2022
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2022-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2023
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2024
INSERT INTO Ventas (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2024-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;


-- CREATE Y INSERT TABLA SIN PARTICIONES

--  Crear la tabla Ventas2 con particionamiento
CREATE TABLE Ventas2 (
    ID INT IDENTITY(1,1),
    FechaVenta DATE NOT NULL,
    ClienteID INT NOT NULL,
    Monto DECIMAL(18,2),
    CONSTRAINT PK_Ventas2 PRIMARY KEY (ID)
)  

-- Insertar 1 millón de registros por año

-- Año 2019
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2019-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2020
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2020-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B

-- Año 2021
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2021-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2022
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2022-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2023
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;

-- Año 2024
INSERT INTO Ventas2 (FechaVenta, ClienteID, Monto)
SELECT TOP 1000000 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2024-01-01'),
    ABS(CHECKSUM(NEWID())) % 1000 + 1, 
    ROUND(RAND() * 1000 + 50, 2)
FROM sys.all_objects
CROSS JOIN sys.all_objects AS B;
 
--CONTAR TOTALES
SELECT COUNT(*) FROM Ventas
SELECT COUNT(*) FROM Ventas2

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT * FROM Ventas WHERE FechaVenta BETWEEN '20220101' AND '20221231' --and ClienteID=792;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT * FROM Ventas2 WHERE FechaVenta BETWEEN '20220101' AND '20221231' --and ClienteID=792;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

SELECT 
    pf.name AS PartitionFunctionName,
    prv.boundary_id,
    prv.value AS BoundaryValue
FROM sys.partition_functions pf
JOIN sys.partition_range_values prv ON pf.function_id = prv.function_id
ORDER BY prv.boundary_id;

SELECT 
    v.object_id, 
    v.index_id, 
    v.partition_id, 
    p.partition_number, 
    p.row_count  
FROM sys.dm_db_partition_stats p
JOIN sys.partitions v ON p.partition_id = v.partition_id
WHERE v.object_id = OBJECT_ID('Ventas');


SELECT 
    v.object_id, 
    v.index_id, 
    v.partition_id, 
    p.partition_number, 
    p.row_count  -- Corregido: 'row_count' en lugar de 'rows'
FROM sys.dm_db_partition_stats p
JOIN sys.partitions v ON p.partition_id = v.partition_id
WHERE v.object_id = OBJECT_ID('Ventas2');


--SET SHOWPLAN_XML ON;
--go
--SELECT * FROM Ventas WHERE FechaVenta BETWEEN '2023-01-01' AND '2023-12-31';
--go
--SET SHOWPLAN_XML OFF;

---- 6️ Automatización: Crear nueva partición para el próximo año
--DECLARE @NextYear INT = YEAR(GETDATE()) + 1;
--DECLARE @NewPartitionDate DATE = CAST(@NextYear AS NVARCHAR(4)) + '-12-31';

--DECLARE @SQL NVARCHAR(MAX) = 'ALTER PARTITION FUNCTION pf_VentasPorAño() SPLIT RANGE (''' + @NewPartitionDate + ''');';

--EXEC sp_executesql @SQL;
--PRINT '✅ Nueva partición creada para ' + CAST(@NextYear AS NVARCHAR(4));

---- 7️ Limpiar datos antiguos (eliminar 2019 si ya no es necesario)
--ALTER PARTITION FUNCTION pf_VentasPorAño() MERGE RANGE ('2019-12-31');