
create database SportsDatabase

GO

create proc Also
@MagName varchar(20),
@Recom varchar(20) OUTPUT
AS
declare @res varchar(20)
declare @T table(cid int)
insert into @T 
select s.cid from Subscribes s where s.title=@Magname
declare @T2 table(cid int,title varchar(20))
insert into @T2 
select t.cid,s.title
from @T t INNER JOIN subscribes s ON t.cid=s.cid AND s.title!=@MagName

select  top 1 @Recom=title 
from @T2 
group by title 
order by count(*) 












drop proc Also

create table customer(CID int primary key identity,name varchar(20))
create table magazine(title varchar(20))
create table Subscribes(cid int ,title varchar(20))

insert into customer values('a7a')
insert into magazine values('dehk')
select * from magazine
insert into Subscribes values(1,'lolz1')

create table names(first varchar(20), last varchar(20), unique (first, last))
insert into names values ('Nada', 'Sharaf');

select ad.name,ad.Location
from Club ad 
where 2>= (
select Count(*) from Match where host=ad.C_ID
)

declare @out varchar(20)
exec Also 'lolz1', @out OUTPUT 
print(@out)

select * from availableMatchesToAttend('2023-01-01 ')

select * from club
exec addRepresentative 'ahmed','FC Barcelona','ahmed101','111'
exec addStadiumManager 'mos3ad','Lusail','mos3ad11','111'
exec addHostRequest 'Arsenal FC','Camp Nou','2023-03-23 17:08:00.000'

select * from allMatches
select * from allStadiumManagers
select * from allRequests

select * from Stadium_Manager

GO
create view SMview as
select hr.Handled_By AS SM_ID, cr.Name AS Club_Rep, c1.Name AS Host,c2.Name AS Guest,m.Start_time,m.End_time,hr.status,hr.HR_ID AS Request_ID 
from Host_request hr INNER JOIN club c1 ON hr.Asked_By = c1.representative 
INNER JOIN match m ON m.Match_ID = hr.Match_ID 
INNER JOIN club c2 on m.guest=c2.C_ID
INNER JOIN Club_representative cr ON cr.CR_ID=hr.Asked_By
GO

select * from allStadiumManagers

GO
create proc createAllTables
AS
create table Users 
(
username varchar(20) primary key,
password varchar(20)
)
create table Stadium_Manager
(
 SM_ID int identity primary key,
 username varchar(20) NOT NULL,
 Name varchar(20) unique,
 Constraint fk_stadiumManager foreign key(username) references Users ON delete cascade 
)
create table Club_representative 
(
CR_ID int identity primary key,
Name varchar(20),
username varchar(20) NOT NULL,
 Constraint fk_ClubRep foreign key(username) references Users ON delete cascade
)
create table Fan
(
 NationalID varchar(20) primary key, 
 PhoneNo int,
 name varchar(20),
 Address varchar(20),
 Status BIT,
 Birth_Date date,
 username varchar(20) NOT NULL,
  Constraint fk_FanUser foreign key (username) references Users ON delete cascade 
)
create table SportsAssosManager
(
SAM_Id int identity primary key,
name varchar(20),
username varchar(20) NOT NULL,
 Constraint fk_SAM foreign key (username) references Users ON delete cascade 
)
create table System_Admin
(
sys_ID int identity primary key,
Name varchar(20),
username varchar(20) NOT NULL,
 Constraint fk_sys foreign key (username) references Users ON delete cascade 
)

create table Stadium
(
Stad_ID int identity primary key,
Status BIT,
Location varchar(20),
capacity int,
name varchar(20) unique,
Managed_By int,
 Constraint fk_stad foreign key (Managed_By) references Stadium_Manager ON update cascade ON delete set NULL 
)
create table Club
(
C_ID int identity primary key,
Name varchar(20) unique,
Location varchar(20),
representative int,
 Constraint fk_Club foreign key (representative) references Club_representative On update cascade ON delete set NULL
)
create table Match
(
Match_ID int identity primary key,
Start_time datetime,
End_time datetime,
host int,
guest int,
stadium int,
Constraint fk_MatchStad foreign key (stadium) references Stadium ON delete set Null ON update set NULL,
Constraint fk_guest foreign key (guest) references Club ON delete no action ON update no action,
Constraint fk_host foreign key (host) references Club ON delete no action ON update no action

)
create table Host_request
(
HR_ID int identity primary key,
Handled_By int NOT NULL,
Asked_By int NOT NULL,
Match_ID int NOT NULL,
status  varchar(20), CHECK (status IN('Unhandled', 'Accepted', 'Rejected')),
Constraint fk1 foreign key (Match_ID) references Match ON delete cascade ON update cascade,
Constraint fk2 foreign key (Handled_By) references Stadium_Manager ON delete no action ON update no action,
Constraint fk3 foreign key (Asked_By) references Club_representative ON delete no action
)
create table Ticket
(
Ticket_ID int identity primary key,
Status BIT,
Match_ID int NOT NULL,
Constraint fk_TicketMatch foreign key (Match_ID) references Match ON delete cascade,
)
create table ticket_buying_transaction
(
Ticket_ID int primary key,
Fan_ID varchar(20),
constraint fk_Ticket foreign key (Ticket_ID) references Ticket On delete cascade,
constraint fk_Fan foreign key (Fan_ID) references Fan On delete cascade
 )

GO


GO
create proc dropAllTables
AS
drop table ticket_buying_transaction
drop table ticket
drop table Host_request
drop table Match
drop table Club
drop table Stadium
drop table System_Admin
drop table SportsAssosManager
drop table Fan
drop table Club_representative
drop table Stadium_Manager
drop table Users
GO

select m1.*,m.Match_ID AS Match_ID from availableMatchesToAttend('2023-01-02 05:00:00.000') m1 INNER JOIN club c1 ON c1.Name=m1.Host INNER JOIN club c2 ON c2.Name=m1.Guest
INNER JOIN Match m ON c1.C_ID=m.host AND c2.C_ID =m.guest AND m1.Start=m.Start_time

select * from allFans
select * from Ticket
select * from availableMatchesToAttend('2023-01-02 05:00:00.000')

select * from allStadiumManagers
select * from Stadium



GO
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
DROP PROC 
clearAllTables,
dropAllTables,
createAllTables,
addAssociationManager,
addNewMatch,
deleteMatch,
deleteMatchesOnStadium,
addClub,
addTicket,
deleteClub,
addStadium,
deleteStadium,
blockFan,
unblockFan,
addRepresentative,
addHostRequest,
addStadiumManager,
acceptRequest,
rejectRequest,
addFan,
purchaseTicket,
updateMatchHost;

DROP VIEW 
allAssocManagers,
allClubRepresentatives,
allStadiumManagers,
allFans,
allMatches,
allTickets,
allCLubs,
allStadiums,
allRequests,
clubsWithNoMatches,
matchesPerTeam,
clubsNeverMatched;

DROP FUNCTION
viewAvailableStadiumsOn,
allUnassignedMatches,
allPendingRequests,
upcomingMatchesOfClub,
availableMatchesToAttend,
clubsNeverPlayed,
matchWithHighestAttendance,
matchesRankedByAttendance,
requestsFromClub;



GO
create proc clearAllTables
AS



ALTER TABLE MATCH
DROP CONSTRAINT fk_host,fk_guest,fk_MatchStad
ALTER TABLE Club
DROP CONSTRAINT fk_club
ALTER TABLE Stadium
DROP CONSTRAINT fk_stad
ALTER TABLE System_admin
DROP CONSTRAINT fk_sys
ALTER TABLE SportsAssosManager
DROP CONSTRAINT fk_SAM
ALTER TABLE Fan
DROP CONSTRAINT fk_FanUser
ALTER TABLE Club_representative 
DROP CONSTRAINT fk_ClubRep 
ALTER TABLE Stadium_Manager
DROP CONSTRAINT fk_stadiumManager 
ALTER TABLE Ticket
DROP CONSTRAINT fk_TicketMatch
ALTER TABLE Host_request
DROP CONSTRAINT fk1,fk2,fk3
ALTER TABLE ticket_buying_transaction
drop constraint fk_Ticket,fk_Fan

truncate table ticket
truncate table Host_request
truncate table ticket_buying_transaction
truncate table  Match
truncate table  Club
truncate table Stadium 
truncate table System_Admin
truncate table SportsAssosManager
truncate table Fan
truncate table Club_representative
truncate table Stadium_Manager
truncate table Users


ALTER TABLE Host_request
ADD CONSTRAINT  fk1 foreign key (Match_ID) references Match ON delete cascade,
Constraint fk2 foreign key (Handled_By) references Stadium_Manager ON delete no action,
Constraint fk3 foreign key (Asked_By) references Club_representative ON delete no action
ALTER TABLE Ticket
ADD CONSTRAINT  fk_TicketMatch foreign key (Match_ID) references Match ON delete cascade
ALTER TABLE Stadium_Manager
ADD Constraint fk_stadiumManager foreign key(username) references Users ON delete cascade 
ALTER TABLE Fan
ADD Constraint fk_FanUser foreign key (username) references Users ON delete cascade 
ALTER TABLE Club_representative
ADD Constraint fk_ClubRep foreign key(username) references Users ON delete cascade
ALTER TABLE SportsAssosManager
ADD Constraint fk_SAM foreign key (username) references Users ON delete cascade 
ALTER Table System_admin
ADD Constraint fk_sys foreign key (username) references Users ON delete cascade 
ALTER TABLE Stadium
ADD Constraint fk_stad foreign key (Managed_By) references Stadium_Manager ON update cascade ON delete set NULL 
ALTER TABLE CLUB
ADD CONSTRAINT fk_Club foreign key (representative) references Club_representative On update cascade ON delete set NULL

ALTER TABLE MATCH
ADD CONSTRAINT  fk_host foreign key (host) references Club ON delete no action on update no action,
Constraint fk_guest foreign key (guest) references Club on delete no action on update no action,
 Constraint fk_MatchStad foreign key (stadium) references Stadium ON delete set Null


 ALTER TABLE ticket_buying_transaction
ADD constraint fk_Ticket foreign key (Ticket_ID) references Ticket On delete cascade,
constraint fk_Fan foreign key (Fan_ID) references Fan On delete cascade



GO
create view allAssocManagers
AS
Select sam.username,u.password,name
from SportsAssosManager sam inner JOIN Users u ON sam.username=u.username
GO


create view allClubRepresentatives
AS
select c.username,u.password,c.name,c1.Name AS Club_Name
from Club_representative c INNER JOIN Club c1
ON c.CR_ID=c1.representative INNER JOIN Users u on c.username=u.username
GO


create view allStadiumManagers
AS
select sm.username AS Username,u.password,sm.Name AS manager_Name ,s.name AS Stadium_Name
from Stadium_Manager sm INNER JOIN Stadium s  
ON sm.SM_ID=s.Managed_By INNER JOIN Users u on u.username=sm.username
GO


create view allFans
AS
select u.username,u.password,f.name,f.NationalID,f.Birth_Date,f.Status
from Fan f INNER JOIN Users u on f.username=u.username
GO



create view allMatches
AS
select c1.Name AS Host,c2.Name AS Guest,m.Start_time,m.End_time
from Match m INNER JOIN club c1 ON m.host=c1.C_ID INNER JOIN club c2 ON c2.C_ID=m.guest
GO

create view allTickets
AS 
select c1.name AS Host,c2.name AS Guest,s.name AS Stadium,m.Start_time
from Ticket t INNER JOIN Match m ON t.Match_ID=m.Match_ID
INNER JOIN Club c1 ON c1.C_ID=m.host INNER JOIN Club c2 on c2.C_ID=m.guest
LEFT OUTER JOIN Stadium s ON s.Stad_ID=m.stadium
GO

create view allCLubs
AS
select Name,Location 
from Club
GO

create view allStadiums
AS
select name,Location,capacity,Status
from Stadium
GO

create view allRequests
AS
select u.username AS Club_rep,u2.username AS S_manager,hr.status
from Host_request hr INNER JOIN Club_representative cr ON hr.Asked_By=cr.CR_ID
INNER JOIN Stadium_Manager sm ON sm.SM_ID=hr.Handled_By INNER JOIN Users u on cr.username=u.username
INNER JOIN Users u2 ON u2.username=sm.username
GO

create proc addAssociationManager
@name varchar(20),
@username varchar(20),
@password varchar(20)
AS
if(NOT EXISTS(select * from Users u where u.username=@username))
begin
insert into Users values (@username,@password)
insert into SportsAssosManager values(@name,@username)
END
else print('Username Already Exists, Pick Another')
GO


GO
create view clubsWithNoMatches
AS
select AllClubs.Name
from Club AllClubs 
EXCEPT
select clubWIth.Name
from Club clubWIth
INNER JOIN Match m ON clubWIth.C_ID=m.guest OR clubWIth.C_ID=m.host
GO



create proc addClub
@name varchar(20),
@location varchar(20)
AS
if((NOT EXISTS(select * from club where Name=@name)))
insert into Club values (@name,@location,NULL)
else print ('Club with that name exists')
GO

exec addClub 'FC Barcelona','Barcelona'
exec addClub 'Real Madrid','Madrid'
exec addStadium 'Lusail','Doha','50'
exec addNewMatch 'FC Barcelona','Real Madrid','2023-01-01 05:00:00','2023-01-01 07:00:00'
select * from availableMatchesToAttend ('2022-01-01 05:00:00')


GO
create proc addNewMatch
@Host varchar(20),
@Guest varchar(20),
@Start datetime,
@End datetime
AS
declare @Day date;
set @Day = CONVERT(VARCHAR(10),@Start, 111);
declare @HostID int
select @HostID=c3.C_ID
from club c3 where c3.Name=@Host
declare @GuestID int
select @GuestID=c2.C_ID
from club c2 where c2.Name=@Guest
if(EXISTS (select * from Match where (host=@HostID OR guest=@HostID) AND CONVERT(VARCHAR(10),Start_time, 111)=@Day) OR 
EXISTS (select * from Match where (host=@GuestID OR guest=@GuestID) AND CONVERT(VARCHAR(10),Start_time, 111)=@Day) OR @GuestID is Null OR @HostID is NULL           )
print ('Atleast One of the Clubs Are Playing A Match On this Day,A Club Cannot play Two matches On the Same Day')
else
insert into match values(@Start,@End,@HostID,@GuestID,NULL)
GO



create proc deleteMatch2
@Host varchar(20),
@Guest varchar(20),
@Start datetime,
@End datetime
AS

declare @HostID int
select @HostID=c3.C_ID
from club c3 where c3.Name=@Host
declare @GuestID int
select @GuestID=c2.C_ID
from club c2 where c2.Name=@Guest

delete from Match 
where guest=@GuestID AND host=@HostID AND Start_time=@Start AND End_time=@End
GO



create proc deleteMatch
@Host varchar(20),
@Guest varchar(20)
AS

declare @HostID int
select @HostID=c3.C_ID
from club c3 where c3.Name=@Host
declare @GuestID int
select @GuestID=c2.C_ID
from club c2 where c2.Name=@Guest

delete from Match 
where guest=@GuestID AND host=@HostID
GO

GO
create proc deleteMatchesOnStadium
@Stad varchar(20)
AS
declare @StadID int
select @StadID=Stad_ID
from Stadium where @Stad=name
delete from Match
where stadium = @StadID AND CURRENT_TIMESTAMP<Start_time
GO


create proc addTicket 
@HostName varchar(20),
@GuestName varchar(20),
@Start datetime
AS
declare @HostID int
declare @GuestID int
select @HostID=C.C_ID
from Club c where name=@HostName

select @GuestID=C.C_ID
from Club c where name=@GuestName

declare @MatchID int
select @MatchID=m.Match_ID
from Match m 
where m.guest=@GuestID AND m.host=@HostID AND m.Start_time=@Start
insert into Ticket values (1,@MatchID)
GO


drop proc deleteClub

GO
create proc deleteClub
@ClubName varchar(20)
AS

ALTER TABLE MATCH
DROP CONSTRAINT fk_host,fk_guest,fk_MatchStad

declare @ClubID int,@CRep int,@RepUser varchar(20) 
select @ClubID=C_ID,@CRep=representative from club where @ClubName=Name

select @RepUser=username from Club_representative where @CRep=CR_ID

delete from Host_request where Asked_By=@CRep
delete from Users where username=@RepUser


delete from match where host=@ClubID OR guest=@ClubID

delete from Club
where name=@ClubName





ALTER TABLE MATCH
ADD CONSTRAINT  fk_host foreign key (host) references Club ON delete no action on update no action,
Constraint fk_guest foreign key (guest) references Club on delete no action on update no action,
 Constraint fk_MatchStad foreign key (stadium) references Stadium ON delete set Null





GO
select * from allFans

select * from Users

exec deleteClub 'adadadadadadadadadadadadadadadadadadadadadadadadadadad'



select * from allStadiumManagers

select * from allClubRepresentatives

select * from allStadiums

GO
create proc addStadium
@name varchar(20),
@location varchar(20),
@capacity int
AS
if(NOT exists(select * from Stadium where name=@name))
insert into Stadium values(1,@location,@capacity,@name,NULL)
else print('Cannot insert another stadium with same name')

select * from allStadiumManagers


GO
create proc deleteStadium
@name varchar(20)
AS
declare @ManID int,@user varchar(20)

select @ManID=Managed_By
from Stadium where name=@name
select @user=username
from Stadium_Manager where SM_ID=@ManID

delete from Host_request 
where Handled_By=@ManID
delete from Users
where username=@user


delete from Stadium
where name=@name


GO



create proc blockFan
@NatID varchar(20)
AS
Update Fan
set status=0
where NationalID=@NatID
GO




create proc unblockFan
@NatID varchar(20)
AS
Update Fan
set status=1
where NationalID=@NatID

GO
create proc addRepresentative
@name varchar(20),
@ClubName varchar(20),
@User varchar(20),
@pass varchar(20)
AS
if(NOT EXISTS (select * from Users where username=@User) AND EXISTS (select * from club where representative is NULL AND name=@ClubName))
BEGIN
insert into Users values (@User,@pass)
insert into Club_representative values (@name,@User)
declare @ID int
select @ID=CR_ID
from Club_representative where @User=username
update Club
set representative=@ID where Name=@ClubName
END
else print ('Username Already Exists, Pick Another')
GO

select * from upcomingMatchesOfClub('Arsenal FC')


GO
create proc addStadiumManager
@name varchar(20),
@StadName varchar(20),
@User varchar(20),
@pass varchar(20)
AS
if(NOT EXISTS (select * from Users where username=@User) AND EXISTS (select * from Stadium where Managed_By is NULL AND name=@StadName))
BEGIN
insert into Users values (@User,@pass)
insert into Stadium_Manager values (@User,@name)
declare @ID int
select @ID=SM_ID
from Stadium_Manager where @User=username
update Stadium
set Managed_By=@ID where Name=@StadName
END
else print ('Username Already Exists, Pick Another')
Go

select * from allClubRepresentatives

GO
create proc addHostRequest2
@CRID varchar(20),
@StadName varchar(20),
@Start datetime
AS
declare @ClubId int
declare @SM_ID2 int,@StadID int
declare @MatchID int
select @ClubId=C_ID
from Club where representative=@CRID
select @SM_ID2=Managed_By,@StadID=Stad_ID
from Stadium where name=@StadName
select @MatchID=m.Match_ID
from match m where m.Start_time=@Start AND m.host=@ClubId

if(EXISTS (select * from Match where stadium=@StadID AND Start_time=@Start)OR @StadID is NULL OR @ClubId is NULL OR @MatchID is NULL)
print ('Cannot Request That Stadium For another Match, Since a match will be played At the Same time')
else
insert into Host_request values (@SM_ID2,@CRID,@MatchID,'Unhandled')
GO


GO
create proc addHostRequest
@clubName varchar(20),
@StadName varchar(20),
@Start datetime
AS
declare @ClubId int
declare @CR_ID1 int
declare @SM_ID2 int,@StadID int
declare @MatchID int
select @CR_ID1=representative,@ClubId=C_ID
from Club where name=@clubName
select @SM_ID2=Managed_By,@StadID=Stad_ID
from Stadium where name=@StadName
select @MatchID=m.Match_ID
from match m where m.Start_time=@Start AND m.host=@ClubId

if(EXISTS (select * from Match where stadium=@StadID AND Start_time=@Start)OR @StadID is NULL OR @ClubId is NULL OR @MatchID is NULL)
print ('Cannot Request That Stadium For another Match, Since a match will be played At the Same time')
else
insert into Host_request values (@SM_ID2,@CR_ID1,@MatchID,'Unhandled')
GO


create function viewAvailableStadiumsOn
(@date2 datetime)
Returns @T Table (name varchar(20),location varchar(20),capacity int) 
AS 
begin

insert into @T 
select s.name,s.Location,s.capacity 
from Stadium s 
EXCEPT 
select s.name,s.Location,s.capacity 
from Stadium s INNER JOIN 
Match m ON s.Stad_ID=m.stadium AND m.Start_time=@date
return
end
GO

 create function allPendingRequests
 (@SM_Username varchar(20))
 returns table
 AS
  return select cr.Name AS Club_Rep,c3.Name AS Club,m.Start_time
 from Host_request hr INNER JOIN Club_representative cr ON hr.Asked_By=cr.CR_ID
 INNER JOIN Stadium_Manager sm ON sm.SM_ID=hr.Handled_By INNER JOIN club c ON c.representative=cr.CR_ID
 INNER JOIN Match m ON m.Match_ID=hr.Match_ID INNER JOIN club c3 ON c3.C_ID=m.guest
 where sm.username=@SM_Username AND hr.status='unhandled'
 GO


 SELECT COUNT(*) FROM dbo.Host_Request where status='Accepted' AND HR_ID=1


 GO
 create proc RejReq
 @ReqID int,
 @ManID int
 AS
 if(EXISTS(select * from Host_request where HR_ID=@ReqID AND status='Unhandled' AND Handled_By=@ManID)) 
 BEGIN
 update Host_request 
 set status='Rejected'
 where HR_ID=@ReqID
 END
 GO
 
 select * from allMatches

 exec addHostRequest 'FC Barcelona','Camp Nou','2023-01-01 05:00:00.000'
 exec addRepresentative 'ali','Arsenal FC','ali1','111'
 select * from allMatches
 select * from Match

 GO
 create proc AccReq
 @ReqID int,
 @ManID int
 AS
 declare @startCurr datetime, @StadID int,@MatchID int,@HostName varchar(20),@Guest varchar(20),@CurrMan int
 select @startCurr = m.Start_time,@MatchID=hr.Match_ID
 from Host_request hr INNER JOIN Match m ON hr.Match_ID=m.Match_ID WHERE hr.HR_ID=@ReqID
 select @StadID = s.Stad_ID,@CurrMan=hr.Handled_By
 from Host_request hr INNER JOIN Stadium s ON hr.Handled_By=s.Managed_By WHERE hr.HR_ID=@ReqID
 select @HostName=c1.Name,@Guest=c2.Name
 from Match m INNER JOIN club c1 ON m.host=c1.C_ID
 INNER JOIN club c2 ON m.guest=c2.C_ID
where m.Match_ID=@MatchID



 if(EXISTS (select * from Match m where m.Start_time=@startCurr AND m.stadium=@StadID) OR EXISTS(select * from Host_request where HR_ID=@ReqID AND status<>'Unhandled') OR @MatchID is NULL OR @ManID!=@CurrMan)
 print('Cannot Accept Request, Since A match will be played at that stadium at the exact same time')
else
BEGIN
update Host_request
set status='Accepted'
where HR_ID=@ReqID
update match 
set stadium=@StadID
where Match_ID=@MatchID
declare @Cnt int =0;
declare @StadCap int = (select capacity from Stadium where Stad_ID=@StadID)

while @Cnt < @StadCap
BEGIN 
exec addTicket @HostName,@Guest,@startCurr
set @Cnt=@Cnt+1
END
END


 GO

 select * from allMatches
 select * from allRequests
 exec addHostRequest 'Arsenal FC','Camp Nou','2023-05-26 16:38:00.000'
 

 select * from allRequests
 select * from Host_request



GO
create proc acceptRequest
@SM_Username varchar(20),
@ClubHostName varchar(20),
@GuestName varchar(20),
@Start datetime
AS
declare @CR_ID int
declare @GID int
declare @MatchId int
declare @SM_ID int
declare @Stad_ID int

select @SM_ID=SM_ID
from Stadium_Manager where username=@SM_Username

select @Stad_ID=s.Stad_ID
from Stadium s INNER JOIN Stadium_Manager sm ON s.Managed_By=sm.SM_ID 
where sm.SM_ID=@SM_ID


declare @CH_ID int
select @GID=C_ID
from Club where Name=@GuestName
select @CH_ID=C_ID,@CR_ID=representative
from Club where name=@ClubHostName
select @MatchId=Match_ID
from Match where @Start=Start_time AND host=@CH_ID AND guest=@GID

if(EXISTS (select * from Match where stadium=@Stad_ID AND Start_time=@Start))
print('Cannot Accept Request, Since A match will be played at that stadium at the exact same time')
else
BEGIN
update Host_request
set status='Accepted'
where Match_ID=@MatchId AND Handled_By=@SM_ID AND Asked_By = @CR_ID
update match 
set stadium=@Stad_ID
where Match_ID=@MatchId

declare @Cnt int =0;
declare @StadCap int = (select capacity from Stadium where Stad_ID=@Stad_ID)

while @Cnt < @StadCap
BEGIN 
exec addTicket @ClubHostName,@GuestName,@Start
set @Cnt=@Cnt+1
END
END
GO


GO
create proc rejectRequest
@SM_Username varchar(20),
@ClubHostName varchar(20),
@GuestName varchar(20),
@Start datetime
AS
declare @CR_ID int
declare @GID int
declare @MatchId int
declare @SM_ID int
select @SM_ID=SM_ID
from Stadium_Manager where username=@SM_Username
declare @CH_ID int
select @GID=C_ID
from Club where Name=@GuestName
select @CH_ID=C_ID,@CR_ID=representative
from Club where name=@ClubHostName
select @MatchId=Match_ID
from Match where @Start=Start_time AND host=@CH_ID AND guest=@GID
update Host_request
set status='Rejected'
where Match_ID=@MatchId AND Handled_By=@SM_ID AND Asked_By = @CR_ID
GO


SELECT count(*) FROM USERS WHERE username='DJOKER' AND password=1234
select * from Users

GO
create proc addFan
@name varchar(20),
@username varchar(20),
@password varchar(20),
@NatID varchar(20),
@BOD datetime,
@address varchar(20),
@phone int
AS
if(NOT EXISTS(select * from Users where username=@username)AND NOT EXISTS(select * from fan where NationalID=@NatID))
BEGIN
insert into Users values (@username,@password)
insert into Fan values(@NatId,@phone,@name,@address,1,@BOD,@username)
END
else print('Username already exists/NationalID is incorrect')
GO

create function allUnassignedMatches
(@host varchar(20))
returns @T Table (Guest varchar(20),Start datetime) 
AS
begin
declare @HostID int
select @HostID=C_ID from club where @host=Name
insert into @T 
select c2.Name,m.Start_time
from match m INNER JOIN club c2 ON m.guest=c2.C_ID
where m.host=@HostID AND stadium is null --AND m.Start_time>CURRENT_TIMESTAMP
return
END
GO

select * from viewAvailableStadiumsOn(@date)

select * from allClubRepresentatives

GO
create function upcomingMatchesOfClub2
(@CRID int)
returns @T Table (Host varchar(20),Guest varchar(20),Start_Time datetime,End_Time datetime,Stadium varchar(20))
AS
BEGIN
declare @ClubID int
select @ClubID=C_ID from Club where representative=@CRID
insert into @T
select c1.Name AS Host,c2.Name AS Guest,m.Start_time,m.End_time,s.name
from Match m INNER JOIN Club c1 ON m.host=c1.C_ID
INNER JOIN Club c2 ON m.guest=c2.C_ID Left OUTER JOIN Stadium s ON m.stadium=s.Stad_ID
where (m.guest=@ClubID OR m.host=@ClubID ) AND m.Start_time>CUrrent_timestamp
return
end
GO
GO


GO
create function upcomingMatchesOfClub
(@clubName varchar(20))
returns @T Table (Host varchar(20),Guest varchar(20),Start datetime,Stadium varchar(20)) 
AS
begin
declare @ClubID int
select @ClubID=C_ID from Club where Name=@clubName
insert into @T
select c1.Name AS Host,c2.Name AS Guest,m.Start_time,s.name
from Match m INNER JOIN Club c1 ON m.host=c1.C_ID
INNER JOIN Club c2 ON m.guest=c2.C_ID Left OUTER JOIN Stadium s ON m.stadium=s.Stad_ID
where (m.guest=@ClubID OR m.host=@ClubID ) AND m.Start_time>CUrrent_timestamp
return
end
GO

select * from allFans
select * from allMatches
select * from allTickets
exec addNewMatch 'Real Madrid','FC Barcelona','2023-01-02 05:00:00','2023-01-02 07:00:00'
select * from availableMatchesToAttend('2023-01-02 05:00:00.000')
exec addTicket 'Real Madrid','FC Barcelona','2023-01-02 05:00:00.000'
exec blockFan '232313131'
select * from ticket_buying_transaction


Go
create function availableMatchesToAttend
(@date datetime)
returns @T Table (Host varchar(20),Guest varchar(20),Start datetime,Stadium varchar(20))
as 
BEGIN
insert into @T
select c1.Name,c2.Name,m.Start_time,s.name
from  Match m 
INNER JOIN Club c1 ON c1.C_ID=m.host INNER JOIN Club c2 ON c2.C_ID = m.guest
INNER JOIN Stadium s ON s.Stad_ID=m.stadium
where m.Start_time>=@date AND EXISTS
(select * from Ticket t INNER JOIN Match m2 ON t.Match_ID=m2.Match_ID
where t.Status=1 AND m2.Match_ID=m.Match_ID)
return
END
GO
insert into Users values('admin','admin')
insert into System_Admin values('SYS_ADMIN','admin')

GO
create proc purchaseTicket
@NatID varchar(20),
@HostName varchar(20),
@GuestName varchar(20),
@Start datetime
AS
declare @MatchID int
declare @HostID int
declare @GuestID int
declare @TicketID int
select @HostID=C_ID
from club where name=@HostName
select @GuestID=C_ID
from club where name=@GuestName
select @MatchID=Match_ID
from Match where host=@HostID AND guest=@GuestID AND Start_time=@Start AND @Start>CURRENT_TIMESTAMP
select @TicketID=Ticket_ID
from Ticket where Status=1 AND Match_ID=@MatchID

if(NOT EXISTS (select * from Fan where NationalID=@NatID AND Status=0))
BEGIN
update Ticket
set Status=0
where Ticket_ID=@TicketID
insert into ticket_buying_transaction values(@TicketID,@NatID)
END
else
print ('Cannot Purchase, Fan is Blocked')
GO

exec addTicket 'Real Madrid','FC Barcelona',''



GO
create proc purchaseTicket2
@NatID varchar(20),
@Match_ID int 
AS
declare @TicketID int
select @TicketID=Ticket_ID
from Ticket where Status=1 AND Match_ID=@Match_ID
if(NOT EXISTS (select * from Fan where NationalID=@NatID AND Status=0) AND @TicketID is not NULL)
BEGIN
update Ticket
set Status=0
where Ticket_ID=@TicketID
insert into ticket_buying_transaction values(@TicketID,@NatID)
END
else
print ('Cannot Purchase, Fan is Blocked')
GO








create proc updateMatchHost
@host varchar(20),
@Guest varchar(20),
@Date datetime 
AS
declare @HostID int
declare @GuestID int
declare @MatchID int
select @HostID=C_ID from club where name=@host
select @GuestID=C_ID from club where name=@Guest
select @MatchID=Match_ID from Match where host=@HostID AND guest=@GuestID AND Start_time=@Date

update Match
set guest=@HostID,host=@GuestID,stadium = null
where host=@HostID AND guest=@GuestID AND Start_time=@Date

delete from Ticket where Match_ID=@MatchID


GO
create view matchesPerTeam
AS
select c.Name AS Club,count(*) AS Matches_Played
from Match m inner join club c on m.host=c.C_ID OR m.guest=c.C_ID
where m.End_time<CURRENT_TIMESTAMP
group by c.Name



GO
create view tmp 
AS
select c1.C_ID AS one,c2.C_ID AS two
from club c1 INNER JOIN club c2 ON c1.C_ID>c2.C_ID
EXCEPT
(select distinct m.host,m.guest
from match m where m.host is not null AND m.guest is not null  
UNION
select distinct m2.guest,m2.host
from match m2  where m2.host is not null and m2.guest is not null)
GO

GO
create view clubsNeverMatched
AS
select c1.Name AS Team_1,c2.Name AS Team_2 
from tmp INNER JOIN club c1 on c1.C_ID=tmp.one INNER JOIN club c2 on c2.C_ID=tmp.two
GO

CREATE LOGIN NewAdminName WITH PASSWORD = 'ABCD'
GO

create user main for login NewAdminName

GO
create function clubsNeverPlayed
(@ClubName varchar(20))
returns @T Table (Club varchar(20))
AS
BEGIN
declare @y table(Team_1 varchar(20),Team_2 varchar(20))
insert into @y select * from clubsNeverMatched
update @y
set Team_2=Team_1,Team_1=@ClubName
where @ClubName=Team_2
insert into @T 
select team_2 from @y where Team_1=@ClubName
return
END
GO

GO
create function matchWithHighestAttendance()
returns @T TABLE(Host varchar(20),Guest varchar(20))
AS
BEGIN
declare @matchID int
 select top 1 @matchID=t.Match_ID
from  Ticket t 
 where t.Status=0
group by t.Match_ID
order by count(t.Ticket_ID) desc
insert into @T
select c1.Name,c2.Name
from  Match m2 
INNER JOIN club c1 ON c1.C_ID=m2.host INNER JOIN Club c2 ON c2.C_ID=m2.guest
where m2.Match_ID=@matchID
return 
END
GO



 
 GO
create function matchesRankedByAttendance()
returns  TABLE
AS

return select  c1.Name As Host ,c2.Name As Guest
from  Ticket t INNER JOIN Match m ON t.Match_ID=m.Match_ID
 iNNER JOIN club c1 on c1.C_ID=m.host INNER JOIN club c2 ON c2.C_ID=m.guest
 where t.Status=0
group by c1.Name,c2.Name 
order by count(t.Ticket_ID) desc offset 0 rows


GO


create function requestsFromClub
(@StadName varchar(20),@ClubName varchar(20))
returns @T Table(Host varchar(20),Guest varchar(20))
AS
BEGIN
declare @SM_ID int,@ClubRep int,@HostID int,@MatchID int
select @SM_ID=Managed_By from Stadium where @StadName=name
select @ClubRep = representative,@HostID=C_ID from club where Name=@ClubName

insert into @T
select c1.Name AS Host,c.Name As Guest
from Host_request hr INNER JOIN Match m ON hr.Match_ID=m.Match_ID INNER JOIN 
Club c ON c.C_ID = m.guest INNER JOIN club c1 on c1.C_ID= m.host 
where hr.Handled_By=@SM_ID AND m.host=@HostID

return
END
GO

