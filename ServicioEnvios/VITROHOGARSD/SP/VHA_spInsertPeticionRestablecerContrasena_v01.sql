USE [VITROHOGARSD]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spInsertPeticionRestablecerContrasena]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].[VHA_spInsertPeticionRestablecerContrasena]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez
-- Create date: 16/03/2022
-- Description:	Inserta los datos de la Peticion parar restablecer contraseña
--				Siempre se inserta en el estatusPeticion = 1 
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spInsertPeticionRestablecerContrasena]
	-- Add the parameters for the stored procedure here
	@idAgente varchar(10),
	@iCliente varchar(10), 
	@correo varchar(100)
AS
DECLARE @ID varchar(10);

BEGIN
	SET NOCOUNT ON;

IF  (@iCliente IS NOT NULL AND @idAgente IS NOT NULL)
BEGIN 
SET @ID = @idAgente
END 
ELSE IF (@idAgente IS NULL)
BEGIN
SET @ID = @iCliente
END

	INSERT INTO contrasenaCallReset 
	(idAgente, 
	idCliente, 
	correo, 
	fechaPeticion, 
	estatusPeticion, 
	FechaEnvioCorreo, 
	estatusReset,  
	FechaReset, 
	fechaAdd, 
	userAdd, 
	fechaMod, 
	userMod)
	VALUES(
		@idAgente,
		@iCliente,
		@correo,
		GETDATE(),
		1, --Siempre que se inserta una nueva peticion el estatusPeticion debe de ser 1
		NULL,
		'Pendiente', 
		NULL, 
		GETDATE(), 
		@ID, 
		NULL,
		NULL)

END
