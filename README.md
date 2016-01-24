# Meta Surf Forecast

## Purpose

Pull data from [Surfline](http://www.surfline.com/), [MagicSeaweed](http://magicseaweed.com/), [Spitcast](http://www.spitcast.com/) and [Weather Underground](http://www.wunderground.com/) APIs to display an aggregated surf & wind forecast.

## Data Sources

### Surfline

Surfline's API is undocumented and unprotected, but is used via javascript on their website, so it was fairly easy to reverse-engineer. They return JSON, but with a very odd structure, with each item that is time-sensitive containing an array of daily arrays of values that correspond to timestamps provided in a separate set of arrays. For example (lots of data left out for brevity):

```json
"Surf": {
  "dateStamp": [
      [
        "January 24, 2016 04:00:00",
        "January 24, 2016 10:00:00",
        "January 24, 2016 16:00:00",
        "January 24, 2016 22:00:00"
      ],
      [
        "January 25, 2016 04:00:00",
        "January 25, 2016 10:00:00",
        "January 25, 2016 16:00:00",
        "January 25, 2016 22:00:00"
      ]
    ],
  "surf_min": [
      [
        2.15,
        1.8,
        1.4,
        1
      ],
      [
        0.7,
        0.4,
        0.3,
        0.3
      ]
    ],
}
```

Requests are structured as follows:

`http://api.surfline.com/v1/forecasts/<spot_id>?resources=&days=&getAllSpots=&units=&usenearshore=&interpolate=&showOptimal=&callback=`

This is a breakdown of the querystring params available:

Param|Values|Effect
-----|------|------
spot_id|integer|Surfline spot id that you want data for. A typical Surfline URL is `http://www.surfline.com/surf-report/venice-beach-southern-california_4211/` where 4211 is the `spot_id`. You can also get this from the response's `id` property.
resources|string|Any comma-separated list of "surf,analysis,wind,weather,tide,sort". There could be more available that I haven't discovered. "Sort" gives an array of swells, periods & heights that are used for the tables on [spot forecast pages](www.surfline.com/surf-forecasts/spot/venice-beach_4211/). 
days|integer|Number of days of forecast to get. This seems to cap out at 16 for Wind and 25 for Surf.
getAllSpots|boolean|`false` returns an object containing the single spot you requested, `true` returns an array of data for all spots in the same region as your spot, in this case "South Los Angeles"
units|string|`e` returns American units (ft/mi), `m` uses metric
usenearshore|boolean|The best that I can gather, you want this set to `true` to use the [more accurate nearshore models](http://www.surfline.com/surf-science/what-is-lola---forecaster-blog_61031/) that take into account how each spot's unique bathymetry affects the incoming swells.
interpolate|boolean|Provide "forecasts" every 3 hours instead of ever 6. These interpolations seem to be simple averages of the values of the 6-hour forecasts.
showOptimal|boolean|Includes arrays of 0's & 1's indicating whether each wind & swell forecast is optimal for this spot or not. Unfortunately the optimal swell data is only provided if you include the "sort" resource - it is not included in the "surf" resource.
callback|string|jsonp callback function name

### MagicSeaweed

MagicSeaweed has a [well-documented JSON API](http://magicseaweed.com/developer/forecast-api) that requires requesting an API key via email. This was a straightforward process and they got back to me quickly with my key.

### Spitcast

Spitcast provides a [list of API endpoints](http://www.spitcast.com/api/docs/), but the data is sanely-structured JSON so it's pretty easy to parse.

### Weather Underground

## TODO

* Stop manually seeding the db and figure out a way to pull all spots from each data source and automatically associate them to a canonical spot record (probably using geocoding)
* Refresh data on a schedule
* Cache API responses