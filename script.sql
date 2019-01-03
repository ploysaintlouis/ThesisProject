USE [master]
GO
/****** Object:  Database [test]    Script Date: 3/1/2562 22:47:13 ******/
CREATE DATABASE [test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'test', FILENAME = N'F:\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\test.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'test_log', FILENAME = N'F:\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\test_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[M_DATABASE_INNOSCHEMA_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_INNOSCHEMA_VERSION](
	[projectId] [int] NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NULL,
	[previousSchemaVersionId] [char](10) NULL,
	[createDate] [date] NULL,
	[createUser] [varchar](50) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[schemaVersionId] [int] NULL,
	[inputid] [int] NULL,
	[dataType] [varchar](50) NULL,
	[dataLength] [nchar](10) NULL,
	[decimalPoint] [nchar](10) NULL,
	[constraintDefault] [nchar](10) NULL,
	[constraintNull] [nchar](10) NULL,
	[constraintMinValue] [nchar](10) NULL,
	[constraintMaxValue] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_DATABASE_OUTNOSCHEMA_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_OUTNOSCHEMA_VERSION](
	[projectId] [int] NULL,
	[outputid] [int] NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NULL,
	[activeFlag] [smallint] NULL,
	[previousSchemaVersionId] [char](10) NULL,
	[createDate] [date] NULL,
	[createUser] [varchar](50) NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[schemaVersionId] [int] NULL,
	[dataType] [varchar](50) NULL,
	[dataLength] [nchar](10) NULL,
	[decimalPoint] [nchar](10) NULL,
	[constraintDefault] [nchar](10) NULL,
	[constraintNull] [nchar](10) NULL,
	[constraintMinValue] [nchar](10) NULL,
	[constraintMaxValue] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_INFO]    Script Date: 3/1/2562 22:47:13 ******/
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
	[schemaVersionId] [char](10) NOT NULL,
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
/****** Object:  Table [dbo].[M_DATABASE_SCHEMA_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_DATABASE_SCHEMA_VERSION](
	[projectId] [int] NOT NULL,
	[schemaVersionId] [int] NOT NULL,
	[schemaVersionNumber] [char](10) NULL,
	[tableName] [varchar](50) NOT NULL,
	[columnName] [varchar](50) NOT NULL,
	[effectiveStartDate] [date] NOT NULL,
	[effectiveEndDate] [date] NOT NULL,
	[createDate] [date] NOT NULL,
	[createUser] [varchar](50) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[activeFlag] [smallint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL]    Script Date: 3/1/2562 22:47:13 ******/
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
	[dataId] [int] NOT NULL,
	[dataName] [char](20) NOT NULL,
	[schemaVersionId] [char](10) NOT NULL,
	[refTableName] [varchar](50) NULL,
	[refColumnName] [varchar](50) NULL,
	[dataType] [char](20) NOT NULL,
	[dataLength] [char](10) NULL,
	[decimalPoint] [char](10) NULL,
	[constraintPrimaryKey] [char](1) NULL,
	[constraintUnique] [char](1) NULL,
	[constraintDefault] [char](10) NULL,
	[constraintNull] [char](1) NULL,
	[constraintMinValue] [char](10) NULL,
	[constraintMaxValue] [char](10) NULL,
	[effectiveStartDate] [date] NOT NULL,
	[effectiveEndDate] [date] NOT NULL,
	[activeFlag] [smallint] NOT NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL_INPUT]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_FN_REQ_DETAIL_OUTPUT]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_FN_REQ_HEADER]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_FN_REQ_HEADER](
	[functionId] [int] NOT NULL,
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
/****** Object:  Table [dbo].[M_FN_REQ_INPUT]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_FN_REQ_OUTPUT]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_FN_REQ_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_MISCELLANEOUS]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_MISCELLANEOUS](
	[miscData] [char](30) NOT NULL,
	[miscValue1] [char](10) NOT NULL,
	[miscValue2] [char](10) NULL,
	[miscDescription] [char](50) NOT NULL,
	[activeFlag] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_PROJECT]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_RTM]    Script Date: 3/1/2562 22:47:13 ******/
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
	[createDate] [char](10) NOT NULL,
	[createUser] [char](10) NOT NULL,
	[effectiveEndDate] [date] NULL,
	[effectiveStartDate] [date] NULL,
	[activeFlag] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RTM_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_RTM_VERSION](
	[projectId] [int] NOT NULL,
	[testCaseId] [int] NOT NULL,
	[testCaseversion] [char](10) NOT NULL,
	[functionId] [int] NOT NULL,
	[functionVersion] [int] NOT NULL,
	[effectiveStartDate] [date] NULL,
	[effectiveEndDate] [date] NOT NULL,
	[createDate] [date] NOT NULL,
	[createUser] [char](10) NOT NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL,
	[activeFlag] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RUNNING_NO]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_RUNNING_NO](
	[runningType] [char](10) NULL,
	[period] [date] NULL,
	[runningNo] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[M_RUNNING_PREFIX]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[M_TESTCASE_DETAIL]    Script Date: 3/1/2562 22:47:13 ******/
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
	[refInputId] [varchar](50) NULL,
	[refInputName] [varchar](50) NULL,
	[refOutputId] [varchar](50) NULL,
	[refOutputName] [varchar](50) NULL,
	[testData] [char](50) NULL,
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
/****** Object:  Table [dbo].[M_TESTCASE_HEADER]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_HEADER](
	[projectId] [int] NULL,
	[testCaseId] [int] NULL,
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
/****** Object:  Table [dbo].[M_TESTCASE_VERSION]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[M_TESTCASE_VERSION](
	[testCaseId] [int] NULL,
	[testCaseVersionNumber] [nchar](10) NULL,
	[testcaseVersion] [char](10) NULL,
	[effectiveStartDate] [nvarchar](50) NULL,
	[effectiveEndDate] [nvarchar](50) NULL,
	[activeFlag] [smallint] NULL,
	[updateDate] [date] NULL,
	[updateUser] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[m_users]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[m_users](
	[userid] [char](10) NOT NULL,
	[Firstname] [char](20) NULL,
	[lastname] [char](20) NULL,
	[username] [char](10) NOT NULL,
	[password] [char](10) NOT NULL,
	[activeFlag] [char](1) NULL,
 CONSTRAINT [PK_m_users] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Project]    Script Date: 3/1/2562 22:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[projectid] [nchar](10) NOT NULL,
	[projectName] [nchar](10) NULL,
	[effdate] [nchar](10) NULL,
	[enddate] [nchar](10) NULL,
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
/****** Object:  Table [dbo].[stock]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[T_CHANGE_REQUEST_DETAIL]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[T_CHANGE_REQUEST_HEADER]    Script Date: 3/1/2562 22:47:13 ******/
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
/****** Object:  Table [dbo].[T_TEMP_CHANGE_LIST]    Script Date: 3/1/2562 22:47:13 ******/
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
	[dataId] [int] NULL,
	[dataName] [char](20) NULL,
	[userId] [char](20) NULL,
	[newDataType] [char](20) NULL,
	[newDataLength] [int] NULL,
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
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_ssn                                             ', N'1         ', N'VARCHAR             ', N'11        ', N'          ', N' ', N'Y', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_firstname                                       ', N'1         ', N'VARCHAR             ', N'45        ', N'          ', N' ', N'N', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_lastname                                        ', N'1         ', N'VARCHAR             ', N'45        ', N'          ', N' ', N'N', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_birthdate                                       ', N'1         ', N'DATE                ', N'          ', N'          ', N' ', N'N', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_phone                                           ', N'1         ', N'VARCHAR             ', N'          ', N'10        ', N' ', N'N', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_INFO] ([projectId], [tableName], [columnName], [schemaVersionId], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue]) VALUES (2, N'patients                                          ', N'p_address                                         ', N'1         ', N'VARCHAR             ', N'          ', N'100       ', N' ', N'N', N'          ', N'Y', N'          ', N'          ')
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients  ', N'p_ssn     ', CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-11-29' AS Date), N'ploy      ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients', N'p_firstname', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-12-07' AS Date), N'ploy ploy', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients', N'p_lastname', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-12-07' AS Date), N'ploy ploy', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients', N'p_birthdate', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-12-07' AS Date), N'ploy ploy', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients', N'p_phone', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-12-07' AS Date), N'ploy ploy', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_DATABASE_SCHEMA_VERSION] ([projectId], [schemaVersionId], [schemaVersionNumber], [tableName], [columnName], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', N'patients', N'p_address', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-12-07' AS Date), N'ploy ploy', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 1, N'HS_FR_01  ', 1, N'1         ', 1, N'Patient Address     ', N'1         ', N'patients', N'p_address', N'VARCHAR             ', N'100       ', N'          ', N'N', N'N', N'          ', N'N', N'          ', N'          ', CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 1, N'HS_FR_01  ', 1, N'1         ', 2, N'Patient Phone No.   ', N'1         ', N'patients', N'p_phone', N'VARCHAR             ', N'10        ', N'          ', N'N', N'N', N'          ', N'N', N'          ', N'          ', CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL] ([projectid], [functionId], [functionNo], [functionVersion], [typeData], [dataId], [dataName], [schemaVersionId], [refTableName], [refColumnName], [dataType], [dataLength], [decimalPoint], [constraintPrimaryKey], [constraintUnique], [constraintDefault], [constraintNull], [constraintMinValue], [constraintMaxValue], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 1, N'HS_FR_01  ', 1, N'1         ', 3, N'Patient Address     ', N'1         ', N'patients', N'p_ssn', N'VARCHAR             ', N'100       ', N'          ', N'N', N'N', N'          ', N'N', N'          ', N'          ', CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 1, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 2, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 3, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_INPUT] ([functionId], [inputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 4, N'1         ', CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_FN_REQ_DETAIL_OUTPUT] ([functionId], [outputId], [schemaVersionId], [effectiveStartDate], [effectiveEndDate], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (1, 1, NULL, CAST(N'2018-12-07' AS Date), CAST(N'9999-12-31' AS Date), 1, CAST(N'2018-12-07' AS Date), N'ploy ploy ', NULL, N'          ')
INSERT [dbo].[M_FN_REQ_HEADER] ([functionId], [functionNo], [functionversion], [functionDescription], [createDate], [createUser], [updateDate], [updateUser], [projectid], [activeflag]) VALUES (1, N'HS_FR_01  ', N'1         ', N'Add a New Patient Information                     ', CAST(N'2018-11-29' AS Date), N'ploy      ', CAST(N'1900-01-01' AS Date), N'          ', 2, 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'Patient SSN', N'patients', N'p_ssn', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 2, N'Patient First Name', N'patients', N'p_firstName', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 3, N'Patient Last Name', N'patients', N'p_lastName', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_INPUT] ([projectId], [inputId], [inputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 4, N'Patient Birth Date', N'patients', N'p_birthdate', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_OUTPUT] ([projectId], [outputId], [outputName], [refTableName], [refColumnName], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'Age', NULL, NULL, CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_FN_REQ_VERSION] ([functionId], [functionVersionNumber], [effectiveStartDate], [effectiveEndDate], [activeFlag], [previousVersionId], [createDate], [createUser], [updateDate], [updateUser], [functionVersionId]) VALUES (1, N'1         ', CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), 1, N'          ', CAST(N'2018-11-29' AS Date), N'ploy      ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDataType                 ', N'CHAR      ', N'          ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'VARCHAR   ', N'          ', N'                                                  ', 1)
INSERT [dbo].[M_MISCELLANEOUS] ([miscData], [miscValue1], [miscValue2], [miscDescription], [activeFlag]) VALUES (N'inputDatatype                 ', N'DATE      ', N'          ', N'                                                  ', 1)
SET IDENTITY_INSERT [dbo].[M_PROJECT] ON 

INSERT [dbo].[M_PROJECT] ([projectId], [projectName], [projectNameAlias], [effDate], [endDate], [customer], [databaseName], [hostname], [port], [username], [password], [startFlag], [activeFlag], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, N'Hospital', N'Hospital', CAST(N'2018-11-29 00:00:00.000' AS DateTime), CAST(N'2018-12-28 00:00:00.000' AS DateTime), N'test1', N'Hospital', N'localhost', N'81', N'ploy', N'1234      ', 1, 1, CAST(N'2018-11-29 17:59:26.000' AS DateTime), N'ploy      ', CAST(N'2018-11-29 17:59:26.000' AS DateTime), N'ploy      ')
SET IDENTITY_INSERT [dbo].[M_PROJECT] OFF
INSERT [dbo].[M_RTM] ([projectId], [testCaseId], [functionId], [createDate], [createUser], [effectiveEndDate], [effectiveStartDate], [activeFlag]) VALUES (2, 1, 1, N'2018-12-07', N'          ', NULL, CAST(N'2018-12-07' AS Date), N'1')
INSERT [dbo].[M_RTM_VERSION] ([projectId], [testCaseId], [testCaseversion], [functionId], [functionVersion], [effectiveStartDate], [effectiveEndDate], [createDate], [createUser], [updateDate], [updateUser], [activeFlag]) VALUES (2, 1, N'1         ', 1, 1, CAST(N'2018-11-29' AS Date), CAST(N'9999-12-31' AS Date), CAST(N'2018-11-29' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ', 1)
INSERT [dbo].[M_TESTCASE_HEADER] ([projectId], [testCaseId], [testCaseNo], [testcaseVersion], [testCaseDescription], [expectedResult], [createDate], [createUser], [updateDate], [updateUser]) VALUES (2, 1, N'HS_TC_01  ', N'1         ', N'', N'Valid', CAST(N'2018-12-07' AS Date), N'ploy ploy ', CAST(N'1900-01-01' AS Date), N'          ')
INSERT [dbo].[M_TESTCASE_VERSION] ([testCaseId], [testCaseVersionNumber], [testcaseVersion], [effectiveStartDate], [effectiveEndDate], [activeFlag], [updateDate], [updateUser]) VALUES (1, N'HS_TC_01  ', N'1         ', N'2018-12-07', N'9999-12-31', 1, NULL, NULL)
INSERT [dbo].[m_users] ([userid], [Firstname], [lastname], [username], [password], [activeFlag]) VALUES (N'0001      ', N'ploy                ', N'ploy                ', N'ploy      ', N'1234      ', NULL)
INSERT [dbo].[stock] ([stock_id], [stockname]) VALUES (1, N'PTT')
ALTER TABLE [dbo].[m_users]  WITH CHECK ADD  CONSTRAINT [FK_m_users_m_users] FOREIGN KEY([username])
REFERENCES [dbo].[m_users] ([username])
GO
ALTER TABLE [dbo].[m_users] CHECK CONSTRAINT [FK_m_users_m_users]
GO
USE [master]
GO
ALTER DATABASE [test] SET  READ_WRITE 
GO
