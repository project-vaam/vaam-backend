USE dbdcdeadcd7ddb447e9f4bab1000bd996d
GO

/****** Object:  Table [dbo].[TAGS]    Script Date: 24/03/2020 23:30:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TAGS](
	[rfid] [varchar](100) NOT NULL,
	[is_available] [bit] NOT NULL,
 CONSTRAINT [PK_TAGS] PRIMARY KEY CLUSTERED 
(
	[rfid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
