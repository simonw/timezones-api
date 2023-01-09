#!/bin/bash
shapefile-to-sqlite \
  timezones.db \
  timezones-with-oceans.shapefile.zip \
  --table timezones \
  --spatial-index

geojson-to-sqlite \
  timezones.db \
  countries \
  countries.geojson \
  --spatial-index
