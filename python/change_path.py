from pathlib import Path
import shutil
from datetime import datetime

# 入出力ディレクトリの定義
input_dir = Path("/home/satokoki/notosac")
output_dir = Path("/home/satokoki/notosac2")
output_dir.mkdir(parents=True, exist_ok=True)

# 入力ディレクトリ内のファイルを処理
for sac_filepath in input_dir.glob("*/*"):
    sac_name = sac_filepath.name
    sac_dirname = sac_filepath.parent.name[1:13]  # ディレクトリ名からタイムスタンプ部分を抽出
    win_dirname = datetime.strptime(sac_dirname, "%y%m%d%H%M%S")
    out_filename = f'{win_dirname.strftime("%y%m%d.%H%M%S")}.{sac_name}'
    
    # 出力ファイルパス
    out_path = output_dir / out_filename
    shutil.copy(sac_filepath, out_path)
