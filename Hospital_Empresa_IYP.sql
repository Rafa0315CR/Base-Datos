/** SE SELECCIONA LA BASE DE DATOS CREADA**/
USE HOSPITAL_EMPRESA
GO

/** INSTRUCCION QUE PERMITE CREAR LOS DIAGRAMAS**/
Alter authorization on database::HOSPITAL_EMPRESA to sa 


/*Establece el formato de la fecha en dia/mes/a�o, 
cualquiera de las dos*/
SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

/*SENTENCIA SELECT*/

/* 1. Mostrar todos los datos de los empleados 
de nuestra tabla Empleados.*/

SELECT [ID_Empleado], [Apellido], [Oficio], [Cod_Jefe], [Fecha_Ingreso], [Salario], [Comision], [Num_Dpto]
FROM [dbo].[Empleado]
GO

/* 2. Mostrar el apellido, oficio, salario, comision,
y el salario anual para aquellos empleados 
con comision mayor de 100.000.*/

SELECT [Apellido], [Oficio], [Salario], [Comision], [Salario] *12 AS SAL_ANUAL
FROM [dbo].[Empleado]
WHERE [Comision] > 100000
GO

/* 3. Mostrar el apellido, oficio, salario, comision,
y el salario anual para aquellos empleados 
que su salario anual supere los 2.200.000.*/

SELECT [Apellido], [Oficio], [Salario], [Comision], [Salario] *12 AS SAL_ANUAL
FROM [dbo].[Empleado]
WHERE ([Salario] * 12) + [Comision] > 2200000
GO

/* 4. Mostrar el apellido, oficio, salario, comision,
y el salario anual de los empleados que sumen entre
 salario anual y comision los 3 millones.(6 PERSONAS).*/
 
SELECT [Apellido], [Oficio], [Salario], [Comision], [Salario] *12 AS SAL_ANUAL
FROM [dbo].[Empleado]
WHERE ([Salario] * 12) + [Comision] > 3000000
GO

 /* 5.	Mostrar apellido, oficio, y depto de los empleados 
ordenados por departamento y dentro de este 
por oficio para tener una vision jerarquica.*/

SELECT [Apellido], [Oficio], [Num_Dpto]
FROM [dbo].[Empleado]
ORDER BY [Num_Dpto], [Oficio]
GO

/* 6. Mostrar el Apellido y la fecha de ingreso
de todos los empleados.*/

SELECT [Apellido], CONVERT (VARCHAR(10), [Fecha_Ingreso], 103) AS [Fecha_Ingreso]
FROM [dbo].[Empleado]
GO

/* 7. Mostrar  Apellido y la fecha de ingreso de los empleados
que no ingresaron entre el 01/01/2010 y el 12/12/2015.*/



/* 8. Mostrar los nombres y la localizacion de los departamentos 
situados ("localizacion") en Madrid o en Barcelona.*/



/* 9.	Mostrar aquellos Apellido y Fecha de Ingreso de 
empleados con fecha de ingreso posterior al 
1 de Julio de 2015.(4 Empleados).*/



/* 10.	Mostrar aquellos empleados con salario entre 150.000 y 
400.000, ordenados por la columna Salario.(11 Empleados).*/



/* 11.	Mostrar aquellos empleados con salario entre 150.000 y 400.000, 
O tambien incluimos aquellos que no siendo analista pertenecen 
al departamento 20.(14 Empleados).*/
