#!/bin/bash
datasette timezones.db \
  --load-extension spatialite \
  --setting default_page_size 10 \
  --setting sql_time_limit_ms 10000 \
  # --setting default_allow_sql off
