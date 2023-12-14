/*Paso 1: Cree una base de datos con el nombre de Laboratorio1.*/

CREATE DATABASE Laboratorio1_Yip
GO

/*Paso 2: Seleccione la base de datos creada Laboratorio1.*/

USE Laboratorio1_Yip
GO

Alter authorization on database::Laboratorio1_Yip to sa
GO

/*Paso 3: Establezca el idioma y la configuración de la fecha en español para la sesión
de la conexión actual.*/

SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

/*Paso 4: Desarrolle las sentencias que permitan crearlas siguientes tablas
en la Base de Datos Laboratorio1.*/

 CREATE TABLE Hospital(
	COD_HOSPITAL INT NOT NULL,
	NOMBRE VARCHAR(50) NULL,
	PROVINCIA VARCHAR(2) NULL,
	TELEFONO VARCHAR(50) NULL,
	CANT_CAMAS INT NULL,
	CONSTRAINT [PK_Hospital] PRIMARY KEY(COD_HOSPITAL ASC),
)
GO

CREATE TABLE Doctor(
	NUM_DOCTOR INT NOT NULL,
	COD_HOSPITAL INT NOT NULL,
	APELLIDO VARCHAR(50) NULL,
	COD_ESPECIALIDAD VARCHAR (5) NULL,
	CONSTRAINT [PK_Doctor] PRIMARY KEY(NUM_DOCTOR ASC),
	CONSTRAINT [FK_Doctor_Hospital] FOREIGN KEY (COD_HOSPITAL) REFERENCES Hospital(COD_HOSPITAL)
)
GO

/*Paso 5: Desarrolle las sentencias que permitan crear las siguientes tablas
en la Base de Datos Laboratorio1.*/

 CREATE TABLE Especialidades(
	COD_ESPECIALIDAD VARCHAR (5) NOT NULL,
	NOM_ESPECIALIDAD VARCHAR(50) NULL,
	CONSTRAINT [PK_Especialidades] PRIMARY KEY(COD_ESPECIALIDAD ASC),
)
GO

 CREATE TABLE Provincias(
	COD_PROVINCIA VARCHAR (2) NOT NULL,
	NOM_PROVINCIA VARCHAR(50) NULL,
	CONSTRAINT [PK_Provincias] PRIMARY KEY(COD_PROVINCIA ASC), 
)
GO

/*Paso 6 : Desarrolle las sentencias Alter Table para agregar los constrains de Foreign Key 
respectivas del paso 5, con las tablas creadas en el paso 4.*/

ALTER TABLE Hospital ADD CONSTRAINT [FK_Especialidades_Doctor]
FOREIGN KEY (COD_ESPECIALIDAD) REFERENCES Especialidades(COD_ESPECIALIDAD)
GO

ALTER TABLE Hospital ADD CONSTRAINT [FK_Provincia_Hospital]
FOREIGN KEY (PROVINCIA) REFERENCES Provincias(COD_PROVINCIA)
GO