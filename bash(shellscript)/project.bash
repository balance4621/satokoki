#! /bin/bash

gmt begin yoshinsuu1 png

gmt basemap -JX12/-5 -R0/25/0/25 -Bx10f1+l"Distance (km)" -By5f1+l"Depth (km)" -BWSne

awk '{print $4,$3}' danmen.txt | gmt plot -Sc0.1 -Gblack


gmt end
