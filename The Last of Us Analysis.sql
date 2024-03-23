/*Shows the actors that have voiced a character in the game and played a character in the show. Lists the voiced and acted character.*/ 
SELECT actors.name, 
       a.name AS voiced_character, 
       b.name AS acted_character 
FROM   voice_actors 
       JOIN actors 
         ON actors.id = voice_actors.actor_id 
       JOIN characters a 
         ON voice_actors.character_id = a.id 
       JOIN characters b 
         ON actors.character_id = b.id; 

/*Shows characters and their partners' names.*/ 
SELECT a.name, 
       b.name AS partner_name 
FROM   characters a 
       JOIN characters b 
         ON a.partner_id = b.id; 

/*Shows actors that are within three years of their character's age.*/ 
SELECT actors.name 
FROM   actors 
       JOIN characters 
         ON actors.character_id = characters.id 
WHERE  actors.age <= ( characters.age + 3 ) 
       AND actors.age >= ( characters.age - 3 ); 


/*The above analysis utilizes the following tables I created with data from The Last of Us:*/ 
CREATE TABLE characters 
  ( 
     id         INTEGER PRIMARY KEY, 
     name       TEXT, 
     age        INTEGER, 
     gender     TEXT, 
     partner_id INTEGER, 
     resides    TEXT, 
     occupation TEXT 
  ); 

INSERT INTO characters 
            (id, 
             name, 
             age, 
             gender, 
             partner_id, 
             resides, 
             occupation) 
VALUES      (1, 
             "Ellie Williams", 
             19, 
             "Female", 
             2, 
             "Jackson, WY", 
             "Jackson Patrolman"), 
            (2, 
             "Dina", 
             20, 
             "Female", 
             1, 
             "Jackson, WY", 
             "Jackson Patrolman"), 
            (3, 
             "Joel Miller", 
             56, 
             "Male", 
             4, 
             "Jackson, WY", 
             "Jackson Patrolman"), 
            (4, 
             "Tess", 
             51, 
             "Female", 
             3, 
             "Boston, MA", 
             "Smuggler"), 
            (5, 
             "Tommy Miller", 
             50, 
             "Male", 
             11, 
             "Jackson, WY", 
             "Jackson Patrolman"), 
            (6, 
             "Marlene", 
             45, 
             "Female", 
             10, 
             "Salt Lake City, UT", 
             "Fireflies Leader"), 
            (7, 
             "Riley Abel", 
             16, 
             "Female", 
             1, 
             "Boston, MA", 
             "Firefly"), 
            (8, 
             "James", 
             45, 
             "Male", 
             NULL, 
             "Silver Lake, CO", 
             "Cannibal"), 
            (9, 
             "Anna", 
             40, 
             "Female", 
             NULL, 
             "Boston, MA", 
             "Nurse"), 
            (10, 
             "Perry", 
             52, 
             "Male", 
             6, 
             "Kansas City, MO", 
             "Rebel Lieutenant"), 
            (11, 
             "Maria Miller", 
             45, 
             "Female", 
             5, 
             "Jackson, WY", 
             "Jackson Leader"); 

CREATE TABLE voice_actors 
  ( 
     id           INTEGER PRIMARY KEY, 
     actor_id     INTEGER, 
     character_id INTEGER 
  ); 

INSERT INTO voice_actors 
            (id, 
             actor_id, 
             character_id) 
VALUES      (1, 
             5, 
             3), 
            (2, 
             6, 
             1), 
            (3, 
             7, 
             5), 
            (4, 
             8, 
             6); 

CREATE TABLE actors 
  ( 
     id           INTEGER PRIMARY KEY, 
     name         TEXT, 
     age          INTEGER, 
     gender       TEXT, 
     height       INTEGER, 
     character_id INTEGER 
  ); 

INSERT INTO actors 
            (id, 
             name, 
             age, 
             gender, 
             height, 
             character_id) 
VALUES      (1, 
             "Bella Ramsey", 
             20, 
             "Non-Binary", 
             61, 
             1), 
            (2, 
             "Pedro Pascal", 
             48, 
             "Male", 
             71, 
             3), 
            (3, 
             "Annie Wersching", 
             45, 
             "Female", 
             67, 
             4), 
            (4, 
             "Storm Reid", 
             20, 
             "Female", 
             67, 
             7), 
            (5, 
             "Troy Baker", 
             47, 
             "Male", 
             75, 
             8), 
            (6, 
             "Ashley Johnson", 
             40, 
             "Female", 
             64, 
             9), 
            (7, 
             "Jeffrey Pierce", 
             52, 
             "Male", 
             72, 
             10), 
            (8, 
             "Merle Dandridge", 
             48, 
             "Female", 
             68, 
             6); 
