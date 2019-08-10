Create database Blockchain
-------------------
CREATE TABLE Users  
(  
FirstName VARCHAR(30) NOT NULL,  
LastName VARCHAR(30) NOT NULL,  
Email VARCHAR(80) PRIMARY KEY,  
UserPassword VARCHAR(20) NOT NULL,  
Balance money 
)

----------------------
CREATE PROCEDURE RegisterUser  
(  
    @FirstName VARCHAR(30),  
    @LastName VARCHAR(30) ,  
    @Email VARCHAR(80) ,  
    @UserPassword VARCHAR(20),  
	@Balance money
)  
AS  
BEGIN  
  
    DECLARE @result VARCHAR(10) ='Failed'
  
    IF NOT EXISTS(SELECT 1 FROM Users where Email=@Email)  
    BEGIN     
        INSERT INTO Users  
        VALUES   
        (  
            @FirstName,@LastName,@Email,@UserPassword, @Balance
        )  
          
        SET @result= 'Success'  
    END   
  
        SELECT @result AS Result  
END
------------------------
CREATE PROCEDURE ValidateUserLogin  
(  
    @LoginEmail VARCHAR(80) ,  
    @LoginPassword VARCHAR(20)  
)  
AS  
BEGIN  
  
    DECLARE @authentication VARCHAR(10)='Failed'  
  
    IF EXISTS(SELECT 1 FROM Users WHERE Email=@LoginEmail AND UserPassword =@LoginPassword)  
    BEGIN  
        SET @authentication='Success'  
    END  
      
    SELECT @authentication AS isAuthenticated  
  
END

-----------------------------
Create function ValidateUserEmail  
(   
   @Email varchar(80)
)  
returns money  
as  
BEGIN  
IF EXISTS(SELECT 1 FROM Users WHERE Email = @Email) 
begin
    DECLARE @balance money;  
    SELECT @balance = U.Balance   
    FROM  Users U
    Where Email = @Email         
     IF (@balance IS NULL)   
        SET @balance = 0;   
end 
 RETURN @balance;
END;

---------------------------
CREATE PROCEDURE ValidateUser
(  
    @LoginEmail VARCHAR(80)  
)  
AS  
BEGIN  
  
    DECLARE @authentication VARCHAR(10)='Failed'  
  
    IF EXISTS(SELECT 1 FROM Users WHERE Email=@LoginEmail)  
    BEGIN  
        SET @authentication='Success'  
    END  
      
    SELECT @authentication AS isAuthenticated  
  
END
