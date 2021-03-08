USE [dbdcdeadcd7ddb447e9f4bab1000bd996d]
GO

/****** Object:  Table [dbo].[PARTS]    Script Date: 05/04/2020 01:55:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PARTS](
	[code] [varchar](100) NOT NULL,
	[code_mould] [bigint] NULL,
	[description] [varchar](300) NULL,
	[rfid_tag] [varchar](100) NULL,
	[id_process] [bigint] NULL,
 CONSTRAINT [PK_PARTS] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PARTS]  WITH CHECK ADD  CONSTRAINT [FK_PARTS_MOULDS] FOREIGN KEY([code_mould])
REFERENCES [dbo].[MOULDS] ([code])
GO

ALTER TABLE [dbo].[PARTS] CHECK CONSTRAINT [FK_PARTS_MOULDS]
GO

ALTER TABLE [dbo].[PARTS]  WITH CHECK ADD  CONSTRAINT [FK_PARTS_PROCESSES] FOREIGN KEY([id_process])
REFERENCES [dbo].[PROCESSES] ([id])
GO

ALTER TABLE [dbo].[PARTS] CHECK CONSTRAINT [FK_PARTS_PROCESSES]
GO

ALTER TABLE [dbo].[PARTS]  WITH CHECK ADD  CONSTRAINT [FK_PARTS_TAGS] FOREIGN KEY([rfid_tag])
REFERENCES [dbo].[TAGS] ([rfid])
GO

ALTER TABLE [dbo].[PARTS] CHECK CONSTRAINT [FK_PARTS_TAGS]
GO

