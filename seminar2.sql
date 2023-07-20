use db1;

create table movies (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) NOT NULL,
year YEAR NOT NULL,
running_time INT NOT NULL,
storyline TEXT NOT NULL);


INSERT into cinema (title, year, running_time, storyline) 
VALUES ('Harry Potter and the Philosophers Stone', 2001, 152, "An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world."),
('Harry Potter and the Chamber of Secrets', 2002, 162,"An ancient prophecy seems to be coming true when a mysterious presence begins stalking the corridors of a school of magic and leaving its victims paralyzed."),
('The Green Mile', 1999, 188,'Death Row guards at a penitentiary, in the 1930s, have a moral dilemma with their job when they discover one of their prisoners, a convicted murderer, has a special gift.'),
('Forrest Gump', 1994, 142,"The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.");

RENAME TABLE movies to cinema;
ALTER TABLE cinema ADD Language VARCHAR(50) NULL; 
ALTER TABLE cinema DROP COLUMN Language;
DROP TABLE course;
TRUNCATE TABLE cinema;