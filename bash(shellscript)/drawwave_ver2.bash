#!/bin/bash

#TEQ地震ごとに図を書く
phase="S"
basedir="/net/messiah/mnt/sdb/satokoki/result3"

for teqdir in "$basedir"/*; do
    [ -d "$teqdir" ] || continue
    teq=$(basename "$teqdir")
    outdir="$teqdir"

    echo "[描画中] $teq"

    # 出力画像のファイル名
    gmt begin "$outdir/spectral_ratio_all_${teq}" png

    # 図のサイズと軸設定
    J=-JX5l/5
    R=-R0.1/26/-1/4
    gmt basemap $J $R -Bxa1f3p -Byaf -BWSne -Bx+l"Frequency (Hz)"

    # lsqmin ファイルを元に egf を自動で判定
    hairetu=($outdir/lsqmin.${teq}*.${phase}.ave)
    for lsqfile in "${hairetu[@]}"; do
        [ -f "$lsqfile" ] || continue

        fname=$(basename "$lsqfile")
        egf=$(echo "$fname" | sed -e "s/lsqmin.//" -e "s/.${phase}.ave//")

        ratio1=$outdir/ratio1.$egf.$phase.ave
        ratio2=$outdir/ratio2.$egf.$phase.ave
        ratio3=$outdir/ratio3.$egf.$phase.ave
        lsqsyn=$outdir/lsqsyn.$egf.$phase.ave

        if [ ! -e $ratio1 ] || [ ! -e $ratio2 ] || [ ! -e $ratio3 ] || [ ! -e $lsqsyn ]; then
            echo "[スキップ] ファイル不足: $egf"
            continue
        fi

        awk '$1>=0.5 && $1<=20 {print}' $ratio1 | gmt plot -W1,gray
        awk '$1>=0.5 && $1<=20 {print}' $ratio2 | gmt plot -W1,gray
        awk '$1>=0.5 && $1<=20 {print}' $ratio3 | gmt plot -W1,gray
    done

    gmt end
done

echo "✅ 全TEQの描画完了 (/net/messiah/mnt/sdb/satokoki/result3)"

