import os

# 調べたいディレクトリ
directory_path = '/mnt/sdb/satokoki/noto2024a_win/'

# ディレクトリ内のファイルをループ
for filename in os.listdir(directory_path):
    # .chファイルのみを対象
    if filename.endswith('.ch') and filename.startswith("T"):

        file_path = os.path.join(directory_path, filename)
        
        # ファイルを読み込み "○○○○" を含むかを確認
        with open(file_path, 'r') as file:
           for line in file:
                columns = line.split()  # 分割
                if len(columns) >= 4 and columns[3] == 'E.UKWM':  # 4列目が '○○○○' かを確認
                    print(filename)
                    break  # 該当ファイルが見つかれば次のファイルへ
