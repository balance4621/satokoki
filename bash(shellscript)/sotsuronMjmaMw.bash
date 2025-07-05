#! /bin/bash

input_file="Mjma_Mw.txt"

J=-JX5/5
R=-R3/6/3/6

#気象庁マグニチュードとモーメントマグニチュードの関係
gmt begin Mjma_Mw png

gmt basemap $J $R -BWSne -Bxa+l"Mjma" -Bya+l"Mw"

#理論値
gmt plot -W1 << END
3 3
6 6
END

#近似線
gmt plot -W1,dashed << end
3.42315518903 3
6 5.766
end

awk '{print $1, $2}' $input_file | gmt plot -Sc0.1 -Gblack

gmt end
