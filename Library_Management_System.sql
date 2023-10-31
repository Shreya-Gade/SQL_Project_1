/*===================================DATABASE====================================*/

CREATE DATABASE IF NOT EXISTS Library_Management_System;

USE Library_Management_System;
 
 /*=====================================TABLES======================================*/
 
CREATE TABLE Authors(
	AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

SELECT * FROM Authors;

CREATE TABLE Genres(
	GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(100) NOT NULL
);

SELECT * FROM Genres;

CREATE TABLE Books(
	BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT,
    GenreID INT,
    PublicationDate DATE,
    Location VARCHAR(50) NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

SELECT * FROM Books;

CREATE TABLE BookCopies(
	CopyID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    Status ENUM('Available','Checked Out','Lost','Damaged') NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

SELECT * FROM BookCopies;

CREATE TABLE Members(
	Member_ID INT AUTO_INCREMENT PRIMARY KEY,
    Member_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone_Number VARCHAR(15),
    Address VARCHAR(200)
);

SELECT * FROM Members;

CREATE TABLE Loans(
	Loan_ID INT AUTO_INCREMENT PRIMARY KEY,
    CopyID INT,
    Member_ID INT,
    Due_Date DATE,
    Loan_Date DATE,
    FOREIGN KEY (CopyID) REFERENCES BookCopies(CopyID),
	FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
);

SELECT * FROM Loans;

CREATE TABLE Staff(
	StaffID INT AUTO_INCREMENT PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL
);
 
 SELECT * FROM Staff;

/*==============================POPULATING TABLES===================================*/

INSERT INTO Authors (AuthorName) VALUES
('J.K, Rowling'),
('George Orwell'),
('Harper Lee'),
('Agatha Christie'),
('Stephen King'),
('Charles Dickens'),
('Mark Twain'),
('J.R.R. Tolkien'),
('Aldous Huxley'),
('F. Scott Fitzgerald');

SELECT * FROM Authors;

INSERT INTO Genres (GenreName) VALUES
('Fiction'),
('Mystery'),
('Science Fiction'),
('Fantasy'),
('Romance'),
('Fiction'),
('Mystery'),
('Science Fiction'),
('Fantasy'),
('Romance');

SELECT * FROM Genres;

INSERT INTO Books (Title, AuthorID, GenreID, PublicationDate, Location, ISBN) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 1, '1997-06-26',  'A101','978-043970818'),
('1984', 2, 3, '1949-06-08', 'B201', '978-045152493'),
('To Kill a Mockingbird', 3, 1, '1960-07-11', 'A102', '978-006112008'),
('Murder on the Orient Express', 4, 2, '1934-01-01', 'C301', '978-006269366'),
('The Shining', 5, 1, '1977-01-28', 'A103', '978-030774365'),
('Great Expectations', 6, 5, '1861-01-01', 'D401', '978-014143956'),
('The Adventures of Huckleberry Finn', 7, 2, '1884-12-10', 'B202', '978-014243717'),
('The Lord of the Rings', 8, 4, '1954-07-29', 'A104','978-061864015'),
('Brave New World', 9, 3, '1932-10-27', 'C302', '978-006085052'),
('The Great Gatsby', 10, 1, '1925-04-10', 'A105', '978-074327356');

SELECT * FROM Books;

INSERT INTO BookCopies(BookId, Status) VALUES
(1, 'Available'),
(1, 'Checked Out'),
(2, 'Available'),
(2, 'Available'),
(3, 'Available'),
(4, 'Available'),
(5, 'Checked Out'),
(6, 'Available'),
(6, 'Available'),
(7, 'Checked Out'),
(8, 'Available'),
(9, 'Available'),
(9, 'Checked Out'),
(10, 'Available'),
(10, 'Checked Out');
 
 SELECT * FROM BookCopies;
 
 INSERT INTO Members(Member_Name, Email, Phone_Number, Address) VALUES
('John Smith', 'john@example.com', '123-456-7890', '123 Main St'),
('Jane Doe', 'jane@example.com', '987-654-3210', '456 Elm St'),
('David Johnson', 'david@example.com', '555-123-4567', '789 Oak St'),
('Susan Johnson', 'susan@example.com', '888-555-1234', '567 Pine St'),
('Michael Brown', 'michael@example.com', '111-999-7777', '321 Cedar St'),
('Emily Wilson', 'emily@example.com', '222-333-4444', '987 Maple St'),
('Sita Ram', 'siyaram@example.com', '222-333-4442', '143 Hap st'),
('Radhe krishna', 'radheradhe@example.com', '111-333-4444', '234 Dav St'),
('Parvati Shiv', 'Parshiv@example.com', '222-123-4444', '934 Sav St'),
('Durga Ma', 'Durga@example.com', '098-393-4534', '987 Lov St');

 SELECT * FROM Members;
 
 INSERT INTO Loans(CopyID, Member_ID, Due_date, Loan_Date) VALUES
 (1, 1, '2023-11-15', '2023-11-01'),
 (10, 2, '2023-11-20', '2023-11-05'),
 (7, 3, '2023-11-25', '2023-11-10'),
 (11, 4, '2023-11-18', '2023-11-02'),
 (12, 5, '2023-11-22', '2023-11-06'),
 (13, 6, '2023-11-30', '2023-11-15'),
 (6, 7, '2023-11-11', '2023-11-02'),
 (8, 8, '2023-11-30', '2023-11-22'),
 (3, 9, '2023-11-24', '2023-11-10'),
 (9, 10, '2023-11-16', '2023-11-09');

 SELECT * FROM Loans;

INSERT INTO Staff(StaffName, Role) VALUES
('Alice Johnson', 'Librarian'),
('Bob Smith', 'Library Assistant'),
('Carol Davis', 'Library Clerk'),
('David Wilson', 'Librarian'),
('Ella Martinez', 'Library Assistant'),
('Frank Brown', 'Library Clerk'),
('Grace Thomas', 'Library Assistant'),
('Henry Johnson', 'Librarian'),
('Isabella Garcia', 'Library Clerk'),
('Jack Miller', 'Library Assistant');

SELECT * FROM Staff;

/*=============================END POPULATING TABLES====================================*/

/*==============================STORED PROCEDURE QUERY QUESTIONS========================*/

/* #1 RETRIEVE TITLES AND AUTHOR OF ALL BOOKS*/

SELECT b.Title, a.Authorname
FROM Books b
JOIN Authors a 
 ON b.AuthorID = a.AuthorID;
 
 /* #2 RETRIEVE TITLES AND AUTHORS OF CHECKED OUT BOOKS */
 
 SELECT b.BookID, b.Title, a.AuthorName, bc.Status 
 FROM Books b 
 JOIN Authors a 
  ON b.AuthorID = a.AuthorID
 JOIN BookCopies bc 
  ON b.bookID = bc.BookID
 WHERE bc.Status = 'ChecKed Out';  
 
 /* #3 RETRIEVE TITLES & AUTHORS OF BOOKS PBLISHED AFTER A CERTAIN DATE */
 
 SELECT b.Title, a.AuthorName, b.PublicationDate
 FROM books b 
 JOIN Authors a 
  On b.AuthorId = a.AuthorID
 WHERE b.PublicationDate > '1977-01-01';
 
 /* #4 RETRIEVIE TITLES, AUTHORS, AND GENRES OF AVAILABLE MYSTERY GENRE BOOK, ORDER BY AUTHOR NAME */
 
SELECT b.Title, a.AuthorName, g.GenreName
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
JOIN Genres g ON b.GenreID = g.GenreID
WHERE b.GenreID = (SELECT GenreID FROM Genres WHERE GenreName = 'Mystery' LIMIT 1)
AND b.BookID IN (SELECT BookID FROM BookCopies WHERE Status = 'Available')
ORDER BY a.AuthorName;

/* #5 RETRIEVE MEMBER NAMES AND COUNT OF CHECKED OUT BOOKS, ORDERED BY MEMBER NAME */

SELECT m.Member_Name, COUNT(l.CopyID) AS Checked_Out_Count
FROM Members m 
LEFT JOIN Loans l
 ON m.Member_ID = l.Member_ID
WHERE l.Due_Date >= NOW()
GROUP BY m.Member_ID 
ORDER BY m.Member_Name;

/* #6 COUNT THE NUMBER OF BOOKS WITH "THE" IN THE TITLE */

SELECT BookID, Title, COUNT(Title) AS Title_Count
FROM Books
WHERE Title LIKE '%The%'
GROUP BY BookID, Title; 

/* #7 COUNT THE NUMBER OF SCIENCE FICTION GENRE BOOK BY EACH AUTHOR */

SELECT a.AuthorID, a.AuthorName, g.GenreName, COUNT(b.BookID) AS Book_Count
FROM Books b
JOIN Authors a 
 ON b.AuthorID = a.AuthorID
JOIN Genres g
 ON b.GenreID = g.GenreID
WHERE g.GenreName = 'Science Fiction'
GROUP BY a.AuthorID, a.AuthorName, g.GenreName
ORDER BY a.AuthorID;

/* #8 RETRIEVE TITLES AND AUTHORS OF AVAILABLE BOOKS WITH MPRE THAN ONE COPY (USING ">) */

SELECT b.BookID, b.Title, a.AuthorName
FROM Books b
JOIN Authors a 
 ON b.AuthorID = a.AuthorID
WHERE b.BookID IN (
	SELECT BookID
    FROM BookCopies
    WHERE Status = 'Available'
    GROUP BY BookID
    HAVING COUNT(*) > 1 
    );
    
/* #9 RETRIEVE THE TITLE OF BOOKS WITH THE HIGHEST NUMBER OF AVAILABLE COPIES*/

SELECT b.BookID, b.Title
FROM Books b
JOIN BookCopies bc ON b.BookID = bc.BookID
WHERE bc.Status = 'Available'
GROUP BY b.BookID, b.Title
HAVING COUNT(bc.Status) = (
    SELECT MAX(AvailableCount)
    FROM (SELECT COUNT(Status) AS AvailableCount
    FROM BookCopies
    WHERE Status = 'Available'
    GROUP BY BookID) AS CopyCounts
);

/* #10 RETRIEVE THE MOST POPULAR GENRE BY COUNTING THE TOTAL NUMBER OF CHECKOUTS FROM BOOKS IN EACH GENRE */

SELECT g.GenreName, COUNT(*) AS TotalCheckouts
FROM Genres g
JOIN Books b 
 ON g.GenreID = b.GenreID
JOIN BookCopies bc 
 ON b.BookID = bc.BookID
JOIN Loans l 
 ON bc.CopyID = l.CopyID
GROUP BY g.GenreName
ORDER BY TotalCheckouts DESC;
