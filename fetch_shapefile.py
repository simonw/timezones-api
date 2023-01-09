import httpx


def fetch_shapefile():
    url = "https://api.github.com/repos/evansiroky/timezone-boundary-builder/releases"
    response = httpx.get(url)
    response.raise_for_status()
    releases = response.json()
    # Find asset with name timezones-with-oceans.shapefile.zip
    filename = "timezones-with-oceans.shapefile.zip"
    for asset in releases[0]["assets"]:
        if asset["name"] == filename:
            break
    else:
        raise RuntimeError(f"Could not find asset {filename}")
    download_url = asset["browser_download_url"]
    # Use httpx to download that file to disk
    with open(filename, "wb") as f:
        with httpx.stream("GET", download_url, follow_redirects=True) as r:
            for data in r.iter_bytes():
                f.write(data)


if __name__ == "__main__":
    fetch_shapefile()
