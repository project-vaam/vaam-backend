USE [dbdcdeadcd7ddb447e9f4bab1000bd996d]
GO

/****** Object:  Table [dbo].[EVENTS]    Script Date: 05/04/2020 01:54:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EVENTS](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[caseId] [bigint] NOT NULL,
	[duration] [bigint] NOT NULL,
	[end_date] [datetime2](7) NULL,
	[name] [varchar](300) NULL,
	[resource] [varchar](200) NULL,
	[role] [varchar](100) NULL,
	[start_date] [datetime2](7) NULL,
	[LOG_ID] [bigint] NULL,
	[code_part] [varchar](100) NULL,
	[id_process] [bigint] NULL,
	[estimated_end] [bit] NULL,
 CONSTRAINT [PK_EVENTS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EVENTS] ADD  CONSTRAINT [DF_EVENTS_duration]  DEFAULT ((0)) FOR [duration]
GO

ALTER TABLE [dbo].[EVENTS]  WITH CHECK ADD  CONSTRAINT [FK_EVENTS_ACTIVITIES] FOREIGN KEY([name])
REFERENCES [dbo].[ACTIVITIES] ([name])
GO

ALTER TABLE [dbo].[EVENTS] CHECK CONSTRAINT [FK_EVENTS_ACTIVITIES]
GO

ALTER TABLE [dbo].[EVENTS]  WITH CHECK ADD  CONSTRAINT [FK_EVENTS_MOULDS] FOREIGN KEY([caseId])
REFERENCES [dbo].[MOULDS] ([code])
GO

ALTER TABLE [dbo].[EVENTS] CHECK CONSTRAINT [FK_EVENTS_MOULDS]
GO

ALTER TABLE [dbo].[EVENTS]  WITH CHECK ADD  CONSTRAINT [FK_EVENTS_PARTS] FOREIGN KEY([code_part])
REFERENCES [dbo].[PARTS] ([code])
GO

ALTER TABLE [dbo].[EVENTS] CHECK CONSTRAINT [FK_EVENTS_PARTS]
GO

ALTER TABLE [dbo].[EVENTS]  WITH CHECK ADD  CONSTRAINT [FK_EVENTS_PROCESSES] FOREIGN KEY([id_process])
REFERENCES [dbo].[PROCESSES] ([id])
GO

ALTER TABLE [dbo].[EVENTS] CHECK CONSTRAINT [FK_EVENTS_PROCESSES]
GO

ALTER TABLE [dbo].[EVENTS]  WITH CHECK ADD  CONSTRAINT [FKro808iycxm1vfukekdwla0o1b] FOREIGN KEY([LOG_ID])
REFERENCES [dbo].[LOGS] ([id])
GO

ALTER TABLE [dbo].[EVENTS] CHECK CONSTRAINT [FKro808iycxm1vfukekdwla0o1b]
GO

