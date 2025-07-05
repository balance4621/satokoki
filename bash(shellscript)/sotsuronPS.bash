#! /bin/bash

input_file="stressdropP_S.txt"

J=-JX5/5
R=-R-1/3/-1/3

#P波解析とS波解析の結果の比較
gmt begin stressdropP_S png

gmt basemap $J $R -BWSne -Bxa+l"Pwave @~D@~@~s@~ (log@-10@- MPa)" -Bya+l"Swave @~D@~@~s@~ (log@-10@- MPa)"

gmt plot -W1 << END
-1 -1
3 3
END

awk '{print $1, $2}' $input_file | gmt plot -Sc0.1 -Gblack

gmt end
