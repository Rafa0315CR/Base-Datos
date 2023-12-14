
DECLARE @nombre VARCHAR(50)
SET @nombre =  'Jose Pérez'
PRINT @nombre
go

use W3SCHOLS
go

-- La consulta debe devolver un único registro
DECLARE @nombre VARCHAR(50)
SET @nombre = (SELECT Nom_Cliente
				FROM [dbo].[Clientes]
				WHERE Cliente_ID=20)
PRINT @nombre
go

-- La consulta debe devolver un único registro
-- Varios datos o culumnas.

DECLARE @nombre VARCHAR(50)
DECLARE @pais VARCHAR(50)
SELECT @nombre=Nom_Cliente,@pais=Pais
				FROM [dbo].[Clientes]
				WHERE Cliente_ID=20
PRINT @nombre
Print @pais

go

--SELECT clasico
SELECT Nom_Cliente,Pais
				FROM [dbo].[Clientes]
				WHERE Cliente_ID=20
go

-- EJEMPLO de uso del IF
DECLARE @nombre varchar(100), @siglas varchar(3)
SET @siglas = 'SJO'

IF  @siglas = 'SJO' BEGIN
     SET @nombre = 'SAN JOSÉ'
END
ELSE BEGIN
    SET @nombre = 'Otra Provincia'  
END 
PRINT @nombre

go


-- Ejemplo, usando la función Exists: 

IF EXISTS(SELECT * 
	FROM [dbo].[Clientes] 
		WHERE Cliente_ID=3) BEGIN
PRINT 'El cliente existe '
END 
ELSE BEGIN
	PRINT 'El cliente NO existe '
END

--  Otra forma de peguntar si existe

DECLARE @cant_regs int
SELECT @cant_regs= count(*)
				FROM [dbo].[Clientes]
				WHERE Cliente_ID=200
IF @cant_regs > 0 BEGIN
PRINT 'El cliente existe '
END 
ELSE BEGIN
	PRINT 'El cliente NO existe '
END

-- SELECT con COUNT para saber cuantos hay osea cuentemelos xd
SELECT count(*)
				FROM [dbo].[Clientes]
				WHERE Pais='USA'
go


-- EJEMPLO, TRY CATCH
BEGIN TRY
      DECLARE @divisor int , 
      @dividendo int, 
      @resultado int
 
     SET @dividendo = 100
     SET @divisor = 0

     -- Esta línea provoca un error
     SET @resultado = @dividendo/@divisor
     PRINT 'No hay error'
END TRY
BEGIN CATCH
     PRINT 'Se despicho el script'
END CATCH 

go

-- EJEMPLO 2 TRY CATCH
BEGIN TRY
      DECLARE @divisor int , 
      @dividendo int, 
      @resultado int
 
     SET @dividendo = 100
     SET @divisor = 0

     -- Esta línea provoca un error
     SET @resultado = @dividendo/@divisor
     PRINT 'No hay error'
END TRY

BEGIN CATCH
	PRINT 'Número: ' + Convert(varchar(20),ERROR_NUMBER())
	PRINT 'Severidad: ' + Convert(varchar(20),ERROR_SEVERITY())
	PRINT 'Estado: ' + Convert(varchar(20),ERROR_STATE())
	PRINT 'Proc. : ' + Convert(varchar(20),ERROR_PROCEDURE())   
	PRINT 'Línea: ' + Convert(varchar(20),ERROR_LINE())   
	PRINT 'Texto: ' + Convert(varchar(20),ERROR_MESSAGE())
END CATCH 
go


-- EJEMPLO SELECT TRY CATCH
  BEGIN TRY
      DECLARE @divisor int , 
      @dividendo int, 
      @resultado int
 
     SET @dividendo = 100
     SET @divisor = 0

     -- Esta línea provoca un error
     SET @resultado = @dividendo/@divisor
     PRINT 'No hay error'
END TRY

BEGIN CATCH
	
 SELECT ERROR_NUMBER() AS ErrorNumber,  
  ERROR_SEVERITY() AS ErrorSeverity,  
  ERROR_STATE() AS ErrorState,  
  ERROR_PROCEDURE() AS ErrorProcedure,  
  ERROR_LINE() AS ErrorLine,  
  ERROR_MESSAGE() AS ErrorMessage
END CATCH 
go


-- CREAR Procedimiento básico

CREATE PROCEDURE pa_Dice_Hola_DavidR
AS BEGIN
      PRINT 'Hola Mundo';
END
-- LLAMAR o ejecutar el procedimiento almacenado
EXECUTE pa_Dice_Hola_DavidR
go

--Crear procedimiento almacendo que
-- Reciba la Categoria_ID y retorne
-- todos los productos de esa categoria

CREATE PROCEDURE pa_Dice_Hola_DavidR_V1
	@Categoria_ID varchar(20)
AS BEGIN 
	SELECT * FROM [dbo].[Productos] WHERE Categoria_ID=@Categoria_ID
END

EXECUTE pa_Dice_Hola_DavidR_V1 '8'

go
--altera la vaina
alter procedure pa_Dice_Hola_DavidR_V1
	@Categoria_ID varchar(20)
AS BEGIN 
	SELECT * FROM [dbo].[Productos] WHERE Categoria_ID=@Categoria_ID
END

go

--hacer un procedimiento almacenado que inserte un producto
--(debe recibir todos los valores del producto)
--TIENE que validar que la categoria exista
--TIENE que validar que el precio sea mayor a cero 


create PROCEDURE pa_insertar_DavidR_V1 @Produ_ID int,
@nomP varchar(50),
@Prove_ID int,
@Catg_ID int,
@Uni varchar(50),
@prec numeric(6,2)

AS
declare @Cant_regs int
SELECT @Cant_regs = count(*)
			FROM [dbo].[Categorias]
				WHERE Categoria_ID=@Catg_ID
	
IF @prec > 0 AND @Cant_regs >0 BEGIN
	INSERT INTO [dbo].[Productos]
		(Producto_ID, Nom_Producto, Proveedor_ID, Categoria_ID, Unidad, Precio)
		VALUES (@Produ_ID,@nomP, @Prove_ID, @Catg_ID, @Uni, @prec)
END 
ELSE BEGIN
	PRINT 'El cliente NO existe '
END

EXECUTE pa_insertar_DavidR_V1 99,'Coquita',1,8,'6ixpack',-200

/*IF @Catg_ID > 0 BEGIN
	INSERT INTO [dbo].[Productos]
	(Producto_ID, Nom_Producto, Proveedor_ID, Categoria_ID, Unidad, Precio)
	VALUES (@Produ_ID,@nomP, @Prove_ID, @Catg_ID, @Uni, @prec)
end
else BEGIN
	PRINT 'NO HAY'
	
end*/




DROP PROCEDURE pa_insertar_DavidR_V1;  
GO  

/* IF EXISTS(SELECT * 
	FROM [dbo].[Clientes] 
		WHERE Cliente_ID=3) BEGIN
PRINT 'El cliente existe '
END 
ELSE BEGIN
	PRINT 'El cliente NO existe '
END 
**
SELECT @Catg_ID= count(*)
				FROM [dbo].[Productos]
				WHERE Categoria_ID=200
IF @Precio > 0 BEGIN
PRINT 'El cliente existe '
END 
ELSE BEGIN
	PRINT 'El cliente NO existe '
END
*/