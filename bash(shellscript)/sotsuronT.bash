#! /bin/bash
input_file="data.txt"
input_file2="data2.txt"

J=-JX12T/4
R=-R2023-12-25T00:00/2024-03-16T00:00/-1/3

gmt begin stressdropT png

gmt psbasemap $J $R \
    -Bxa1o -Bya+l"@~D@~@~s@~ (log@-10@- MPa)" -BWSne \

gmt plot $input_file2 -Sc0.15 -Gblack

gmt text -F+f10p,0,black+jLB -N <<END
2023-12-27T000000 2.6 (a)P
END

gmt psbasemap $J $R \
    -Bxa1o+l"Time" -Bya+l"@~D@~@~s@~ (log@-10@- MPa)" -BWSne -Y-5\

gmt plot $input_file -Sc0.15 -Gblack

gmt text -F+f10p,0,black+jLB -N <<END
2023-12-27T000000 2.6 (b)S
END

gmt end
