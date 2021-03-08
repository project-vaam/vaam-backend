USE [dbdcdeadcd7ddb447e9f4bab1000bd996d]
GO

/****** Object:  Table [dbo].[ACTIVITIES_USERS]    Script Date: 05/04/2020 01:53:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ACTIVITIES_USERS](
	[username] [varchar](200) NOT NULL,
	[name_activity] [varchar](300) NOT NULL,
 CONSTRAINT [PK_ACTIVITIES_USERS] PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[name_activity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS]  WITH CHECK ADD  CONSTRAINT [FK_ACTIVITIES_USERS_ACTIVITIES] FOREIGN KEY([name_activity])
REFERENCES [dbo].[ACTIVITIES] ([name])
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS] CHECK CONSTRAINT [FK_ACTIVITIES_USERS_ACTIVITIES]
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS]  WITH CHECK ADD  CONSTRAINT [FK_ACTIVITIES_USERS_USERS] FOREIGN KEY([username])
REFERENCES [dbo].[USERS] ([username])
GO

ALTER TABLE [dbo].[ACTIVITIES_USERS] CHECK CONSTRAINT [FK_ACTIVITIES_USERS_USERS]
GO

