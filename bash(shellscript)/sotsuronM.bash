#!/bin/bash

input_file="S_Mjma_.txt"
input_file2="P_Mjma_.txt"

J=-JX5/5
R=-R3/6/-1/3

#静的応力降下量とマグニチュードの関係
gmt begin stressdropM png

#P波
gmt basemap $J $R -B1 -BWSne -Bx+l"Magnitude" -Byaf+l"@~D@~@~s@~ (log@-10@- MPa)" 

awk '{if ($2 >= 3.0 && $2 <= 6.0) print $2, $6, $7}' $input_file2 | gmt plot -Sc0.1 -Gblack -W0.3,black -Ey  #マグニチュード3~6の範囲で

gmt text -F+f10p,0,black+jLB -N <<END
3.1 2.6 (a)P
END

#S波
gmt basemap $J $R -B1 -BWSne -Bx+l"Magnitude" -X6

awk '{if ($2 >= 3.0 && $2 <= 6.0) print $2, $6, $7}' $input_file | gmt plot -Sc0.1 -Gblack -W0.3,black -Ey   #マグニチュード3~6の範囲で

gmt text -F+f10p,0,black+jLB -N <<END
3.1 2.6 (b)S
END

gmt end
