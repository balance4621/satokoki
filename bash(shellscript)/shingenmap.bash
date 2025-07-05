#! /bin/bash

gmt begin shingen2 png

gmt set FORMAT_GEO_MAP D
#gmt set MAP_FRAME_TYPE plain

gmt set FONT_ANNOT_PRIMARY 20p
gmt set FONT_LABEL 20p

#余震分布図
gmt basemap -JM14 -R136.1/138.2/36.7/38.2 -B1f0.1 -BWSne

gmt makecpt -Cjet -T0/20/1 -Z -D -I

awk '{print $5,$4,$6}' 震源カタログ2.txt | gmt plot -C -Sc0.1

#awk '{print $15,$14}' 観測点.txt | gmt plot -St0.7 -W0.02 -G190/190/190

#awk '{print $15,$14}' 臨時観測点.txt | gmt plot -St0.7 -W0.02 -G0/0/0

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1

gmt colorbar -C -DjBL+w6c/0.5c+o0/-2c+h -Bxa10+l"Depth (km)"

gmt text -F+f18p,0,black+jBL -N << END
136.2 38.1 (a)
END

#観測点分布図
gmt basemap -JM14 -R136.1/138.2/36.7/38.2 -B1f0.1 -BWSne -X15.5

gmt makecpt -Cjet -T0/20/1 -Z -D -I

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1 -GlightGreen

#awk '{print $5,$4,$6}' 震源カタログ2.txt | gmt plot -C -Sc0.1

awk '{print $15,$14}' 観測点.txt | gmt plot -St0.5 -W0.02 -G190/190/190

awk '{print $15,$14}' 臨時観測点.txt | gmt plot -St0.5 -W0.02 -G0/0/0

gmt text -F+f18p,0,black+jBL -N << END
136.2 38.1 (b)
END

gmt end
