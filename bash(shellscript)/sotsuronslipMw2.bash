#! /bin/bash

#モーメントマグニチュードver
gmt begin slipMw3 png

gmt set FORMAT_GEO_MAP D
gmt set FONT_ANNOT_PRIMARY 20p
gmt set FONT_LABEL 20p

# P波解析
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne

gmt makecpt -Cpolar -T0/2.0/0.01 -Z -D

gmt image sotsurinslip2.png -Dx0/0+w14c

awk '{print $2,$1,$3}' Pflag_kuukan.txt | gmt plot -C -Sc0.24 -W0.2

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (a)P
END

#gmt colorbar -C -DjBL+w6c/0.3c+o0/-2c+h -Bxa0.5+l"@~D@~@~s@~ (log@-10@- MPa)"


#S波解析
gmt basemap -JM14 -R136/138.5/36.5/38.2 -B1f0.1 -BWSne -Y-13.2

gmt image sotsurinslip2.png -Dx0/0+w14c

gmt makecpt -Cpolar -T0/2.0/0.01 -Z -D

awk '{print $2,$1,$3}' Sflag_kuukan.txt | gmt plot -C -Sc0.24 -W0.2

gmt text -F+f20p,0,black+jLB -N << END
136.02 38.1 (b)S
END

gmt colorbar -C -DjBL+w6c/0.3c+o0/-2c+h -Bxa0.5+l"@~D@~@~s@~ (log@-10@- MPa)"

gmt end
