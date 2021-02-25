
--Database II Project By Smita Rothe on 11/11/2020
--first we will create the database for our project
USE master
go
CREATE DATABASE DBProject

--start using an existing database shopping
USE DBProject

--now we will create the table invoices if it does not exist
DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices
( 
	InvoiceNumber int Primary key,
	InvoiceDate datetimeoffset NOT NULL,
	InvoiceTotal smallmoney NOT NULL,
	CreditTotal smallmoney NULL,
	PaymentTotal smallmoney NOT NULL
)
--first we will check if spDateRange exists then we will drop it and then we will create it
if OBJECT_ID('spDateRange','P') is not null 
drop proc spDateRange
go
create procedure spDateRange (@DateMin datetime=Null, @DateMax datetime=null)
As
begin
   Declare --declaring the variables we need to use in the code
	@ErrorMessage nvarchar(1000),
	@ErrorNumber INT,
	@ErrorSeverity INT,
	@ErrorState INT
     
	 BEGIN TRY--start try block
	     --validate the @DateMin and @DateMax parameters
		 If @DateMin is null or @DateMax is null 
		   begin
		      If @DateMin is null AND @DateMax is null 
			     begin
				   RAISERROR ('You must give the value for Datemin and DateMax parameters.',16,1)--ERROR_SEVERITY(), ERROR_STATE()) 
				 end 
			  Else If @DateMax is null 
				 begin
				   RAISERROR ( 'You must give the value for DateMax parameter.',16,1)
				 end 
			end 
		   --check if the datemin provided is less than the datemax
		 else if @DateMin > @DateMax
				begin
					RAISERROR('The first date provided(DateMin) must be less than the second(DateMax) date.',16,1)
				end
				 --now if the parameters are valid then select the columns 
		 else if not exists(select * from invoices where InvoiceDate between @DateMin and @DateMax)
				begin
					RAISERROR('The date range provided has no records in the table.',16,1)
				end 
		 else if exists (select * from invoices where InvoiceDate between @DateMin and @DateMax)
				begin
					select InvoiceNumber, InvoiceDate, InvoiceTotal, (InvoiceTotal-PaymentTotal-CreditTotal) as Balance 
					from invoices 
					where InvoiceDate between @DateMin and @DateMax
					order by InvoiceDate DESC
		        end
	 END TRY
	 --catch the error if any
	 BEGIN CATCH 
	    Select Error_Number() AS ErrorNumber , ERROR_MESSAGE() as ErrorMessage--we can use @@ERROR instead of Error_Number()
		select @ErrorMessage= ERROR_MESSAGE(),@ErrorSeverity= ERROR_SEVERITY(), @ErrorState= ERROR_STATE();
		RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
	 END CATCH 
end
go

--executing the stored procedure using the values april 10 to april 20
exec spDateRange '20200410', '20200420'
--now we will give some values for which we don't have any data in our table
exec spDateRange '20200101', '20200131'
--pass the values using variables
DECLARE @DateMin datetime 
DECLARE @DateMax datetime
set @DateMin='2020-oct-06'--'20200910'--'2020-sep-06'
set @DateMax ='20201030'
if(Isdate(@DateMin)=1 and Isdate(@DateMax)=1)
  begin
   exec spDateRange @DateMin,@DateMax --'2020', 45 
  end

exec spDateRange '20201030'  --20, 45 