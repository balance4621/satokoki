import os

# ディレクトリとファイルのパスを指定
directory = 'noto2024a_pick'
dat_file = 'datfileと結合.txt'
pick_file = 'pickと対応.txt'

# dat_fileの内容を読み込む
with open(dat_file, 'r', encoding='utf-8') as f, open(pick_file, 'w', encoding='utf-8') as g:
    lines = f.readlines()

    for i in range(0,len(lines)):

        linessplit = lines[i].strip().split()      

        datname = str(linessplit[12])

        # picks_M76ディレクトリ内のファイルを処理
        y = os.listdir(directory)
        y = sorted(y)
        for filename in y:
            
            filepath = os.path.join(directory, filename)

            # ファイルの内容を確認
            with open(filepath, 'r', encoding='utf-8') as file:
                line = file.readlines()

                a = line[0][3:20]

                if datname == a:
                    g.writelines(lines[i][:-1] + "\t" + filename + "\n")





        

        
        
                   

