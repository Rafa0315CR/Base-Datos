
/* SE CREA LA BASE DE DATOS*/
CREATE DATABASE Banco_Rafael
GO

 

/* SE SELECCIONA LA BASE DE DATOS CREADA*/
USE Banco_Rafael
GO

 

/* INSTRUCCION QUE PERMITE CREAR LOS DIAGRAMAS*/
Alter authorization on database::Banco_Rafael to sa 
go

 

/*Establece el formato de la fecha en dia/mes/año, 
cualquiera de las dos*/
SET DATEFORMAT dmy
SET LANGUAGE spanish
go

 


Create Table Cuenta (
    NUM_CUENTA INT NOT NULL,
    SALDO  int,
    FECHA_APERTURA date,
    ID_CLIENTE INT 
    Constraint PK_NUMCUENTA primary key (NUM_CUENTA),
    CONSTRAINT CHK_SALDO_POSITIVO CHECK (SALDO >=0)
)
go

 


create table Movimientos (
    NUM_Movimiento  INT IDENTITY NOT NULL,
    Tipo_movimiento VARCHAR(1) NOT NULL,
    Monto_anterior int,
    Monto_movimiento int,
    Fecha date,
    Saldo_posterior int,
    NUM_CUENTA INT
 Constraint PK_NM primary key (NUM_MOVIMIENTO),
 CONSTRAINT FK_NUMCU Foreign key (NUM_CUENTA) references Cuenta (NUM_CUENTA),
 CONSTRAINT CHK_TIPO CHECK (Tipo_movimiento='R' OR Tipo_movimiento='D')
)
go
Insert into Cuenta ( NUM_CUENTA,SALDO ,FECHA_APERTURA,ID_CLIENTE) Values (11112,5000 ,'26/10/2020',01)
Insert into Cuenta ( NUM_CUENTA,SALDO ,FECHA_APERTURA,ID_CLIENTE) Values (11113,2000 ,'06/02/2021',02)
GO
 


/* PA_REGISTRO_MOVIMIENTO (CTA,MONTO,TIPO (R,D) 
a. Validar que la cuenta exista (usand el trow para envar el error)
b. La cuenta tiene que tener fondos( usano en trow para envar el error)
c. insertar el movimiento(inser)(umn_Movimientos es uto incremenal ) 
d. actualizar los datos de la cuenta(Update)
 */

	CREATE PROCEDURE PA_REGISTRO_MOVIMIENTO

		@NUM_CUENTA INT, @MONTO NUMERIC(10,2), 
		@TIPO VARCHAR(1)

	AS BEGIN 

		DECLARE @msg_Error VARCHAR(100)

		IF EXISTS(SELECT * FROM Cuenta
		WHERE NUM_CUENTA = @NUM_CUENTA) BEGIN 
		
			DECLARE @SALDO INT
			SET @SALDO = (SELECT Saldo FROM Cuenta 
			WHERE NUM_CUENTA = @NUM_CUENTA)

			IF (@TIPO = 'R' AND @SALDO > @MONTO)BEGIN

				DECLARE @RETIRO NUMERIC(10,2)
				SET @RETIRO = (SELECT SALDO - @MONTO FROM CUENTA
				WHERE NUM_CUENTA = @NUM_CUENTA)

			END	
			ELSE BEGIN

				SET @msg_Error = 'NO SE HIZO EL RETIRO';
			    THROW 56000,@msg_Error,10;

			END

			IF(@TIPO = 'D') BEGIN

				DECLARE @DEPOSITO NUMERIC(10,2)
				SET @DEPOSITO = (SELECT SALDO + @MONTO FROM CUENTA
				WHERE NUM_CUENTA = @NUM_CUENTA)

			END
			ELSE BEGIN

				SET @msg_Error = 'NO SE HIZO EL DEPOSITO';
			    THROW 56000,@msg_Error,10;

			END
	
		END 
		ELSE BEGIN 

			SET @msg_Error = 'NO EXISTE LA CUENTA';
			THROW 56000,@msg_Error,10;

		END 
	END 
	GO 