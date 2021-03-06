USE [VITROHOGARSD]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spControlEnvioCorreoResetPassword]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].[VHA_spControlEnvioCorreoResetPassword]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez
-- Create date: Jueves 10 de Marzo de 2022
-- Description:	Obtiene los registros de la tabla [dbo].[contrasenaCallReset] por el Estatus
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spControlEnvioCorreoResetPassword]
	-- Add the parameters for the stored procedure here
	@Estatus int
AS
BEGIN
	SELECT
		idCCR,
		idAgente,
		idCliente,
		correo,
		correo AS Destinatario,
		fechaPeticion,
		estatusPeticion,
		FechaEnvioCorreo,
		estatusReset,
		FechaReset
	FROM
		contrasenaCallReset	
	WITH(NOLOCK)
	WHERE
		estatusPeticion = @Estatus
END

-- exec VHA_spControlEnvioCorreoResetPassword '1'