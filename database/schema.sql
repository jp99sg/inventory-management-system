-- =============================================
-- Base de Datos: InventarioDB
-- Versión SQL Server: 2019 / 2022
-- =============================================

USE master
GO

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'InventarioDB')
BEGIN
	CREATE DATABASE InventarioDB
END
GO

USE InventarioDB
GO

-- =============================================
-- Tabla: Categorias
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Categorias')
BEGIN
	CREATE TABLE Categorias (
        Id          INT IDENTITY(1,1) PRIMARY KEY,
        Nombre      NVARCHAR(100)   NOT NULL,
        Descripcion NVARCHAR(255)   NULL,
        Activo      BIT             NOT NULL DEFAULT 1,
        FechaCreacion DATETIME2     NOT NULL DEFAULT GETDATE()
    );
END
GO

ALTER TABLE Categorias
ALTER COLUMN Nombre NVARCHAR(100) NOT NULL

ALTER TABLE Categorias DROP COLUMN Contacto
ALTER TABLE Categorias DROP COLUMN Telefono
ALTER TABLE Categorias DROP COLUMN Email

ALTER TABLE Categorias
ADD Descripcion NVARCHAR(255) NULL

-- =============================================
-- Tabla: Proveedores
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Proveedores')
BEGIN
	CREATE TABLE Proveedores (
        Id          INT IDENTITY(1,1) PRIMARY KEY,
        Nombre      NVARCHAR(150)   NOT NULL,
        Contacto    NVARCHAR(100)   NULL,
        Telefono    NVARCHAR(20)    NULL,
        Email       NVARCHAR(150)   NULL,
        Activo      BIT             NOT NULL DEFAULT 1,
        FechaCreacion DATETIME2     NOT NULL DEFAULT GETDATE()
    );
END
GO

ALTER TABLE Proveedores
ALTER COLUMN Telefono NVARCHAR(20) NULL
ALTER TABLE Proveedores
ALTER COLUMN Contacto NVARCHAR(100) NULL
ALTER TABLE Proveedores
ALTER COLUMN Email NVARCHAR(150) NULL


-- =============================================
-- Tabla: Productos
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Productos')
BEGIN
	CREATE TABLE Productos(
		Id INT IDENTITY(1,1) PRIMARY KEY,
		Nombre NVARCHAR(200) NOT NULL,
		Descripcion NVARCHAR(500) NULL,
		Precio DECIMAL(18,2) NOT NULL,
		Stock INT NOT NULL DEFAULT 0,
		StockMinimo INT NOT NULL DEFAULT 5,
		IdCategoria INT NOT NULL,
		IdProveedor INT NOT NULL,
		Activo BIT NOT NULL DEFAULT 1,
		FechaCreacion DATETIME2 NOT NULL DEFAULT GETDATE(),
		FechaActualizacion DATETIME2 NULL,

		CONSTRAINT FK_Productos_Categorias FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id),
		CONSTRAINT FK_Productos_Proveedores	FOREIGN KEY (IdProveedor) REFERENCES Proveedores(Id),
		CONSTRAINT CHK_Precio_Positivo CHECK(Precio >= 0),
		CONSTRAINT CHK_Stock_NoNegativo CHECK(Stock >= 0)
	)
END
GO

-- =============================================
-- Tabla: MovimientosStock
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MovimientosStock')
BEGIN
	CREATE TABLE MovimientosStock(
		Id INT IDENTITY(1,1) PRIMARY KEY,
		IdProducto INT NOT NULL,
		Tipo NVARCHAR(10) NOT NULL,
		Cantidad INT NOT NULL,
		Motivo NVARCHAR(255) NULL,
		Fecha DATETIME2 NOT NULL DEFAULT GETDATE(),

		CONSTRAINT FK_Movimientos_Productos FOREIGN KEY (IdProducto) REFERENCES Productos(Id),
		CONSTRAINT CHK_Tipo_Movimiento CHECK(Tipo IN ('ENTRADA', 'SALIDA')),
		CONSTRAINT CHK_Cantidad_Positiva CHECK (Cantidad > 0)
	)
END


-- =============================================
-- Datos de ejemplo (Seed Data)
-- =============================================
IF NOT EXISTS (SELECT TOP 1 1 FROM Categorias)
BEGIN
    INSERT INTO Categorias (Nombre, Descripcion) VALUES
    ('Electrónica',     'Dispositivos y componentes electrónicos'),
    ('Oficina',         'Artículos de oficina y papelería'),
    ('Herramientas',    'Herramientas manuales y eléctricas');

    INSERT INTO Proveedores (Nombre, Contacto, Email) VALUES
    ('Tech Solutions S.A.',  'Juan Pérez',  'juan@techsolutions.com'),
    ('Distribuidora Omega',  'Ana García',  'ana@omega.com');

    INSERT INTO Productos (Nombre, Precio, Stock, StockMinimo, IdCategoria, IdProveedor) VALUES
    ('Monitor 24" Full HD',     4500.00, 10,  3, 1, 2),
    ('Teclado Mecánico RGB',     850.00, 25,  5, 1, 2),
    ('Mouse Inalámbrico',        350.00, 40,  8, 1, 2),
    ('Resma de Papel A4',         85.00, 100, 20, 2, 3),
    ('Bolígrafos (caja x12)',     45.00, 60,  10, 2, 3),
    ('Desarmador Multibit',      120.00, 15,  5, 3, 3);
END
GO