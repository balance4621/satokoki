import os

# 調べたいディレクトリのパスを指定
directory = '/home/satokoki/応力降下/png_files'

# ディレクトリ内のファイルの個数をカウント
file_count = len([file for file in os.listdir(directory) if os.path.isfile(os.path.join(directory, file))])

# 結果を表示
print(f"{directory} 内のファイル数: {file_count}")
