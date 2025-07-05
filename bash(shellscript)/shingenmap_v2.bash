#! /bin/bash

gmt begin shingen4 png

gmt set FORMAT_GEO_MAP D
#gmt set MAP_FRAME_TYPE plain


gmt set FONT_ANNOT_PRIMARY 20p
gmt set FONT_LABEL 20p


#解析に使用した地震の分布図
gmt basemap -JM14 -R136.2/138.3/36.8/38.1 -B1f0.1 -BWSne

gmt makecpt -Cjet -T0/20/1 -Z -D -I

awk '{print $9,$8,$10}' pair_teq.txt | gmt plot -C -Sc0.2

#awk '{print $9,$8,$10}' 本震.txt | gmt plot -Sa0.6 -G0/0/0

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1

gmt colorbar -C -DjBL+w6c/0.5c+o0/-2c+h -Bxa10+l"Depth (km)"

gmt end
