#!/bin/bash
conky -c ~/.conky/main -dq
conky -c ~/.conky/conky-spotify/conky-spotify -dq
conky -c ~/.conky/cpu-graphs -dq
conky -c ~/.conky/mem-graphs -dq

conky -c ~/.conky/main-leftmon -dq
conky -c ~/.conky/conky-spotify/conky-spotify-leftmon -dq
conky -c ~/.conky/cpu-graphs-leftmon -dq
conky -c ~/.conky/mem-graphs-leftmon -dq
