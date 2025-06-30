import os
import shutil

source_root = '/mnt/sdb/satokoki/resultS3'
destination_root = '/net/messiah/mnt/sdb/satokoki/result3'

# エラー記録用
errors = []

# TEQ_EGF ディレクトリ
for entry in os.listdir(source_root):
    teq_egf_path = os.path.join(source_root, entry)
    if not os.path.isdir(teq_egf_path):
        continue

    if '_' not in entry:
        #print(f"[スキップ] フォーマット不正: {entry}")
        continue

    teq = entry.split('_')[0]
    src_out_dir = os.path.join(teq_egf_path, "out")
    if not os.path.isdir(src_out_dir):
        #print(f"[スキップ] out ディレクトリが存在しません: {src_out_dir}")
        continue

    dest_dir = os.path.join(destination_root, teq)
    os.makedirs(dest_dir, exist_ok=True)

    # outの中身を1ファイルずつコピー（同名はリネーム）
    for fname in os.listdir(src_out_dir):
        src_file = os.path.join(src_out_dir, fname)
        dst_file = os.path.join(dest_dir, fname)

        if not os.path.isfile(src_file):
            continue

        # ファイル名が重複する場合はリネーム
        if os.path.exists(dst_file):
            base, ext = os.path.splitext(fname)
            counter = 1
            while True:
                new_fname = f"{base}_{counter}{ext}"
                dst_file = os.path.join(dest_dir, new_fname)
                if not os.path.exists(dst_file):
                    break
                counter += 1

        try:
            shutil.copy2(src_file, dst_file)
        except Exception as e:
            errors.append((src_file, dst_file, str(e)))
            print(f"[エラー] {src_file} → {dst_file}: {e}")

    print(f"[完了] {entry} → {dest_dir}")

print(" すべてのコピー処理が終了しました。")

if errors:
    print(f"\n エラーが {len(errors)} 件あります。内容を確認してください。")
