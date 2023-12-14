USE HOSPITAL_EMPRESA
GO
/*SELECT PARTE II*/

/*.    =========== USANDO OPERADOR DISTINCT =========== */    
/*12. Listar los oficios de los empleados */
SELECT distinct [oficio], [Num_Dpto] FROM [dbo].[Empleado]
/*13. Listar los numeros de departamentos de los empleados
sin repetir */

SELECT distinct [Num_Dpto] FROM [dbo].[Empleado]

/*.    =========== USANDO OPERADOR LIKE =========== */    
/*14. Mostrar Apellido, y num_dpto de los empleados 
cuyo apellido  inicie en 'M' termine en 'Z'
 ordenados por departamento */

 SELECT [Apellido],[Num_Dpto] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE 'M%Z'

/*15. Mostrar Id, y apellido de los empleados 
que contengan en su apellido ER.*/

SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '%ER%'

/*16. Mostrar Id, y apellido de los empleados 
que su primer letra del apellido sea A, M o R.*/

SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE 'A%'OR [Apellido] LIKE 'M%'
	OR [Apellido] LIKE 'R%'

	SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '[AMR]%'

/*17 Mostrar Id, y apellido de los empleados 
que su primer letra del apellido NO sea A, M o R.*/

SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] NOT LIKE '[AMR]%'

/*18. Mostrar Id, y apellido de los empleados 
que su primer letra del apellido este entre A y M.*/

SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '[A-M]%'

/* 19.    Mostrar Id, apellido y num_dpto de los empleados
 cuyo APELLIDOS sean de 5 letras y este termine 
con la letra S */

SELECT [ID_Empleado],[Apellido],[Num_Dpto] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '____S'


/* 20.    Mostrar Id, apellido y num_dpto de los empleados
 cuyo APELLIDOS tenga como segunda letra una i y la primera no importa 
 cual sea  */

 SELECT [ID_Empleado],[Apellido],[Num_Dpto] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '_i%'

/* 21.    Mostrar Id, apellido y num_dpto de los empleados
 cuyo apellido inicien con e, f, g o h */

 SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido] LIKE '[EFGH]%'

/* 22. Mostrar Id, apellido y num_dpto empleados cuyo apellido 
comience por la letra M, y la segunda letra no sea A. */

SELECT [ID_Empleado],[Apellido] FROM [dbo].[Empleado]
	WHERE [Apellido]  LIKE 'M[^A]%' 


/*.    =========== FUNCIONES DE AGREGADO =========== */


/*23. Mostrar cuantos empleados existen,
salario minimo, salario maximo, suma de todos los salarios
y el salario promedio */

SELECT COUNT (*), MIN([Salario]),MAX([Salario]),SUM([Salario]),AVG([Salario]) FROM [dbo].[Empleado]

 /*24. Mostrar cuantos empleados existen,
salario minimo, salario maximo, 
salario promedio de todos los vendedores (COUNT=4)*/

SELECT COUNT(*), MIN([Salario]),MAX([Salario]),AVG([Salario])
FROM [dbo].[Empleado]
WHERE [Oficio] = 'vendedor'


/*Se usa el WHERE porque no esta 
el campo OFICIO en el select EN FUNCION DE AGREGADO
O EN UNA CLUASULA GROUP BY*/
/*25. Mostrar cuantos empleados existen,
salario minimo, salario maximo, 
salario promedio POR oficio*/
SELECT [Oficio],COUNT(*), MIN([Salario]),MAX([Salario]),AVG([Salario])
FROM [dbo].[Empleado]
WHERE [Oficio] = 'vendedor'
GROUP BY [Oficio]



/*26. Mostrar cuantos empleados existen,
salario minimo, salario maximo, 
salario promedio de los vendedores, y 
mostrar el oficio 'VENDEDOR'*/

SELECT [Oficio],COUNT(*), MIN([Salario]),MAX([Salario]),AVG([Salario])
FROM [dbo].[Empleado]
WHERE [Oficio] = 'vendedor'
GROUP BY [Oficio] 

/*27. Mostrar cuantos empleados existen por cada 
oficio */

SELECT [Oficio],COUNT(*)
FROM [dbo].[Empleado]
GROUP BY [Oficio]

/*28. Mostrar cuantos empleados existen para el  
oficio ANALISTA (Mostrar cantidad y oficio) */

SELECT [Oficio],COUNT(*)
FROM [dbo].[Empleado]
WHERE [Oficio] = 'analista'
GROUP BY [Oficio]

/* 29.    Encontrar el salario mas alto, 
mas bajo y la diferencia entre ambos 
de todos los empleados con oficio EMPLEADO.*/

SELECT COUNT(*),MIN([Salario]),MAX([Salario]), MAX([Salario]) - MIN([Salario])
FROM [dbo].[Empleado]
WHERE [Oficio] = 'empleado'
GROUP BY [Oficio]


/*30. Mostrar  el número de personas que realizan cada 
oficio en cada uno de los departamentos. Visualizar Num_Dpto, oficio
y Cantidad personas */
    
SELECT [Num_Dpto],[Oficio], COUNT(*)
FROM [dbo].[Empleado]
group by [Num_Dpto],[Oficio]
order BY [Num_Dpto],[Oficio]

/* 31.    Buscar aquellos numero de departamento 
con cuatro o mas personas trabajando. */

SELECT [Num_Dpto], COUNT(*)
FROM [dbo].[Empleado]
group by [Num_Dpto]
having COUNT(*) >=4

/*ERROR*/
select [Num_Dpto], COUNT(*)
FROM[dbo].[Empleado]
WHERE COUNT (*) >=4
GROUP BY [Num_Dpto]

/* 32.    Mostrar el oficio y la cantidad de 
empleados de cada uno de esos oficios. 
De ese listado solo desplegar los primeros dos oficios 
con mas empleados. */

select [Oficio], COUNT(*)
FROM[dbo].[Empleado]
GROUP BY [Oficio]
ORDER BY  COUNT (*) desc


/*32.1 Mostrar los tres empleados con mejores salarios
ejemplo de un uso de TOP, en una sentencia normal, sin funciones*/

SELECT top 3 [Apellido],[Salario]
FROM [dbo].[Empleado]
order by [Salario] desc




/* SELECT MULTIPLES TABLAS  
33. Devuelva el apellido de los empleados el
salario, num_dto y nombre del departamento donde trabaja.*/
-- Con el Where sin Inner Join NO RECOMENDADO

SELECT [Apellido],[Salario],[Num_Dpto]
	FROM [dbo].[Empleado]

SELECT [Num_Dpto], [Dpto_Nombre]
	from [dbo].[Departamento]

SELECT [Apellido],[Salario],E.[Num_Dpto],D.Num_Dpto,[Dpto_Nombre]
	FROM [dbo].[Empleado] E,[dbo].[Departamento] D
	WHERE E.[Num_Dpto] = D.[Num_Dpto]

/* INNER JOIN (OPCION RECOMENDA)
34. Devuelva el apellido de los empleados el
salario, num_dto y nombre del departamento donde trabaja.*/
SELECT [Apellido],[Salario],E.[Num_Dpto],D.Num_Dpto, [Dpto_Nombre]
	FROM [dbo].[Empleado] E INNER JOIN [dbo].[Departamento] D
	ON E.[Num_Dpto] = D.[Num_Dpto]


/* 35. Mostrar todos los nombres de Hospital con sus 
nombres de salas correspondientes. */

 SELECT H.[Nombre] AS Nom_Hosp ,H.[Cod_Hospital],S.[Cod_Hospital], S.[Nombre] as Nom_Sala
FROM [dbo].[Hospital] H INNER JOIN [dbo].[Sala] S ON H.[Cod_Hospital] = S.[Cod_Hospital]
ORDER BY H.[Nombre]


/* 36. Mostrar el apellido del doctor y el nombre del hospital donde trabaja.*/

SELECT [Apellido] ,[Nombre] 
		FROM [dbo].[Doctor] Doc
		INNER JOIN [dbo].[Hospital] Hospi ON Doc.Cod_Hospital = Hospi.Cod_Hospital
		

https://www.aulaclic.es/sqlserver/index.htm
http://www.ingenieriasystems.com/2014/01/Manual-de-Microsoft-SQL-Server-Full-Transact-SQL.html
http://www.ingenieriasystems.com/2015/04/Consultas-de-combinacion-en-SQL-Server-Parte-2.html
https://www.w3schools.com/sql/
https://www.hackerrank.com/

/* BASE DE DATOS DE FACTURAS*/

/*37. Mostrar el cliente y el id de la factura relacionada, es decir 
que aparecen en AMBAS tablas relacionadas.(3 REGISTROS) */

SELECT [Id_Factura], [Nombre]
	FROM [dbo].[Cliente] C
	INNER JOIN [dbo].[Factura] F ON F.Cliente = C.Id_Cliente


/*38. Mostrar todos los clientes y (en caso de tener FACTURAS, MOSTRAR 
la informacion de la FACTURA) */

SELECT [Nombre],[Id_Factura]
	FROM [dbo].[Cliente] C
	LEFT JOIN [dbo].[Factura] F ON F.Cliente = C.Id_Cliente


/*39. Mostrar todos los clientes(NOMBRE) y (en caso de tener FACTURAS, MOSTRAR 
la informacion de la FACTURA) 

(usando LEFT, aparece todo del FROM) */

SELECT [Nombre],[Id_Factura]
	FROM [dbo].[Cliente] C
	LEFT JOIN [dbo].[Factura] F ON F.Cliente = C.Id_Cliente

/*CON RIGHT, aparece todo despues de lo que es despues del JOIN*/

SELECT [Nombre],[Id_Factura]
	FROM [dbo].[Factura] F
	RIGHT JOIN  [dbo].[Cliente] C ON F.Cliente = C.Id_Cliente


/*CON FULL*/

SELECT [Nombre],[Id_Factura]
	FROM [dbo].[Factura] F
	FULL JOIN  [dbo].[Cliente] C ON F.Cliente = C.Id_Cliente

/*40. Mostrar todos los datos de todas las FACTURAS y (en caso de tener
cliente, EL NOMBRE del cliente) */

/*RIGHT*/


/*41. Mostrar todos los datos de todas las FACTURAS y los datos de todos los clientes 
(Nombre, Apellido) */ /*CON FULL ES*/




/*MULTIPLES TABLAS*/
/*id factura y la fecha, : FACTURA= INNER JOIN [dbo].[DetalleFactura] D ON F.[Id_Factura] = D.[Id_Factura]
id del articulo y la cantidad : DETALLE= INNER JOIN [dbo].[Articulo]A ON D.[Id_Articulo] = A.Id_Articulo
nombre articulo, id_categoria: ARTICULO
nombre categoria: CATEGORIA*/

SELECT F.[Id_Factura],[Fecha],D.[Id_Articulo],[Cantidad], [Nombre_Articulo],C.[Id_Categoria],[Nombre_Categoria]
	FROM [dbo].[Factura] F
	INNER JOIN [dbo].[DetalleFactura] D ON F.[Id_Factura] = D.[Id_Factura]
	INNER JOIN [dbo].[Articulo]A ON D.[Id_Articulo] = A.Id_Articulo
	INNER JOIN [dbo].[Categoria]C ON C.[Id_Categoria] = A.Id_Categoria


/*42. Mostrar el id de la factura y la cantidad de lineas de esa factura*/

/*43. Mostrar el id de la factura y la suma de las cantidades de los productos en esa factura*/

/*44. Mostrar el id de la factura y el monto total de esa factura*/