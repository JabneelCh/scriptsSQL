USE [PRUEBAS]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spUpdateContrasenaSD]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].VHA_spUpdateContrasenaSD
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez
-- Create date: 22/03/2022
-- Description:	Actualiza/Inserta la contraseña de los Clientes/Agentes de la WebApp Subdistribuidores   
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spUpdateContrasenaSD] 
	-- Add the parameters for the stored procedure here
@password varchar(150), 
@correo varchar(100)
AS
BEGIN
DECLARE @idCliente varchar(15);
DECLARE @idAgente varchar(15);
	SET NOCOUNT ON;
	--Entra a buscar si existe el correo en la tabla de clientes para extraer el id del mismo y proceder a actualizar la contraseña en AgenteCte
	IF EXISTS(SELECT Ct.Cliente FROM Cte Ct WHERE Ct.eMail1 = @correo OR Ct.eMail2 = @correo AND Ct.Categoria IN ('SUBDISTRIBUCION(SD)') )
	BEGIN
	SET @idCliente = (SELECT Ct.Cliente FROM Cte Ct WHERE Ct.eMail1 = @correo OR Ct.eMail2 = @correo AND Ct.Categoria IN ('SUBDISTRIBUCION(SD)'))
	--UPDATE AgenteCte SET contrasenaWebAppSD = @password WHERE Cliente = @idCliente
	UPDATE Cte SET Contrasena2 = @password WHERE eMail1 = @correo AND Cliente = @idCliente
	END
	--ENTRA Y VALIDA SI EXISTE EL CORREO EN LA TABLA AGENTE PARA EXTRAER EL ID DEL AGENTE Y PROCEDER A ACTUALIZAR LA CONTRASEÑA EN LA TABLA AgenteCte
	ELSE IF EXISTS(SELECT SD.Agente FROM Agente SD WHERE SD.eMail = @correo AND SD.Tipo IN ('Subdistribuidor') )
	BEGIN
	SET @idAgente =(SELECT SD.Agente FROM Agente SD WHERE SD.eMail = @correo AND SD.Tipo IN ('Subdistribuidor'))
	UPDATE AgenteCte SET contrasenaWebAppSD = @password WHERE Agente = @idAgente
	END
END
