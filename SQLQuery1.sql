create database Ropa_E;

use Ropa_E;

CREATE TABLE Productos (
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Categoria NVARCHAR(50) NOT NULL CHECK (Categoria IN ('Hombre', 'Mujer')),
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio > 0)
);
INSERT INTO Productos (NombreProducto, Categoria, Precio)
VALUES
('Camisa Casual', 'Hombre', 25.50),
('Pantalón Formal', 'Hombre', 40.00),
('Zapatos Deportivos', 'Hombre', 60.00),
('Camiseta Básica', 'Hombre', 15.00),
('Jeans Slim Fit', 'Hombre', 45.00),
('Blusa Elegante', 'Mujer', 30.00),
('Vestido Floral', 'Mujer', 55.00),
('Zapatos de Tacón', 'Mujer', 70.00),
('Chamarra de Cuero', 'Mujer', 90.00),
('Pantalón Skinny', 'Mujer', 35.00);

CREATE TABLE Proveedores (
    IdProveedor INT PRIMARY KEY IDENTITY(1,1),
    NombreProveedor NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(15),
    Email NVARCHAR(100)
);
CREATE TABLE Clientes (
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
    NombreCliente NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(15),
    Email NVARCHAR(100)
);
CREATE TABLE Inventarios (
    IdInventario INT PRIMARY KEY IDENTITY(1,1),
    IdProducto INT NOT NULL,
    Stock INT NOT NULL CHECK (Stock >= 0),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
CREATE TABLE Compras (
    IdCompra INT PRIMARY KEY IDENTITY(1,1),
    IdProveedor INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    FechaCompra DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
CREATE TABLE ControlEventos (
    IdEvento INT PRIMARY KEY IDENTITY(1,1),
    NombreTabla NVARCHAR(50),
    Operacion NVARCHAR(50),
    Fecha DATETIME DEFAULT GETDATE(),
    Usuario NVARCHAR(50),
    Informacion NVARCHAR(MAX)
);
CREATE TRIGGER trgInsertProductos
ON Productos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ControlEventos (NombreTabla, Operacion, Usuario, Informacion)
    SELECT 
        'Productos' AS NombreTabla,
        'INSERT' AS Operacion,
        SYSTEM_USER AS Usuario,
        CONCAT('IdProducto: ', IdProducto, ', Nombre: ', NombreProducto, ', Categoria: ', Categoria, ', Precio: ', Precio) AS Informacion
    FROM Inserted;
END;
GO

CREATE PROCEDURE spInsertarProducto
    @NombreProducto NVARCHAR(100),
    @Categoria NVARCHAR(50),
    @Precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Productos (NombreProducto, Categoria, Precio)
    VALUES (@NombreProducto, @Categoria, @Precio);
END;
CREATE PROCEDURE spObtenerProductosConProveedores
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.NombreProducto, 
        p.Categoria, 
        p.Precio, 
        pr.NombreProveedor
    FROM 
        Productos p
    INNER JOIN 
        Compras c ON p.IdProducto = c.IdProducto
    INNER JOIN 
        Proveedores pr ON c.IdProveedor = pr.IdProveedor;
END;
GO

CREATE PROCEDURE spActualizarStock
    @IdProducto INT,
    @Cantidad INT
AS
BEGIN
    UPDATE Inventarios
    SET Stock = Stock + @Cantidad
    WHERE IdProducto = @IdProducto;
END;
CREATE PROCEDURE spConsultarBajoStock
AS
BEGIN
    SELECT p.NombreProducto, i.Stock
    FROM Inventarios i
    INNER JOIN Productos p ON i.IdProducto = p.IdProducto
    WHERE i.Stock < 10;
END;
INSERT INTO Proveedores (NombreProveedor, Telefono, Email)
VALUES
('Proveedor 1', '555-1234', 'contacto1@proveedores.com'),
('Proveedor 2', '555-2345', 'contacto2@proveedores.com'),
('Proveedor 3', '555-3456', 'contacto3@proveedores.com'),
('Proveedor 4', '555-4567', 'contacto4@proveedores.com'),
('Proveedor 5', '555-5678', 'contacto5@proveedores.com');

-- Continuar hasta 100 registros.

INSERT INTO Clientes (NombreCliente, Telefono, Email)
VALUES
('Cliente 1', '555-1111', 'cliente1@ejemplo.com'),
('Cliente 2', '555-2222', 'cliente2@ejemplo.com'),
('Cliente 3', '555-3333', 'cliente3@ejemplo.com'),
('Cliente 4', '555-4444', 'cliente4@ejemplo.com'),
('Cliente 5', '555-5555', 'cliente5@ejemplo.com');

-- Continuar hasta 100 registros.
INSERT INTO Inventarios (IdProducto, Stock)
VALUES
(1, 50),
(2, 30),
(3, 70),
(4, 20),
(5, 60);

-- Generar para los 100 productos.
INSERT INTO Compras (IdProveedor, IdProducto, Cantidad, FechaCompra)
VALUES
(1, 1, 20, '2024-11-01'),
(2, 2, 15, '2024-11-02'),
(3, 3, 50, '2024-11-03'),
(4, 4, 30, '2024-11-04'),
(5, 5, 40, '2024-11-05');

-- Completar con 100 compras.

select * from Productos;



