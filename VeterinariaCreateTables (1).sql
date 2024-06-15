--CREATE DATABASE VETERINARIA
--DROP DATABASE Veterinaria
USE VETERINARIA


CREATE TABLE TipoUsuario (
    IDTipoUsuario INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(50) NOT NULL
);

CREATE TABLE TipoEspecie (
	IDEspecie INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(50) NOT NULL
);

CREATE TABLE TipoRaza (
    IDRaza INT PRIMARY KEY IDENTITY,
	IDEspecie INT,
    Nombre NVARCHAR(50) NOT NULL

	FOREIGN KEY (IDEspecie) REFERENCES TipoEspecie(IDEspecie)
);

CREATE TABLE Sucursal (
    IDSucursal INT PRIMARY KEY IDENTITY,
    Ubicacion NVARCHAR(50) NOT NULL
);

CREATE TABLE Labor (
    IDTipoActividad INT PRIMARY KEY IDENTITY,
    Descripcion NVARCHAR(500) NOT NULL
);

CREATE TABLE TipoMedida (
    IDTipoMedida INT PRIMARY KEY IDENTITY,
    Descripción NVARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    IDUsuario INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL,
    IDTipoUsuario INT NOT NULL,
    Correo NVARCHAR(264) NOT NULL,
    Contraseña NVARCHAR(60) NOT NULL,
    IDSucursal INT,
    FOREIGN KEY (IDTipoUsuario) REFERENCES TipoUsuario(IDTipoUsuario),
    FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal)
);

CREATE TABLE Producto (
    IDProducto INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(500) NOT NULL,
    Precio DECIMAL(12,3) NOT NULL,
    Stock INT NOT NULL
);

CREATE TABLE IMAGEN (
	IDImagen INT PRIMARY KEY IDENTITY,
	IDProducto INT,
	URL NVARCHAR(300) NOT NULL

	FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
);

CREATE TABLE Mascota (
    IDMascota INT PRIMARY KEY IDENTITY,
    IDDueño INT NOT NULL,
    Nombre NVARCHAR(50) NOT NULL,
    TipoRaza INT NOT NULL,

    FOREIGN KEY (IDDueño) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (TipoRaza) REFERENCES TipoRaza(IDRaza)
);

CREATE TABLE Insumo (
    IDInsumo INT PRIMARY KEY IDENTITY,
    NombreMedicamento NVARCHAR(100) NOT NULL,
    Precio DECIMAL(12,3) NOT NULL,
    IDTipoMedida INT NOT NULL,
    FOREIGN KEY (IDTipoMedida) REFERENCES TipoMedida(IDTipoMedida)
);

CREATE TABLE Carrito (
	IDCarrito INT PRIMARY KEY IDENTITY
);

CREATE TABLE CarritoCliente (
    IDCarrito INT NOT NULL,
    IDCliente INT NOT NULL,
	PRIMARY KEY (IDCarrito, IDCliente),
	FOREIGN KEY (IDCarrito) REFERENCES Carrito(IDCarrito),
    FOREIGN KEY (IDCliente) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE UsuarioAudit (
    IDUsuarioAudit INT PRIMARY KEY IDENTITY,
    IDUsuario INT NOT NULL,
    NombreViejo NVARCHAR(100) NOT NULL,
    NombreNuevo NVARCHAR(100) NOT NULL,
    CorreoViejo NVARCHAR(264) NOT NULL,
    CorreoNuevo NVARCHAR(264) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE Reseña (
    IDReseña INT PRIMARY KEY IDENTITY,
    IDUsuario INT NOT NULL,
    IDProducto INT NOT NULL,
    Comentario NVARCHAR(500) NOT NULL,
    Calificacion INT NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
);

CREATE TABLE ProductoCarrito (
    IDProductoCarrito INT PRIMARY KEY IDENTITY,
    IDCarrito INT NOT NULL,
    IDProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    FOREIGN KEY (IDCarrito) REFERENCES Carrito(IDCarrito),
    FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
);


CREATE TABLE Venta (
    IDVenta INT PRIMARY KEY IDENTITY,
    IDCarrito INT NOT NULL,
    Total DECIMAL(12,3) NOT NULL,
    Fecha DATE NOT NULL,
    TipoPago NVARCHAR(20) NOT NULL,
    Estado NVARCHAR(20) NOT NULL,
    FOREIGN KEY (IDCarrito) REFERENCES Carrito(IDCarrito)
);

CREATE TABLE Cita (
    IDCita INT PRIMARY KEY IDENTITY,
    IDSucursal INT NOT NULL,
    IDMascota INT NOT NULL,
    IDVeterinario INT NOT NULL,
    FechaHora DATE NOT NULL,
    TipoCita NVARCHAR(50) NOT NULL,
    Estado NVARCHAR(20) NOT NULL,
    FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal),
    FOREIGN KEY (IDMascota) REFERENCES Mascota(IDMascota),
    FOREIGN KEY (IDVeterinario) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE EntradaExpediente (
    IDEntradaExpediente INT PRIMARY KEY IDENTITY,
    IDMascota INT NOT NULL,
    Descripcion NVARCHAR(500) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (IDMascota) REFERENCES Mascota(IDMascota)
);

CREATE TABLE Envio (
    IDEnvio INT PRIMARY KEY IDENTITY,
    IDVenta INT NOT NULL,
    FechaSalida DATE NOT NULL,
    FechaLlegada DATE NOT NULL,
    Estado NVARCHAR(20) NOT NULL,
    Dirección NVARCHAR(500) NOT NULL,
    FOREIGN KEY (IDVenta) REFERENCES Venta(IDVenta)
);

CREATE TABLE PersonalCita (
    IDPersonalCita INT PRIMARY KEY IDENTITY,
    IDLabor INT NOT NULL,
    IDUsuario INT NOT NULL,
    IDCita INT NOT NULL,
    FOREIGN KEY (IDLabor) REFERENCES Labor(IDTipoActividad),
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario),
    FOREIGN KEY (IDCita) REFERENCES Cita(IDCita)
);

CREATE TABLE Tratamiento (
    IDTratamiento INT PRIMARY KEY IDENTITY,
    IDCita INT NOT NULL,
    Total DECIMAL(12,3) NOT NULL,
    FOREIGN KEY (IDCita) REFERENCES Cita(IDCita)
);

CREATE TABLE Cobro (
    IDCobro INT PRIMARY KEY IDENTITY,
    IDTratamiento INT NOT NULL,
    TipoPago NVARCHAR(20) NOT NULL,
    Fecha DATE NOT NULL,
    Estado NVARCHAR(20) NOT NULL,
    FOREIGN KEY (IDTratamiento) REFERENCES Tratamiento(IDTratamiento)
);

CREATE TABLE AplicMedic (
    IDAplicMedic INT PRIMARY KEY IDENTITY,
    IDMascota INT NOT NULL,
    IDInsumo INT NOT NULL,
    Cantidad DECIMAL(12,3) NOT NULL,
    IDTratamiento INT NOT NULL,
    FOREIGN KEY (IDMascota) REFERENCES Mascota(IDMascota),
    FOREIGN KEY (IDInsumo) REFERENCES Insumo(IDInsumo),
    FOREIGN KEY (IDTratamiento) REFERENCES Tratamiento(IDTratamiento)
);

CREATE TABLE Actividad (
	IDActividad INT PRIMARY KEY IDENTITY,
	IDUsuario INT,
	Descripcion NVARCHAR(100)

	FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario)
);

--TABLAS DE ACTIVIDAD.