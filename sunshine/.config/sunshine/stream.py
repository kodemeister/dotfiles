#!/usr/bin/env python3

# pylint: disable=missing-module-docstring, missing-function-docstring

import json
import os
import subprocess
import sys
import time

import dbus

DISPLAY_CONFIG = [
    {
        "name": "DP-1",
        "priority": 1,
        "mode": (3840, 2160, 60),
        "position": (0, 0),
        "scale": 2,
    },
    {
        "name": "DP-2",
        "priority": 2,
        "mode": (3840, 2160, 60),
        "position": (1920, 0),
        "scale": 2,
    },
]

DUMMY_PLUG_NAME = "HDMI-A-1"

WORK_ACTIVITY = "Work"
GAMING_ACTIVITY = "Gaming"

SLEEP_INTERVAL = 3


def main():
    if sys.argv[1] == "start":
        switch_to_activity(GAMING_ACTIVITY)
        enable_dummy_plug()
    elif sys.argv[1] == "stop":
        disable_dummy_plug()
        switch_to_activity(WORK_ACTIVITY)
    else:
        raise RuntimeError(f"Invalid action: {sys.argv[1]}")


def enable_dummy_plug():
    width = int(os.environ["SUNSHINE_CLIENT_WIDTH"])
    height = int(os.environ["SUNSHINE_CLIENT_HEIGHT"])
    refresh_rate = int(os.environ["SUNSHINE_CLIENT_FPS"])

    displays = list_displays()
    modes = displays[DUMMY_PLUG_NAME]["modes"]
    mode_id = find_mode_id(modes, width, height, refresh_rate)

    args = ["kscreen-doctor"]
    for config in DISPLAY_CONFIG:
        args.append(f"output.{config["name"]}.disable")

    args.append(f"output.{DUMMY_PLUG_NAME}.enable")
    args.append(f"output.{DUMMY_PLUG_NAME}.priority.1")
    args.append(f"output.{DUMMY_PLUG_NAME}.mode.{mode_id}")
    args.append(f"output.{DUMMY_PLUG_NAME}.position.0,0")
    args.append(f"output.{DUMMY_PLUG_NAME}.scale.1")

    subprocess.run(args, check=True)
    time.sleep(SLEEP_INTERVAL)


def disable_dummy_plug():
    displays = list_displays()

    args = ["kscreen-doctor"]
    for config in DISPLAY_CONFIG:
        name = config["name"]
        modes = displays[name]["modes"]
        mode_id = find_mode_id(modes, *config["mode"])
        left, top = config["position"]

        args.append(f"output.{name}.enable")
        args.append(f"output.{name}.priority.{config["priority"]}")
        args.append(f"output.{name}.mode.{mode_id}")
        args.append(f"output.{name}.position.{left},{top}")
        args.append(f"output.{name}.scale.{config["scale"]}")

    args.append(f"output.{DUMMY_PLUG_NAME}.disable")

    subprocess.run(args, check=True)
    time.sleep(SLEEP_INTERVAL)


def list_displays():
    result = subprocess.run(
        ["kscreen-doctor", "--json"], capture_output=True, check=True, text=True
    )
    info = json.loads(result.stdout)
    return {display["name"]: display for display in info["outputs"]}


def find_mode_id(modes, width, height, refresh_rate):
    return min(
        int(mode["id"])
        for mode in modes
        if mode["size"]["width"] == width
        and mode["size"]["height"] == height
        and abs(mode["refreshRate"] - refresh_rate) <= 0.5
    )


def switch_to_activity(name):
    bus = dbus.SessionBus()
    manager = bus.get_object("org.kde.ActivityManager", "/ActivityManager/Activities")
    activities = {manager.ActivityName(guid): guid for guid in manager.ListActivities()}
    manager.SetCurrentActivity(activities[name])


main()
