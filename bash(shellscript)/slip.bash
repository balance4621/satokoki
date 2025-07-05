#! /bin/bash

gmt begin slip3 png

gmt set FORMAT_GEO_MAP D
gmt set FONT_ANNOT_PRIMARY 20p
gmt set FONT_LABEL 20p

#断層すべりモデル上に静的応力降下量をプロット
# P波
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne

gmt makecpt -Cpolar -T0/2.0/0.01 -Z -D

gmt image sotsurinslip2.png -Dx0/0+w14c

awk '{print $4,$3,$6}' P波コーナー周波数_Mjma.txt | gmt plot -C -Sc0.24 -W0.2

awk '{print $9, $8}' 本震.txt | gmt plot -Sa0.3 -Gblack

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (a)P
END


#S波
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne -Y-13.2

gmt image sotsurinslip2.png -Dx0/0+w14c

gmt makecpt -Cpolar -T0/2.0/0.01 -Z -D

awk '{print $4,$3,$6}' S波コーナー周波数_Mjma.txt | gmt plot -C -Sc0.24 -W0.2

awk '{print $9, $8}' 本震.txt | gmt plot -Sa0.3 -Gblack

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (b)S
END

gmt colorbar -C -DjBL+w6c/0.3c+o0/-2c+h -Bxa0.5+l"@~D@~@~s@~ (log@-10@- MPa)"

gmt end

