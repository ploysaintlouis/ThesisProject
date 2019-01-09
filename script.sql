USE [master]
GO
/****** Object:  Database [test]    Script Date: 09/01/2562 17:57:30 ******/
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
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_INFO]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_SCHEMA_INFO](
	[projectId] [int] NOT NULL,
	[tableName] [char](50) NOT NULL,
	[columnName] [char](50) NOT NULL,
	[schemaVersionId] [int] NOT NULL,
	[dataType] [char](20) NOT NULL,
	[dataLength] [char](10) NULL,
	[decimalPoint] [char](10) NULL,
	[constraintPrimaryKey] [char](1) NULL,
	[constraintUnique] [char](1) NULL,
	[constraintDefault] [char](10) NULL,
	[constraintNull] [char](1) NULL,
	[constraintMinValue] [char](10) NULL,
	[constraintMaxValue] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_VERSION]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_SCHEMA_VERSION](
	[projectId] [int] NOT NULL,
	[schemaVersionId] [int] IDENTITY(1,1) NOT NULL,
	[schemaVersionNumber] [char](10) NULL,
	[tableName] [varchar](50) NOT NULL,
	[columnName] [varchar](50) NOT NULL,
	[effectiveStartDate] [date] NOT NULL,
	[effectiveEndDate] [date] NULL,
	[createDate] [date] NOT NULL,
	[createUser] [varchar](50) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[activeFlag] [smallint] NULL,
 CONSTRAINT [PK_M_DATABASE_SCHEMA_VERSION] PRIMARY KEY CLUSTERED 
(
	[schemaVersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_DETAIL](
	[projectid] [int] NULL,
	[functionId] [int] NOT NULL,
	[functionNo] [char](10) NOT NULL,
	[functionVersion] [int] NULL,
	[typeData] [char](10) NOT NULL,
	[dataId] [int] IDENTITY(1,1) NOT NULL,
	[dataName] [char](20) NOT NULL,
	[schemaVersionId] [char](10) NULL,
	[refTableName] [varchar](50) NULL,
	[refColumnName] [varchar](50) NULL,
	[dataType] [char](20) NOT NULL,
	[dataLength] [char](10) NULL,
	[decimalPoint] [char](10) NULL,
	[constraintPrimaryKey] [char](10) NULL,
	[constraintUnique] [char](10) NULL,
	[constraintDefault] [char](10) NULL,
	[constraintNull] [char](10) NULL,
	[constraintMinValue] [char](10) NULL,
	[constraintMaxValue] [char](10) NULL,
	[effectiveStartDate] [date] NOT NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NOT NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL_INPUT]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_DETAIL_INPUT](
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
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL_OUTPUT]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_DETAIL_OUTPUT](
	[functionId] [int] NULL,
	[outputId] [int] NULL,
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
/****** Object:  Table [dbo].[M_FN_REQ_HEADER]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_HEADER](
	[functionId] [int] IDENTITY(1,1) NOT NULL,
	[functionNo] [char](10) NOT NULL,
	[functionversion] [char](10) NULL,
	[functionDescription] [char](50) NOT NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[projectid] [int] NOT NULL,
	[activeflag] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_INPUT]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_INPUT](
	[projectId] [int] NULL,
	[inputId] [int] NULL,
	[inputName] [varchar](50) NULL,
	[refTableName] [varchar](50) NULL,
	[refColumnName] [varchar](50) NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NOT NULL,
	[updateUser] [char](10) NULL,
	[activeFlag] [smallint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_OUTPUT]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_OUTPUT](
	[projectId] [int] NULL,
	[outputId] [int] NULL,
	[outputName] [varchar](50) NULL,
	[refTableName] [varchar](50) NULL,
	[refColumnName] [varchar](50) NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[activeFlag] [smallint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_VERSION]    Script Date: 09/01/2562 17:57:30 ******/
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
	[updateUser] [char](10) NULL,
	[functionVersionId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_MISCELLANEOUS]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_MISCELLANEOUS](
	[miscData] [char](30) NOT NULL,
	[miscValue1] [char](20) NOT NULL,
	[miscValue2] [char](20) NULL,
	[miscDescription] [char](50) NOT NULL,
	[activeFlag] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_PROJECT]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_PROJECT](
	[projectId] [int] IDENTITY(1,1) NOT NULL,
	[projectName] [varchar](50) NOT NULL,
	[projectNameAlias] [varchar](50) NOT NULL,
	[effDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[customer] [varchar](50) NULL,
	[databaseName] [varchar](50) NOT NULL,
	[hostname] [varchar](50) NULL,
	[port] [varchar](50) NULL,
	[username] [varchar](50) NOT NULL,
	[password] [char](10) NOT NULL,
	[startFlag] [smallint] NULL,
	[activeFlag] [smallint] NULL,
	[createDate] [datetime] NULL,
	[createUser] [nchar](10) NULL,
	[updateDate] [datetime] NOT NULL,
	[updateUser] [nchar](10) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RTM]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_RTM](
	[projectId] [int] NOT NULL,
	[testCaseId] [int] NOT NULL,
	[functionId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[effectiveEndDate] [datetime] NULL,
	[effectiveStartDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[updateUser] [char](10) NOT NULL,
	[activeFlag] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RTM_VERSION]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_RTM_VERSION](
	[projectId] [int] NOT NULL,
	[testCaseId] [int] NOT NULL,
	[testCaseversion] [int] NOT NULL,
	[functionId] [int] NOT NULL,
	[functionVersion] [int] NOT NULL,
	[effectiveStartDate] [date] NOT NULL,
	[effectiveEndDate] [date] NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[updateDate] [date] NOT NULL,
	[updateUser] [char](10) NOT NULL,
	[activeFlag] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RUNNING_PREFIX]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_RUNNING_PREFIX](
	[prefix] [char](20) NULL,
	[affix] [nchar](10) NULL,
	[length] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_TESTCASE_DETAIL]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_DETAIL](
	[projectId] [int] NOT NULL,
	[testCaseId] [int] NOT NULL,
	[testCaseNo] [char](10) NOT NULL,
	[testcaseVersion] [char](10) NOT NULL,
	[typeData] [int] NOT NULL,
	[refdataId] [int] NULL,
	[refdataName] [char](20) NOT NULL,
	[testData] [char](50) NOT NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [char](1) NOT NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[sequenceNo] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_TESTCASE_HEADER]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_HEADER](
	[projectId] [int] NULL,
	[testCaseId] [int] IDENTITY(1,1) NOT NULL,
	[testCaseNo] [char](10) NULL,
	[testcaseVersion] [char](10) NULL,
	[testCaseDescription] [varchar](50) NULL,
	[expectedResult] [varchar](50) NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_TESTCASE_VERSION]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_VERSION](
	[testCaseId] [int] IDENTITY(1,1) NOT NULL,
	[testCaseVersionNumber] [nchar](10) NULL,
	[testcaseVersion] [char](10) NULL,
	[effectiveStartDate] [nvarchar](50) NULL,
	[effectiveEndDate] [nvarchar](50) NULL,
	[activeFlag] [smallint] NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[createDate] [date] NULL,
	[createUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[m_users]    Script Date: 09/01/2562 17:57:30 ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 09/01/2562 17:57:30 ******/
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
/****** Object:  Table [dbo].[T_CHANGE_REQUEST_DETAIL]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CHANGE_REQUEST_DETAIL](
	[changeRequestNo] [nchar](10) NULL,
	[sequenceNo] [nchar](10) NULL,
	[changeType] [nchar](10) NULL,
	[typeData] [nchar](10) NULL,
	[refdataId] [nchar](10) NULL,
	[refSchemaVersionId] [nchar](10) NULL,
	[dataName] [nchar](10) NULL,
	[dataType] [nchar](10) NULL,
	[dataLength] [nchar](10) NULL,
	[scale] [nchar](10) NULL,
	[constraintUnique] [nchar](10) NULL,
	[constraintNotNull] [nchar](10) NULL,
	[constraintDefault] [nchar](10) NULL,
	[constraintMin] [nchar](10) NULL,
	[constraintMax] [nchar](10) NULL,
	[refTableName] [nchar](10) NULL,
	[refColumnName] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_CHANGE_REQUEST_HEADER]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CHANGE_REQUEST_HEADER](
	[projectId] [nchar](10) NULL,
	[changeRequestNo] [nchar](10) NULL,
	[changeUserId] [nchar](10) NULL,
	[changeDate] [nchar](10) NULL,
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
/****** Object:  Table [dbo].[T_TEMP_CHANGE_LIST]    Script Date: 09/01/2562 17:57:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_TEMP_CHANGE_LIST](
	[functionId] [int] NULL,
	[functionVersion] [char](20) NOT NULL,
	[schemaVersionId] [int] NULL,
	[changeType] [char](20) NULL,
	[typeData] [int] NULL,
	[dataId] [int] IDENTITY(1,1) NOT NULL,
	[dataName] [char](20) NULL,
	[userId] [char](20) NULL,
	[newDataType] [char](20) NULL,
	[newDataLength] [char](10) NULL,
	[newScaleLength] [char](20) NULL,
	[newUnique] [char](20) NULL,
	[newNotNull] [char](20) NULL,
	[newDefaultValue] [char](20) NULL,
	[newMinValue] [char](20) NULL,
	[newMaxValue] [char](20) NULL,
	[tableName] [char](20) NULL,
	[columnName] [char](20) NULL,
	[createUser] [char](20) NULL,
	[createDate] [date] NULL,
	[lineNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'PRODUCT_ID                                        ', 25, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'PRODUCT_NAME                                      ', 26, N'varchar             ', N'50        ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'CATEGORY_ID                                       ', 27, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'QUANLITY_PER_UNIT                                 ', 28, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'UNIT_PRICE                                        ', 29, N'decimal             ', N'18        ', N'6         ', N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'UNIT_INSTOCK                                      ', 30, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'PRODUCTS                                          ', N'UNIT_ONORDER                                      ', 31, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CATEGORIES                                        ', N'CATEGORY_ID                                       ', 32, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CATEGORIES                                        ', N'CATEGORY_NAME                                     ', 33, N'varchar             ', N'100       ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CATEGORIES                                        ', N'DESCRIPTION                                       ', 34, N'varchar             ', N'255       ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CUSTOMERS                                         ', N'CUSTORMER_ID                                      ', 35, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CUSTOMERS                                         ', N'COMPANY_NAME                                      ', 36, N'varchar             ', N'255       ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CUSTOMERS                                         ', N'CONTACT_NAME                                      ', 37, N'varchar             ', N'50        ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CUSTOMERS                                         ', N'CONTACT_TITLE                                     ', 38, N'char                ', N'2         ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'CUSTOMERS                                         ', N'PHONE_NO                                          ', 39, N'varchar             ', N'10        ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDERS                                            ', N'ORDER_ID                                          ', 40, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDERS                                            ', N'CUSTOMER_ID                                       ', 41, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDERS                                            ', N'ORDER_DATE                                        ', 42, N'date                ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDERS                                            ', N'SHIP_ADDRESS                                      ', 43, N'varchar             ', N'255       ', NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDER_DETAILS                                     ', N'ORDER_ID                                          ', 44, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDER_DETAILS                                     ', N'PRODUCT_ID                                        ', 45, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDER_DETAILS                                     ', N'UNIT_PRICE                                        ', 46, N'decimal             ', N'18        ', N'6         ', N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDER_DETAILS                                     ', N'QUANLITY                                          ', 47, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'ORDER_DETAILS                                     ', N'DISCOUNT                                          ', 48, N'int                 ', NULL, NULL, N'N', N'N', NULL, N'Y', NULL, NULL)
SET IDENTITY_INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ON 

INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 25, N'1         ', N'PRODUCTS', N'PRODUCT_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 26, N'1         ', N'PRODUCTS', N'PRODUCT_NAME', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 27, N'1         ', N'PRODUCTS', N'CATEGORY_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 28, N'1         ', N'PRODUCTS', N'QUANLITY_PER_UNIT', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 29, N'1         ', N'PRODUCTS', N'UNIT_PRICE', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 30, N'1         ', N'PRODUCTS', N'UNIT_INSTOCK', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 31, N'1         ', N'PRODUCTS', N'UNIT_ONORDER', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 32, N'1         ', N'CATEGORIES', N'CATEGORY_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 33, N'1         ', N'CATEGORIES', N'CATEGORY_NAME', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 34, N'1         ', N'CATEGORIES', N'DESCRIPTION', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 35, N'1         ', N'CUSTOMERS', N'CUSTORMER_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 36, N'1         ', N'CUSTOMERS', N'COMPANY_NAME', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 37, N'1         ', N'CUSTOMERS', N'CONTACT_NAME', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 38, N'1         ', N'CUSTOMERS', N'CONTACT_TITLE', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 39, N'1         ', N'CUSTOMERS', N'PHONE_NO', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 40, N'1         ', N'ORDERS', N'ORDER_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 41, N'1         ', N'ORDERS', N'CUSTOMER_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 42, N'1         ', N'ORDERS', N'ORDER_DATE', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 43, N'1         ', N'ORDERS', N'SHIP_ADDRESS', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 44, N'1         ', N'ORDER_DETAILS', N'ORDER_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 45, N'1         ', N'ORDER_DETAILS', N'PRODUCT_ID', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 46, N'1         ', N'ORDER_DETAILS', N'UNIT_PRICE', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 47, N'1         ', N'ORDER_DETAILS', N'QUANLITY', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 48, N'1         ', N'ORDER_DETAILS', N'DISCOUNT', CAST(N'2019-01-07' AS Date), NULL, CAST(N'2019-01-07' AS Date), N'ploy', CAST(N'2019-01-07' AS Date), N'ploy      ', 1)
SET IDENTITY_INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] OFF
SET IDENTITY_INSERT [dbo].[M_FN_REQ_DETAIL] ON 

INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'1         ', 36, N'dOrder Id           ', N'44        ', N'ORDER_DETAILS', N'ORDER_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'1         ', 37, N'dProduct Id         ', N'45        ', N'ORDER_DETAILS', N'PRODUCT_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'1         ', 38, N'dUnit Price         ', N'46        ', N'ORDER_DETAILS', N'UNIT_PRICE', N'decimal             ', N'18        ', N'6         ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'1         ', 39, N'dQty                ', N'47        ', N'ORDER_DETAILS', N'QUANLITY', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'1         ', 40, N'dDiscount           ', N'48        ', N'ORDER_DETAILS', N'DISCOUNT', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 25, N'OS_FR_03  ', 1, N'2         ', 41, N'dPrice              ', NULL, N'', N'', N'decimal             ', N'18        ', N'2         ', NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 42, N'Product Id          ', N'25        ', N'PRODUCTS', N'PRODUCT_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 43, N'Product Name        ', N'26        ', N'PRODUCTS', N'PRODUCT_NAME', N'varchar             ', N'50        ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 44, N'Category Id         ', N'27        ', N'PRODUCTS', N'CATEGORY_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 45, N'Qty Per Unit        ', N'28        ', N'PRODUCTS', N'QUANLITY_PER_UNIT', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 46, N'unit Price          ', N'29        ', N'PRODUCTS', N'UNIT_PRICE', N'decimal             ', N'18        ', N'6         ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 47, N'Unit in Stock       ', N'30        ', N'PRODUCTS', N'UNIT_INSTOCK', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 26, N'OS_FR_01  ', 1, N'1         ', 48, N'Unit in Order       ', N'31        ', N'PRODUCTS', N'UNIT_ONORDER', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 27, N'OS_FR_02  ', 1, N'1         ', 49, N'Order Id            ', N'40        ', N'ORDERS', N'ORDER_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 27, N'OS_FR_02  ', 1, N'1         ', 50, N'Order Customer Id   ', N'41        ', N'ORDERS', N'CUSTOMER_ID', N'int                 ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 27, N'OS_FR_02  ', 1, N'1         ', 51, N'Order Date          ', N'42        ', N'ORDERS', N'ORDER_DATE', N'date                ', N'          ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 27, N'OS_FR_02  ', 1, N'1         ', 52, N'Ship Address        ', N'43        ', N'ORDERS', N'SHIP_ADDRESS', N'varchar             ', N'255       ', N'          ', N'N         ', N'N         ', N'          ', N'Y         ', N'          ', N'          ', CAST(N'2019-01-07' AS Date), NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
SET IDENTITY_INSERT [dbo].[M_FN_REQ_DETAIL] OFF
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 1, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 2, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 3, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 4, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_OUTPUT] ([functionId], [outputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 1, NULL, CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', NULL, N'          ')
SET IDENTITY_INSERT [dbo].[M_FN_REQ_HEADER] ON 

INSERT [dbo].[M_FN_REQ_HEADER] ([functionId], [functionNo], [functionversion], [functionDescription], [createDate], [createUser], [updateDate], [updateUser], [projectid], [activeflag]) VALUES (25, N'OS_FR_03  ', N'1         ', N'Create Order List                                 ', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 2, 1)
INSERT [dbo].[M_FN_REQ_HEADER] ([functionId], [functionNo], [functionversion], [functionDescription], [createDate], [createUser], [updateDate], [updateUser], [projectid], [activeflag]) VALUES (26, N'OS_FR_01  ', N'1         ', N'Add A New Product Information                     ', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 2, 1)
INSERT [dbo].[M_FN_REQ_HEADER] ([functionId], [functionNo], [functionversion], [functionDescription], [createDate], [createUser], [updateDate], [updateUser], [projectid], [activeflag]) VALUES (27, N'OS_FR_02  ', N'1         ', N'Create a New Order                                ', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 2, 1)
SET IDENTITY_INSERT [dbo].[M_FN_REQ_HEADER] OFF
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'Patient SSN', N'patients', N'p_ssn', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 2, N'Patient First Name', N'patients', N'p_firstName', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 3, N'Patient Last Name', N'patients', N'p_lastName', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 4, N'Patient Birth Date', N'patients', N'p_birthdate', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_OUTPUT] ([projectId], [outputId], [outputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'Age', NULL, NULL, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (22, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (23, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (24, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (25, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (26, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (27, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (19, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (20, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (21, N'1         ', CAST(N'2019-01-07' AS Date), NULL, 1, NULL, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', NULL)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDataType                 ', N'CHAR                ', N'char                ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'VARCHAR             ', N'varchar             ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'DATE                ', N'date                ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'INT                 ', N'int                 ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'FLOAT               ', N'float               ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'DOUBLE              ', N'double              ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'DECIMAL             ', N'decimal             ', N'                                                  ', 1)
SET IDENTITY_INSERT [dbo].[M_PROJECT] ON 

INSERT [dbo].[M_PROJECT] ([projectId], [projectName], [projectNameAlias], [effDate], [endDate], [customer], [databaseName], [hostname], [port], [username], [password], [startFlag], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, N'Hospital', N'Hospital', CAST(N'2018-11-29 00:00:00.000' AS DateTime), CAST(N'2018-12-28 00:00:00.000' AS DateTime), N'test1', N'Hospital', N'localhost', N'81', N'ploy', N'1234      ', 1, 1, CAST(N'2018-11-29 17:59:26.000' AS DateTime), N'ploy      ', CAST(N'2018-11-29 17:59:26.000' AS DateTime), N'ploy      ')
INSERT [dbo].[M_PROJECT] ([projectId], [projectName], [projectNameAlias], [effDate], [endDate], [customer], [databaseName], [hostname], [port], [username], [password], [startFlag], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, N'products', N'products', CAST(N'2019-01-06 00:00:00.000' AS DateTime), CAST(N'2019-03-08 00:00:00.000' AS DateTime), N'test2', N'products', N'localhost:81', N'81', N'ploy ploy', N'1234      ', 1, 1, CAST(N'2019-01-06 18:31:30.000' AS DateTime), N'ploy      ', CAST(N'2019-01-06 18:44:52.000' AS DateTime), N'ploy      ')
SET IDENTITY_INSERT [dbo].[M_PROJECT] OFF
INSERT [dbo].[M_RTM] ([projectId], [testCaseId], [functionId], [createDate], [createUser], [effectiveEndDate], [effectiveStartDate], [updateDate], [updateUser], [activeFlag]) VALUES (2, 17, 26, CAST(N'2019-01-08 15:52:13.000' AS DateTime), N'ploy      ', NULL, CAST(N'2019-01-08 15:52:13.000' AS DateTime), CAST(N'2019-01-08 15:52:13.000' AS DateTime), N'ploy      ', N'1')
INSERT [dbo].[M_RTM] ([projectId], [testCaseId], [functionId], [createDate], [createUser], [effectiveEndDate], [effectiveStartDate], [updateDate], [updateUser], [activeFlag]) VALUES (2, 18, 27, CAST(N'2019-01-08 15:52:16.000' AS DateTime), N'ploy      ', NULL, CAST(N'2019-01-08 15:52:16.000' AS DateTime), CAST(N'2019-01-08 15:52:16.000' AS DateTime), N'ploy      ', N'1')
INSERT [dbo].[M_RTM] ([projectId], [testCaseId], [functionId], [createDate], [createUser], [effectiveEndDate], [effectiveStartDate], [updateDate], [updateUser], [activeFlag]) VALUES (2, 16, 25, CAST(N'2019-01-08 15:52:18.000' AS DateTime), N'ploy      ', NULL, CAST(N'2019-01-08 15:52:18.000' AS DateTime), CAST(N'2019-01-08 15:52:18.000' AS DateTime), N'ploy      ', N'1')
INSERT [dbo].[M_RTM_VERSION] ([projectId], [testCaseId], [testCaseversion], [functionId], [functionVersion], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 17, 1, 26, 1, CAST(N'2019-01-08' AS Date), NULL, CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_RTM_VERSION] ([projectId], [testCaseId], [testCaseversion], [functionId], [functionVersion], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 18, 1, 27, 1, CAST(N'2019-01-08' AS Date), NULL, CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 1)
INSERT [dbo].[M_RTM_VERSION] ([projectId], [testCaseId], [testCaseversion], [functionId], [functionVersion], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 16, 1, 25, 1, CAST(N'2019-01-08' AS Date), NULL, CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 1)
SET IDENTITY_INSERT [dbo].[M_TESTCASE_DETAIL] ON 

INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 1, 36, N'dOrder Id           ', N'34                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 11)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 1, 37, N'dProduct Id         ', N'1                                                 ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 12)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 1, 38, N'dUnit Price         ', N'28900                                             ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 13)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 1, 39, N'dQty                ', N'1                                                 ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 14)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 1, 40, N'dDiscount           ', N'2000                                              ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 15)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', 2, 41, N'dPrice              ', N'1000                                              ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 16)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 42, N'Product id          ', N'xx                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 17)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 43, N'Product Name        ', N'iPhone 7+                                         ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 18)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 44, N'Category Id         ', N'17                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 19)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 46, N'Unit Price          ', N'28900                                             ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 20)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 47, N'Unit in Stock       ', N'500                                               ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 21)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 48, N'Unit in Order       ', N'20                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 22)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 18, N'OS_TC_02  ', N'1         ', 1, 49, N'Order Id            ', N'34                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 23)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 18, N'OS_TC_02  ', N'1         ', 1, 50, N'Order Customer Id   ', N'89                                                ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 24)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 18, N'OS_TC_02  ', N'1         ', 1, 51, N'Order Date          ', N'19-Jul-2017                                       ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 25)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 18, N'OS_TC_02  ', N'1         ', 1, 52, N'Ship Address        ', N'59 Moo.1, Thanthan Uthaithani Thailand            ', CAST(N'2019-01-07' AS Date), NULL, N'1', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ', 26)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 42, N'Product id          ', N'xx                                                ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 27)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 43, N'Product Name        ', N'iPhone 7+                                         ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 28)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 44, N'Category Id         ', N'17                                                ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 29)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 46, N'Unit Price          ', N'28900                                             ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 30)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 47, N'Unit in Stock       ', N'500                                               ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 31)
INSERT [dbo].[M_TESTCASE_DETAIL] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [typeData], [refdataId], [refdataName], [testData], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser], [sequenceNo]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', 1, 48, N'Unit in Order       ', N'20                                                ', CAST(N'2019-01-08' AS Date), NULL, N'1', CAST(N'2019-01-08' AS Date), N'ploy      ', CAST(N'2019-01-08' AS Date), N'ploy      ', 32)
SET IDENTITY_INSERT [dbo].[M_TESTCASE_DETAIL] OFF
SET IDENTITY_INSERT [dbo].[M_TESTCASE_HEADER] ON 

INSERT [dbo].[M_TESTCASE_HEADER] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [testCaseDescription], [expectedResult], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 16, N'OS_TC_03  ', N'1         ', N'', N'Valid', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_TESTCASE_HEADER] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [testCaseDescription], [expectedResult], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 17, N'OS_TC_01  ', N'1         ', N'', N'Valid', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_TESTCASE_HEADER] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [testCaseDescription], [expectedResult], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 18, N'OS_TC_02  ', N'1         ', N'', N'Valid', CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
SET IDENTITY_INSERT [dbo].[M_TESTCASE_HEADER] OFF
SET IDENTITY_INSERT [dbo].[M_TESTCASE_VERSION] ON 

INSERT [dbo].[M_TESTCASE_VERSION] ([testCaseId], [testCaseVersionNumber], [testcaseVersion], [effectiveStartDate], [effectiveEndDate], [activeFlag], [updateDate], [updateUser], [createDate], [createUser]) VALUES (16, N'OS_TC_03  ', N'1         ', N'2019-01-07 17:10:16', NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_TESTCASE_VERSION] ([testCaseId], [testCaseVersionNumber], [testcaseVersion], [effectiveStartDate], [effectiveEndDate], [activeFlag], [updateDate], [updateUser], [createDate], [createUser]) VALUES (17, N'OS_TC_01  ', N'1         ', N'2019-01-07 17:11:59', NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
INSERT [dbo].[M_TESTCASE_VERSION] ([testCaseId], [testCaseVersionNumber], [testcaseVersion], [effectiveStartDate], [effectiveEndDate], [activeFlag], [updateDate], [updateUser], [createDate], [createUser]) VALUES (18, N'OS_TC_02  ', N'1         ', N'2019-01-07 17:12:04', NULL, 1, CAST(N'2019-01-07' AS Date), N'ploy      ', CAST(N'2019-01-07' AS Date), N'ploy      ')
SET IDENTITY_INSERT [dbo].[M_TESTCASE_VERSION] OFF
INSERT [dbo].[m_users] ([userid], [Firstname], [lastname], [username], [password], [status]) VALUES (N'0001      ', N'ploy      ', N'ploy      ', N'ploy      ', N'1234      ', NULL)
ALTER TABLE [dbo].[m_users]  WITH CHECK ADD  CONSTRAINT [FK_m_users_m_users] FOREIGN KEY([username])
REFERENCES [dbo].[m_users] ([username])
GO
ALTER TABLE [dbo].[m_users] CHECK CONSTRAINT [FK_m_users_m_users]
GO
USE [master]
GO
ALTER DATABASE [test] SET  READ_WRITE 
GO
