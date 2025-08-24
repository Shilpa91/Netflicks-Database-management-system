--------------------------- For fresh DB creation, drop any existing DB ---------------------------

USE AdventureWorks2008R2; -- Set a different context to be able to drop netflicks database
DROP DATABASE netflicks;

--------------------------- DB creation below ---------------------------

CREATE DATABASE netflicks; -- to be run separately

USE netflicks;

--------------------------- ER creation below ---------------------------

CREATE TABLE PaymentType (
PaymentTypeID INT IDENTITY(1,1) PRIMARY KEY,
PaymentType varchar(255) UNIQUE NOT NULL
)

CREATE TABLE SubscriptionType (
SubscriptionTypeID INT IDENTITY(1,1) PRIMARY KEY,
SubscriptionType varchar(255) UNIQUE NOT NULL
)

CREATE TABLE Country (
CountryID INT IDENTITY(1,1) PRIMARY KEY,
CountryName varchar(255) UNIQUE NOT NULL
)

CREATE TABLE [Language] (
LanguageID INT IDENTITY(1,1) PRIMARY KEY,
LanguageName varchar(255) UNIQUE NOT NULL
)

CREATE TABLE [Role] (
RoleID INT IDENTITY(1,1) PRIMARY KEY,
RoleName varchar(255) UNIQUE NOT NULL
)

CREATE TABLE Genre (
GenreID INT IDENTITY(1,1) PRIMARY KEY,
GenreName varchar(255) UNIQUE NOT NULL
)

CREATE TABLE [User] (
UserID INT IDENTITY(1,1) PRIMARY KEY,
Email varchar(255) UNIQUE NOT NULL,
FirstName varchar(255) NOT NULL,
MiddleName varchar(255),
LastName varchar(255) NOT NULL,
Gender varchar(255),
CountryID INT FOREIGN KEY REFERENCES Country(CountryID),
CONSTRAINT UC_User UNIQUE (FirstName, LastName, Gender, CountryID)
)

CREATE TABLE Subscription (
SubscriptionID INT IDENTITY(1,1) PRIMARY KEY,
SubscriptionTypeID INT FOREIGN KEY REFERENCES SubscriptionType(SubscriptionTypeID),
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
PaymentTypeID INT FOREIGN KEY REFERENCES PaymentType(PaymentTypeID),
CONSTRAINT UC_Subscription UNIQUE (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID)
)

CREATE TABLE UserSubscription (
UserID INT FOREIGN KEY REFERENCES [User](UserID),
SubscriptionID INT FOREIGN KEY REFERENCES Subscription(SubscriptionID),
PRIMARY KEY (UserID, SubscriptionID)
)

CREATE TABLE Artist (
ArtistID INT IDENTITY(1,1) PRIMARY KEY,
FirstName varchar(255) NOT NULL,
MiddleName varchar(255),
LastName varchar(255) NOT NULL,
DOB DATE NOT NULL,
Gender varchar(255) NOT NULL,
CountryID INT FOREIGN KEY REFERENCES Country(CountryID),
CONSTRAINT UC_Artist UNIQUE (FirstName, LastName, DOB, Gender, CountryID)
)

CREATE TABLE Content (
ContentID INT IDENTITY(1,1) PRIMARY KEY,
ContentType varchar(255) NOT NULL,
LanguageID INT FOREIGN KEY REFERENCES Language(LanguageID),
Rating FLOAT NOT NULL,
GenreID INT FOREIGN KEY REFERENCES Genre(GenreID),
CountryID INT FOREIGN KEY REFERENCES Country(CountryID),
CONSTRAINT UC_Content UNIQUE (ContentID, ContentType, LanguageID, Rating, GenreID, CountryID)
)

CREATE TABLE TVShows (
TVShowID INT IDENTITY(1,1) PRIMARY KEY,
Title varchar(255) NOT NULL,
Season varchar(255) NOT NULL,
Episode varchar(255) NOT NULL,
ContentID INT FOREIGN KEY REFERENCES Content(ContentID),
CONSTRAINT UC_TVShows UNIQUE (Title, Season, Episode, ContentID)
)

CREATE TABLE Movies (
MovieID INT IDENTITY(1,1) PRIMARY KEY,
[Name] varchar(255) NOT NULL,
DurationMinutes INT NOT NULL,
ReleaseDate DATE NOT NULL,
ContentID INT FOREIGN KEY REFERENCES Content(ContentID),
CONSTRAINT UC_Movies UNIQUE ([Name], DurationMinutes, ReleaseDate, ContentID)
)

CREATE TABLE UserContentViews (
UserID INT FOREIGN KEY REFERENCES [User](UserID),
ContentID INT FOREIGN KEY REFERENCES Content(ContentID),
Times INT NOT NULL,
PRIMARY KEY (UserID, ContentID)
)

CREATE TABLE RolePlayedContent (
ArtistID INT FOREIGN KEY REFERENCES Artist(ArtistID),
RoleID INT FOREIGN KEY REFERENCES Role(RoleID),
ContentID INT FOREIGN KEY REFERENCES Content(ContentID),
PRIMARY KEY (ArtistID, RoleID, ContentID)
)

--------------------------- Data entry part below ---------------------------

USE netflicks;

-- Independent entities: PaymentType, SubscriptionType, Country, Genre, Language, Role

-- Data entry for: PaymentType
INSERT INTO PaymentType (PaymentType) VALUES ('CREDIT');
INSERT INTO PaymentType (PaymentType) VALUES ('DEBIT');
INSERT INTO PaymentType (PaymentType) VALUES ('PAYPAL');

-- Data entry for: SubscriptionType
INSERT INTO SubscriptionType (SubscriptionType) VALUES ('TRIAL');
INSERT INTO SubscriptionType (SubscriptionType) VALUES ('MONTHLY');
INSERT INTO SubscriptionType (SubscriptionType) VALUES ('ANNUAL');

-- Data entry for: Country
INSERT INTO Country (CountryName) VALUES ('CHINA');
INSERT INTO Country (CountryName) VALUES ('INDIA');
INSERT INTO Country (CountryName) VALUES ('SOUTH KOREA');
INSERT INTO Country (CountryName) VALUES ('UNITED KINGDOM');
INSERT INTO Country (CountryName) VALUES ('UNITED STATES OF AMERICA');

-- Data entry for: Genre
INSERT INTO Genre (GenreName) VALUES ('ACTION');
INSERT INTO Genre (GenreName) VALUES ('ADVENTURE');
INSERT INTO Genre (GenreName) VALUES ('COMEDY');
INSERT INTO Genre (GenreName) VALUES ('CRIME');
INSERT INTO Genre (GenreName) VALUES ('DRAMA');
INSERT INTO Genre (GenreName) VALUES ('FANTASY');
INSERT INTO Genre (GenreName) VALUES ('HISTORICAL');
INSERT INTO Genre (GenreName) VALUES ('HORROR');
INSERT INTO Genre (GenreName) VALUES ('MYSTERY');
INSERT INTO Genre (GenreName) VALUES ('ROMANCE');
INSERT INTO Genre (GenreName) VALUES ('SCIENCE FICTION');

-- Data entry for: Language
INSERT INTO Language (LanguageName) VALUES ('ENGLISH');
INSERT INTO Language (LanguageName) VALUES ('HINDI');
INSERT INTO Language (LanguageName) VALUES ('GUJRATI');
INSERT INTO Language (LanguageName) VALUES ('KOREAN');
INSERT INTO Language (LanguageName) VALUES ('MANDARIN');
INSERT INTO Language (LanguageName) VALUES ('MALAYALAM');
INSERT INTO Language (LanguageName) VALUES ('PUNJABI');
INSERT INTO Language (LanguageName) VALUES ('SPANISH');
INSERT INTO Language (LanguageName) VALUES ('TAMIL');
INSERT INTO Language (LanguageName) VALUES ('TELUGU');

-- Data entry for: Role
INSERT INTO Role (RoleName) VALUES ('CAMEO');
INSERT INTO Role (RoleName) VALUES ('CINEMATOGRAPHER');
INSERT INTO Role (RoleName) VALUES ('COMEDIAN');
INSERT INTO Role (RoleName) VALUES ('COSTUME DESIGNER');
INSERT INTO Role (RoleName) VALUES ('DIRECTOR');
INSERT INTO Role (RoleName) VALUES ('LEAD');
INSERT INTO Role (RoleName) VALUES ('MUSIC DIRECTOR');
INSERT INTO Role (RoleName) VALUES ('PRODUCER');
INSERT INTO Role (RoleName) VALUES ('SUPPORTING');
INSERT INTO Role (RoleName) VALUES ('VILLIAN');

-- Dependent entities: User, Subscription, Content, TVShows, Movies, Artist

-- Data entry for: User
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('ken0@adventure-works.com', 'Ken', 'J', 'Sanchez', 'M', 1);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('terri0@adventure-works.com', 'Terri', 'Lee', 'Duffy', 'F', 5);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('roberto0@adventure-works.com', 'Roberto', NULL, 'Tamburello', 'M', 4);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('rob0@adventure-works.com', 'Rob', NULL, 'Walters', 'M', 5);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('gail0@adventure-works.com', 'Gail', 'A', 'Erikson', 'F', 4);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('jossef0@adventure-works.com', 'Jossef', 'H', 'Goldberg', 'M', 3);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('Shilpa0@adventure-works.com', 'Shilpa', NULL, 'Poolla', 'F', 2);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('dylan0@adventure-works.com', 'Dylan', 'A', 'Miller', 'M', 3);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('diane1@adventure-works.com', 'Diana', 'L', 'Margheim', 'F', 5);
INSERT INTO [User] (Email, FirstName, MiddleName, LastName, Gender, CountryID) VALUES ('gigi0@adventure-works.com', 'Gigi', 'N', 'Mathew', 'M', 2);

-- Data entry for: Subscription
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (2, '2018-01-25', '2018-02-24', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2018-02-05', '2019-02-04', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2018-06-23', '2019-06-22', 1);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (2, '2017-04-05', '2017-05-04', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2019-03-15', '2020-03-14', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2016-01-20', '2016-01-19', 1);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (1, '2018-04-25', '2018-05-01', 2);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2018-08-20', '2019-08-19', 1);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (2, '2017-01-05', '2017-02-04', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2018-11-15', '2019-11-14', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (2, '2019-11-15', '2019-12-14', 3);

-- Updating Subscription to set end date since the corresponding User (userID = 1) upgraded to an annual plan thereafter
UPDATE Subscription SET EndDate = '2018-02-04' WHERE SubscriptionID = 1;

-- Data entry for: Artist
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Kim', 'Soo', 'Hyun', 'M', '1988-02-16', 3);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Jun', 'Ji', 'Hyun', 'F', '1981-10-30', 3);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Park', 'Hae', 'Jin', 'M', '1983-05-01', 3);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Jonathan', NULL, 'Groff', 'M', '1985-03-26', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Holt', NULL, 'McCallany', 'M', '1963-09-03', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Jennifer', 'Jason', 'Leigh', 'F', '1962-05-02', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Keir', NULL, 'Gilchrist', 'M', '1992-09-28', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Michael', NULL, 'Rapaport', 'M', '1970-03-20', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Andy', NULL, 'Whitfield', 'M', '1971-10-17', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Liam', NULL, 'Mclntyre', 'M', '1982-02-08', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Dustin', NULL, 'Clara', 'M', '1981-01-02', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Gagan', NULL, 'Malik', 'M', '1988-03-20', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Neha', NULL, 'Sargam', 'F', '1988-03-04', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Dhruv', NULL, 'Sehgal', 'M', '1991-02-15', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Mithila', NULL, 'Palkar', 'F', '1993-01-12', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Shahid', NULL, 'Kapoor', 'M', '1981-02-25', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Kiara', NULL, 'Advani', 'F', '1992-07-31', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Deepika', NULL, 'Padukone', 'F', '1986-07-05', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Ranbir', NULL, 'Kapoor', 'M', '1982-09-28', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Piyush', NULL, 'Mishra', 'M', '1963-01-13', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Ava', NULL, 'Michelle', 'F', '2002-04-10', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Griffin', NULL, 'Gluck', 'M', '2000-07-24', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Sabrina', NULL, 'Carpenter', 'F', '1999-05-11', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Christian', NULL, 'Bale', 'M', '1974-01-30', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Kate', NULL, 'Blanchett', 'F', '1969-10-14', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Benedict', NULL, 'Cumberbatch', 'M', '1976-07-19', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Gal', NULL, 'Gadot', 'F', '1985-04-30', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Chris', NULL, 'Pine', 'M', '1980-07-26', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Patty', NULL, 'Jenkins', 'F', '1971-07-24', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Vin', NULL, 'Diesel', 'M', '1987-07-19', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Rose', NULL, 'Leslie', 'F', '1987-02-09', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Breck', NULL, 'Eisner', 'M', '1970-12-24', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Angelina', NULL, 'Jolie', 'F', '1975-06-04', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('James', NULL, 'McAvoy', 'M', '1979-04-21', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Timur', NULL, 'Bekmambetov', 'M', '1961-06-25', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Jaeden', NULL, 'Leiberher', 'M', '2003-01-04', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Jeremy', 'Ray', 'Taylor', 'M', '2003-06-02', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Sophia', NULL, 'Lillis', 'F', '2002-02-13', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Andres', NULL, 'Muschietti', 'M', '1973-08-26', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Samantha', 'Ruth', 'Prabhu', 'F', '1987-04-29', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Rajendra', NULL, 'Prasad', 'M', '1956-07-19', 2);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Emma', NULL, 'Watson', 'F', '1990-04-15', 4);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Dan', NULL, 'Stevens', 'M', '1982-10-10', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Bill', NULL, 'Condon', 'M', '1955-10-22', 5);
INSERT INTO Artist (FirstName, MiddleName, LastName, Gender, DOB, CountryID) VALUES ('Wu', NULL, 'Jing', 'M', '1974-04-03', 1); -- Lead and director of Wolf Warrior 2

-- Add remaining artists below

-- Data entry for: Content
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 2, 5, 2, 9.1); -- Ramayan
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 5, 1, 1, 8.5); -- Spartacus
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 5, 3, 1, 8.3); -- Atypical 
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 4, 4, 1, 8.6); -- Mindhunter
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 3, 10, 4, 8.3); -- My love from the stars
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('TVShow', 2, 10, 1, 8.3); -- Little things
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 2, 10, 2, 7.2); -- Kabir Singh
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 2, 10, 2, 7.2); -- Tamasha
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 3, 1, 5.3); -- Tall Girl
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 4, 1, 1, 6.5); -- Mowgli
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 11, 1, 7.4); -- Wonder Woman
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 11, 1, 6.0); -- The last witch hunter
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 1, 1, 6.7); -- Wanted
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 8, 1, 7.3); -- IT
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 2, 3, 10, 7.5); -- Oh Baby
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 5, 10, 1, 7.2); -- Beauty and the beast
INSERT INTO Content (ContentType, CountryID, GenreID, LanguageID, Rating) VALUES ('Movie', 1, 1, 5, 6.0); -- Wolf warrior 2

-- Data entry for: TVShows
-- Ramayan
DECLARE @Counter INT = 1;
WHILE @Counter <= 56
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Ramayan', 1, @Counter, 1);
		SET @Counter += 1;
	END

-- Spartacus
SET @Counter = 1;
WHILE @Counter <= 6
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Spartacus', 1, @Counter, 2);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 10
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Spartacus', 2, @Counter, 2);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 10
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Spartacus', 3, @Counter, 2);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 13
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Spartacus', 4, @Counter, 2);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 8
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Atypical', 1, @Counter, 3);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 10
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Atypical', 2, @Counter, 3);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 10
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Atypical', 3, @Counter, 3);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 10
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Mindhunter', 1, @Counter, 4);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 9
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Mindhunter', 2, @Counter, 4);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 21
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('My love from the stars', 1, @Counter, 5);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 5
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Little Things', 1, @Counter, 6);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 8
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Little Things', 2, @Counter, 6);
		SET @Counter += 1;
	END

SET @Counter = 1;
WHILE @Counter <= 8
	BEGIN
		INSERT INTO TVShows (Title, Season, Episode, ContentID) VALUES ('Little Things', 3, @Counter, 6);
		SET @Counter += 1;
	END

-- Data entry for: Movies
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Kabir Singh', '2019-06-21', 171, 7);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Tamasha', '2015-07-27', 132, 8);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Tall Girl', '2019-09-13', 162, 9);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Mowgli', '2018-11-25', 164, 10);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Wonder Woman', '2017-05-15', 181, 11);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('The last witch hunter', '2015-10-13', 106, 12);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Wanted', '2008-06-12', 109, 13);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('IT', '2017-09-05', 174, 14);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Oh Baby', '2019-07-05', 197, 15);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Beauty and the beast', '2017-02-23', 133, 16);
INSERT INTO Movies ([Name], ReleaseDate, DurationMinutes, ContentID) VALUES ('Wolf Warrior 2', '2017-07-27', 126, 17);

-- Associative entities: UserSubscription, UserContentViews, RolePayedContent

-- Data entry for: UserSubscription
-- User can have only one active subscription but more than one subscription in total since subscription table contains past subscriptions too
-- Therefore, UserID one had a one month subscription (SubscriptionID 1) which was terminated on 2018-02-04 when he chose an annual subscription plan (SubscriptionID 2)
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (1,1);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (1,2);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (2,5);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (3,6);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (4,9);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (5,3);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (6,4);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (7,10);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (8,8);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (9,7);
INSERT INTO UserSubscription (UserID, SubscriptionID) VALUES (10,11);

-- Data entry for: UserContentViews
-- Chinese users: 1
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (1, 17, 10);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (1, 5, 4);
-- Indian users: 7, 10
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (7, 8, 1);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (10, 15, 3);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (7, 15, 9);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (10, 1, 7);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (7, 6, 9);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (10, 6, 12);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (7, 2, 4);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (10, 17, 2);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (7, 10, 3);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (10, 11, 2);
-- Korean users: 3, 5
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (3, 5, 6);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (5, 5, 3);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (3, 17, 1);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (5, 17, 5);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (3, 7, 2);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (5, 7, 2);
-- UK and USA users: 2, 4, 6, 8, 9 (English content: 2,3,4,9-14,16)
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (2, 2, 6);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (4, 3, 3);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (6, 4, 1);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (8, 9, 5);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (9, 10, 1);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (2, 11, 2);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (4, 12, 6);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (6, 13, 4);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (8, 14, 8);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (9, 16, 12);
INSERT INTO UserContentViews (UserID, ContentID, Times) VALUES (4, 17, 2);

-- Data entry for: RolePlayedContent
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (1, 12, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (1, 13, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (2, 9, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (2, 10, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (2, 11, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (3, 6, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (3, 7, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (3, 8, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (4, 4, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (4, 5, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (5, 1, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (5, 2, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (5, 3, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (6, 14, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (6, 15, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (7, 16, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (7, 17, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (8, 18, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (8, 19, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (8, 20, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (9, 21, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (9, 22, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (9, 23, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (10, 24, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (10, 25, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (10, 26, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (11, 27, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (11, 28, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (11, 29, 5);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (12, 30, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (12, 31, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (12, 32, 5);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (13, 33, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (13, 34, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (13, 35, 5);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (14, 36, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (14, 37, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (14, 38, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (14, 39, 5);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (15, 40, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (15, 41, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (16, 42, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (16, 43, 6);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (16, 44, 5);
INSERT INTO RolePlayedContent (ContentID, ArtistID, RoleID) VALUES (17, 45, 6); 

--------------------------- Table-level check constraint below ---------------------------

CREATE FUNCTION SubscriptionCheck()  
RETURNS date  
AS   
BEGIN  
   DECLARE @retval date  
   SELECT @retval = StartDate FROM Subscription 
   RETURN @retval
END;  
GO  
ALTER TABLE Subscription WITH NOCHECK 
ADD CONSTRAINT chkdate CHECK (dbo.SubscriptionCheck() < EndDate AND dbo.SubscriptionCheck() <= getdate());  
GO  

----------- Run below code only to check if constraint chkdate already implemented in the table -----------

-- The below insert statements should fail since the end date is before the start date in the first case and the start date is greater than the current date in the second case
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2017-12-12', '2016-02-04', 3);
INSERT INTO Subscription (SubscriptionTypeID, StartDate, EndDate, PaymentTypeID) VALUES (3, '2020-12-12', '2021-02-04', 3);

--------------------------- Encryption constraint below ---------------------------

CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = 'netflicks';  

CREATE CERTIFICATE PaymentType1  
   WITH SUBJECT = 'User Payment Type';  
GO  

CREATE SYMMETRIC KEY Payment  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE PaymentType1;  
GO  

 use netflicks;

-- Create a column in which to store the encrypted data.  
ALTER TABLE dbo.PaymentType  
    ADD EncryptedPaymentType varbinary(128) ;   
GO  

----------- Run below code only to check if encryption constraint already implemented in the table -----------

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY Payment  
   DECRYPTION BY CERTIFICATE PaymentType1;  

-- Encrypt the value in column PaymentType with symmetric   
-- key Payment. Save the result in column EncryptedPaymentType.  
UPDATE dbo.PaymentType  
SET EncryptedPaymentType = EncryptByKey(Key_GUID('Payment'), PaymentType);  
GO  

-- Verify the encryption.  
-- First, open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY Payment  
   DECRYPTION BY CERTIFICATE PaymentType1;  
GO  

-- Now list the original ID, the encrypted ID, and the   
-- decrypted ciphertext. If the decryption worked, the original  
-- and the decrypted ID will match.  
SELECT PaymentType, EncryptedPaymentType   
    AS 'Encrypted Payment Type',  
    CONVERT(varchar, DecryptByKey(EncryptedPaymentType))   
    AS 'Decrypted Payment Type'  
    FROM dbo.PaymentType;  
GO  

--------------------------- View 1 (UserCountryView) ---------------------------

CREATE VIEW UserCountryView 
AS 
SELECT [User].FirstName, [User].LastName, [User].Email, Country.CountryName FROM [User]
INNER JOIN Country ON [User].CountryID = Country.CountryID;

SELECT * FROM UserCountryView;

--------------------------- View 2 (ArtistCountryView) ---------------------------

CREATE VIEW ArtistCountryView 
AS 
SELECT Artist.FirstName, Artist.LastName, Artist.DOB, Artist.Gender, Country.CountryName FROM Artist
INNER JOIN Country ON Artist.CountryID = Country.CountryID;

SELECT * FROM ArtistCountryView;

--------------------------- View 3 (MovieContentView) ---------------------------

CREATE VIEW MovieContentView 
AS 
SELECT Movies.[Name] AS [Name], Movies.ContentID, ContentType, LanguageID, Rating, GenreID, CountryID FROM Content
INNER JOIN Movies ON Content.ContentID = Movies.ContentID;

SELECT * FROM MovieContentView;

--------------------------- View 4 (TvContentView) ---------------------------

CREATE VIEW TvContentView
AS
SELECT CONCAT(TvShows.Title, ', Season ', TvShows.Season, ', Episode ', TvShows.Episode) AS [Name], TvShows.ContentID, ContentType, LanguageID, Rating, GenreID, CountryID FROM Content
INNER JOIN TvShows ON Content.ContentID = TvShows.ContentID;

SELECT * FROM TvContentView;

--------------------------- View 5 (ContentsPartialView) ---------------------------

CREATE VIEW ContentsPartialView
AS
SELECT * FROM MovieContentView
UNION ALL
SELECT * FROM TvContentView

SELECT * FROM ContentsPartialView;

--------------------------- Persistent Table (ContentsTable) --------------------------

CREATE TABLE ContentsTable (
[Name] varchar(255),
ContentID INT,
ContentType varchar(255) NOT NULL,
LanguageID INT,
Rating FLOAT NOT NULL,
GenreID INT,
CountryID INT,
);

INSERT INTO ContentsTable SELECT * FROM ContentsPartialView;

--------------------------- View 6 (ContentsView) ---------------------------

CREATE VIEW ContentsView
AS
SELECT [Name], ContentID, ContentType, [Language].LanguageName AS [Language], Rating, Genre.GenreName AS Genre, Country.CountryName AS Country FROM ContentsTable
INNER JOIN [Language] ON ContentsTable.LanguageID = [Language].LanguageID
INNER JOIN Genre ON ContentsTable.GenreID = Genre.GenreID
INNER JOIN Country ON ContentsTable.CountryID = Country.CountryID

SELECT * FROM ContentsView;

--------------------------- View 7 (RolePlayedContentView) ---------------------------

CREATE VIEW RolePlayedContentView
AS
SELECT [Name] AS ContentName, RolePlayedContent.ContentID, ContentType, [Language], Rating, Genre, ContentsView.Country AS ContentCountry, CONCAT(FirstName, MiddleName, LastName) AS ArtistName, DOB, Gender, CountryName AS ArtistCountry, RoleName
FROM RolePlayedContent
INNER JOIN ContentsView ON RolePlayedContent.ContentID = ContentsView.ContentID
INNER JOIN Artist ON RolePlayedContent.ArtistID = Artist.ArtistID
INNER JOIN Country ON Artist.CountryID = Country.CountryID
INNER JOIN [Role] ON RolePlayedContent.RoleID = [Role].RoleID

SELECT * FROM RolePlayedContentView;

--------------------------- View 8 (UserContentSummaryView) ---------------------------

CREATE VIEW UserContentSummaryView
AS
SELECT CONCAT(FirstName, LastName) AS UserName, [User].Email AS UserEmail, CountryName AS UserCountry, [Name] AS ContentName, ContentsView.ContentID, ContentType, [Language], Genre, Rating, Country AS ContentCountry, Times AS ViewCount
FROM UserContentViews
INNER JOIN [User] ON UserContentViews.UserID = [User].UserID
INNER JOIN Country ON [User].CountryID = Country.CountryID
INNER JOIN ContentsView ON UserContentViews.ContentID = ContentsView.ContentID

SELECT * FROM UserContentSummaryView;

--------------------------- View 9 (MasterView) ---------------------------

CREATE VIEW MasterView
AS
SELECT UserName, UserEmail, UserCountry, ViewCount, RolePlayedContentView.ContentName, RolePlayedContentView.ContentType, RolePlayedContentView.[Language], RolePlayedContentView.Rating, RolePlayedContentView.Genre, RolePlayedContentView.ContentCountry, ArtistName, DOB, Gender, ArtistCountry, RoleName
FROM UserContentSummaryView
INNER JOIN RolePlayedContentView ON UserContentSummaryView.ContentID = RolePlayedContentView.ContentID

SELECT * FROM MasterView;