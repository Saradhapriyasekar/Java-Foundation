create database virtualartgallery;
use virtualartgallery;
CREATE TABLE Artists (
ArtistID INT PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
Biography TEXT,
Nationality VARCHAR(100));
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL);
CREATE TABLE Artworks (
ArtworkID INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
ArtistID INT,
CategoryID INT,
Year INT,
Description TEXT,
ImageURL VARCHAR(255),
constraint ai FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID) ON DELETE CASCADE
ON UPDATE CASCADE,
constraint CI FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID) ON DELETE CASCADE
ON UPDATE CASCADE);
CREATE TABLE Exhibitions (
ExhibitionID INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
StartDate DATE,
EndDate DATE,
Description TEXT);
CREATE TABLE ExhibitionArtworks (
ExhibitionID INT,
ArtworkID INT,
PRIMARY KEY (ExhibitionID, ArtworkID),
FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');
INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg');
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);
SELECT a.name , count(aw.ArtworkID) as artworkcount
from artists a
left join artworks aw on a.artistid = aw.artistid
group by a.name
order by artworkcount desc;
select aw.title
from artworks aw
join artists a on a.artistid = aw.artistid
where a.nationality in ('spanish','dutch')
order by aw.year asc;
select a.name , count(*) as paintingwork
from artworks aw
join artists a on a.artistid = aw.artistid
join categories c on  c.categoryid = aw.categoryid
where c.name = 'painting'
group by a.name;
select Title,
(select Name from Artists where ArtistID = aw.ArtistID) as ArtistName,
(select Name from Categories where CategoryID = aw.CategoryID) as CategoryName
from Artworks aw
where ArtworkID in (
select ArtworkID from ExhibitionArtworks
where ExhibitionID = (
select ExhibitionID from Exhibitions where Title = 'Modern Art Masterpieces'));
select name 
from artists a
where (select count(*) from artworks aw where a.artistid = aw.artistid) > 2;
select title
from artworks
where artworkid in(select artworkid from exhibitionartworks where exhibitionid = 1)
and artworkid in(select artworkid from exhibitionartworks where exhibitionid = 2);
select name as categoryname, 
(select count(*) from artworks where categoryid = c.categoryid) as totalartwork 
from categories c;
select name
from artists a
where (select count(*) from artworks where artistid = a.artistid) > 3;
select title 
from artworks 
where artistid in (select artistid from artists where nationality = 'spanish');
select e.Title
from Exhibitions e
join ExhibitionArtworks ea on e.ExhibitionID = ea.ExhibitionID
join Artworks aw on ea.ArtworkID = aw.ArtworkID
join Artists a on aw.ArtistID = a.ArtistID
where a.Name in ('Vincent van Gogh', 'Leonardo da Vinci')
group by e.Title
having count(distinct a.Name) = 2;
select title
from artworks
where artworkid not in (select artworkid from exhibitionartworks);
select artistid , name 
from artists a
where (select count(distinct categoryid)
from artworks
where artistid = a.artistid) = (select count(*) from categories); 
select c.name as categoryname , count(aw.artworkid) as totalartwork
from categories c
left join artworks aw on c.categoryid = aw.categoryid
group by c.name; 
select a.Name, count(aw.ArtworkID) as ArtworkCount
from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name
having count(aw.ArtworkID) > 2;
select c.name as categoryname,
(select avg(year) from artworks where categoryid = c.categoryid ) as avgyear
from categories c
where(select count(*) from artworks where categoryid = c.categoryid) > 1;
select title
from artworks
where artworkid in (select artworkid 
from exhibitionartworks
where exhibitionid = (select exhibitionid 
from exhibitions where title = 'Modern Art Masterpieces'));
select name
from categories c
where (select avg(year) from artworks where categoryid = c.categoryid) >
(select avg(year) from artworks);
select title
from artworks
where artworkid not in (select artworkid from exhibitionartworks);
select distinct name
from artists 
where artistid in (select artistid from artworks where categoryid = 
(select  categoryid from artworks where title = 'Mona lisa')
);
select name,
(select count(*) from artworks where artistid = a.artistid) as artworkcount
from artists a;
