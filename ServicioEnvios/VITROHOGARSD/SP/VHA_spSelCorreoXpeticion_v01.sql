USE [VITROHOGARSD]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spSelCorreoXpeticion]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].[VHA_spSelCorreoXpeticion]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez
-- Create date: 14/03/2020
-- Description:	obtienen los correos por Id de la peticion
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spSelCorreoXpeticion]
	-- Add the parameters for the stored procedure here
	@idPeticion int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		idCCR AS 'nPeticion',
		CASE
			WHEN correo LIKE '%_@__%.__%' AND PATINDEX('%[^a-z,0-9,@,.,_,\ -]%', correo) = 0
			THEN REPLACE((CASE WHEN (SUBSTRING((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')), (LEN((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')))), (LEN((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')))))) = '.' THEN (SUBSTRING((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')), 0, (LEN((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')))))) ELSE (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(correo, ',', '.'), '@.', '@'), 'co.', 'com'), '.@', '@'), '..', '.')) END), '-.', '.')
			ELSE 'correosnovalidoscfdi@vitrohogar.com.mx'
		END AS correo
	FROM
		[dbo].[contrasenaCallReset]
	WITH(NOLOCK)
	WHERE
		idCCR = @idPeticion
		AND estatusPeticion = 1
		AND correo NOT IN ('SIN@CORREO', 'NOCUENT@GMAIL.COM')
END


--exec VHA_spSelCorreoXpeticion '1'