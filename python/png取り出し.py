import os
import shutil

# 元のディレクトリ
source_dir = '/net/messiah/mnt/sdb/satokoki/result3'  
# PNGファイルを保存する新しいディレクトリ
target_dir = '/home/satokoki/応力降下/result3'  

# ディレクトリが存在しない場合は作成
if not os.path.exists(target_dir):
    os.makedirs(target_dir)

# resultsディレクトリ内のサブディレクトリを探索
for root, dirs, files in os.walk(source_dir):
    for file in files:
        if file.endswith('.png'):  # PNGファイルをチェック
            # PNGファイルのフルパスを作成
            full_file_path = os.path.join(root, file)
            # ファイルをターゲットディレクトリにコピー
            shutil.copy(full_file_path, target_dir)

print(f"PNGファイルのコピーが完了しました。{target_dir}にすべてのPNGが保存されました。")
