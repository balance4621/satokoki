#! /bin/bash

input_file="S_Mjma_.txt"
input_file2="P_Mjma_.txt"

J=-JX5/5
R=-R0/25/-1/3

#静的応力降下量と深さの関係
gmt begin stressdropD png

#P波
gmt basemap $J $R -BWSne -Bxa5+l"Depth (km)" -Bya+l"@~D@~@~s@~ (log@-10@- MPa)"

awk '{print $5, $6, $7}' $input_file2 | gmt plot -Sc0.1 -Gblack -W0.3,black -Ey

gmt text -F+f10p,0,black+jLB -N <<END
1.0 2.6 (a)P
END

#S波
gmt basemap $J $R -BWSne -Bxa5+l"Depth (km)" -Bya1 -X6

awk '{print $5, $6, $7}' $input_file | gmt plot -Sc0.1 -Gblack -W0.3,black -Ey

gmt text -F+f10p,0,black+jLB -N <<END
1.0 2.6 (b)S
END

gmt end
