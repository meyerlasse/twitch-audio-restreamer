#!/bin/bash

trap "exit" INT

_display_help () {
	printf "Usage: twitch-audio-restream [Twitch.tv username] [icecast source password]\n"
}

if (( $# < 2 )); then
	_display_help
	exit 1
fi

while true; do
	youtube-dl -q -o - "https://www.twitch.tv/$1" 2> /dev/null |\
		ffmpeg -i pipe:0 -f mp3 icecast://source:"$2"@localhost:8000/"$1" -loglevel warning
	sleep 60
done
