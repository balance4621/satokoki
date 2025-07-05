#! /bin/bash
#静的応力降下量の空間分布
gmt begin Sflaglogstressdrop png

gmt set FORMAT_GEO_MAP D
#gmt set MAP_FRAME_TYPE plain

#gmt basemap -JM14 -R136/138/36.7/38.2 -B1f0.1 -BWSne
gmt set FONT_ANNOT_PRIMARY 20p

gmt set FONT_LABEL 20p 

#P波解析結果の出力(静的応力降下量の空間分布)
gmt basemap -JM14 -R136.2/138.3/36.8/38.1 -B1f0.1 -BWSne

gmt makecpt -Cpolar -T0/2.0/0.01  -Z -D

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1 -Glightgreen

awk '{print $4,$3,$6}' P波コーナー周波数_Mjma.txt | gmt plot -C -Sc0.4 -W0.1

gmt colorbar -C -DjBL+w6c/0.3c+o0/-2c+h -Bxa0.5+l"Stress Drop (log10 MPa)"

gmt text -F+f18p,0,black+jBL -N << END
136.3 38 (a)P
END

#S波解析結果の出力(静的応力降下量の空間分布)
gmt basemap -JM14 -R136.2/138.3/36.8/38.1 -B1f0.1 -BWSne -X16

gmt makecpt -Cpolar -T0/2.0/0.01  -Z -D

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1 -Glightgreen

awk '{print $4,$3,$6}' S波コーナー周波数_Mjma.txt | gmt plot -C -Sc0.4 -W0.1

gmt colorbar -C -DjBL+w6c/0.3c+o0/-2c+h -Bxa0.5+l"Stress Drop (log10 MPa)"

gmt text -F+f18p,0,black+jBL -N << END
136.3 38 (b)S
END

gmt end
