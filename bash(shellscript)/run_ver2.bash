#!/bin/bash

list=./egfpair.txt
pickdir=/mnt/sdb/satokoki/noto2024a_pick/
cmp=E

# 仮出力ディレクトリ
if [ ! -d ./out ]; then
    mkdir ./out
  fi

# TEQごとの処理用リスト作成
teq_list=$(awk '{print $1}' $list | while read pickfile1; do
    awk 'NR==1 {print $2}' $pickdir$pickfile1 | cut -c2-13
done | sort | uniq)

# TEQごとに処理
for teq in $teq_list; do
 
    # 該当するEGFペアを全て探す
    awk '{print NR, $1, $2}' $list | while read n pickfile1 pickfile2; do
        winfile1=$(awk 'NR==1 {print $2}' $pickdir$pickfile1 | cut -c2-13)
        winfile2=$(awk 'NR==1 {print $2}' $pickdir$pickfile2 | cut -c2-13)

        if [ "$winfile1" = "$teq" ]; then
           echo "[INFO] TEQ: $teq - EGF: $winfile2"

            cat $pickdir$pickfile1 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' > tmp1
            cat $pickdir$pickfile2 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' >> tmp1

            sort tmp1 | uniq -d | while read stn; do
                sacfile1=$winfile1.$stn.$cmp.sac
                sacfile2=$winfile2.$stn.$cmp.sac

                # スペクトル比計算だけを行う
                bash spratio2.bash $sacfile1 $sacfile2 S
            done

            # 仮ディレクトリに移動
            if [ ! -d /mnt/sdb/satokoki/resultS2/$winfile1"_"$winfile2 ]; then
		mkdir /mnt/sdb/satokoki/resultS2/$winfile1"_"$winfile2
            fi

            mv ./out/ /mnt/sdb/satokoki/resultS2/$winfile1"_"$winfile2/
        fi
    done


   # echo "[INFO] 図を描画中 TEQ: $teq"
    bash drawwave2.bash $teq S

done

#echo "[INFO] 全処理完了"

