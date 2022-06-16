Create Database P225Trigger

Use P225Trigger

Create Table Students
(
	Id int primary key identity,
	Name nvarchar(50),
	SurName nvarchar(50)
)

Insert Into Students
Values
(N'Hamid',N'Mammadov')

Update Students Set Name = N'Həmid' Where Id = 1

Create Table StudnetsArchives
(
	Id int,
	Name nvarchar(50),
	SurName nvarchar(50),
	StatementType nvarchar(50),
	Date datetime2
)

--Trigger
--1. Create Trigger
Create Trigger StudentInsert 
On Students
after insert
As
Begin
	declare @id int
	declare @name nvarchar(50)
	declare @surname nvarchar(50)
	declare @statementType nvarchar
	declare @date datetime2

	Select @id = stu.Id from inserted stu
	Select @name = stu.Name from inserted stu
	Select @surname = stu.SurName from inserted stu
	Select @statementType = 'Created Object' from inserted stu
	Select @date = GETDATE() from inserted stu

	Insert Into StudnetsArchives(Id, Name, SurName, StatementType, Date)
	Values(@id, @name,@surname, @statementType, @date)
End

--2. Update Trigger
alter Trigger StudentInsert 
On Students
after insert,delete
As
Begin
	declare @id int
	declare @name nvarchar(50)
	declare @surname nvarchar(50)
	declare @statementType nvarchar(50)
	declare @date datetime2

	Select @id = stu.Id from inserted stu
	Select @name = stu.Name from inserted stu
	Select @surname = stu.SurName from inserted stu
	Select @statementType = 'Created Object' from inserted stu
	Select @date = GETDATE() from inserted stu

	Select @id = stu.Id from deleted stu
	Select @name = stu.Name from deleted stu
	Select @surname = stu.SurName from deleted stu
	Select @statementType = 'Deleted Object' from deleted stu
	Select @date = GETDATE() from deleted stu

	Insert Into StudnetsArchives(Id, Name, SurName, StatementType, Date)
	Values(@id, @name,@surname, @statementType, @date)
End

Insert Into Students
Values
(N'Maqsud',N'Seferov')

Create Trigger UpdatedStudnets
On Students
after update
As
Begin

	declare @id int
	declare @name nvarchar(50)
	declare @surname nvarchar(50)
	declare @statementType nvarchar(50)
	declare @date datetime2

	Select @id = stu.Id from inserted stu
	Select @name = stu.Name from inserted stu
	Select @surname = stu.SurName from inserted stu
	Select @statementType = 'Updated Object' from inserted stu
	Select @date = GETDATE() from inserted stu

	Insert Into StudnetsArchives(Id, Name, SurName, StatementType, Date)
	Values(@id, @name,@surname, @statementType, @date)
End

Update Students Set SurName = N'Rəhimli' Where Id = 4