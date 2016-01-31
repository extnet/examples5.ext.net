use "SimpleTasks"
go


/* DROP OBJECTS */

if exists (select * from sys.objects where name = 'Reset')
	drop procedure "Reset"
GO

CREATE PROCEDURE Reset
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	BEGIN
		EXECUTE sp_executesql N'/* INITIALIZE */

SET DATEFORMAT ymd


use "SimpleTasks"


/* DROP OBJECTS */

if exists (select * from sys.objects where name = ''Task'')
	drop table "Task"	


if exists (select * from sys.objects where name = ''Category'')
	drop table "Category"


if exists (select * from sys.objects where name = ''IsListParent'')
	drop function "IsListParent"
	




/* CREATE TABLES */

CREATE TABLE "Category" (
	"ID" "int" IDENTITY (1, 1) NOT NULL ,
	"ParentID" "int" NULL,
	"Name" nvarchar (MAX) NOT NULL ,
	"IsFolder" bit NOT NULL,
	CONSTRAINT "PK_Category" PRIMARY KEY CLUSTERED 
	(
		"ID"
	),
	CONSTRAINT "FK_Category_Category" FOREIGN KEY 
	(
		"ParentID"
	) REFERENCES "Category" (
		"ID"
	)
)


CREATE TABLE "Task" (
	"ID" "int" IDENTITY (1, 1) NOT NULL ,
	"CategoryID" "int" NOT NULL,
	"Title" nvarchar (MAX) NOT NULL ,
	"Description" nvarchar (MAX) NULL ,
	"DueDate" "datetime" NOT NULL ,
	"CompletedDate" "datetime" NULL ,
	"Reminder" "datetime" NULL,
	"Completed" bit NOT NULL,
	CONSTRAINT "PK_Task" PRIMARY KEY CLUSTERED 
	(
		"ID"
	),
	CONSTRAINT "FK_Task_Category" FOREIGN KEY 
	(
		"CategoryID"
	) REFERENCES "Category" (
		"ID"
	)
)



/* ADD DATA */

set quoted_identifier on


set identity_insert "Category" on


ALTER TABLE "Category" NOCHECK CONSTRAINT ALL


INSERT "Category"("ID", "ParentID", "Name", "IsFolder") VALUES(1, null, ''All Lists'', 1)
INSERT "Category"("ID", "ParentID", "Name", "IsFolder") VALUES(2, 1, ''Work'', 1)
INSERT "Category"("ID", "ParentID", "Name", "IsFolder") VALUES(3, 1, ''Home'', 1)
INSERT "Category"("ID", "ParentID", "Name", "IsFolder") VALUES(4, 1, ''Misc'', 1)


set identity_insert "Category" off


ALTER TABLE "Category" CHECK CONSTRAINT ALL



set identity_insert "Task" on


ALTER TABLE "Task" NOCHECK CONSTRAINT ALL


DECLARE @Date DATETIME = GETDATE()
Declare @DayOfMonth TinyInt Set @DayOfMonth = DAY(@Date) - 1
Declare @Month TinyInt Set @Month = MONTH(@Date) - 1
Declare @Year Integer Set @Year = YEAR(@Date)
SET @Date = DateAdd(day, @DayOfMonth, 
				DateAdd(month, @Month, 
						   DateAdd(Year, @Year-1900, 0)))
						   
/* SUBTRACT 3 DAYS */
INSERT "Task"("ID", "CategoryID", "Title", "Description", "DueDate", "CompletedDate", "Reminder", "Completed") 
	VALUES(1, 4, ''Groceries'', ''Milk and Eggs'', DATEADD(DAY, -3, @Date), DATEADD(DAY, -3, @Date), null, 1)
	
/* SUBTRACT 2 DAYS */		
INSERT "Task"("ID", "CategoryID", "Title", "Description", "DueDate", "CompletedDate", "Reminder", "Completed") 
	VALUES(2, 3, ''Bike Tune-up'', ''Drop off bike for tune-up'', DATEADD(DAY, -2, @Date), DATEADD(DAY, -2, @Date), null, 1)

/* TODAY */
INSERT "Task"("ID", "CategoryID", "Title", "Description", "DueDate", "CompletedDate", "Reminder", "Completed") 
	VALUES(3, 2, ''Finish demo application'', null, @Date, null, null, 0)
INSERT "Task"("ID", "CategoryID", "Title", "Description", "DueDate", "CompletedDate", "Reminder", "Completed") 
	VALUES(4, 3, ''Movie Night'', ''Rent Family Movie'', @Date, null, null, 0)
	
/* PLUS 20 DAYS */
INSERT "Task"("ID", "CategoryID", "Title", "Description", "DueDate", "CompletedDate", "Reminder", "Completed") 
	VALUES(5, 2, ''Documentation Kick Off'', ''Meeting to discuss documentation project'', DATEADD(DAY, 20, @Date), null, null, 0)


set identity_insert "Task" off


ALTER TABLE "Task" CHECK CONSTRAINT ALL
	
		'
		
		EXECUTE sp_executesql N'

CREATE FUNCTION IsListParent
	(
		@targetNode int,
		@dropNode int
	)

	RETURNS bit
	AS
	BEGIN
		WHILE (EXISTS(SELECT * FROM Category WHERE ParentID = @dropNode ))
			BEGIN
			  SELECT @dropNode = ID FROM Category  WHERE ParentID = @dropNode
			  IF @dropNode = @targetNode
			  BEGIN
				 RETURN 1
			  END
			END
		RETURN 0
	END
'
	RETURN
 END
GO