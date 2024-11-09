# Design Document

By Diya Kothari

Video overview: <https://youtu.be/vFPSoZTVrjs>

## Scope

The primary objective of this database is to capture and analyze personal music listening habits, focusing on identifying preferred songs and artists. To achieve this, the database encompasses the following core elements:

Songs: Essential details including song title, artist, and duration.
Artists: Basic information about the music creators.
Playlists: User-curated collections of songs for organized listening.

Elements such as genres, albums, and song lyrics, while potentially relevant for a comprehensive music platform, are excluded from this database to maintain a focused scope on personal listening preferences.

## Functional Requirements

This database will support:
* finding my favorite songs
* finding my favorite artists
* seeing what songs are in a given playlist

Note that the database cannot support finding other details about the song such as what album it is a part of.

## Representation
Entities are captured in SQLite tables with the following schema.

### Entities
The database includes the following entities:

#### Artists

The 'artists' table includes:

* 'id' which specifies the unique id of the artist as an INTEGER and has the PRIMARY KEY constraint.
* 'name' which specifies the name of the artist in TEXT as TEXT is appropriate for name fields. It is also NOT NULL to ensure a value is present.

#### Songs

The 'songs' table includes:

* 'id', which specifies the unique id of the song as an INTEGER and thus has the PRIMARY KEY constraint.
* 'name', which specifies the name of the song as a TEXT as is appropriate for name fields. It is also NOT NULL to ensure a value is present.
* 'artist_id', specifies the id of the artist as an INTEGER derived from the artists table and therefore has the FOREIGN KEY constraint
* 'duration', which is the length of the song as an INTEGER to measure time.

#### my_playlists

The 'my_playlists' table includes:

* 'id' which specifies the unique id of the playlist as an INTEGER and thus has the PRIMARY KEY constraint.
* 'playlist' which specifies the name of the playlist as a TEXT. It is also NOT NULL to ensure a value is present.

#### playlist_songs

This table joins the two tables 'songs' and 'playlists' and includes:

* 'playlist_id' as the unique id of the playlist as an INTEGER with a FOREIGN KEY constraint referencing the id in the playlists table
* 'song_id' as the unique id of the song as an INTEGER with a FOREIGN KEY constraint referencing the id in the songs table
* the two entities together also act as a unique id with a PRIMARY KEY constraint.

#### song_plays

This table includes:

* 'play_id' which is the unique id of that specific song play as an INTEGER and thus have the PRIMARY KEY constraint
* 'song_id' as the unique id of the song as an INTEGER with a FOREIGN KEY constraint referencing the id in the songs table
* 'play_timestamp' which gives the CURRENT DEFAULT TIMESTAMP when the song was being played for the most accurate data.


### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.
![IMAGE](IMG_3864.JPG)

As detailed by the diagram:
* a song can be written by 1 or many artists. Similarly, an artist writes at least 1 or more songs.
* a song can be a part of 1 or more playlists and a playlist can have 1 or more songs. it is assumed that a playlist cannot be empty and a song must be a part of some playlist
* a song can be played 1 or more times but only one song can be played at a time
* a song is related to a playlist via playlist_songs and they are identified uniquely.

## Optimizations
Per the typical queries in `queries.sql`, it is common for users of the database to access all data related to what songs are most listened to and how often they are being played. For that reason, an index is created on the `song_id' column in 'song_plays' to speed the identification of these songs.

Similarly, it is also common practice for a user of the database to be concerned with viewing what songs are most popular and who are their favorite artists so I have created views for each of those scenarios.


## Limitations
My current schema is not as complex right now and provides little information about the song.For example, it does not tell what album the song is from or what year it was released. To incorporate and represent all of this information would require more work within the schema.
