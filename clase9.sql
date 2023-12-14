
BEGIN TRY
      DECLARE @divisor int , 
      @dividendo int, 
      @resultado int
 
     SET @dividendo = 100
     SET @divisor = 1

     -- Esta línea provoca un error
     SET @resultado = @dividendo/@divisor
     PRINT 'No hay error'
END TRY
BEGIN CATCH
     PRINT 'Se ha producido un error'
END CATCH 
go

--Ejemplo 2

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
GO

--Ejemplo 3

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
	GO
	--Ejemplo sin el catch 4

	 DECLARE @divisor int , 
		  @dividendo int, 
		  @resultado int,
		  @msg_Error VARCHAR(100)
 
		 SET @dividendo = 100
		 SET @divisor = 5
		 IF @divisor = 0 BEGIN
			SET @msg_Error = 'NO SE PUEDE DIVIDIR ENTRE 0';
			THROW 56000, @msg_ERROR, 10
		END
		 -- Esta línea provoca un error
		 SET @resultado = @dividendo/@divisor
		 PRINT concat('No hay Error.',' El resultado es: ',trim(str(@resultado)))
		 GO

	--Ejemplo 5

	DECLARE @Tipo_Movimiento VARCHAR(1)
	DECLARE @msg_Error VARCHAR(100)
	SET @Tipo_Movimiento = 'A'
	IF NOT(@Tipo_Movimiento = 'R' OR @Tipo_Movimiento ='D') BEGIN
	   SET @msg_Error = 'El TIPO MOVIMIENTO debe ser R o D';
	   THROW 56000,@msg_Error,10
	END
	GO
	--Ejemplo 6 usando throw en el catch
	
		 DECLARE @divisor int , 
		  @dividendo int, 
		  @resultado int
		 
		 BEGIN TRY
			 SET @dividendo = 100
			 SET @divisor = 0
		 			 -- Esta línea provoca un error
			 SET @resultado = @dividendo/@divisor
			 PRINT concat('No hay Error.',' El resultado es: ',trim(str(@resultado)))
		 END TRY
		 BEGIN CATCH
			THROW;
		END CATCH
		GO






