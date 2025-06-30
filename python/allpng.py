import os
import shutil

# コピー元のディレクトリ
src_root = "/net/messiah/mnt/sdb/satokoki/result3"

# コピー先のディレクトリ
dst_dir = "/home/satokoki/応力降下/allpng"

os.makedirs(dst_dir, exist_ok=True)


copied = []
skipped = []

for teq in os.listdir(src_root):
    teq_path = os.path.join(src_root, teq)
    if not os.path.isdir(teq_path):
        continue

    for fname in os.listdir(teq_path):
        if fname.endswith(".png"):
            src_file = os.path.join(teq_path, fname)
            dst_file = os.path.join(dst_dir, f"{teq}_{fname}")  # TEQ名付きで保存

            try:
                shutil.copy2(src_file, dst_file)
                copied.append(dst_file)
            except Exception as e:
                skipped.append((src_file, str(e)))

print(f" コピー完了：{len(copied)} 個の PNG ファイルを {dst_dir} に保存しました。")

if skipped:
    print(f" スキップされたファイル：{len(skipped)} 件")
    for path, reason in skipped:
        print(f" - {path}: {reason}")
