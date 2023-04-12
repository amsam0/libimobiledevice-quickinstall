# libimobiledevice-quickinstall

A bash script to quickly install libimobiledevice on macOS and Linux using binaries built by GitHub Actions.

## Usage

## macOS

First, ensure you have installed [Homebrew](https://brew.sh). Then, download and run [mac/libimobiledevice-quickinstall.sh](./mac/libimobiledevice-quickinstall.sh) with `sudo` (example:
`sudo bash ./libimobiledevice-quickinstall.sh`).

If you have `wget` installed (either by Homebrew or Xcode CLI tools), you can use this one liner to download and run the script.

```bash
wget https://github.com/naturecodevoid/libimobiledevice-quickinstall/raw/main/mac/libimobiledevice-quickinstall.sh && sudo bash ./libimobiledevice-quickinstall.sh
```

You will need to run it with `sudo` because it will copy the libimobiledevice files to `/usr/local/`.

## Linux

Make sure you have `wget` installed. Then, download and run [linux/libimobiledevice-quickinstall.sh](./linux/libimobiledevice-quickinstall.sh) with `sudo` (example:
`sudo bash ./libimobiledevice-quickinstall.sh`).

You can use this one liner to download and run the script.

```bash
wget https://github.com/naturecodevoid/libimobiledevice-quickinstall/raw/main/linux/libimobiledevice-quickinstall.sh && sudo bash ./libimobiledevice-quickinstall.sh
```

You will need to run it with `sudo` because it will copy the libimobiledevice files to `/usr/local/`.

## What does it do?

Downloads directory will be at `./libimobiledevice-quickinstall-tmp`. This directory will be cleaned before and after the script is run.

First, it will download `libimobiledevice`, `libplist`, `libusbmuxd`, and `libimobiledevice-glue` from GitHub Actions using [nightly.link](https://nightly.link).

Next, it will extract the downloaded zips.

Finally, it will go through the `bin`, `lib`, `share` and `include` folders in `libimobiledevice-quickinstall-tmp/usr/local`. It will attempt to run `ldid` on each file and then copy everything to
`/usr/local/`. It will also make every file an executable.
