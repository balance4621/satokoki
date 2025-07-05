#!/bin/bash

# 入力ファイル
input_file="EGFnumber.txt"
input_file2="distancenumber.txt"

J=-JX5/5

gmt begin EGFdistance png

#P波震源距離
gmt basemap $J -R-0/6/0/150 -BWSne -Bxa1+l"EGF number" -Bya20f+l"Frequency"

awk '{print $1}' $input_file | gmt histogram -T1 -W -Z

gmt text -F+f12p,0,black+jLB -N <<END
0.3 130 (a)
END

#S波震源距離
gmt basemap $J -R-0.05/1.05/0/100 -BWSne -Bxa0.2+l"Distance (km)" -Bya20f -X6

awk '{print $1}' $input_file2 | gmt histogram -T0.1 -W -Z

gmt text -F+f12p,0,black+jLB -N <<END
0 85 (b)
END

gmt end
