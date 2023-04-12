#!/bin/bash

if [[ $UID != 0 ]]; then
  echo "Please run this script with sudo. We need it to copy the libimobiledevice files to /usr/local/ since if we don't, we would need to relink every binary to use libraries in a different location, which is a pain."
  echo "sudo $0 $*"
  exit 1
fi

set -e

DOWNLOADS_DIR="$(pwd)/libimobiledevice-quickinstall-tmp"
echo "Downloads directory: $DOWNLOADS_DIR"
if [ -d "$DOWNLOADS_DIR" ]; then
  echo "Cleaning downloads directory (deleted files will be listed)"
  rm -rv "$DOWNLOADS_DIR"/* || true
  echo "Done cleaning!"
fi
mkdir -p "$DOWNLOADS_DIR"

DOWNLOADS=(
  libimobiledevice
  libplist
  libusbmuxd
  libimobiledevice-glue
  usbmuxd
)

echo

for DOWNLOAD in "${DOWNLOADS[@]}"; do
  DOWNLOAD_LOCATION="$DOWNLOADS_DIR/$DOWNLOAD.zip"
  DOWNLOAD_URL="https://nightly.link/libimobiledevice/$DOWNLOAD/workflows/build/master/$DOWNLOAD-latest_x86_64-linux-gnu.zip"
  echo "Downloading $DOWNLOAD from $DOWNLOAD_URL to $DOWNLOAD_LOCATION"
  wget -q --show-progress -O "$DOWNLOAD_LOCATION" "$DOWNLOAD_URL"
done

echo

for DOWNLOAD in "${DOWNLOADS[@]}"; do
  DOWNLOAD_LOCATION="$DOWNLOADS_DIR/$DOWNLOAD"
  cd "$DOWNLOADS_DIR"
  echo "Extracting $DOWNLOAD_LOCATION.zip"
  unzip "$DOWNLOAD_LOCATION.zip" > /dev/null
  tar xf "$DOWNLOAD_LOCATION.tar" > /dev/null
done

install () {
  echo

  mkdir -p /usr/local/"$1"/
  for FILE in ./usr/local/"$1"/*; do
    USR_LOCAL_FILE="/usr/local/$1/$(basename "$FILE")"
    cp -rv "$FILE" "$USR_LOCAL_FILE"
    chmod +x "$USR_LOCAL_FILE" 2> /dev/null || true # for some reason we need to do this after copying the file
  done
}

install bin
install lib
install share
install include

echo
echo "Cleaning downloads directory (deleted files will be listed)"
rm -rv "$DOWNLOADS_DIR"/* || true
echo "Done! You can test it by running \`idevice_id\` and ensuring there are no weird errors (make sure /usr/local/bin/ is in your PATH!). If you ever need to update libimobiledevice, just re-run this script!"

