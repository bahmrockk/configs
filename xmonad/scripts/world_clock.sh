#!/bin/sh

FGCOL=green
BGCOL=black
TITLECOL=green4
LOCATIONCOL=blue
TIMECOL=grey
#FONT='-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*'

#FONT="Verdana-9"
#FONT='-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859'
FONT="-*-roboto-medium-r-normal-*-14-*-*-*-*-*-*-1"
local_location="Frankfurt"
local_time=`date +"%H.%M"`
#ger_location="Frankfurt"
#ger_time=`TZ="Europe/Frankfurt" date +"%H.%M"`
uk_location="London"
uk_time=`TZ="Europe/London" date +"%H:%M"`
us_location="New York"
us_time=`TZ="America/New_York" date +"%H:%M"`
aus_location="Sydney"
aus_time=`TZ="Australia/Sydney" date +"%H:%M"`
jp_location="Tokyo"
jp_time=`TZ="Asia/Tokyo" date +"%H:%M"`


touch /tmp/worldclock.sh_visible
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
) | dzen2 -fg $FGCOL -bg $BGCOL -x 35 -y 450 -xs 1 -l 15 -ta c -sa c -w 100 -p 10 -fn $FONT 
rm /tmp/worldclock.sh_visible
