#!/bin/bash
datasette publish fly timezones.db \
  --app timezones-api \
  --setting default_page_size 10 \
  --setting sql_time_limit_ms 5000 \
  --install datasette-geojson-map \
  --metadata metadata.yml \
  --spatialite
