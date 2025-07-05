#! /bin/bash

#図の作成
teq=$1
egf=$2
phase=$3

winfile1=`echo $teq | cut -b 1-13`
winfile2=`echo $egf | cut -b 1-13`

outdir=./out
yloc=0.03

figs=$outdir/$teq"_"$egf.$phase.figs

filew=$outdir/$teq.$phase.wave
file1=$outdir/$teq.$phase.tw1
file2=$outdir/$teq.$phase.tw2
file3=$outdir/$teq.$phase.tw3
filen=$outdir/$teq.$phase.twn
spf11=$outdir/"sp".$teq.$phase"1"
spf12=$outdir/"sp".$teq.$phase"2"
spf13=$outdir/"sp".$teq.$phase"3"
spf1n=$outdir/"sp".$teq.$phase"n"

file2w=$outdir/$egf.$phase.wave
file21=$outdir/$egf.$phase.tw1
file22=$outdir/$egf.$phase.tw2
file23=$outdir/$egf.$phase.tw3
file2n=$outdir/$egf.$phase.twn
spf21=$outdir/"sp".$egf.$phase"1"
spf22=$outdir/"sp".$egf.$phase"2"
spf23=$outdir/"sp".$egf.$phase"3"
spf2n=$outdir/"sp".$egf.$phase"n"

ratio1=$outdir/"ratio1".$teq"_"$egf.$phase
ratio2=$outdir/"ratio2".$teq"_"$egf.$phase
ratio3=$outdir/"ratio3".$teq"_"$egf.$phase
ratio1ave=$outdir/"ratio1".$teq"_"$egf.$phase."ave"
ratio2ave=$outdir/"ratio2".$teq"_"$egf.$phase."ave"
ratio3ave=$outdir/"ratio3".$teq"_"$egf.$phase."ave"

lsqmin=$outdir/"lsqmin".$teq"_"$egf.$phase."ave"
lsqres=$outdir/"lsqres".$teq"_"$egf.$phase."ave"
lsqsyn=$outdir/"lsqsyn".$teq"_"$egf.$phase."ave"

# 解析結果がない場合は中断する
if [ ! -e $lsqmin ]; then
  exit
fi

max=`cat $filew | awk '{if(m<$2*1e6) m=$2*1e6*1.1} END {print m}'`
min=`cat $filew | awk 'BEGIN{m=10000}{if(m>$2*1e6) m=$2*1e6*1.4} END {print m}'`
max2=`cat $file2w | awk '{if(m<$2*1e6) m=$2*1e6*1.1} END {print m}'`
min2=`cat $file2w | awk 'BEGIN{m=10000}{if(m>$2*1e6) m=$2*1e6*1.4} END {print m}'`
echo $egf
gmt begin $figs png

# TEQ地震の波形
J=-JX8/4
R=-R0/32/$min/$max

gmt basemap $J $R -Bxaf+l"Time (s)" -Byaf+l"Velocity (\32710@+-6@+ m/s)" -BWSne -Y15
awk '{print $1,$2*1e6}' $filew | gmt plot -W0.5

R1=-R0/32/0/1
gmt basemap $J $R1 -BWSne
awk -v yloc=$yloc '{print $1,yloc*3}' $file1 | gmt plot -W1,red
awk -v yloc=$yloc '{print $1,yloc*2}' $file2 | gmt plot -W1,blue
awk -v yloc=$yloc '{print $1,yloc*1}' $file3 | gmt plot -W1,green
awk -v yloc=$yloc '{print $1,yloc*3}' $filen | gmt plot -W1,gray
gmt text -F+f10p,0,black+jLB -N << END
0 1.1 TEQ $teq
END

# EGF地震の波形
R=-R0/32/$min2/$max2
gmt basemap $J $R -Bxaf+l"Time (s)" -Byaf+l"Velocity (\32710@+-6@+ m/s)" -BWSne -Y-6
awk '{print $1,$2*1e6}' $file2w | gmt plot -W0.5

R1=-R0/32/0/1
gmt basemap $J $R1 -Bwsne
awk -v yloc=$yloc '{print $1,yloc*3}' $file21 | gmt plot -W1,red
awk -v yloc=$yloc '{print $1,yloc*2}' $file22 | gmt plot -W1,blue
awk -v yloc=$yloc '{print $1,yloc*1}' $file23 | gmt plot -W1,green
awk -v yloc=$yloc '{print $1,yloc*3}' $file2n | gmt plot -W1,gray
gmt text -F+f10p,0,black+jLB -N << END
0 1.1 EGF $egf
END

# TEQ地震のスペクトル
J=-JX3l/4l
R2=-R0.1/26/1e-12/1e-2
gmt basemap $J $R2 -Ba1f3p -Bx+l"Frequency (Hz)" -Byaf+l"Displacement amplitude (m)"  -BWSne  -Y6 -X10
awk '{print $1,$3}' $spf11 | gmt plot -W1,red
awk '{print $1,$3}' $spf12 | gmt plot -W1,blue
awk '{print $1,$3}' $spf13 | gmt plot -W1,green
awk '{print $1,$3}' $spf1n | gmt plot -W1,gray

# EGF地震のスペクトル
gmt basemap $J $R2 -Ba1f3p -Bx+l"Frequency (Hz)" -Byaf+l"Displacement amplitude (m)" -BWSne -Y-6
awk '{print $1,$3}' $spf21 | gmt plot -W1,red
awk '{print $1,$3}' $spf22 | gmt plot -W1,blue
awk '{print $1,$3}' $spf23 | gmt plot -W1,green
awk '{print $1,$3}' $spf2n | gmt plot -W1,gray

# スペクトル比
J=-JX5l/5
R3=-R0.1/26/-1/4
gmt basemap $J $R3 -Bxa1f3p -BWSne -Bx+l"Frequency (Hz)" -Byaf+l"log(Spectral ratio)" -Y-7 -X-10
awk '$1>=0.5&&$1<=20{print}' $ratio1ave | gmt plot -W1,red
awk '$1>=0.5&&$1<=20{print}' $ratio2ave | gmt plot -W1,blue
awk '$1>=0.5&&$1<=20{print}' $ratio3ave | gmt plot -W1,green
gmt plot -W0.5,black $lsqsyn
fc_teq=`cat $lsqmin | awk '{print $2}'`
fc_egf=`cat $lsqmin | awk '{print $3}'`
mo_rat=`cat $lsqmin | awk '{print $1}'`
gmt plot -W0.3 << END
$fc_teq 0
$fc_teq 2
END
gmt plot -W0.3 << END
$fc_egf 0
$fc_egf 2
END

J=-JX5/5
R=-R0/1/0/1
gmt set MAP_FRAME_PEN 1,white
gmt basemap $J $R -X7 -Bne
gmt text -F+f12p,0,black+jLB -N << END
0 0.9 moment ratio $mo_rat
0 0.8 fc_teq $fc_teq
0 0.7 * fc_egf $fc_egf
END

#gmt end show
gmt end
