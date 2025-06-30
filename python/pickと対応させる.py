import os

# ディレクトリとファイルのパスを指定
directory = 'picks_M76'
egf_file = 'egf地震2.txt'

# egf地震.txtの内容を読み込む
with open(egf_file, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# 各行の2~11列の値をリスト化
egf_values = [line[20:76].strip().split() for line in lines]

# picks_M76ディレクトリ内のファイルを処理
y = os.listdir(directory)
y = sorted(y)
for filename in y:
    
    filepath = os.path.join(directory, filename)

    # ファイルの内容を確認
    with open(filepath, 'r', encoding='utf-8') as file:
        content = file.readlines()

        
        if content:  # ファイルが空でないことを確認
            last_line = content[-1][4:].strip().split()  # 最後の行の2~11列目を取得

            last_line[5] = last_line[5][:-1]

            # egf地震.txtの各行の2~11列の値と比較
            for i, value in enumerate(egf_values):
                
                if last_line == value:
                    lines[i] = lines[i].strip() + ' ' + filename + '\n'
                   
# egf地震.txtの内容を更新
with open(egf_file, 'w', encoding='utf-8') as f:
    f.writelines(lines)

print("処理が完了しました。")
