#!/bin/bash

(thunderbird &) && sleep 5 && kdocker -x $(pgrep -x 'thunderbird') -m -t -i /usr/share/icons/hicolor/128x128/apps/org.mozilla.Thunderbird.png
