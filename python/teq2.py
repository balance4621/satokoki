import os
import shutil

# 設定
source_root = '/mnt/sdb/satokoki/resultScoda'
destination_dir = '/mnt/sdb/satokoki/resultteq/240101.161216'
target_teq = '240101.161216'

# 保存先ディレクトリ作成
os.makedirs(destination_dir, exist_ok=True)

# 操作
for folder_name in os.listdir(source_root):
    folder_path = os.path.join(source_root, folder_name)

    if not os.path.isdir(folder_path):
        continue

    teq_part = folder_name.split('_')[0]
    if teq_part == target_teq:
        out_path = os.path.join(folder_path, 'out')
        if os.path.isdir(out_path):
            for item in os.listdir(out_path):
                src = os.path.join(out_path, item)
                dst = os.path.join(destination_dir, item)

                # 同名ファイル・フォルダがあるかをチェックして対処（上書き or 改名）
                if os.path.exists(dst):
                    base, ext = os.path.splitext(item)
                    counter = 1
                    while os.path.exists(dst):
                        new_name = f"{base}_{counter}{ext}"
                        dst = os.path.join(destination_dir, new_name)
                        counter += 1

                if os.path.isdir(src):
                    shutil.copytree(src, dst)
                else:
                    shutil.copy2(src, dst)

            print(f"Copied from {out_path} to {destination_dir}")
        else:
            print(f"Skipped (no 'out'): {folder_path}")

print("完了")
