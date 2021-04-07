# ConnectIQ Beer Pong Stats Widget

A [ConnectIQ](https://developer.garmin.com/connect-iq/overview/) Widget App for
Garmin Sports Watches to track Beer Pong Statistics.

## Description and Controls

This App allows you to track your Stats in the highly competitive sport that is
_Beer Pong_. The App does nothing automatically and requires User Input at
every step. To track a new Game, simply hit `Select` and hit `Select` for every
cup you score. Some Beer Pong rules allow half cups for one player, which can
be added with pressing `Up`. Two half cups will give one cup. To remove a
mistake press `Down`. Finish the game by hitting `Back`. In the subsequent
menu, you can choose wether you hav won or lost or abort the last game by
pressing the button closest the marked text.

You will return back to the main stats. The App also features a seasonal
tracking, by long pressing `Select`, the all time stats are being presented.
Pressing `Select` again returns to the current Season.

In the Widget settings, you can begin a new season, clear data and add manual data.

## Building

To build the app locally, make sure the Garmin ConnectIQ SDK is
[installed](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/)
and executables are in the `PATH`. To start the app, first start the simulator
by typing `connectiq`, then build and run the app with:

```
make run
```

You can set custom devices by setting the environment variable
`CONNECTIQ_DEVICE` (e.g. `export CONNECTIQ_DEVICE=fr245`). Also, to be able to
build in the first place, you need to have a garmin developer key, follow the
getting started references to generate your key. You need to set the
environment variable `GARMIN_DEVELOPER_KEY` to point to the key loaction. By
default it points to `~/.garmin/developer_key`.

To package the app into a `.iq` file, make sure `uuidgen` is installed and then
run `make release`.
