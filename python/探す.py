# ファイルを読み込む
with open('egfpair.txt', 'r') as file1, open('egfpair2.txt', 'r') as file2:
    lines1 = set(file1.readlines())
    lines2 = set(file2.readlines())

# 差分を抽出
unique_lines = lines1 - lines2

# 結果を表示
for line in sorted(unique_lines):
    print(line.strip())
