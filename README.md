# KumariCinema Hall - ASP.NET Web Application
## CC6012NI Data and Web Development - Milestone 2

---

## SETUP INSTRUCTIONS

### Step 1: Oracle Database Setup
1. Open Oracle SQL Developer (24.3.1)
2. Connect: User=Salina, Password=23047540, Host=localhost, Port=1521, SID=XEPDB1
3. Open and run: KumariCinema\SQL_Setup.sql  (Run entire script at once)
4. Verify tables are created and sample data inserted

### Step 2: Install Oracle NuGet Package (IMPORTANT - read carefully)
Open the solution in Visual Studio 2022, then go to:
  Tools > NuGet Package Manager > Package Manager Console

Run this EXACT command (NOT the Core version):
  Install-Package Oracle.ManagedDataAccess -Version 21.15.0

  *** DO NOT install Oracle.ManagedDataAccess.Core - that is for .NET Core only ***
  *** This project uses .NET Framework 4.8 which needs Oracle.ManagedDataAccess ***

### Step 3: Check Oracle Service Name
If connection fails, check your Oracle service name in SQL Developer connection:
  - If it says XE  --> change Web.config: Data Source=localhost:1521/XE
  - If it says XEPDB1 --> keep as is (default in Web.config)
  - Change it in BOTH Web.config AND App_Code\DBHelper.cs

### Step 4: Build and Run
1. Build solution: Ctrl+Shift+B
2. Run: F5
3. Login page will appear

### Step 5: Login
Use any user from the USERS table (inserted by SQL_Setup.sql):
  Username: Pratibha Gurung   Password: pass123
  Username: Ram Shrestha      Password: pass123

---

## TROUBLESHOOTING

Problem: "Could not install Oracle.ManagedDataAccess.Core"
Fix: You installed the wrong package. Run:
     Install-Package Oracle.ManagedDataAccess -Version 21.15.0

Problem: HTTP 500.19 - runAllManagedModulesForRequest
Fix: Already fixed in Web.config (removed that line)

Problem: ORA-12541 or connection refused
Fix: Make sure Oracle Database XE service is running.
     Open Windows Services > find OracleServiceXE > Start

Problem: ORA-01017 invalid username/password
Fix: Check Salina user exists in Oracle.
     In SQL Developer as SYSTEM: CREATE USER Salina IDENTIFIED BY 23047540;
     GRANT CONNECT, RESOURCE, DBA TO Salina;

---

## PROJECT STRUCTURE

KumariCinema/
+-- App_Code/
|   +-- DBHelper.cs              <- Oracle DB helper (connection + queries)
+-- Forms/
|   +-- Basic/
|   |   +-- UserForm.aspx(.cs)   <- User CRUD
|   |   +-- TheaterForm.aspx(.cs)<- Theater CRUD
|   |   +-- HallForm.aspx(.cs)   <- Hall CRUD
|   |   +-- MovieForm.aspx(.cs)  <- Movie CRUD
|   |   +-- ShowForm.aspx(.cs)   <- Show CRUD
|   |   +-- TicketForm.aspx(.cs) <- Ticket CRUD (with FK dropdowns)
|   +-- Complex/
|       +-- UserTicketForm.aspx(.cs)   <- User + 6-month ticket history
|       +-- TheaterMovieForm.aspx(.cs) <- Theater movies & showtimes
|       +-- OccupancyForm.aspx(.cs)    <- Top 3 occupancy by movie (paid only)
+-- Default.aspx(.cs)            <- Dashboard with counts + recent tickets
+-- Login.aspx(.cs)
+-- Logout.aspx(.cs)
+-- Site.master(.cs)             <- Master page (navbar + sidebar)
+-- Web.config                   <- Connection string config
+-- packages.config              <- NuGet packages list
+-- SQL_Setup.sql                <- Full Oracle DB setup script
+-- KumariCinema.csproj

---

## DATABASE TABLES (3NF)

USERS         - UserId, Username, UserEmail, Password, Address
MOVIE         - MovieId, MovieTitle, Duration, Language, Genre, ReleaseDate
THEATER       - TheaterId, TheaterName, TheaterCity, TheatreType
HALL          - HallId, HallCapacity, HallType, FloorNo, TotalSeats
SHOW_TABLE    - ShowId, ShowName, ShowDate, ShowType, ShowStatus
TICKET        - TicketId, TicketPrice, TicketDate, TicketStatus, PaymentStatus
(Junction tables: MOVIEUSER, THEATERMOVIEMAP, HALLTHEATER, SHOWHALL, TICKETSHOW)
