# Meta Surf Forecast

## Purpose

Pull data from [Surfline](http://www.surfline.com/), [MagicSeaweed](http://magicseaweed.com/) & [Spitcast](http://www.spitcast.com/) APIs to display an aggregated surf forecast.

[See it in action!](https://metasurfforecast.com/)

## Developer Setup

1. Install postgres, if you don't have it already: `brew install postgresql`
1. Create your database & seed it with spots: `bin/rails db:setup`
1. Install [yarn](https://yarnpkg.com): `brew install yarn`
1. Install yarn packages: `yarn`
1. Grab some [Spitcast](http://www.spitcast.com/) data: `bin/rails spitcast:update`
1. Grab some [Surfline](http://www.surfline.com/) data: `bin/rails surfline:update`
1. Grab some [MagicSeaweed](http://magicseaweed.com/) data (requires a valid [API key](http://magicseaweed.com/developer/sign-up)): `MSW_API_KEY=xxx bin/rails msw:update`
1. Start the server: `bin/invoker start`
1. Connect to https://surf.dev
1. Score!

Note: If you get a security warning in Chrome, Click "Advanced" and then "Proceed to surf.dev (unsafe)". Nothing to worry about, you're just connecting to your own machine and it's a self-signed SSL certificate so Chrome freaks out. You will also probably need to open the [Browsersync javascript](https://surf.dev:9500/browser-sync/browser-sync-client.js) and [Webpacker bundle](https://surf.dev:9001/packs/application.js) once each to trust those certificates as well. I'm hoping to find a better workaround for this in the future...

**Pull requests welcome, especially around new data sources/better data visualization (see [TODO](#todo) for suggestions)**

## Adding Spots

Contributing new spots is easy! Make sure you're signed into your [Github account](https://github.com/join) and edit the [seeds file](https://github.com/swrobel/meta-surf-forecast/edit/master/db/seeds.rb):

1. Get the Spitcast spot id & lat/lon data using [their spot list API](http://api.spitcast.com/api/spot/all).
1. Go to the MagicSeaweed page for the spot you want to add. Their spot id is the number at the end of the url, ex: for `http://magicseaweed.com/Pipeline-Backdoor-Surf-Report/616/` it's `616`.
1. Go to the Surfline page for the spot you want to add. Their spot id is also at the end of the url, ex: for `http://www.surfline.com/surf-report/venice-beach-southern-california_4211/` it's `4211`.
1. It's strongly encouraged to add all spots for a particular county or region rather than just a single one. Be a pal!
1. Submit a pull request and I'll get it on the site ASAP!

Use the following as a template. Delete the lines for `surfline_id`, `msw_id`, etc, if that spot doesn't exist on that particular site.

```ruby
  {
    name: 'County Line',
    lat: 34.051,
    lon: -118.964,
    surfline_id: 4203,
    msw_id: 277,
    spitcast_id: 207,
  },
```

## Data Sources

### [Surfline](http://www.surfline.com/)

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
resources|string|Any comma-separated list of "surf,analysis,wind,weather,tide,sort". There could be more available that I haven't discovered. "Sort" gives an array of swells, periods & heights that are used for the tables on [spot forecast pages](http://www.surfline.com/surf-forecasts/spot/venice-beach_4211/).
days|integer|Number of days of forecast to get. This seems to cap out at 16 for Wind and 25 for Surf.
getAllSpots|boolean|`false` returns an object containing the single spot you requested, `true` returns an array of data for all spots in the same region as your spot, in this case "South Los Angeles"
units|string|`e` returns American units (ft/mi), `m` uses metric
usenearshore|boolean|The best that I can gather, you want this set to `true` to use the [more accurate nearshore models](http://www.surfline.com/surf-science/what-is-lola---forecaster-blog_61031/) that take into account how each spot's unique bathymetry affects the incoming swells.
interpolate|boolean|Provide "forecasts" every 3 hours instead of ever 6. These interpolations seem to be simple averages of the values of the 6-hour forecasts.
showOptimal|boolean|Includes arrays of 0's & 1's indicating whether each wind & swell forecast is optimal for this spot or not. Unfortunately the optimal swell data is only provided if you include the "sort" resource - it is not included in the "surf" resource.
callback|string|jsonp callback function name

### [MagicSeaweed](http://magicseaweed.com/)

MagicSeaweed has a [well-documented JSON API](http://magicseaweed.com/developer/forecast-api) that requires requesting an API key via email. This was a straightforward process and they got back to me quickly with my key.

### [Spitcast](http://www.spitcast.com/)

Spitcast provides a [list of API endpoints](http://www.spitcast.com/api/docs/), but the data is sanely-structured JSON so it's pretty easy to parse.

## TODO

* [ ] **Improve charts:**
  * [x] **Fix timestamp formatting.**
  * [x] **Account for min/max size forecast. Currently charts just reflect the max.**
  * [ ] **Display forecast quality ratings.** Perhaps color each bar different depending on how good the rating is. Surfline also has an `optimal_wind` boolean that is being crudely integrated into the [`display_swell_rating`](https://github.com/swrobel/meta-surf-forecast/blob/master/app/models/surfline.rb#L5) method - improvements welcome.
* [ ] Fetch & display tide/wind/water temperature data from [NOAA](https://tidesandcurrents.noaa.gov/waterlevels.html?id=9410840) (they actually have a decent [API](https://tidesandcurrents.noaa.gov/api/)!)
* [ ] Fetch & display [recent buoy trends](http://www.ndbc.noaa.gov/show_plot.php?station=46025&meas=wvht&uom=E&time_diff=-7&time_label=PDT) that are relevant to each spot to give an idea of when swell is actually arriving.
* [ ] Stop manually seeding the db and figure out a way to pull all spots from each data source and automatically associate them to a canonical spot record (probably using geocoding)
* [x] Refresh data on a schedule based on when new data is available (refreshing all forecast sources hourly)
