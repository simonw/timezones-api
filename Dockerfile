FROM python:3.6-slim-stretch

RUN apt update
RUN apt install -y python3-dev gcc spatialite-bin libsqlite3-mod-spatialite wget unzip

RUN pip install https://github.com/simonw/datasette/archive/6e37f091.zip

# Download and import the shapefiles
RUN wget --quiet https://github.com/evansiroky/timezone-boundary-builder/releases/download/2018d/timezones-with-oceans.shapefile.zip \
    && unzip timezones-with-oceans.shapefile.zip && \
    cd dist && \
    echo ".loadshp combined-shapefile-with-oceans timezones CP1252 23032\nSELECT CreateSpatialIndex('timezones', 'geometry');" | spatialite timezones.db && \
    mv timezones.db .. && \
    cd .. && rm -rf dist && rm timezones-with-oceans.shapefile.zip

ENV SQLITE_EXTENSIONS /usr/lib/x86_64-linux-gnu/mod_spatialite.so

ADD metadata.json metadata.json

ADD templates templates

RUN datasette inspect timezones.db --inspect-file inspect-data.json

EXPOSE 8001

CMD ["datasette", "serve", "timezones.db", "--host", "0.0.0.0", "--cors", "--port", "8001", "--inspect-file", "inspect-data.json", "-m", "metadata.json", "--template-dir", "templates"]
