#!/bin/bash
current=`git symbolic-ref --short -q HEAD`
git checkout ${current}

# Compile the site before copying to the new image.
hugo --ignoreCache --ignoreVendor --minify --debug --verbose --baseURL=https://stc-rec.tamatoledo.net
echo "STC-Rec's TamaToledo.net compilation is complete."
echo "Starting docker image build..."
docker image build -f push-update-Dockerfile --no-cache -t stc-rec .
echo "docker image build is complete."
docker login
docker tag stc-rec summittdweller/stc-rec:latest
docker push summittdweller/stc-rec:latest
