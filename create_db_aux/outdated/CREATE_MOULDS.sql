USE [dbdcdeadcd7ddb447e9f4bab1000bd996d]
GO

/****** Object:  Table [dbo].[MOULDS]    Script Date: 05/04/2020 01:54:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MOULDS](
	[code] [bigint] NOT NULL,
	[description] [varchar](300) NULL,
	[id_process] [bigint] NULL,
 CONSTRAINT [PK_Moulds] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MOULDS]  WITH CHECK ADD  CONSTRAINT [FK_MOULDS_PROCESSES] FOREIGN KEY([id_process])
REFERENCES [dbo].[PROCESSES] ([id])
GO

ALTER TABLE [dbo].[MOULDS] CHECK CONSTRAINT [FK_MOULDS_PROCESSES]
GO
