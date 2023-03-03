# StreamLined Endpoints

## User Dashboard API
---
### GET User Lists

`/api/v1/users/{user_id}/lists?list={list_name}`  
    
Get an array of details for a user's lists and the media on those lists
   
 | Parameter  | Required    | Description |
| ----------- | ----------- |-------------- |
| list         | required   | string        |
|              |            | To choose which list is being displayed for a particular user, replace {list_name} with one of three values.  'Currently Watching', 'Want to Watch', and 'Watched' (case sensitive)|
| {user_id}    | required   | integer        |
|              |            | Replace {user_id} with a valid string of a user's id that was registered through google OAuth
   
Example:
`GET http://localhost:5000/api/v1/users/1/lists?list=Currently%20Watching`
```
{
    "data": [
        {
            "id": "345534",
            "type": "media",
            "attributes": {
                "id": 345534,
                "title": "Game of Thrones",
                "audience_score": 8.8,
                "rating": "TV-MA",
                "media_type": "tv_series",
                "description": "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
                "genres": [],
                "release_year": 2011,
                "runtime": 60,
                "language": "en",
                "sub_services": [
                    "HBO MAX",
                    "Spectrum On Demand",
                    "HBO (Via Hulu)"
                ],
                "poster": "https://cdn.watchmode.com/posters/0345534_poster_w185.jpg",
                "imdb_id": "tt0944947",
                "tmdb_id": 1399,
                "tmdb_type": "tv",
                "trailer": "https://www.youtube.com/watch?v=BpJYNVhGf1s",
                "user_lists": "Currently Watching",
                "added_to_list_on": "2023-02-28T06:15:49.108Z",
                "user_rating": 4
            }
        },
        {
            "id": "2733214",
            "type": "media",
            "attributes": {
                "id": 2733214,
                "title": "LEGO Marvel Avengers: Time Twisted",
                "audience_score": null,
                "rating": null,
                "media_type": "short_film",
                "description": "When Thanos steals the quantum tunnel, the Avengers embark on a mission to stop him from changing history.",
                "genres": [
                    "Action",
                    "Adventure",
                    "Animation",
                    "Family"
                ],
                "release_year": 2022,
                "runtime": 22,
                "language": "en",
                "sub_services": [],
                "poster": "https://cdn.watchmode.com/posters/02733214_poster_w185.jpg",
                "imdb_id": "tt16531868",
                "tmdb_id": 940543,
                "tmdb_type": "movie",
                "trailer": "",
                "user_lists": "Currently Watching",
                "added_to_list_on": "2023-03-02T23:04:08.427Z",
                "user_rating": null
            }
        }
    ]
}
```
---
### GET User   

`api/v1/users/{user_id}`   
   
Return a single users info given a valid user id that has been registered.   

   
| Parameter  | Required    | Description |
| ----------- | ----------- |-------------- |
| {user_id}    | required   | integer      |
|              |            | In order to return a users data replace {user_id} with a valid string of a user's id that was registered through google OAuth

Example:   
`http://localhost:5000/api/v1/users/1`

```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "sub": "82665364084893123327527102824",
            "username": "matthew_bergstrom",
            "email": "sylvester@rempel.com",
            "name": "Dewitt McDermott VM",
            "picture": "http://hansen.name/dannie_wyman"
        }
    }
}
```   
## Media API
---
### GET Media Search Results

`/api/v1/media?q={search_query}&user_id={user_id}`

Get an array of media with titles that match the search query params.  Optional params available for logged in user to see their interaction with a particular piece of media
   
| Parameter  | Required    | Description |
| ----------- | ----------- |-------------- |
| q          | required   | string         |
|              |            | Replace {search_query} with your case insensitive title or title fragment to get results for matching movie or tv show titles|
| user_id    | optional   | integer       |
|              |            | Replace {user_id} with a valid string of a user's id that was registered through google OAuth.  This will allow tracking of user lists media live on, user rating for a piece of media, and the last update time that media was placed on a list |
   
Example:    
GET /api/v1/media?q=everything%20everywhere&user_id=1   
```
{
    "data": [
        {
            "id": "1516721",
            "type": "search_result",
            "attributes": {
                "id": 1516721,
                "title": "Everything Everywhere All at Once",
                "media_type": "movie",
                "release_year": 2022,
                "tmdb_id": 545611,
                "tmdb_type": "movie",
                "poster": "https://cdn.watchmode.com/posters/01516721_poster_w185.jpg",
                "user_lists": "Currently Watching",
                "added_to_list_on": "2023-03-03T00:54:41.083Z",
                "user_rating": 5
            }
        },
        {
            "id": "1126597",
            "type": "search_result",
            "attributes": {
                "id": 1126597,
                "title": "Everything, Everything",
                "media_type": "movie",
                "release_year": 2017,
                "tmdb_id": 417678,
                "tmdb_type": "movie",
                "poster": "https://cdn.watchmode.com/posters/01126597_poster_w185.jpg",
                "user_lists": "None",
                "added_to_list_on": null,
                "user_rating": null
            }
        },
        {
            "id": "1435331",
            "type": "search_result",
            "attributes": {
                "id": 1435331,
                "title": "To Wong Foo, Thanks for Everything! Julie Newmar",
                "media_type": "movie",
                "release_year": 1995,
                "tmdb_id": 9090,
                "tmdb_type": "movie",
                "poster": "https://cdn.watchmode.com/posters/01435331_poster_w185.jpg",
                "user_lists": "None",
                "added_to_list_on": null,
                "user_rating": null
            }
        }
        
    ]
}
```   
   
    
    
---
### GET Media Details

`/api/v1/media/#{media_id}`

Get a single media’s details by the media id
| Parameter | Required | Description |
| ----      | -------  | ---------   |
| {media_id} | required | integer    |
|            |          | replace {media_id} with a valid media id from the watchmode db |
| user_id    | optional | intger     |
|            |           | Can enter optional user_id params for if a user is logged into the page. If no user_id is entered then the ‘user_lists’, ‘added_to_list_on’, and ‘user_rating’ will return null.|     
   

Example:    
`GET http://localhost:5000/api/v1/media/1516721?user_id=1`   
   
```
{
    "data": {
        "id": "1516721",
        "type": "media",
        "attributes": {
            "id": 1516721,
            "title": "Everything Everywhere All at Once",
            "audience_score": 8.2,
            "rating": null,
            "media_type": "movie",
            "description": "An aging Chinese immigrant is swept up in an insane adventure, where she alone can save what's important to her by connecting with the lives she could have led in other universes.",
            "genres": [],
            "release_year": 2022,
            "runtime": 140,
            "language": "en",
            "sub_services": [
                "DirecTV On Demand",
                "Showtime",
                "Showtime (via Amazon Prime)",
                "fuboTV",
                "Hulu with Showtime"
            ],
            "poster": "https://cdn.watchmode.com/posters/01516721_poster_w185.jpg",
            "imdb_id": "tt6710474",
            "tmdb_id": 545611,
            "tmdb_type": "movie",
            "trailer": "https://www.youtube.com/watch?v=wxN1T1uxQ2g",
            "user_lists": "Currently Watching",
            "added_to_list_on": "2023-03-03T00:54:41.083Z",
            "user_rating": 5
        }
    }
}
```

   
## Trending Media API
---
### GET Trending Media


`/api/v1/trending_media`

Get an array of the top 3 trending media for the day

Example: `GET http://localhost:5000/api/v1/trending_media`

```
{
    "data": [
        {
            "id": "82856",
            "type": "trending_media",
            "attributes": {
                "id": 82856,
                "title": "The Mandalorian",
                "poster_path": "/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg",
                "media_type": "tv",
                "vote_average": 8.476
            }
        },
        {
            "id": "937278",
            "type": "trending_media",
            "attributes": {
                "id": 937278,
                "title": "A Man Called Otto",
                "poster_path": "/130H1gap9lFfiTF9iDrqNIkFvC9.jpg",
                "media_type": "movie",
                "vote_average": 7.666
            }
        },
        {
            "id": "906221",
            "type": "trending_media",
            "attributes": {
                "id": 906221,
                "title": "Magic Mike's Last Dance",
                "poster_path": "/5C9rerMqV1X0jnRdbbsM1BswVI2.jpg",
                "media_type": "movie",
                "vote_average": 6.892
            }
        }
    ]
}
```
