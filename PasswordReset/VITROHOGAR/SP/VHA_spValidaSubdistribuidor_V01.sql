USE [PRUEBAS]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[VHA_spValidaSubdistribuidor]') 
 AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE [dbo].VHA_spValidaSubdistribuidor
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jabneel Chavez< ? >
-- Create date: 16/03/2022
-- Description:	Busca si hace Match el Correo del Cliente/Subdistribuidor, si 1
--              procede a insertar la peticion en la tabla [dbo].[contrasenaCallReset] 
--              de la Base de Datos VITROHOGARSD, Si 0 No hace nada
-- =============================================
CREATE PROCEDURE [dbo].[VHA_spValidaSubdistribuidor]
	
	--@id varchar(10), 
	@correo varchar(100),
	@return_Sts int output

AS
BEGIN
DECLARE @IdCliente varchar(10);
DECLARE @IdAgente varchar(10);
	SET NOCOUNT ON;
	--VALIDA SI EXISTE EL CORREO DEL CLIENTE EN LA TABLA Cte
	IF EXISTS(SELECT Ct.Cliente FROM Cte Ct WHERE Ct.eMail1 = @correo OR Ct.eMail2 = @correo AND Ct.Categoria IN ('SUBDISTRIBUCION(SD)'))
	 BEGIN
	  --SETEA ID´s PARA ENVIAR EN LA PETICION
		SET @IdCliente =(SELECT Ct.Cliente FROM Cte Ct WHERE Ct.eMail1 = @correo OR Ct.eMail2 = @correo AND Ct.Categoria IN ('SUBDISTRIBUCION(SD)'))
		SET @IdAgente = (SELECT Agente FROM AgenteCte WHERE Cliente = @IdCliente)

		--INSERTA LA PETICION
		EXEC VITROHOGARSD.dbo.VHA_spInsertPeticionRestablecerContrasena @IdAgente, @IdCliente, @correo
		SET @return_Sts = 1--'Success'

	 END
	 --VALIDA SI EXISTE EL CORREO DEL AGENTE EN LA TABLA Agente
	 ELSE IF EXISTS(SELECT SD.Agente, SD.eMail FROM Agente SD WHERE SD.eMail = @correo AND SD.Tipo IN ('Subdistribuidor') )
	BEGIN
	  --SETEA ID´s PARA ENVIAR EN LA PETICION
		SET @IdAgente =(SELECT SD.Agente FROM Agente SD WHERE SD.eMail = @correo AND SD.Tipo IN ('Subdistribuidor'))
		SET @IdCliente = (SELECT Cliente FROM AgenteCte WHERE Agente = @IdAgente)

		--INSERTA LA PETICION
		EXEC VITROHOGARSD.dbo.VHA_spInsertPeticionRestablecerContrasena @IdAgente, @IdCliente, @correo
		SET @return_Sts = 1--'Success'
		
	 END
	 ELSE 
	 BEGIN
		SET @return_Sts = 0
		
	 END
END


--EXEC VHA_spValidaSubdistribuidor 'hsfkhgsakfgj@correo.com', ''