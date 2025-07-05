#! /bin/bash

gmt begin yoshinsuu2 png

gmt basemap -JX12/-4 -R0/40/0/25 -Bx10f1+l"Distance (km)" -By5f1+l"Depth (km)" -BWSne

awk '{print $4,$3}' danmen2.txt | gmt plot -Sc0.1 -Gblack

gmt basemap -JX12/4 -R0/40/0/100 -Bx10f1 -Byaf+l"Number" -BWSne -Y4.7

awk '{print $4}' danmen2.txt | gmt histogram -T2 -W -Z0

gmt end
