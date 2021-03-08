USE [dbdcdeadcd7ddb447e9f4bab1000bd996d]
GO

/****** Object:  Table [dbo].[ACTIVITIES_USERS]    Script Date: 03/05/2020 13:24:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ACTIVITIES_USERS](
	[username] [varchar](200) NOT NULL,
	[activityId] [bigint] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NULL,
 CONSTRAINT [PK_ACTIVITIES_USERS] PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[activityId] ASC,
	[startDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS] ADD  CONSTRAINT [DF_ACTIVITIES_USERS_startDate]  DEFAULT (sysdatetime()) FOR [startDate]
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS]  WITH CHECK ADD  CONSTRAINT [FK_ACTIVITIES_USERS_ACTIVITIES] FOREIGN KEY([activityId])
REFERENCES [dbo].[ACTIVITIES] ([id])
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS] CHECK CONSTRAINT [FK_ACTIVITIES_USERS_ACTIVITIES]
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS]  WITH CHECK ADD  CONSTRAINT [FK_ACTIVITIES_USERS_USERS] FOREIGN KEY([username])
REFERENCES [dbo].[USERS] ([username])
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS] CHECK CONSTRAINT [FK_ACTIVITIES_USERS_USERS]
GO

