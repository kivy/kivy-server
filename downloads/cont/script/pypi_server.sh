#!/usr/bin/env bash

server_path="/web/downloads/simple/kivy"

echo -e "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Links for Kivy</title>\n  </head>\n  <body>\n    <h1>Links for Kivy</h1>" > /tmp/kivy_pypi_index.html


for f in /web/downloads/ci/win/kivy /web/downloads/ci/osx/kivy /web/downloads/ci/linux/kivy
do
    find -L $f -name "*.whl" | grep -E '.+Kivy-([0-9a-z]{1,6}\.)+[0-9a-z]+-.+\.whl' | tr "\n" "\0" |
        while IFS= read -r -d '' fname; do
            relative_name=${fname#"/web/downloads/"}
            clean_name=$(basename "$fname")
            echo "    <a href="../../$relative_name">$clean_name</a><br>" >> /tmp/kivy_pypi_index.html
        done
done

echo -e "  </body>\n</html>" >> /tmp/kivy_pypi_index.html
mv /tmp/kivy_pypi_index.html $server_path/index.html
