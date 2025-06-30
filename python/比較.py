# ファイルのパスを指定
file1 = 'egfpair.txt'  # egfpair.txtのパス
file2 = 'egfpair2.txt'  # egfpair2.txtのパス
output_file = 'added_pairs.txt'  # 出力ファイルのパス

# ファイルからペアを読み込みセットに格納
def load_pairs(file_path):
    pairs = set()
    with open(file_path, 'r') as f:
        for line in f:
            pair = tuple(line.strip().split('\t'))  # タブ区切りのペアを読み込む
            pairs.add(pair)
    return pairs

# ファイルからペアを読み込む
pairs1 = load_pairs(file1)  # egfpair.txtからペアを読み込む
pairs2 = load_pairs(file2)  # egfpair2.txtからペアを読み込む

# egfpair.txtに追加されたペアを取得 (egfpair.txtにあってegfpair2.txtにないペア)
added_pairs = pairs1 - pairs2

# 結果を新しいファイルに書き込む
with open(output_file, 'w') as f:
    for pair in added_pairs:
        f.write(f"{pair[0]}\t{pair[1]}\n")

print(f"追加されたペアが{output_file}に書き込まれました。")
