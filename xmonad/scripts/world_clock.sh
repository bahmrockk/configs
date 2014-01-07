#!/bin/sh
DURATION=6
SEPERATOR=":"
FGCOL=green
BGCOL=black
TITLECOL=green4
LOCATIONCOL=blue
TIMECOL=grey
#FONT='-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*'
#FONT="Verdana-9"
#FONT='-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859'
FONT="-*-roboto-medium-r-normal-*-14-*-*-*-*-*-*-1"
LOCKFILE="/tmp/worldclock.sh_visible"

pids=`pidof dzen2`
local_location="Frankfurt"
local_time=`date +"%H.%M"`
#ger_location="Frankfurt"
#ger_time=`TZ="Europe/Frankfurt" date +"%H.%M"`
uk_location="London"
uk_time=`TZ="Europe/London" date +"%H$SEPERATOR%M"`
us_location="New York"
us_time=`TZ="America/New_York" date +"%H$SEPERATOR%M"`
aus_location="Sydney"
aus_time=`TZ="Australia/Sydney" date +"%H$SEPERATOR%M"`
jp_location="Tokyo"
jp_time=`TZ="Asia/Tokyo" date +"%H$SEPERATOR%M"`

if [ -e $LOCKFILE ]
then
    rm $LOCKFILE
    kill `pgrep -f "dzen2.*worldclock"`
    kill `pidof -o $$ -x "world_clock.sh"`
else
    touch $LOCKFILE
    (
    #echo -e "^fg($TITLECOL)World Time^fg() " 
    echo
    echo -e "^fg($LOCATIONCOL)$us_location^fg()"
    echo -e "^fg($TIMECOL)$us_time^fg()"
    echo
    echo -e "^fg($LOCATIONCOL)$uk_location^fg()"
    echo -e "^fg($TIMECOL)$uk_time ^fg()"
    echo
    echo -e "^fg($LOCATIONCOL)$local_location^fg()"
    echo -e "^fg($TIMECOL)$local_time ^fg()"
    echo
    echo -e "^fg($LOCATIONCOL)$jp_location^fg()"
    echo -e "^fg($TIMECOL)$jp_time^fg()"
    echo
    echo -e "^fg($LOCATIONCOL)$aus_location^fg()"
    echo -e "^fg($TIMECOL)$aus_time^fg()"

    echo -e "^uncollapse()"
    echo "^stick()"
    echo "^scrollhome()"
    ) | dzen2 -fg $FGCOL -bg $BGCOL -x 35 -y 450 -xs 1 -l 15 -ta c -sa c -w 100 -p $DURATION -fn $FONT -title-name worldclockdzenmaster -slave-name worldclockdzenslave&
    sleep 0.1
    transset-df .9 -n worldclockdzenmaster 
    transset-df .9 -n worldclockdzenslave
    sleep `bc <<< $DURATION-0.1` 
    rm $LOCKFILE
fi
