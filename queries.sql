-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
-- Insert artists
INSERT INTO "artists"("name") VALUES ('Peter Cat Recording Co.');
INSERT INTO "artists"("name") VALUES ('Tame Impala');
INSERT INTO "artists"("name") VALUES ('Doja Cat');
INSERT INTO "artists"("name") VALUES ('Kenny Beats');
INSERT INTO "artists"("name") VALUES ('Coldplay');
INSERT INTO "artists"("name") VALUES ('Enrique Iglesias');

-- Insert songs
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Soulless Friends', 1, 300);
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Eventually', 2, 350);
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Agora Hills', 3, 245);
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Hold My Head', 4, 210);
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Yellow', 5, 300);
INSERT INTO "songs"("name", "artist_id", "duration") VALUES ('Hero', 6, 240);

-- Insert playlist
INSERT INTO "my_playlists"("name") VALUES ('My Favorite Playlist');

-- Add songs to playlist
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 1);
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 2);
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 3);
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 4);
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 5);
INSERT INTO "playlist_songs"("playlist_id", "song_id") VALUES (1, 6);

-- Record song plays
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (1, '2023-01-01 10:00:00');
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (2, '2023-01-02 11:00:00');
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (3, '2023-01-03 12:00:00');
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (4, '2023-01-01 13:00:00');
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (5, '2023-01-01 14:00:00');
INSERT INTO "song_plays"("song_id", "play_timestamp") VALUES (6, '2023-01-01 15:00:00');

-- Query to find the most played songs
SELECT * FROM "favorite_songs";

-- Query to find the favorite artists
SELECT * FROM "favorite_artists";

-- Query to find all songs in 'My Favorite Playlist'
SELECT "songs"."name"
FROM "songs"
JOIN "playlist_songs" ON "songs"."id" = "playlist_songs"."song_id"
JOIN "my_playlists" ON "playlist_songs"."playlist_id" = "my_playlists"."id"
WHERE "my_playlists"."name" = 'My Favorite Playlist';

-- Query to find the total play count for a specific song
SELECT "name", COUNT("play_id") AS "total_plays"
FROM "songs"
JOIN "song_plays" ON "songs"."id" = "song_plays"."song_id"
WHERE "songs"."name" = 'Yellow';
