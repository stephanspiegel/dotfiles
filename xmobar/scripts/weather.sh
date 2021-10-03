#!/bin/sh
refresh() {
    for _ in 1 2 3 4 5; do
        if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
            weather=$(curl -s wttr.in/?format="%x+%t\n") && break
        else
            sleep 2s
        fi
    done
    [ -z "$weather" ] && return

    condition=${weather% *}
    temperature=${weather##* }

    hour=$(date +%H)
    night_yet() {
        [ "$hour" -ge 19 ] && icon=$*
        [ "$hour" -le 4 ] && icon=$*
    }

case $condition in
    "?") icon="" ;;
    "mm") icon="" ;;
    "=")
        icon=""
        night_yet ""
        ;;
    "///") icon="" ;;
    "//") icon="" ;;
    "**") icon="" ;;
    "*/*") icon="" ;;
    "/")
        icon=""
        night_yet ""
        ;;
    ".")
        icon=""
        night_yet ""
        ;;
    "x")
        icon=""
        night_yet ""
        ;;
    "x/")
        icon=""
        night_yet ""
        ;;
    "*")
        icon=""
        night_yet ""
        ;;
    "*/")
        icon=""
        night_yet ""
        ;;
    "m")
        icon=""
        night_yet ""
        ;;
    "o")
        icon=""
        night_yet ""
        ;;
    "/!/") icon="" ;;
    "!/") icon="" ;;
    "*!*")
        icon=""
        night_yet ""
        ;;
    "mmm") icon="" ;;
    *) icon=$condition ;;
esac
}

formatForBar() {
    bgColor="#1E222A"
    fgColor="#ff6c6b"
    refresh
    if [ -z "$weather" ]; then
        printf "<fn=1><fc=%s,%s> !</fc></fn>" \
            "$fgColor" "$bgColor"
    else
        printf '<fn=1><fc=%s,%s>%s </fc></fn><fc=%s,%s> %s</fc>\n' \
            "$fgColor" "$bgColor" "$icon" "$fgColor" "$bgColor" "$temperature"
    fi
}

case $1 in
    bar) formatForBar 
        ;;
    *)
        refresh
        [ -z "$weather" ] &&
            printf "\033[01;31mERROR:\033[0m Check your network connection.\n" ||
            printf "%s  %s\n" "$icon" "$temperature"
        ;;
esac
