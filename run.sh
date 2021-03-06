#!/bin/sh
sudo apt-get update
sudo apt-get install unzip

cd $WERCKER_ROOT
debug 'Downloading AppEngine SDK...'

curl -O https://commondatastorage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.0.zip ; unzip -x google_appengine_1.9.0.zip
export PATH="$PATH:$(pwd)/google_appengine"

echo "$WERCKER_APPENGINE_DEPLOY_PATH_PASSWORD" > "$WERCKER_STEP_TEMP/password"

cd $WERCKER_SOURCE_DIR

debug 'Starting deployment of directory'
appcfg.py update $WERCKER_APPENGINE_DEPLOY_PATH_SRCPATH --email="$WERCKER_APPENGINE_DEPLOY_PATH_EMAIL" --passin < "$WERCKER_STEP_TEMP/password"

success 'Finished'