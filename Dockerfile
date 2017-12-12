FROM python:3.6-slim-stretch

RUN apt update
RUN apt install -y python3-dev gcc spatialite-bin libsqlite3-mod-spatialite wget unzip

RUN pip install https://github.com/simonw/datasette/archive/master.zip

# Download and import the shapefiles
RUN wget https://github.com/evansiroky/timezone-boundary-builder/releases/download/2017c/timezones.shapefile.zip \
    && unzip timezones.shapefile.zip && \
    cd dist && \
    echo ".loadshp combined_shapefile timezones CP1252 23032\nSELECT CreateSpatialIndex('timezones', 'geometry');" | spatialite timezones.db && \
    mv timezones.db .. && \
    cd .. && rm -rf dist && rm timezones.shapefile.zip

ENV SQLITE_EXTENSIONS /usr/lib/x86_64-linux-gnu/mod_spatialite.so

ADD metadata.json metadata.json

ADD templates templates

RUN datasette inspect timezones.db --inspect-file inspect-data.json

EXPOSE 8001

CMD ["datasette", "serve", "timezones.db", "--host", "0.0.0.0", "--cors", "--port", "8001", "--inspect-file", "inspect-data.json", "-m", "metadata.json", "--template-dir", "templates"]
