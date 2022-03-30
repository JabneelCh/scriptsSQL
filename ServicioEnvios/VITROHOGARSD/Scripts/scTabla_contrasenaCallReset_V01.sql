USE [VITROHOGARSD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[contrasenaCallReset]') AND type in (N'U'))
DROP TABLE [dbo].[contrasenaCallReset]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contrasenaCallReset](
	[idCCR] [int] IDENTITY(1,1) NOT NULL,
	[idAgente] [varchar](10) NULL,
	[idCliente] [varchar](10) NULL,
	[correo] [varchar](100) NULL,
	[fechaPeticion] [datetime] NOT NULL,
	[estatusPeticion] [int] NULL,
	[FechaEnvioCorreo] [datetime] NULL,
	[estatusReset] [varchar](20) NULL,
	[FechaReset] [datetime] NULL,
	[fechaAdd] [datetime] NULL,
	[userAdd] [varchar](10) NULL,
	[fechaMod] [datetime] NULL,
	[userMod] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCCR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


