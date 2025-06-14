USE [fit-admin-system-db]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[BookingDateTime] [datetime] NOT NULL,
	[IsCancelled] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[Photo] [varbinary](max) NULL,
	[MedicalNotes] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsRemoved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Memberships](
	[MembershipID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[MembershipTypeID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipTypes]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipTypes](
	[MembershipTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[DurationDays] [int] NOT NULL,
	[Restrictions] [nvarchar](max) NULL,
	[IsRemoved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MembershipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[WorkoutTypeID] [int] NOT NULL,
	[TrainerID] [int] NOT NULL,
	[Room] [nvarchar](50) NULL,
	[ScheduledDateTime] [datetime] NOT NULL,
	[MaxParticipants] [int] NOT NULL,
	[IsRemoved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](256) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Specialization] [nchar](100) NULL,
	[Phone] [nchar](20) NULL,
	[IsRemoved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkoutTypes]    Script Date: 30.04.2025 13:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkoutTypes](
	[WorkoutTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsRemoved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkoutTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (2, 1, 102, CAST(N'2025-04-29T12:42:47.640' AS DateTime), 1)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (3, 1, 3, CAST(N'2025-04-29T13:22:32.437' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (4, 2, 32, CAST(N'2025-04-29T14:17:20.173' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (5, 2, 65, CAST(N'2025-04-29T14:17:23.117' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (6, 2, 100, CAST(N'2025-04-29T14:17:25.660' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (7, 2, 102, CAST(N'2025-04-29T14:17:28.923' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (8, 2, 3, CAST(N'2025-04-29T14:19:28.080' AS DateTime), 1)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (9, 2, 7, CAST(N'2025-04-29T14:19:32.653' AS DateTime), 1)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (10, 2, 40, CAST(N'2025-04-29T14:20:59.670' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (11, 4, 23, CAST(N'2025-04-29T16:19:29.130' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (12, 4, 68, CAST(N'2025-04-29T16:19:43.307' AS DateTime), 0)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (13, 4, 46, CAST(N'2025-04-29T16:19:48.400' AS DateTime), 1)
INSERT [dbo].[Bookings] ([BookingID], [ScheduleID], [ClientID], [BookingDateTime], [IsCancelled]) VALUES (15, 5, 3, CAST(N'2025-04-30T13:28:09.077' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (3, N'Иван Иванов', CAST(N'1976-03-03' AS Date), N'+79119604268', N'иван.иванов560@example.com', N'г. Москва, ул. Ленина, д. 86', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.313' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (4, N'Сергей Кузнецов', CAST(N'1998-07-19' AS Date), N'+79434622847', N'сергей.кузнецов863@example.com', N'г. Москва, ул. Ленина, д. 100', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.333' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (5, N'Михаил Козлов', CAST(N'1997-06-01' AS Date), N'+79780066554', N'михаил.козлов476@example.com', N'г. Москва, ул. Ленина, д. 49', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.333' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (6, N'Андрей Волков', CAST(N'2005-02-19' AS Date), N'+79140455928', N'андрей.волков816@example.com', N'г. Москва, ул. Ленина, д. 60', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.333' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (7, N'Владимир Смирнов', CAST(N'1983-06-18' AS Date), N'+79438971875', N'владимир.смирнов547@example.com', N'г. Москва, ул. Ленина, д. 94', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (8, N'Михаил Козлов', CAST(N'1967-09-01' AS Date), N'+79445082568', N'михаил.козлов293@example.com', N'г. Москва, ул. Ленина, д. 9', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (9, N'Сергей Петров', CAST(N'1983-06-02' AS Date), N'+79678855936', N'сергей.петров740@example.com', N'г. Москва, ул. Ленина, д. 77', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (10, N'Артем Кузнецов', CAST(N'1965-12-21' AS Date), N'+79987041375', N'артем.кузнецов969@example.com', N'г. Москва, ул. Ленина, д. 53', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (11, N'Михаил Попов', CAST(N'1970-01-27' AS Date), N'+79774884380', N'михаил.попов205@example.com', N'г. Москва, ул. Ленина, д. 60', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (12, N'Евгений Кузнецов', CAST(N'2007-02-04' AS Date), N'+79523358519', N'евгений.кузнецов259@example.com', N'г. Москва, ул. Ленина, д. 66', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (13, N'Иван Иванов', CAST(N'1999-01-25' AS Date), N'+79702302948', N'иван.иванов509@example.com', N'г. Москва, ул. Ленина, д. 32', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (14, N'Артем Кузнецов', CAST(N'2006-07-13' AS Date), N'+79190067022', N'артем.кузнецов172@example.com', N'г. Москва, ул. Ленина, д. 27', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (15, N'Владимир Попов', CAST(N'1971-10-05' AS Date), N'+79006644428', N'владимир.попов177@example.com', N'г. Москва, ул. Ленина, д. 7', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (16, N'Михаил Лебедев', CAST(N'1992-01-23' AS Date), N'+79789695519', N'михаил.лебедев435@example.com', N'г. Москва, ул. Ленина, д. 83', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (17, N'Андрей Сидоров', CAST(N'1992-07-29' AS Date), N'+79075770177', N'андрей.сидоров794@example.com', N'г. Москва, ул. Ленина, д. 14', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (18, N'Андрей Лебедев', CAST(N'1981-01-14' AS Date), N'+79958624880', N'андрей.лебедев576@example.com', N'г. Москва, ул. Ленина, д. 91', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (19, N'Евгений Иванов', CAST(N'1987-04-20' AS Date), N'+79286316807', N'евгений.иванов881@example.com', N'г. Москва, ул. Ленина, д. 45', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (20, N'Евгений Волков', CAST(N'2006-01-11' AS Date), N'+79832422563', N'евгений.волков237@example.com', N'г. Москва, ул. Ленина, д. 91', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (21, N'Владимир Кузнецов', CAST(N'1996-05-16' AS Date), N'+79041738648', N'владимир.кузнецов319@example.com', N'г. Москва, ул. Ленина, д. 1', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.337' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (22, N'Николай Козлов', CAST(N'1977-08-26' AS Date), N'+79409640465', N'николай.козлов408@example.com', N'г. Москва, ул. Ленина, д. 58', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (23, N'Евгений Попов', CAST(N'1988-06-01' AS Date), N'+79724151456', N'евгений.попов826@example.com', N'г. Москва, ул. Ленина, д. 63', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (24, N'Александр Кузнецов', CAST(N'1969-04-14' AS Date), N'+79106658274', N'александр.кузнецов134@example.com', N'г. Москва, ул. Ленина, д. 19', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (25, N'Артем Морозов', CAST(N'1975-12-06' AS Date), N'+79486081287', N'артем.морозов883@example.com', N'г. Москва, ул. Ленина, д. 28', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (26, N'Михаил Попов', CAST(N'1990-09-05' AS Date), N'+79172658757', N'михаил.попов653@example.com', N'г. Москва, ул. Ленина, д. 84', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (27, N'Дмитрий Попов', CAST(N'1990-05-16' AS Date), N'+79347080276', N'дмитрий.попов363@example.com', N'г. Москва, ул. Ленина, д. 86', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (28, N'Евгений Иванов', CAST(N'2002-12-19' AS Date), N'+79394079676', N'евгений.иванов108@example.com', N'г. Москва, ул. Ленина, д. 80', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (29, N'Дмитрий Смирнов', CAST(N'1992-01-29' AS Date), N'+79534317001', N'дмитрий.смирнов121@example.com', N'г. Москва, ул. Ленина, д. 19', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (30, N'Владимир Петров', CAST(N'1988-04-05' AS Date), N'+79241311164', N'владимир.петров673@example.com', N'г. Москва, ул. Ленина, д. 64', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (31, N'Андрей Лебедев', CAST(N'1999-02-23' AS Date), N'+79400671074', N'андрей.лебедев715@example.com', N'г. Москва, ул. Ленина, д. 76', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (32, N'Андрей Волков', CAST(N'1983-10-06' AS Date), N'+79529241406', N'андрей.волков194@example.com', N'г. Москва, ул. Ленина, д. 36', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (33, N'Сергей Петров', CAST(N'1969-07-21' AS Date), N'+79016443792', N'сергей.петров630@example.com', N'г. Москва, ул. Ленина, д. 64', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (34, N'Михаил Иванов', CAST(N'2006-05-27' AS Date), N'+79979692795', N'михаил.иванов252@example.com', N'г. Москва, ул. Ленина, д. 44', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (35, N'Евгений Иванов', CAST(N'1974-11-12' AS Date), N'+79322858449', N'евгений.иванов65@example.com', N'г. Москва, ул. Ленина, д. 48', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (36, N'Николай Иванов', CAST(N'1967-02-26' AS Date), N'+79602829123', N'николай.иванов566@example.com', N'г. Москва, ул. Ленина, д. 88', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (37, N'Дмитрий Козлов', CAST(N'1994-01-11' AS Date), N'+79753508441', N'дмитрий.козлов182@example.com', N'г. Москва, ул. Ленина, д. 59', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.340' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (38, N'Владимир Волков', CAST(N'2000-10-29' AS Date), N'+79330551697', N'владимир.волков931@example.com', N'г. Москва, ул. Ленина, д. 10', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.343' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (39, N'Владимир Сидоров', CAST(N'1988-10-27' AS Date), N'+79530303028', N'владимир.сидоров795@example.com', N'г. Москва, ул. Ленина, д. 17', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.343' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (40, N'Евгений Кузнецов', CAST(N'1997-05-19' AS Date), N'+79945152603', N'евгений.кузнецов801@example.com', N'г. Москва, ул. Ленина, д. 1', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.343' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (41, N'Сергей Морозов', CAST(N'1979-07-26' AS Date), N'+79860577956', N'сергей.морозов228@example.com', N'г. Москва, ул. Ленина, д. 52', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (42, N'Сергей Сидоров', CAST(N'2006-06-24' AS Date), N'+79380504893', N'сергей.сидоров66@example.com', N'г. Москва, ул. Ленина, д. 47', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (43, N'Владимир Попов', CAST(N'1996-01-26' AS Date), N'+79915901633', N'владимир.попов656@example.com', N'г. Москва, ул. Ленина, д. 2', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (44, N'Иван Попов', CAST(N'1979-05-24' AS Date), N'+79327583190', N'иван.попов765@example.com', N'г. Москва, ул. Ленина, д. 17', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (45, N'Александр Волков', CAST(N'1998-04-29' AS Date), N'+79368797120', N'александр.волков188@example.com', N'г. Москва, ул. Ленина, д. 58', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (46, N'Николай Смирнов', CAST(N'1981-08-27' AS Date), N'+79325962120', N'николай.смирнов513@example.com', N'г. Москва, ул. Ленина, д. 70', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (47, N'Михаил Смирнов', CAST(N'1966-09-27' AS Date), N'+79803053593', N'михаил.смирнов761@example.com', N'г. Москва, ул. Ленина, д. 42', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (48, N'Михаил Кузнецов', CAST(N'1990-12-17' AS Date), N'+79565968522', N'михаил.кузнецов601@example.com', N'г. Москва, ул. Ленина, д. 37', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (49, N'Михаил Иванов', CAST(N'1974-04-07' AS Date), N'+79398081463', N'михаил.иванов486@example.com', N'г. Москва, ул. Ленина, д. 97', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (50, N'Владимир Сидоров', CAST(N'1997-04-30' AS Date), N'+79865150189', N'владимир.сидоров445@example.com', N'г. Москва, ул. Ленина, д. 27', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.367' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (51, N'Михаил Смирнов', CAST(N'1988-02-04' AS Date), N'+79059610709', N'михаил.смирнов123@example.com', N'г. Москва, ул. Ленина, д. 62', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (52, N'Александр Лебедев', CAST(N'1998-11-09' AS Date), N'+79144422724', N'александр.лебедев770@example.com', N'г. Москва, ул. Ленина, д. 58', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (53, N'Артем Иванов', CAST(N'1986-07-28' AS Date), N'+79152779949', N'артем.иванов658@example.com', N'г. Москва, ул. Ленина, д. 73', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (54, N'Владимир Иванов', CAST(N'1992-04-07' AS Date), N'+79134243115', N'владимир.иванов398@example.com', N'г. Москва, ул. Ленина, д. 15', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (55, N'Владимир Попов', CAST(N'1982-11-03' AS Date), N'+79998601476', N'владимир.попов889@example.com', N'г. Москва, ул. Ленина, д. 52', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (56, N'Иван Кузнецов', CAST(N'1988-07-09' AS Date), N'+79920074429', N'иван.кузнецов94@example.com', N'г. Москва, ул. Ленина, д. 4', NULL, N'Противопоказания: проблемы с сердцем', 0, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (57, N'Евгений Попов', CAST(N'1970-01-15' AS Date), N'+79088494118', N'евгений.попов575@example.com', N'г. Москва, ул. Ленина, д. 13', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (58, N'Дмитрий Морозов', CAST(N'1997-04-25' AS Date), N'+79760778838', N'дмитрий.морозов944@example.com', N'г. Москва, ул. Ленина, д. 14', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (59, N'Дмитрий Петров', CAST(N'1997-06-04' AS Date), N'+79602730200', N'дмитрий.петров150@example.com', N'г. Москва, ул. Ленина, д. 8', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (60, N'Николай Лебедев', CAST(N'1991-06-21' AS Date), N'+79774998416', N'николай.лебедев254@example.com', N'г. Москва, ул. Ленина, д. 65', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (61, N'Александр Лебедев', CAST(N'1976-05-14' AS Date), N'+79035590921', N'александр.лебедев538@example.com', N'г. Москва, ул. Ленина, д. 62', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (62, N'Евгений Сидоров', CAST(N'1996-11-28' AS Date), N'+79625008628', N'евгений.сидоров961@example.com', N'г. Москва, ул. Ленина, д. 29', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (63, N'Александр Лебедев', CAST(N'1991-12-14' AS Date), N'+79559435405', N'александр.лебедев52@example.com', N'г. Москва, ул. Ленина, д. 91', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.370' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (64, N'Владимир Морозов', CAST(N'1985-07-13' AS Date), N'+79583082002', N'владимир.морозов600@example.com', N'г. Москва, ул. Ленина, д. 60', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (65, N'Андрей Попов', CAST(N'1994-02-03' AS Date), N'+79149217026', N'андрей.попов388@example.com', N'г. Москва, ул. Ленина, д. 25', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (66, N'Артем Сидоров', CAST(N'2001-07-24' AS Date), N'+79516718394', N'артем.сидоров998@example.com', N'г. Москва, ул. Ленина, д. 38', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (67, N'Николай Морозов', CAST(N'1990-05-02' AS Date), N'+79087950817', N'николай.морозов354@example.com', N'г. Москва, ул. Ленина, д. 43', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (68, N'Михаил Смирнов', CAST(N'1987-11-23' AS Date), N'+79727995850', N'михаил.смирнов687@example.com', N'г. Москва, ул. Ленина, д. 38', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (69, N'Михаил Волков', CAST(N'1989-01-25' AS Date), N'+79877896562', N'михаил.волков245@example.com', N'г. Москва, ул. Ленина, д. 23', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (70, N'Евгений Иванов', CAST(N'2004-05-16' AS Date), N'+79029219035', N'евгений.иванов867@example.com', N'г. Москва, ул. Ленина, д. 73', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (71, N'Николай Лебедев', CAST(N'1998-09-15' AS Date), N'+79132758315', N'николай.лебедев372@example.com', N'г. Москва, ул. Ленина, д. 17', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (72, N'Артем Сидоров', CAST(N'1993-06-03' AS Date), N'+79779840373', N'артем.сидоров949@example.com', N'г. Москва, ул. Ленина, д. 96', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (73, N'Дмитрий Кузнецов', CAST(N'1983-09-28' AS Date), N'+79858998056', N'дмитрий.кузнецов62@example.com', N'г. Москва, ул. Ленина, д. 17', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (74, N'Николай Волков', CAST(N'1977-08-29' AS Date), N'+79146640248', N'николай.волков8@example.com', N'г. Москва, ул. Ленина, д. 86', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (75, N'Александр Кузнецов', CAST(N'1986-12-04' AS Date), N'+79685282124', N'александр.кузнецов789@example.com', N'г. Москва, ул. Ленина, д. 18', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (76, N'Андрей Козлов', CAST(N'1986-07-17' AS Date), N'+79339210854', N'андрей.козлов816@example.com', N'г. Москва, ул. Ленина, д. 65', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (77, N'Артем Попов', CAST(N'1973-01-10' AS Date), N'+79621974780', N'артем.попов920@example.com', N'г. Москва, ул. Ленина, д. 93', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (78, N'Артем Козлов', CAST(N'1965-06-11' AS Date), N'+79199007985', N'артем.козлов666@example.com', N'г. Москва, ул. Ленина, д. 89', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (79, N'Иван Морозов', CAST(N'1977-12-07' AS Date), N'+79597272084', N'иван.морозов197@example.com', N'г. Москва, ул. Ленина, д. 18', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.373' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (80, N'Александр Кузнецов', CAST(N'2007-02-09' AS Date), N'+79537497007', N'александр.кузнецов408@example.com', N'г. Москва, ул. Ленина, д. 26', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (81, N'Иван Иванов', CAST(N'1965-06-22' AS Date), N'+79075487746', N'иван.иванов424@example.com', N'г. Москва, ул. Ленина, д. 49', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (82, N'Андрей Лебедев', CAST(N'1992-03-19' AS Date), N'+79072500549', N'андрей.лебедев33@example.com', N'г. Москва, ул. Ленина, д. 22', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (83, N'Владимир Лебедев', CAST(N'1991-12-13' AS Date), N'+79550066895', N'владимир.лебедев266@example.com', N'г. Москва, ул. Ленина, д. 39', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (84, N'Александр Попов', CAST(N'1968-07-27' AS Date), N'+79084969102', N'александр.попов111@example.com', N'г. Москва, ул. Ленина, д. 53', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (85, N'Владимир Петров', CAST(N'1995-01-08' AS Date), N'+79807021313', N'владимир.петров229@example.com', N'г. Москва, ул. Ленина, д. 56', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (86, N'Николай Петров', CAST(N'1984-03-01' AS Date), N'+79486432578', N'николай.петров178@example.com', N'г. Москва, ул. Ленина, д. 62', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (87, N'Александр Козлов', CAST(N'2002-12-05' AS Date), N'+79022971844', N'александр.козлов425@example.com', N'г. Москва, ул. Ленина, д. 1', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (88, N'Владимир Смирнов', CAST(N'1982-12-12' AS Date), N'+79756229126', N'владимир.смирнов932@example.com', N'г. Москва, ул. Ленина, д. 37', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (89, N'Николай Попов', CAST(N'1983-05-05' AS Date), N'+79598828064', N'николай.попов716@example.com', N'г. Москва, ул. Ленина, д. 45', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (90, N'Дмитрий Смирнов', CAST(N'1965-11-17' AS Date), N'+79645330809', N'дмитрий.смирнов753@example.com', N'г. Москва, ул. Ленина, д. 76', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (91, N'Михаил Волков', CAST(N'2002-10-06' AS Date), N'+79102776173', N'михаил.волков695@example.com', N'г. Москва, ул. Ленина, д. 99', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (92, N'Сергей Волков', CAST(N'1971-11-21' AS Date), N'+79308245773', N'сергей.волков465@example.com', N'г. Москва, ул. Ленина, д. 33', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (93, N'Иван Смирнов', CAST(N'1992-05-12' AS Date), N'+79087244864', N'иван.смирнов885@example.com', N'г. Москва, ул. Ленина, д. 40', NULL, N'Противопоказания: проблемы с сердцем', 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (94, N'Евгений Сидоров', CAST(N'1979-08-09' AS Date), N'+79908126016', N'евгений.сидоров940@example.com', N'г. Москва, ул. Ленина, д. 15', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.377' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (95, N'Андрей Волков', CAST(N'1967-07-17' AS Date), N'+79440107468', N'андрей.волков84@example.com', N'г. Москва, ул. Ленина, д. 3', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.380' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (96, N'Артем Петров', CAST(N'1997-11-10' AS Date), N'+79992757212', N'артем.петров298@example.com', N'г. Москва, ул. Ленина, д. 1', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.380' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (97, N'Николай Смирнов', CAST(N'1973-05-28' AS Date), N'+79282941893', N'николай.смирнов941@example.com', N'г. Москва, ул. Ленина, д. 81', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (98, N'Сергей Петров', CAST(N'1996-05-07' AS Date), N'+79919360933', N'сергей.петров866@example.com', N'г. Москва, ул. Ленина, д. 17', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (99, N'Евгений Кузнецов', CAST(N'1995-07-26' AS Date), N'+79399446343', N'евгений.кузнецов732@example.com', N'г. Москва, ул. Ленина, д. 100', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (100, N'Николай Смирнов', CAST(N'2003-07-03' AS Date), N'+79529375208', N'николай.смирнов877@example.com', N'г. Москва, ул. Ленина, д. 93', NULL, NULL, 0, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (101, N'Артем Волков', CAST(N'1996-05-10' AS Date), N'+79101395114', N'артем.волков74@example.com', N'г. Москва, ул. Ленина, д. 96', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
GO
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (102, N'Александр Волков', CAST(N'1977-05-06' AS Date), N'+79709395197', N'александр.волков294@example.com', N'г. Москва, ул. Ленина, д. 95', NULL, NULL, 1, CAST(N'2025-04-28T16:52:13.383' AS DateTime), 0)
INSERT [dbo].[Clients] ([ClientID], [FullName], [DateOfBirth], [Phone], [Email], [Address], [Photo], [MedicalNotes], [IsActive], [CreatedAt], [IsRemoved]) VALUES (103, N'Тест тест етс', CAST(N'2004-05-18' AS Date), N'89776201212', N'122@mail.ru', N'', NULL, N'', 1, CAST(N'2025-04-29T16:15:56.793' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Memberships] ON 

INSERT [dbo].[Memberships] ([MembershipID], [ClientID], [MembershipTypeID], [StartDate], [EndDate], [CreatedAt]) VALUES (3, 3, 2, CAST(N'2025-04-29' AS Date), CAST(N'2025-05-29' AS Date), CAST(N'2025-04-29T15:03:22.687' AS DateTime))
INSERT [dbo].[Memberships] ([MembershipID], [ClientID], [MembershipTypeID], [StartDate], [EndDate], [CreatedAt]) VALUES (5, 32, 1, CAST(N'2025-04-30' AS Date), CAST(N'2025-05-07' AS Date), CAST(N'2025-04-29T16:21:25.020' AS DateTime))
SET IDENTITY_INSERT [dbo].[Memberships] OFF
GO
SET IDENTITY_INSERT [dbo].[MembershipTypes] ON 

INSERT [dbo].[MembershipTypes] ([MembershipTypeID], [Name], [Price], [DurationDays], [Restrictions], [IsRemoved]) VALUES (1, N'Пробный абонемент', CAST(500.00 AS Decimal(10, 2)), 7, N'Только тренажерный зал, без групповых занятий.', 0)
INSERT [dbo].[MembershipTypes] ([MembershipTypeID], [Name], [Price], [DurationDays], [Restrictions], [IsRemoved]) VALUES (2, N'Стартовый', CAST(1500.00 AS Decimal(10, 2)), 30, N'Доступ в тренажерный зал с 9:00 до 17:00', 0)
INSERT [dbo].[MembershipTypes] ([MembershipTypeID], [Name], [Price], [DurationDays], [Restrictions], [IsRemoved]) VALUES (3, N'Безлимитный', CAST(3000.00 AS Decimal(10, 2)), 30, N'Полный доступ ко всем залам и групповым занятиям.', 0)
INSERT [dbo].[MembershipTypes] ([MembershipTypeID], [Name], [Price], [DurationDays], [Restrictions], [IsRemoved]) VALUES (4, N'Групповые тренировки', CAST(2000.00 AS Decimal(10, 2)), 30, N'Только групповые занятия', 0)
INSERT [dbo].[MembershipTypes] ([MembershipTypeID], [Name], [Price], [DurationDays], [Restrictions], [IsRemoved]) VALUES (5, N'Полугодовой безлимит', CAST(12000.00 AS Decimal(10, 2)), 180, N'Полный доступ ко всему центру.', 0)
SET IDENTITY_INSERT [dbo].[MembershipTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Администратор')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Тренер')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ScheduleID], [WorkoutTypeID], [TrainerID], [Room], [ScheduledDateTime], [MaxParticipants], [IsRemoved]) VALUES (1, 1, 4, N'123', CAST(N'2025-03-29T12:12:00.000' AS DateTime), 12, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WorkoutTypeID], [TrainerID], [Room], [ScheduledDateTime], [MaxParticipants], [IsRemoved]) VALUES (2, 6, 6, N'12', CAST(N'2025-04-30T15:00:00.000' AS DateTime), 5, 0)
INSERT [dbo].[Schedule] ([ScheduleID], [WorkoutTypeID], [TrainerID], [Room], [ScheduledDateTime], [MaxParticipants], [IsRemoved]) VALUES (3, 6, 4, N'12', CAST(N'2025-04-29T15:00:00.000' AS DateTime), 5, 0)
INSERT [dbo].[Schedule] ([ScheduleID], [WorkoutTypeID], [TrainerID], [Room], [ScheduledDateTime], [MaxParticipants], [IsRemoved]) VALUES (4, 9, 9, N'15', CAST(N'2025-05-01T12:00:00.000' AS DateTime), 8, 0)
INSERT [dbo].[Schedule] ([ScheduleID], [WorkoutTypeID], [TrainerID], [Room], [ScheduledDateTime], [MaxParticipants], [IsRemoved]) VALUES (5, 1, 4, N'12', CAST(N'2025-05-01T12:00:00.000' AS DateTime), 12, 1)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (2, N'1', N'1', N'test@mail.ruy', N'Елена Кузнецова', 1, 1, CAST(N'2025-04-28T12:38:35.177' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (4, N'2', N'1', N'test1111@mail.ru', N'Павел Андреев', 2, 1, CAST(N'2025-04-28T12:38:57.767' AS DateTime), N'Йога                                                                                                ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (6, N'trainer1', N'123', N'trainer1@example.com', N'Иван Иванов', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Йога                                                                                                ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (7, N'trainer2', N'123', N'trainer2@example.com', N'Мария Петрова', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Кроссфит                                                                                            ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (8, N'trainer3', N'123', N'trainer3@example.com', N'Алексей Сидоров', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Фитнес                                                                                              ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (9, N'trainer4', N'123', N'trainer4@example.com', N'Елена Кузнецова', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Кроссфит                                                                                            ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (10, N'trainer5', N'123', N'trainer5@example.com', N'Дмитрий Морозов', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Фитнес                                                                                              ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (11, N'trainer6', N'123', N'trainer6@example.com', N'Ольга Николаева', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Йога                                                                                                ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (12, N'trainer7', N'123', N'trainer7@example.com', N'Сергей Васильев', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Кроссфит                                                                                            ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (13, N'trainer8', N'123', N'trainer8@example.com', N'Анна Федорова', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Фитнес                                                                                              ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (14, N'trainer9', N'123', N'trainer9@example.com', N'Павел Андреев', 2, 1, CAST(N'2025-04-28T16:03:16.983' AS DateTime), N'Кроссфит                                                                                            ', N'+79123456789        ', 0)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (19, N'333', N'', N'123@mail.ru', N'Анна Федорова', 1, 1, CAST(N'2025-04-29T16:13:31.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Users] ([UserID], [Login], [PasswordHash], [Email], [FullName], [RoleID], [IsActive], [CreatedAt], [Specialization], [Phone], [IsRemoved]) VALUES (21, N'123', N'123', N'123', N'123', 1, 1, CAST(N'2025-04-30T13:11:32.500' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkoutTypes] ON 

INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (1, N'Йога', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (2, N'Пилатес от 16', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (3, N'Пилатес группа от 14 до 16', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (4, N'Степ-аэробика', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (5, N'Силовая тренировка с весами', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (6, N'Велотренировка ', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (7, N'Скандинавская ходьба', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (8, N'Стретчинг для начинающих ', 0)
INSERT [dbo].[WorkoutTypes] ([WorkoutTypeID], [Name], [IsRemoved]) VALUES (9, N'Детская йога', 1)
SET IDENTITY_INSERT [dbo].[WorkoutTypes] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Clients__5C7E359E7BD83428]    Script Date: 30.04.2025 13:32:37 ******/
ALTER TABLE [dbo].[Clients] ADD UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B61609F99FC8A]    Script Date: 30.04.2025 13:32:37 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__5E55825BD22CDCD3]    Script Date: 30.04.2025 13:32:37 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534622DB267]    Script Date: 30.04.2025 13:32:37 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__WorkoutT__737584F60AA2CADD]    Script Date: 30.04.2025 13:32:37 ******/
ALTER TABLE [dbo].[WorkoutTypes] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bookings] ADD  DEFAULT (getdate()) FOR [BookingDateTime]
GO
ALTER TABLE [dbo].[Bookings] ADD  DEFAULT ((0)) FOR [IsCancelled]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [DF_Clients_IsRemoved]  DEFAULT ((0)) FOR [IsRemoved]
GO
ALTER TABLE [dbo].[Memberships] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[MembershipTypes] ADD  CONSTRAINT [DF_MembershipTypes_IsRemoved]  DEFAULT ((0)) FOR [IsRemoved]
GO
ALTER TABLE [dbo].[Schedule] ADD  CONSTRAINT [DF_Schedule_IsRemoved]  DEFAULT ((0)) FOR [IsRemoved]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsRemoved]  DEFAULT ((0)) FOR [IsRemoved]
GO
ALTER TABLE [dbo].[WorkoutTypes] ADD  CONSTRAINT [DF_WorkoutTypes_IsRemoved]  DEFAULT ((0)) FOR [IsRemoved]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD FOREIGN KEY([MembershipTypeID])
REFERENCES [dbo].[MembershipTypes] ([MembershipTypeID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([TrainerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([WorkoutTypeID])
REFERENCES [dbo].[WorkoutTypes] ([WorkoutTypeID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
