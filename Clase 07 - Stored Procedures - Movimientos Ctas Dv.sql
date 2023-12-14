/*
CREATE TABLE Cuenta (
	NUM_CUENTA INT NOT NULL,
	SALDO  INT,
	FECHA_APERTURA DATE,
	ID_CLIENTE INT,
	CONSTRAINT PK_NUMCUENTA PRIMARY KEY (NUM_CUENTA)
)
GO

CREATE TABLE Movimientos (
	NUM_MOVIMIENTO  INT IDENTITY(1,1) NOT NULL,
	TIPO_MOVIMIENTO VARCHAR(1) NOT NULL,
	MONTO_ANTERIOR INT,
	MONTO_MOVIMIENTO INT,
	FECHA DATE,
	SALDO_POSTERIOR INT,
	NUM_CUENTA INT
 CONSTRAINT PK_NM PRIMARY KEY (NUM_MOVIMIENTO),
 CONSTRAINT FK_CUENTA_MOVIMIENTOS FOREIGN KEY (NUM_CUENTA) REFERENCES Cuenta (NUM_CUENTA),
 CONSTRAINT CHK_TIPO CHECK (TIPO_MOVIMIENTO='R' OR TIPO_MOVIMIENTO='D')
)
go
INSERT INTO Cuenta ( NUM_CUENTA,SALDO ,FECHA_APERTURA,ID_CLIENTE) VALUES (1,5000 ,'6/20/2015',01)
INSERT INTO Cuenta ( NUM_CUENTA,SALDO ,FECHA_APERTURA,ID_CLIENTE) VALUES (2,750 ,'6/20/2015',02)

go
*/

/**/
/* PA_REGISTRAR_RETIRO
Debe registrar el retiro de dinero de la cuenta bancaria, para lo 
cual debe recibir los siguiente parametros (Cta,Monto_Mov)
Debe validar que:
-Validar que la cuenta exista 
-Validar que la cuenta tiene que tener fondos para hacer el retiro
-Insertar el movimiento en la tabla Movimientos
-Actualizar el saldo de la tabla Cuenta */
USE BANCO_CLIENTE
GO

CREATE PROCEDURE Pa_Registrar_Retiro_DaveR
@Num_Cta INT,
@Monto_Mov INT,
@T_Mov varchar(1)

AS BEGIN
    DECLARE @Cant_Regs INT
    DECLARE @Saldo_Cta INT
    DECLARE @Saldo_Posterior INT

    SELECT @Cant_Regs = COUNT(*) FROM [dbo].[Cuenta] 
	WHERE NUM_CUENTA = @Num_Cta
    IF @Cant_Regs = 0 BEGIN
        PRINT 'LA CUENTA NO EXISTE'
    END
    ELSE BEGIN

        SELECT @Saldo_Cta = SALDO
		FROM [dbo].[Cuenta] 
		WHERE [NUM_CUENTA] = @Num_Cta

			IF @T_Mov = 'R' BEGIN
				IF @Saldo_Cta=@Monto_Mov BEGIN
				SET @Saldo_Posterior = @Saldo_Cta-@Monto_Mov
				END
				ELSE BEGIN
				PRINT 'LA CUENTA NO TIENE FONDOS SUFICIENTES'
				END
			END
			ELSE BEGIN
				SET @Saldo_Posterior = @Saldo_Cta+@Monto_Mov
            -- INSERT
				INSERT INTO Movimientos ([TIPO_MOVIMIENTO],[MONTO_ANTERIOR],[MONTO_MOVIMIENTO],[FECHA],[SALDO_POSTERIOR],[NUM_CUENTA])
                 VALUES(@T_Mov, @Saldo_Cta, @Monto_Mov, GETDATE(), @Saldo_Posterior, @Num_Cta)

            --UPDATE
            UPDATE [dbo].[Cuenta] SET SALDO = @Saldo_Posterior WHERE [NUM_CUENTA] = @Num_Cta

			END
		END
	END


EXECUTE Pa_Registrar_Retiro_DaveR 14, 50000, 'D'
go

/*DROP PROCEDURE */

INSERT INTO Cuenta ( NUM_CUENTA,SALDO ,FECHA_APERTURA,ID_CLIENTE) VALUES (117,299 ,'6/20/2000',07)
go



/*
	PA_REGISTRAR_TRANSFERENCIA
	Debe recibir los siguientes parametros (Cta_Origen, Cta_Destino, Monto_Mov)
	-Insertar los movimientos en la tabla Movimientos (2)
	-Actualizar el saldo de las cuentas (2) 
*/


CREATE PROCEDURE Pa_Transferir_Retiro_DaveR
@Cta_Origen INT,
@Cta_Destino INT,
@Monto_Mov INT,
@T_Mov varchar(1)

AS BEGIN
    DECLARE @Cant_Regs INT
    DECLARE @Saldo_Cta INT
    DECLARE @Saldo_Posterior INT

    SELECT @Cant_Regs = COUNT(*) FROM [dbo].[Cuenta] 
	WHERE NUM_CUENTA = @Num_Cta
    IF @Cant_Regs = 0 BEGIN
        PRINT 'LA CUENTA NO EXISTE'
    END
    ELSE BEGIN

        SELECT @Saldo_Cta = SALDO
		FROM [dbo].[Cuenta] 
		WHERE [NUM_CUENTA] = @Num_Cta

			IF @T_Mov = 'R' BEGIN
				IF @Saldo_Cta=@Monto_Mov BEGIN
				SET @Saldo_Posterior = @Saldo_Cta-@Monto_Mov
				END
				ELSE BEGIN
				PRINT 'LA CUENTA NO TIENE FONDOS SUFICIENTES'
				END
			END
			ELSE BEGIN
				SET @Saldo_Posterior = @Saldo_Cta+@Monto_Mov
            -- INSERT
				INSERT INTO Movimientos ([TIPO_MOVIMIENTO],[MONTO_ANTERIOR],[MONTO_MOVIMIENTO],[FECHA],[SALDO_POSTERIOR],[NUM_CUENTA])
                 VALUES(@T_Mov, @Saldo_Cta, @Monto_Mov, GETDATE(), @Saldo_Posterior, @Num_Cta)

            --UPDATE
            UPDATE [dbo].[Cuenta] SET SALDO = @Saldo_Posterior WHERE [NUM_CUENTA] = @Num_Cta

			END
		END
	END