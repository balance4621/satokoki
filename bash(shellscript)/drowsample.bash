#! /bin/bash


teq=240101.161216.000
phase=S
egfs=("240204.034638.000" "240212.193512.000")
resultroot=/mnt/sdb/satokoki/resultScoda
outdir=./merged_out
figs=$outdir/${teq}_multi.$phase.figs
yloc=0.03

mkdir -p $outdir

# 必要な TEQ 波形ファイルをコピー
cp $resultroot/${teq}_${egfs[0]}/out/${teq}.${phase}.wave $outdir/
cp $resultroot/${egfs[0]}_${egfs[0]}/out/${teq}.${phase}.tw* $outdir/
cp $resultroot/${egfs[0]}_${egfs[0]}/out/${teq}.${phase}.twn $outdir/

filew=$outdir/$teq.$phase.wave
file1=$outdir/$teq.$phase.tw1
file2=$outdir/$teq.$phase.tw2
file3=$outdir/$teq.$phase.tw3
filen=$outdir/$teq.$phase.twn

# 最大・最小スケールの取得
max=`cat $filew | awk '{if(m<$2*1e6) m=$2*1e6*1.1} END {print m}'`
min=`cat $filew | awk 'BEGIN{m=10000}{if(m>$2*1e6) m=$2*1e6*1.4} END {print m}'`

gmt begin $figs png

# 波形描画
J=-JX8/4
R=-R0/100/$min/$max
gmt basemap $J $R -Bxaf+l"Time (s)" -Byaf+l"Velocity (10^-6 m/s)" -BWSne -Y15
awk '{print $1,$2*1e6}' $filew | gmt plot -W0.5
R1=-R0/100/0/1
gmt basemap $J $R1 -BWSne
awk -v yloc=$yloc '{print $1,yloc*3}' $file1 | gmt plot -W1,red
awk -v yloc=$yloc '{print $1,yloc*2}' $file2 | gmt plot -W1,blue
awk -v yloc=$yloc '{print $1,yloc*1}' $file3 | gmt plot -W1,green
awk -v yloc=$yloc '{print $1,yloc*3}' $filen | gmt plot -W1,gray
gmt text -F+f10p,0,black+jLB -N << END
0 1.1 TEQ $teq
END

# スペクトル比描画
J=-JX5l/5
R3=-R0.1/26/-1/4
gmt basemap $J $R3 -Bxa1f3p -Byaf -BWSne -Bx+l"Frequency (Hz)" -Y-7 -X-10

for egf in "${egfs[@]}"; do
    sourcedir=$resultroot/${teq}_${egf}/out

    ratio1ave=$sourcedir/"ratio1".$teq"_"$egf.$phase."ave"
    ratio2ave=$sourcedir/"ratio2".$teq"_"$egf.$phase."ave"
    ratio3ave=$sourcedir/"ratio3".$teq"_"$egf.$phase."ave"
    lsqsyn=$sourcedir/"lsqsyn".$teq"_"$egf.$phase."ave"
    lsqmin=$sourcedir/"lsqmin".$teq"_"$egf.$phase."ave"

    [ -e $lsqmin ] || continue

    awk '$1>=0.5&&$1<=20{print}' $ratio1ave | gmt plot -W0.5,red
    awk '$1>=0.5&&$1<=20{print}' $ratio2ave | gmt plot -W0.5,blue
    awk '$1>=0.5&&$1<=20{print}' $ratio3ave | gmt plot -W0.5,green
    gmt plot -W0.5,black $lsqsyn

    fc_teq=$(awk '{print $2}' $lsqmin)
    fc_egf=$(awk '{print $3}' $lsqmin)
    gmt plot -W0.3,gray << END
$fc_teq 0
$fc_teq 2
END
    gmt plot -W0.3,gray << END
$fc_egf 0
$fc_egf 2
END
done

gmt end

