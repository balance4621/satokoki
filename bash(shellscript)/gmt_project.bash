#! /bin/bash
#緯度経度深さを別のファイルに保存(基準から±5kmのみ)
awk '{print $5,$4,$6}' 震源カタログ2.txt | gmt project -C136.8/37.35 -E136.714/37.22 -W-5/5 -Lw -Q > danmen3.txt
