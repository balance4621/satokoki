#!/bin/bash

# 入力ファイル
input_file="SflagM0_fc2.txt"
input_file2="PflagM0_fc2.txt"

J=-JX5l/5l
R=-R0.1/100/100000000000000/1000000000000000000

#地震モーメントとコーナー周波数の関係
gmt begin fc_M0 png

#P波
gmt basemap $J $R -BWSne -Bxa1f2+l"fc (Hz)" -Byaf+l"M0 (Nm)"

awk '{print $2, $1}' $input_file2 | gmt plot -Sc0.1 -Gred -W0.3,black

#1MPaの時
gmt plot -W1p,dashed << end
2.91 1.0e+14
1.35e-01 1.0e+18
end

#10MPaの時
gmt plot -W1p,dashed << end
6.26 1.0e+14
2.91e-01 1.0e+18
end

#100MPaの時
gmt plot -W1p,dashed << end
1.35e+01 1.0e+14
6.26e-01 1.0e+18
end

#S波
gmt basemap $J $R -B1 -BWSne -Bxa1f2+l"fc (Hz)" -X6.5

awk '{print $2, $1}' $input_file | gmt plot -Sc0.1 -Gred -W0.3,black

#1MPaの時
gmt plot -W1p,dashed << end
1.91 1.0e+14
8.58e-02 1.0e+18
end

#10MPaの時
gmt plot -W1p,dashed << end
4.11 1.0e+14
1.91e-01 1.0e+18
end

#100MPaの時
gmt plot -W1p,dashed << end
8.55 1.0e+14
4.11e-01 1.0e+18
end
#gmt text -F+f20p,0,black+jLB -N <<END
#3.1 2.6 (b)S
#END

gmt end
