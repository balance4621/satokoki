#! /bin/bash

list=./egfpair.txt
pickdir=/mnt/sdb/satokoki/noto2024a_pick/
n=1
nmax=`wc ./egfpair.txt | awk '{print $1}'`

while [ $n -ne $nmax ]
do

  pickfile1=`awk '{if (NR=='$n') print $1}' $list`
  pickfile2=`awk '{if (NR=='$n') print $2}' $list`
  cmp=E

  # pickfile1とpickfile2のタイムスタンプを抽出して変換する関数
  extract_timestamp() {
      local file_content
      file_content=$(awk 'NR==1 {print $2}' "$1")
      echo "${file_content:1:6}.${file_content:7:6}"
  }

  # ファイルからタイムスタンプを取得
  winfile1=$(extract_timestamp "$pickdir$pickfile1")
  winfile2=$(extract_timestamp "$pickdir$pickfile2")

  #echo $winfile1 $winfile2

  cat $pickdir$pickfile1 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' > tmp1
  cat $pickdir$pickfile2 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' >> tmp1

  # 結果の仮出力ディレクトリー
  if [ ! -d ./out ]; then
    mkdir ./out
  fi

  if [ ! -d /mnt/sdb/satokoki/results/$winfile1"_"$winfile2 ]; then
    mkdir /mnt/sdb/satokoki/results/$winfile1"_"$winfile2
  fi


  sort tmp1 | uniq -d | while read stn; do

  sacfile1=$winfile1.$stn.$cmp.sac
  sacfile2=$winfile2.$stn.$cmp.sac

  #echo $sacfile1 $sacfile2

  bash spratio2.bash $sacfile1 $sacfile2 P
  bash spratio2.bash $sacfile1 $sacfile2 S
  #bash spratio2.2.bash $sacfile1 $sacfile2 P
  #bash spratio2.2.bash $sacfile1 $sacfile2 S

  bash drawwave.bash $sacfile1 $sacfile2 P
  bash drawwave.bash $sacfile1 $sacfile2 S

  done

  #結果の保存：ディレクトリーの移動
    mv ./out /mnt/sdb/satokoki/results/$winfile1"_"$winfile2

        n=`expr 1 + $n`
    done

pickfile1=`awk '{if (NR=='$n') print $1}' $list`
pickfile2=`awk '{if (NR=='$n') print $2}' $list`
cmp=E

# pickfile1とpickfile2のタイムスタンプを抽出して変換する関数
extract_timestamp() {
    local file_content
    file_content=$(awk 'NR==1 {print $2}' "$1")
    echo "${file_content:1:6}.${file_content:7:6}"
}

# ファイルからタイムスタンプを取得
winfile1=$(extract_timestamp "$pickdir$pickfile1")
winfile2=$(extract_timestamp "$pickdir$pickfile2")

#echo $winfile1 $winfile2

cat $pickdir$pickfile1 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' > tmp1
cat $pickdir$pickfile2 | /usr/local/win/bin/seis | awk 'NR>=2 {print $1}' >> tmp1

# 結果の仮出力ディレクトリー
if [ ! -d ./out ]; then
  mkdir ./out
fi

if [ ! -d /mnt/sdb/satokoki/results/$winfile1"_"$winfile2 ]; then
  mkdir /mnt/sdb/satokoki/results/$winfile1"_"$winfile2
fi


sort tmp1 | uniq -d | while read stn; do

sacfile1=$winfile1.$stn.$cmp.sac
sacfile2=$winfile2.$stn.$cmp.sac

#echo $sacfile1 $sacfile2

bash spratio2.bash $sacfile1 $sacfile2 P
bash spratio2.bash $sacfile1 $sacfile2 S
#bash spratio2.2.bash $sacfile1 $sacfile2 P
#bash spratio2.2.bash $sacfile1 $sacfile2 S

bash drawwave.bash $sacfile1 $sacfile2 P
bash drawwave.bash $sacfile1 $sacfile2 S

done

#結果の保存：ディレクトリーの移動
  mv ./out /mnt/sdb/satokoki/results/$winfile1"_"$winfile2
