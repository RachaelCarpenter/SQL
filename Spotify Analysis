/*What track is most likely to uplift mood? According to Rita Steblin in History of Key Characteristics in the Eighteenth and Early Nineteenth Centuries, F# major is associated with triumph over difficulty. Therefore, song_key = 6.*/
SELECT artist_name, 
       track_name 
FROM   spotifydata 
WHERE  song_mode = 1 
       AND song_key = 6;  
       
/*Orders artists by average acousticness and lists the artist's tracks.*/
SELECT artist_name, 
       track_name, 
       acousticness, 
       Avg(acousticness) 
         OVER ( 
           partition BY artist_name) AS artist_acousticness_avg 
FROM   spotifydata 
ORDER  BY artist_acousticness_avg DESC; 
       
/*"I can't remember the name of this Doja Cat song that's been stuck in my head, but I remember it has the words "kiss me" in it."*/
SELECT artist_name, 
       track_name 
FROM   spotifydata 
WHERE  track_name LIKE '%kiss me%' 
       AND artist_name = 'Doja Cat'; 
       
/* Shows each artist's loudest track, the loudness of the track, and the average loudness across all the artist's tracks, then categorizes the artist's average loudness and loudest track.*/ 
SELECT artist_name, 
       track_name, 
       Max(loudness) AS artist_loudest_track, 
       track_loudness_cat, 
       artist_loudness_avg, 
       artist_loudness_cat 
FROM   (SELECT Round(Avg(loudness) 
                       OVER ( 
                         partition BY artist_name), 3) AS artist_loudness_avg, 
               CASE 
                 WHEN loudness >= -4 THEN 'loudest' 
                 WHEN loudness >= -6 THEN 'louder' 
                 WHEN loudness >= -8 THEN 'loud' 
                 ELSE 'not loud' 
               END                                     AS track_loudness_cat, 
               CASE 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) >= -4 THEN 'loudest' 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) >= -6 THEN 'louder' 
                 WHEN Avg(loudness) 
                        OVER ( 
                          partition BY artist_name) >= -8 THEN 'loud' 
                 ELSE 'not loud' 
               END                                     AS artist_loudness_cat, 
               * 
        FROM   spotifydata) 
GROUP  BY artist_name 
ORDER  BY artist_loudest_track DESC; 

/*What tracks are similar to the top three tracks with the highest average combined danceability and energy?*/
SELECT a.artist_name, 
       a.track_name, 
       b.artist_name AS artist, 
       b.track_name  AS similar_track 
FROM   (SELECT Dense_rank() 
                 OVER ( 
                   ORDER BY (danceability+energy)/2) AS rank, 
               * 
        FROM   spotifydata) a 
       LEFT JOIN spotifydata b 
              ON ( a.danceability + a.energy ) / 2 = 
                 ( b.danceability + b.energy ) / 2 BETWEEN ( 
                           ( a.danceability + 
                             a.energy ) / 2 - 0.5 
                           ) AND ( 
                           ( a.danceability + a.energy ) / 2 + 0.5 ) 
WHERE  rank <= 3; 

/* Shows the artists whose average popularites are 90 or above using the CTE, avg_artist_pop.*/ 
WITH avg_artist_pop 
     AS (SELECT artist_name, 
                Avg(popularity) AS avg_pop 
         FROM   spotifydata 
         GROUP  BY artist_name) 
SELECT artist_name, 
       avg_pop, 
       'Top Star' AS tag 
FROM   avg_artist_pop 
WHERE  avg_pop >= 90; 
       

/*For this project, I downloaded Spotify data from Kaggle, created a table to insert the data into, and analyzed the data by asking questions and providing the insights above.*/

/*Created the table using the following:*/
CREATE TABLE   spotifydata 
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

/*Inserted the spotify_top50_2021.csv file downloaded from Kaggle into the table using SQLiteStudio.*/
