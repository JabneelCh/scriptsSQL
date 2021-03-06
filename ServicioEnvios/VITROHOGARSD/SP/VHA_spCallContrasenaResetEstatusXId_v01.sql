USE [VITROHOGARSD]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spCallContrasenaResetEstatusXId]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].[VHA_spCallContrasenaResetEstatusXId]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez
-- Create date: 14/03/2022
-- Description:	Cambia el estatus de los registros para el control de envios 
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spCallContrasenaResetEstatusXId]
	-- Add the parameters for the stored procedure here
	 @Id int 
	,@estatus TINYINT
AS
BEGIN
	SET NOCOUNT ON;

	IF @estatus = 2
	BEGIN 
		UPDATE
		contrasenaCallReset
		SET
		estatusPeticion = @estatus,
		FechaEnvioCorreo = GETDATE()
		WHERE idCCR = @Id
	END
	ELSE 
	BEGIN UPDATE
		contrasenaCallReset
		SET
		estatusPeticion = @estatus
		WHERE idCCR = @Id
	END
END
