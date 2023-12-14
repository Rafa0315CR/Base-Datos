
--Trigers

	CREATE TRIGGER TR_CLIENTS_UPDATE ON CLIENTES AFTER INSERT 
	AS BEGIN

		-- SET NOCOUNT ON evita que se generen
		-- mensajes de texto con cada instrucción
		SET NOCOUNT ON;

		DECLARE @cod AS NUMERIC(5,0)
		DECLARE @Nomb AS VARCHAR(25)

		SELECT @cod = [CODIGO_CLIENTE], @Nomb =[NOMBRE]
			FROM inserted

		SELECT @Cod,@Nomb

	end
	GO
	 
	 INSERT INTO [dbo].[CLIENTES]([CODIGO_CLIENTE],
				[NOMBRE],[DIRECCION],[PROVINCIA],
				[TELEFONO],[FAX])
		VALUES(70,'A','AAA','AAAA','AAAAA','AAAAAAA')
go

--No entendi

	/* EN LA BASE DE DATOS DE PROYECTO*/
	/*DISPARDOR O TRIGGER QUE RESPONDA AL INSERT DE UN PAGO*/
	/*EL TRIGGER DEBE ACTUALIZAR EL [ACUMULADO_PAGO DEL PROYECO
	AL QUE SE LE HIZO EL PAGO O ABONO*/

	/*PASOS
	A.obtener el codigo del proyecto y el monto del abono.TB INSETED
	B.obener el [Acumulado_pagos] de poyectos.Tabla proyectos
	c.sumar el monto del abono + el [acumulado_pagos]
	D.realiza el update  la tabl proyectos con el nuevo [Acumulado_Pagos]
	*/

	CREATE TRIGGER TR_CLIENTS_INSERT ON PAGOS AFTER INSERT
	AS BEGIN

		-- SET NOCOUNT ON evita que se generen
		-- mensajes de texto con cada instrucción
		SET NOCOUNT ON;

		DECLARE @cod AS NUMERIC(5,0)
		DECLARE @monto AS NUMERIC(10,2)

		SELECT @cod = [COD_PROYECTO], @monto = MONTO
			FROM inserted

		SELECT @monto = MONTO_ABONOS
			FROM PROYECTOS WHERE COD_PROYECTO = @cod

		SELECT @cod = COD_PROYECTO, @monto = MONTO
			FROM inserted

		UPDATE PROYECTOS SET MONTO_ABONOS = MONTO_ABONOS + @monto
			WHERE COD_PROYECTO = @cod

	END
	--INSERT
	GO
	 
/*EN LA BASE DE CUENTA */