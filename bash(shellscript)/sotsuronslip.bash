#! /bin/bash


gmt begin slip png

gmt set FORMAT_GEO_MAP D
#gmt set MAP_FRAME_TYPE plain

gmt set FONT_ANNOT_PRIMARY 20p
gmt set FONT_LABEL 20p

# 余震分布
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne

gmt makecpt -Cjet -T0/20/1 -Z -D -I

awk '{print $5,$4,$6}' 震源カタログ2.txt | gmt plot -C -Sc0.1

gmt coast -LjBR+c36+w50k+l+f+o0c/-2c -Dh -W1

#基準線
gmt plot -W3 << end
136.8 37.35
136.6 37.05
end

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (a)
END


gmt colorbar -C -DjBL+w6c/0.5c+o0/-2c+h -Bxa10+l"Depth (km)"


# すべり分布
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne -X15.5

gmt image sotsurinslip2.png -Dx0/0+w14c

#基準線(すべり域内)
gmt plot -W3.5,blue << end
136.8 37.35
136.721 37.23
end

#基準線(すべり域外)
gmt plot -W3.5,black << end
136.721 37.23
136.6 37.05
end

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (b)
END

#基準線から±5km内にある余震の深さ分布
gmt basemap -JX20/-6 -R0/40/0/25 -Bx10f1+l"Distance (km)" -By5f1+l"Depth (km)" -BWSne -X-10 -Y-17

awk '{print $4,$3}' danmen3.txt | gmt plot -Sc0.1 -Gblue

awk '{print $4 + 15.0504055906 ,$3}' danmen4.txt | gmt plot -Sc0.1 -Gblack

gmt text -F+f20p,0,black+jLB -N << END
1 -25 (c)
END

#基準線から±5km内にある余震のヒストグラム
gmt basemap -JX20/6 -R0/40/0/50 -Bx10f1 -Byaf+l"Number" -BWSne -Y6.9

awk '{print $4}' danmen2.txt | gmt histogram -T1 -W2,black -Z0

gmt text -F+f20p,0,black+jLB -N << END
1 -15 (d)
END

gmt end
