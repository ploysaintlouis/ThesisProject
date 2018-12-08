USE [master]
GO
/****** Object:  Database [test]    Script Date: 08/12/2561 21:42:11 ******/
CREATE DATABASE [test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2018\MSSQL\DATA\test.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2018\MSSQL\DATA\test_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [test] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [test] SET ARITHABORT OFF 
GO
ALTER DATABASE [test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [test] SET  MULTI_USER 
GO
ALTER DATABASE [test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [test] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [test] SET DELAYED_DURABILITY = DISABLED 
GO
USE [test]
GO
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_INFO]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_SCHEMA_INFO](
	[tableName] [varchar](50) NULL,
	[columnName] [varchar](50) NULL,
	[schemaVersionId] [nchar](10) NULL,
	[dataType] [varchar](50) NULL,
	[dataLength] [nchar](10) NULL,
	[decimalPoint] [nchar](10) NULL,
	[constraintPrimaryKey] [nchar](10) NULL,
	[constraintUnique] [nchar](10) NULL,
	[constraintDefault] [nchar](10) NULL,
	[constraintNull] [nchar](10) NULL,
	[constraintMinValue] [nchar](10) NULL,
	[constraintMaxValue] [nchar](10) NULL,
	[projectId] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_VERSION]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_SCHEMA_VERSION](
	[projectId] [int] NULL,
	[tableName] [varchar](50) NULL,
	[columnName] [varchar](50) NULL,
	[schemaVersionNumber] [char](10) NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NULL,
	[previousSchemaVersionId] [char](10) NULL,
	[createDate] [date] NULL,
	[createUser] [varchar](50) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[schemaVersionId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_DETAIL](
	[functionId] [int] NULL,
	[inputId] [int] NULL,
	[schemaVersionId] [char](10) NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_HEADER]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_HEADER](
	[functionId] [int] NULL,
	[functionNo] [char](10) NULL,
	[functionDescription] [varchar](50) NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[projectid] [int] NOT NULL,
	[testCaseId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_INPUT]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_INPUT](
	[projectId] [char](10) NULL,
	[inputName] [varchar](50) NULL,
	[refTableName] [varchar](50) NULL,
	[refColumnName] [varchar](50) NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NOT NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_VERSION]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_VERSION](
	[functionId] [int] NULL,
	[functionVersionNumber] [char](10) NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NULL,
	[previousVersionId] [char](10) NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_MISCELLANEOUS]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_MISCELLANEOUS](
	[miscValue1] [nchar](10) NOT NULL,
	[miscData] [nchar](10) NOT NULL,
	[miscDescription] [nchar](10) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[M_PROJECT]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_PROJECT](
	[projectId] [int] IDENTITY(1,1) NOT NULL,
	[projectName] [varchar](50) NULL,
	[projectNameAlias] [varchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[customer] [varchar](50) NULL,
	[databaseName] [varchar](50) NULL,
	[hostname] [varchar](50) NULL,
	[port] [varchar](50) NULL,
	[username] [varchar](50) NULL,
	[password] [char](10) NULL,
	[startFlag] [smallint] NULL,
	[activeFlag] [smallint] NULL,
	[createDate] [datetime] NULL,
	[createUser] [nchar](10) NULL,
	[updateDate] [datetime] NULL,
	[updateUser] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RTM]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_RTM](
	[testCaseId] [int] NOT NULL,
	[functionId] [int] NOT NULL,
	[createDate] [nchar](10) NOT NULL,
	[createUser] [nchar](10) NOT NULL,
	[projectId] [nchar](10) NOT NULL,
	[activeFlag] [nchar](10) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[M_RTM_VERSION]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_RTM_VERSION](
	[rtmVersionId] [nchar](10) NULL,
	[effectiveStartDate] [nchar](10) NULL,
	[effectiveEndDate] [nchar](10) NULL,
	[updateDate] [nchar](10) NULL,
	[previousVersionId] [nchar](10) NULL,
	[projectId] [nchar](10) NULL,
	[rtmVersionNumber] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[M_TESTCASE_HEADER]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_HEADER](
	[testCaseNo] [char](10) NULL,
	[testCaseDescription] [varchar](50) NULL,
	[expectedResult] [varchar](50) NULL,
	[projectId] [int] NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[testCaseId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_TESTCASE_VERSION]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_TESTCASE_VERSION](
	[activeFlag] [smallint] NULL,
	[testCaseVersionNumber] [nchar](10) NULL,
	[effectiveStartDate] [nvarchar](50) NULL,
	[effectiveEndDate] [nvarchar](50) NULL,
	[testCaseId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[m_users]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m_users](
	[userid] [nchar](10) NOT NULL,
	[Firstname] [nchar](10) NULL,
	[lastname] [nchar](10) NULL,
	[username] [nchar](10) NOT NULL,
	[password] [nchar](10) NULL,
	[status] [nchar](10) NULL,
 CONSTRAINT [PK_m_users] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[projectid] [nchar](10) NOT NULL,
	[projectName] [nchar](10) NULL,
	[effdate] [nchar](10) NULL,
	[enddae] [nchar](10) NULL,
	[DatabaseName] [nchar](10) NULL,
	[HostName] [nchar](10) NULL,
	[username] [nchar](10) NULL,
	[Password] [nchar](10) NULL,
	[status] [nchar](10) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[projectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[stock]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stock](
	[stock_id] [int] NULL,
	[stockname] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_CHANGE_REQUEST_HEADER]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CHANGE_REQUEST_HEADER](
	[changeRequestNo] [nchar](10) NULL,
	[changeUserId] [nchar](10) NULL,
	[changeDate] [nchar](10) NULL,
	[projectId] [nchar](10) NULL,
	[changeFunctionId] [nchar](10) NULL,
	[changeFunctionNo] [nchar](10) NULL,
	[changeFunctionVersion] [nchar](10) NULL,
	[changeStatus] [nchar](10) NULL,
	[createUser] [nchar](10) NULL,
	[createDate] [nchar](10) NULL,
	[updateUser] [nchar](10) NULL,
	[updateDate] [nchar](10) NULL,
	[reason] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_TEMP_CHANGE_LIST]    Script Date: 08/12/2561 21:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_TEMP_CHANGE_LIST](
	[userId] [nchar](10) NULL,
	[functionId] [nchar](10) NULL,
	[functionVersion] [nchar](10) NULL,
	[inputId] [nchar](10) NULL,
	[inputName] [nchar](10) NULL,
	[schemaVersionId] [nchar](10) NULL,
	[newDataType] [nchar](10) NULL,
	[newDataLength] [nchar](10) NULL,
	[newScaleLength] [nchar](10) NULL,
	[newUnique] [nchar](10) NULL,
	[newNotNull] [nchar](10) NULL,
	[newDefaultValue] [nchar](10) NULL,
	[newMinValue] [nchar](10) NULL,
	[newMaxValue] [nchar](10) NULL,
	[tableName] [nchar](10) NULL,
	[columnName] [nchar](10) NULL,
	[changeType] [nchar](10) NULL,
	[createUser] [nchar](10) NULL,
	[createDate] [nchar](10) NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[m_users]  WITH CHECK ADD  CONSTRAINT [FK_m_users_m_users] FOREIGN KEY([username])
REFERENCES [dbo].[m_users] ([username])
GO
ALTER TABLE [dbo].[m_users] CHECK CONSTRAINT [FK_m_users_m_users]
GO
USE [master]
GO
ALTER DATABASE [test] SET  READ_WRITE 
GO
