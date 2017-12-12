# timezones-api

A [Datasette](https://github.com/simonw/datasette)-powered API for finding the time zone for a latitude/longitude point

Try the API here: http://timezones-api.now.sh/timezones/by_point

Full background and explanation: [Building a location to time zone API with SpatiaLite, OpenStreetMap and Datasette](https://simonwillison.net/2017/Dec/12/building-a-location-time-zone-api/)

You can deploy your own copy by installing [Zeit Now](http://timezones-api.now.sh/timezones/by_point) and running `now simonw/timezones-api`

Uses shapefiles from https://github.com/evansiroky/timezone-boundary-builder
