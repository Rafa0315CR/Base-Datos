
/** SE CREA LA BASE DE DATOS**/
CREATE DATABASE BD_PROY_Rafael
GO

/** SE SELECCIONA LA BASE DE DATOS CREADA**/
USE BD_PROY_Rafael
GO

/** INSTRUCCION QUE PERMITE CREAR LOS DIAGRAMAS**/
Alter authorization on database::BD_PROY_Rafael to sa 
GO

/*Establece el formato de la fecha en dia/mes/a�o, 
cualquiera de las dos*/
SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

/*Creaci�n de las tablas*/
CREATE TABLE CLIENTES(
    [CODIGO_CLIENTE] [numeric](5, 0)    NOT NULL,
    [NOMBRE] [varchar](25)                NULL,
    [DIRECCION] [varchar](50)            NULL,
    [PROVINCIA] [varchar](20)            NULL,
    [TELEFONO] [varchar](11)            NULL,
    [FAX] [varchar](11)                    NULL,
 CONSTRAINT [PK_CLIENTES] PRIMARY KEY ([CODIGO_CLIENTE]),

 

) 
GO

CREATE TABLE PROYECTOS (
    COD_PROYECTO VARCHAR(5) NOT NULL,
    DESCRIPCION VARCHAR(60) NULL,
    COSTO_TOTAL NUMERIC(10,2) NOT NULL,
    FEC_INICIO DATE NULL,
    FEC_FIN DATE NULL,
    [CODIGO_CLIENTE] [numeric](5, 0)    NOT NULL,
    CONSTRAINT PK_PROYECTOS PRIMARY KEY(COD_PROYECTO), 
    CONSTRAINT [FK_CLIENTES_PROYECTOS] FOREIGN KEY ([CODIGO_CLIENTE]) 
    REFERENCES [CLIENTES]([CODIGO_CLIENTE])
)
GO

INSERT INTO CLIENTES([CODIGO_CLIENTE],[NOMBRE],[DIRECCION]
           ,[PROVINCIA],[TELEFONO],[FAX])
     VALUES(1,'Pedro','San Pablo', 'Heredia','8825-6467','2211-5858')
GO

INSERT INTO PROYECTOS (COD_PROYECTO,DESCRIPCION,
    COSTO_TOTAL,FEC_INICIO,FEC_FIN, CODIGO_CLIENTE) VALUES
    (1,'Construccion Cochera',5000,'01/05/2019','30/03/2020',1)

INSERT INTO PROYECTOS (COD_PROYECTO,DESCRIPCION,
    COSTO_TOTAL,FEC_INICIO,FEC_FIN,CODIGO_CLIENTE) VALUES
    (2,'Construccion CASA',8000,'01/12/2019','20/08/2021', 1)
GO

/*10. Crear un procedimiento que reciba como parametros 
los datos de pago de un proyecto. Debe validar que el 
proyecto exista y en caso afirmativo insertar el pago. BD Lab1_A*/

CREATE PROCEDURE pa_INSERTAR_PAGO 
    @NUM_PAGO VARCHAR(5),@DETALLE varchar(60),
    @MONTO numeric(10,2), @COD_PROYECTO varchar(5)
AS BEGIN
    IF EXISTS(SELECT * FROM PROYECTOS
          WHERE COD_PROYECTO = @COD_PROYECTO) BEGIN
        
        INSERT INTO PAGOS ([NUM_PAGO],[DETALLE],[MONTO],
           [FEC_PAGO],[COD_PROYECTO]) VALUES (@NUM_PAGO,
           @DETALLE,@MONTO,GETDATE(),@COD_PROYECTO)
    END 
    ELSE BEGIN
        PRINT 'El PROYECTO NO EXISTE '
    END
END
GO

EXEC pa_INSERTAR_PAGO '150','TERCER ABONO',5000,1
GO


CREATE TABLE PAGOS(
    NUM_PAGO varchar(5) NOT NULL,
    DETALLE varchar(60) NULL,
    MONTO numeric(10, 2) NULL,
    FEC_PAGO datetime NULL,
    COD_PROYECTO varchar(5) NOT NULL,
    CONSTRAINT [PK_PAGO] PRIMARY KEY (NUM_PAGO ASC),
    CONSTRAINT [FK_PROYECTOS_PAGOS] FOREIGN KEY(COD_PROYECTO)
        REFERENCES PROYECTOS (COD_PROYECTO)
) 
GO

ALTER TABLE PROYECTOS ADD MONTO_ABONOS NUMERIC(10,2)NOT NULL DEFAULT(0)
GO

/*Modificar el procedimiento de insertar pago para que:
- En caso de existir el proyecto obtener el ACUMULDO_PAGOS del proyecto
- Sumarla al acumulado el monto actual del pago
- Insertar el nuevo pago
- Acualizar el campo ACUMULADO_PAGOS de proyecto,
con el nuevo monto (ACUMULADO_PAGOS + MONTO)*/

CREATE PROCEDURE pa_INSERTAR_PAGO
	@NUM_PAGO VARCHAR(5), @DETALLE varchar(60), 
	@MONTO numeric(10,2), @COD_PROYECTO varchar(5) 
AS BEGIN 
	IF EXISTS(SELECT * FROM PROYECTOS 
	WHERE COD_PROYECTO = @COD_PROYECTO) BEGIN 
	
	DECLARE @ACUMULANDO_MONTOS NUMERIC(10, 2)
	SET @ACUMULANDO_MONTOS = (SELECT MONTO_ABONOS FROM PROYECTOS 
	WHERE COD_PROYECTO = @COD_PROYECTO)
	PRINT @ACUMULANDO_MONTOS
	
	SET @ACUMULANDO_MONTOS += @MONTO

	UPDATE [dbo].[PROYECTOS]
	SET MONTO_ABONOS = @ACUMULANDO_MONTOS
	WHERE COD_PROYECTO = @COD_PROYECTO

	INSERT INTO PAGOS ([NUM_PAGO],[DETALLE],[MONTO], [FEC_PAGO],[COD_PROYECTO]) 
	VALUES (@NUM_PAGO, @DETALLE,@MONTO,GETDATE(),@COD_PROYECTO) 
END 
	ELSE BEGIN 
	PRINT 'El PROYECTO NO EXISTE ' 
	END 
END 
GO 

EXEC pa_INSERTAR_PAGO '150','TERCER ABONO',5000,1 
GO

/*10.3 Modificar el proceimiento de insertar pago para que:
 -en caso de existir el proyecto obtener el ACUMULADO_PAGOS del proyecto
 -Sumarle al acomulado el monto actual del pago
 -validar que monto acumulado no supere COSTO_TOTAL.No hacer el insert y el update (print abono supera costo total)
 -Insertar el nuevo pago
 *Actualizar el campo ACUMULADO_PAGOS de proyectos, con el nuevo monto (ACUMULADO_PAGOS + Monto)
 */

CREATE PROCEDURE pa_INSERTAR_PAGO

	@NUM_PAGO VARCHAR(5), @DETALLE varchar(60), 
	@MONTO numeric(10,2), @COD_PROYECTO varchar(5) 

AS BEGIN 
	IF EXISTS(SELECT * FROM PROYECTOS 
	WHERE COD_PROYECTO = @COD_PROYECTO) BEGIN 

		DECLARE @ACUMULANDO_MONTOS NUMERIC(10, 2)
		SET @ACUMULANDO_MONTOS = (SELECT MONTO_ABONOS FROM PROYECTOS 
		WHERE COD_PROYECTO = @COD_PROYECTO)
	
		SET @ACUMULANDO_MONTOS += @MONTO

		DECLARE @COSTO_TOTAL NUMERIC(10, 2)
		SET @COSTO_TOTAL = (SELECT [COSTO_TOTAL] FROM PROYECTOS 
		WHERE COD_PROYECTO = @COD_PROYECTO)

		IF (@COSTO_TOTAL >= @ACUMULANDO_MONTOS) BEGIN

			UPDATE [dbo].[PROYECTOS]
			SET MONTO_ABONOS = @ACUMULANDO_MONTOS
			WHERE COD_PROYECTO = @COD_PROYECTO

			INSERT INTO PAGOS ([NUM_PAGO],[DETALLE],[MONTO], [FEC_PAGO],[COD_PROYECTO]) 
			VALUES (@NUM_PAGO, @DETALLE,@MONTO,GETDATE(),@COD_PROYECTO) 
		END
		ELSE BEGIN 
			PRINT 'NO SE INSERTO NI SE ACTUALIZO ' 
		END 
	END 
	ELSE BEGIN 
		PRINT 'El PROYECTO NO EXISTE ' 
	END 
END 
GO 

EXEC pa_INSERTAR_PAGO '150','TERCER ABONO',5000,1 
GO