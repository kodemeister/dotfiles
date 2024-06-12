#!/bin/bash

readonly DISPLAY1_NAME="DP-1"
readonly DISPLAY1_MODE="3840x2160@60"
readonly DISPLAY1_POSITION="0,0"
readonly DISPLAY1_SCALE=2
readonly DISPLAY1_PRIORITY=1
readonly DISPLAY2_NAME="DP-2"
readonly DISPLAY2_MODE="3840x2160@60"
readonly DISPLAY2_SCALE=2
readonly DISPLAY2_PRIORITY=2

if [[ "${XDG_SESSION_TYPE}" == "wayland" ]]; then
  readonly DISPLAY2_POSITION="1920,0"
  readonly DUMMY_PLUG_NAME="HDMI-A-1"
else
  readonly DISPLAY2_POSITION="3840,0"
  readonly DUMMY_PLUG_NAME="HDMI-1"
fi

readonly DEFAULT_ACTIVITY="Default"
readonly GAMING_ACTIVITY="Gaming"

readonly SLEEP_INTERVAL=5

session_started() {
  # Switch to Gaming activity.
  local activity_guid
  activity_guid="$(awk -F "=" "\$2 == \"${GAMING_ACTIVITY}\" { print \$1 }" \
    ~/.config/kactivitymanagerdrc)"
  qdbus6 org.kde.ActivityManager /ActivityManager/Activities \
    SetCurrentActivity "${activity_guid}"

  # Determine the requested streaming resolution.
  local dummy_plug_mode
  dummy_plug_mode="$(printf "%sx%s@%s" \
    "${SUNSHINE_CLIENT_WIDTH}" \
    "${SUNSHINE_CLIENT_HEIGHT}" \
    "${SUNSHINE_CLIENT_FPS}")"

  # HACK: kscreen-doctor fails to set mode 3840x2160@60 for my HDMI dummy plug.
  # Let's use the numeric identifier of this particular mode instead.
  if [[ "${dummy_plug_mode}" == "3840x2160@60" &&
    "${XDG_SESSION_TYPE}" == "wayland" ]]; then
    dummy_plug_mode=8
  fi

  # Turn off physical displays and set up the dummy plug for streaming.
  kscreen-doctor \
    "output.${DISPLAY1_NAME}.disable" \
    "output.${DISPLAY2_NAME}.disable" \
    "output.${DUMMY_PLUG_NAME}.enable" \
    "output.${DUMMY_PLUG_NAME}.mode.${dummy_plug_mode}" \
    "output.${DUMMY_PLUG_NAME}.scale.1"
  sleep "${SLEEP_INTERVAL}"
}

session_stopped() {
  # Restore the original display configuration.
  kscreen-doctor \
    "output.${DISPLAY1_NAME}.enable" \
    "output.${DISPLAY1_NAME}.priority.${DISPLAY1_PRIORITY}" \
    "output.${DISPLAY1_NAME}.mode.${DISPLAY1_MODE}" \
    "output.${DISPLAY1_NAME}.position.${DISPLAY1_POSITION}" \
    "output.${DISPLAY1_NAME}.scale.${DISPLAY1_SCALE}" \
    "output.${DISPLAY2_NAME}.enable" \
    "output.${DISPLAY2_NAME}.priority.${DISPLAY2_PRIORITY}" \
    "output.${DISPLAY2_NAME}.mode.${DISPLAY2_MODE}" \
    "output.${DISPLAY2_NAME}.position.${DISPLAY2_POSITION}" \
    "output.${DISPLAY2_NAME}.scale.${DISPLAY2_SCALE}" \
    "output.${DUMMY_PLUG_NAME}.disable"
  sleep "${SLEEP_INTERVAL}"

  # Switch to Default activity.
  local activity_guid
  activity_guid="$(awk -F "=" "\$2 == \"${DEFAULT_ACTIVITY}\" { print \$1 }" \
    ~/.config/kactivitymanagerdrc)"
  qdbus6 org.kde.ActivityManager /ActivityManager/Activities \
    SetCurrentActivity "${activity_guid}"
}

main() {
  local action="$1"

  set -e

  case "${action}" in
    "started") session_started ;;
    "stopped") session_stopped ;;
  esac
}

main "$@"
