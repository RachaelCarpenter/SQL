/* Shows artist's loudest track, the loudness of that track, the average loudness across all the artist's tracks, then, categorizes the artist's 
average loudness and track loudness.*/

SELECT artist_name, 
       track_name, 
       Min(loudness) AS loudest, 
       track_loudness_category, 
       avg_artist_loudness, 
       artist_loudness_category 
FROM   (SELECT Round(Avg(loudness) 
                       OVER ( 
                         partition BY artist_name), 3) AS avg_artist_loudness, 
               CASE 
                 WHEN loudness <= -8 THEN 'loudest' 
                 WHEN loudness <= -6 THEN 'louder' 
                 WHEN loudness <= -4 THEN 'loud' 
                 ELSE 'not loud' 
               END                                     AS track_loudness_category 
               , 
               CASE 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) <= -8 THEN 'loudest' 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) <= -6 THEN 'louder' 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) <= -4 THEN 'loud' 
                 ELSE 'not loud' 
               END                                     AS 
               artist_loudness_category, 
               * 
        FROM   bit_db.spotifydata) 
GROUP  BY artist_name 
ORDER  BY loudest;

-- Orders artists by average acousticness and lists the artist's tracks.
SELECT artist_name, 
       track_name, 
       acousticness, 
       Avg(acousticness) 
         OVER ( 
           partition BY artist_name) AS avg_artist_acousticness 
FROM   bit_db.spotifydata 
ORDER  BY avg_artist_acousticness DESC; 

/*What track is the most likely to uplift mood? According to Rita Steblin in History of Key Characteristics in the Eighteenth and Early Nineteenth Centuries, F# 
major is associated with triumph over difficulty, therefore, song_key = 6.*/
SELECT artist_name, 
       track_name 
FROM   bit_db.spotifydata 
WHERE  song_mode = 1 
       AND song_key = 6; 

-- What tracks are similar to the top three tracks with the highest average danceability and energy?
SELECT a.track_name, 
       Nullif(b.track_name, a.track_name) AS similar_track 
FROM   bit_db.spotifydata a 
       LEFT JOIN bit_db.spotifydata b 
              ON a.danceability = b.danceability BETWEEN ( a.danceability - 0.5
                                                         ) AND ( 
                                                         a.danceability + 0.5 ) 
                                            BETWEEN ( a.energy - 0.5 ) AND ( 
                                                    a.energy + 0.5 ) 
WHERE  a.track_name IN (SELECT track_name 
                        FROM   bit_db.spotifydata 
                        ORDER  BY ( danceability + energy ) / 2 
                        LIMIT  3);
                        
-- I couldn't remember the name of Doja Cat's most popular track, but I remembered hearing the words "Kiss Me" in it.
SELECT artist_name, 
       track_name 
FROM   bit_db.spotifydata 
WHERE  track_name LIKE '%Kiss Me%' 
       AND artist_name = 'Doja Cat'; 
       

/*For this project, I downloaded Spotify data from Kaggle, created a table to insert the data into, and analyzed the data by asking questions and providing
the insights listed above.*/

-- Created the table using the following:
CREATE TABLE bit_db.spotifydata 
  ( 
     id               INTEGER PRIMARY KEY, 
     artist_name      VARCHAR NOT NULL, 
     track_name       VARCHAR NOT NULL, 
     track_id         VARCHAR NOT NULL, 
     popularity       INTEGER NOT NULL, 
     danceability     DECIMAL(4, 3) NOT NULL, 
     energy           DECIMAL(4, 3) NOT NULL, 
     song_key         INTEGER NOT NULL, 
     loudness         DECIMAL(5, 3) NOT NULL, 
     song_mode        INTEGER NOT NULL, 
     speechiness      DECIMAL(5, 4) NOT NULL, 
     acousticness     DECIMAL(6, 5) NOT NULL, 
     instrumentalness DECIMAL(8, 7) NOT NULL, 
     liveness         DECIMAL(5, 4) NOT NULL, 
     valence          DECIMAL(4, 3) NOT NULL, 
     tempo            DECIMAL(6, 3) NOT NULL, 
     duration_ms      INTEGER NOT NULL, 
     time_signature   INTEGER NOT NULL 
  ) 

-- Inserted the spotify_top50_2021.csv file downloaded from Kaggle into the table using SQLiteStudio.