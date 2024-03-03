/*Shows the actors that have voiced a character in the game and played a character in the show. Lists the voiced character and acted character.*/ 
SELECT actors.NAME, 
       a.NAME AS voiced_character, 
       b.NAME AS acted_character 
FROM   voice_actors 
       JOIN actors 
         ON actors.id = voice_actors.actor_id 
       JOIN characters a 
         ON voice_actors.character_id = a.id 
       JOIN characters b 
         ON actors.character_id = b.id; 

/*Shows characters and their partners' names.*/ 
SELECT a.NAME, 
       b.NAME AS partner_name 
FROM   characters a 
       JOIN characters b 
         ON a.partner_id = b.id; 

/*Shows actors that are within three years of their character's age.*/ 
SELECT actors.NAME 
FROM   actors 
       JOIN characters 
         ON actors.character_id = characters.id 
WHERE  actors.age <= ( characters.age + 3 ) 
       AND actors.age >= ( characters.age - 3 ); 


/*The analysis above utilizes the following data from The Last of Us:*/ 
CREATE TABLE characters 
  ( 
     id         INTEGER PRIMARY KEY, 
     NAME       TEXT, 
     age        INTEGER, 
     gender     TEXT, 
     partner_id INTEGER, 
     resides    TEXT, 
     occupation TEXT 
  ); 

INSERT INTO characters 
            (id, 
             NAME, 
             age, 
             gender, 
             partner_id, 
             resides, 
             occupation) 
VALUES      (1, 
             "ellie williams", 
             19, 
             "female", 
             2, 
             "jackson, wy", 
             "jackson patrolman"), 
            (2, 
             "dina", 
             20, 
             "female", 
             1, 
             "jackson, wy", 
             "jackson patrolman"), 
            (3, 
             "joel miller", 
             56, 
             "male", 
             4, 
             "jackson, wy", 
             "jackson patrolman"), 
            (4, 
             "tess", 
             51, 
             "female", 
             3, 
             "boston, ma", 
             "smuggler"), 
            (5, 
             "tommy miller", 
             50, 
             "male", 
             11, 
             "jackson, wy", 
             "jackson patrolman"), 
            (6, 
             "marlene", 
             45, 
             "female", 
             10, 
             "salt lake city, ut", 
             "fireflies leader"), 
            (7, 
             "riley abel", 
             16, 
             "female", 
             1, 
             "boston, ma", 
             "firefly"), 
            (8, 
             "james", 
             45, 
             "male", 
             NULL, 
             "silver lake, co", 
             "cannibal"), 
            (9, 
             "anna", 
             40, 
             "female", 
             NULL, 
             "boston, ma", 
             "nurse"), 
            (10, 
             "perry", 
             52, 
             "male", 
             6, 
             "kansas city, mo", 
             "rebel lieutenant"), 
            (11, 
             "maria miller", 
             45, 
             "female", 
             5, 
             "jackson, wy", 
             "jackson leader"); 

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
     NAME         TEXT, 
     age          INTEGER, 
     gender       TEXT, 
     height       INTEGER, 
     character_id INTEGER 
  ); 

INSERT INTO actors 
            (id, 
             NAME, 
             age, 
             gender, 
             height, 
             character_id) 
VALUES      (1, 
             "bella ramsey", 
             20, 
             "non-binary", 
             61, 
             1), 
            (2, 
             "pedro pascal", 
             48, 
             "male", 
             71, 
             3), 
            (3, 
             "annie wersching", 
             45, 
             "female", 
             67, 
             4), 
            (4, 
             "storm reid", 
             20, 
             "female", 
             67, 
             7), 
            (5, 
             "troy baker", 
             47, 
             "male", 
             75, 
             8), 
            (6, 
             "ashley johnson", 
             40, 
             "female", 
             64, 
             9), 
            (7, 
             "jeffrey pierce", 
             52, 
             "male", 
             72, 
             10), 
            (8, 
             "merle dandridge", 
             48, 
             "female", 
             68, 
             6); 
