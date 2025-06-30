# ファイル名の指定
input_file = 'added_pairs.txt'  # 読み込むファイル
output_file = 'added.txt'  # 書き込むファイル

# ファイルを読み込み、ペアをリストに格納
pairs = []
with open(input_file, 'r') as f:
    for line in f:
        if line.strip():
            
            parts = line.strip().split('\t')
            if len(parts) == 2:
                left_value = parts[0].strip()
                right_value = parts[1].strip()

                # 左側の値の最初の2つの部分を結合して数値として扱う
                try:
                    # 最初の2つの部分を結合
                    left_numeric = '.'.join(left_value.split('.')[:2])
                    float(left_numeric)  # 左側の値を浮動小数点数に変換して確認
                    pairs.append((left_value, right_value))
                except ValueError:
                    print(f"無効な左側の数字: {left_value}")  # 問題のある値を表示

# 左側の数字を基準にペアをソート
pairs.sort(key=lambda x: float('.'.join(x[0].split('.')[:2])))  # 左側の最初の2つの部分を使う

# ソートしたペアを新しいファイルに書き込み
with open(output_file, 'w') as f:
    for pair in pairs:
        f.write(f"{pair[0]}\t{pair[1]}\n")

print(f"ペアを{output_file}に左側の数字で昇順に並び替えました。")
