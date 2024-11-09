-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
-- Create table for artists
CREATE TABLE "artists" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- Create table for songs
CREATE TABLE "songs" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "artist_id" INTEGER,
    "duration" INTEGER,
    FOREIGN KEY("artist_id") REFERENCES "artists"("id")
);

-- Create table for playlists
CREATE TABLE "my_playlists" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- Create table to manage many-to-many relationships between songs and playlists
CREATE TABLE "playlist_songs" (
    "playlist_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("playlist_id", "song_id"),
    FOREIGN KEY("playlist_id") REFERENCES "my_playlists"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

-- Create table to track song plays
CREATE TABLE "song_plays" (
    "play_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "song_id" INTEGER,
    "play_timestamp" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

-- Create index on song_id in song_plays to improve query performance
CREATE INDEX "song_performance" ON "song_plays"("song_id");

-- Create view for most listened to songs
CREATE VIEW "favorite_songs" AS
SELECT
    "songs"."id" AS "song_id",
    "songs"."name" AS "song_name",
    COUNT("song_plays"."play_id") AS "play_count"
FROM "songs"
JOIN "song_plays" ON "songs"."id" = "song_plays"."song_id"
GROUP BY "songs"."id"
ORDER BY "play_count" DESC;

-- Create view for favorite artists
CREATE VIEW "favorite_artists" AS
SELECT
    "artists"."id" AS "artist_id",
    "artists"."name" AS "artist_name",
    COUNT("song_plays"."play_id") AS "play_count"
FROM "artists"
JOIN "songs" ON "artists"."id" = "songs"."artist_id"
JOIN "song_plays" ON "songs"."id" = "song_plays"."song_id"
GROUP BY "artists"."id"
ORDER BY "play_count" DESC;
