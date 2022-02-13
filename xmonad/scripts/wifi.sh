#!/bin/bash
CONNECTIVITY=$(nmcli network connectivity)
# none: the host is not connected to any network.
# portal: the host is behind a captive portal and cannot reach the full Internet.
# limited: the host is connected to a network, but it has no access to the Internet.
# full: the host is connected to a network and has full access to the Internet.
# unknown
ICON=$(case $CONNECTIVITY in
    (none) printf "<fn=1> </fn>";;
    (portal|limited) printf "<fn=1>直 </fn>!";;
    (full) printf "<fn=1>直 </fn>";;
    (*) printf "<fn=1>直 </fn>?";;
esac)

#CONNECTIONINFO=$(nmcli -g AP device show wlan0 | rg "AP\[\d+\]:\*:")
#AP[4]:*:3C\:37\:86\:D7\:02\:75:oort cloud:Infra:36:195 Mbit/s:40:▂▄__:WPA2

printf "$ICON"
