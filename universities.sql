USE [master]
GO
/****** Object:  Database [UniversitiesDB]    Script Date: 10/13/2015 10:50:56 AM ******/
CREATE DATABASE [UniversitiesDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UniversitiesDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\UniversitiesDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UniversitiesDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\UniversitiesDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [UniversitiesDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UniversitiesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UniversitiesDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UniversitiesDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UniversitiesDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UniversitiesDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UniversitiesDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UniversitiesDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UniversitiesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UniversitiesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UniversitiesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UniversitiesDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UniversitiesDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UniversitiesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UniversitiesDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UniversitiesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UniversitiesDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UniversitiesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UniversitiesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UniversitiesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UniversitiesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UniversitiesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UniversitiesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UniversitiesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UniversitiesDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UniversitiesDB] SET  MULTI_USER 
GO
ALTER DATABASE [UniversitiesDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UniversitiesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UniversitiesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UniversitiesDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [UniversitiesDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [UniversitiesDB]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CoursesProffesors]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoursesProffesors](
	[proffesor_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
 CONSTRAINT [PK_CoursesProffesors] PRIMARY KEY CLUSTERED 
(
	[proffesor_id] ASC,
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeparmentsProffesors]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeparmentsProffesors](
	[department_id] [int] NOT NULL,
	[proffesor_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[faculty_id] [int] NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DepartmentsCourses]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentsCourses](
	[department_id] [int] NOT NULL,
	[course_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proffesors]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proffesors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Proffesors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProffesorTitles]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProffesorTitles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProffesorTitles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nchar](100) NOT NULL,
	[faculty_id] [int] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentsCourses]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsCourses](
	[student_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
 CONSTRAINT [PK_StudentsCourses] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TitlesProffesors]    Script Date: 10/13/2015 10:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TitlesProffesors](
	[proffesor_id] [int] NOT NULL,
	[title_id] [int] NOT NULL,
 CONSTRAINT [PK_TitlesProffesors] PRIMARY KEY CLUSTERED 
(
	[proffesor_id] ASC,
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CoursesProffesors]  WITH CHECK ADD  CONSTRAINT [FK_CoursesProffesors_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[CoursesProffesors] CHECK CONSTRAINT [FK_CoursesProffesors_Courses]
GO
ALTER TABLE [dbo].[CoursesProffesors]  WITH CHECK ADD  CONSTRAINT [FK_CoursesProffesors_Proffesors] FOREIGN KEY([proffesor_id])
REFERENCES [dbo].[Proffesors] ([id])
GO
ALTER TABLE [dbo].[CoursesProffesors] CHECK CONSTRAINT [FK_CoursesProffesors_Proffesors]
GO
ALTER TABLE [dbo].[DeparmentsProffesors]  WITH CHECK ADD  CONSTRAINT [FK_DeparmentsProffesors_Departments] FOREIGN KEY([department_id])
REFERENCES [dbo].[Departments] ([id])
GO
ALTER TABLE [dbo].[DeparmentsProffesors] CHECK CONSTRAINT [FK_DeparmentsProffesors_Departments]
GO
ALTER TABLE [dbo].[DeparmentsProffesors]  WITH CHECK ADD  CONSTRAINT [FK_DeparmentsProffesors_Proffesors] FOREIGN KEY([proffesor_id])
REFERENCES [dbo].[Proffesors] ([id])
GO
ALTER TABLE [dbo].[DeparmentsProffesors] CHECK CONSTRAINT [FK_DeparmentsProffesors_Proffesors]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Faculties] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[Faculties] ([id])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Faculties]
GO
ALTER TABLE [dbo].[DepartmentsCourses]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentsCourses_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[DepartmentsCourses] CHECK CONSTRAINT [FK_DepartmentsCourses_Courses]
GO
ALTER TABLE [dbo].[DepartmentsCourses]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentsCourses_Departments] FOREIGN KEY([department_id])
REFERENCES [dbo].[Departments] ([id])
GO
ALTER TABLE [dbo].[DepartmentsCourses] CHECK CONSTRAINT [FK_DepartmentsCourses_Departments]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Faculties] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[Faculties] ([id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Faculties]
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD  CONSTRAINT [FK_StudentsCourses_Courses] FOREIGN KEY([course_id])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[StudentsCourses] CHECK CONSTRAINT [FK_StudentsCourses_Courses]
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD  CONSTRAINT [FK_StudentsCourses_Students] FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([id])
GO
ALTER TABLE [dbo].[StudentsCourses] CHECK CONSTRAINT [FK_StudentsCourses_Students]
GO
ALTER TABLE [dbo].[TitlesProffesors]  WITH CHECK ADD  CONSTRAINT [FK_TitlesProffesors_Proffesors] FOREIGN KEY([proffesor_id])
REFERENCES [dbo].[Proffesors] ([id])
GO
ALTER TABLE [dbo].[TitlesProffesors] CHECK CONSTRAINT [FK_TitlesProffesors_Proffesors]
GO
ALTER TABLE [dbo].[TitlesProffesors]  WITH CHECK ADD  CONSTRAINT [FK_TitlesProffesors_ProffesorTitles] FOREIGN KEY([title_id])
REFERENCES [dbo].[ProffesorTitles] ([id])
GO
ALTER TABLE [dbo].[TitlesProffesors] CHECK CONSTRAINT [FK_TitlesProffesors_ProffesorTitles]
GO
USE [master]
GO
ALTER DATABASE [UniversitiesDB] SET  READ_WRITE 
GO
