import os

# .chファイルがあるディレクトリのパス
directory = '/home/satokoki/noto2024a_win'
winprm = '/home/satokoki/winprm/win.prm'
prmfile = '/home/satokoki/winprm/win2.prm'
betsu = '/home/satokoki/winprm/chate.ch'




# .chファイルを処理
for filename in os.listdir(directory):
    if filename.endswith(".ch"):
        if filename [0:2] != '._':

            file_path = os.path.join(directory, filename)
            # .chを抜いたファイル名
            base_name =directory + '/' + filename.replace(".ch", "")

            sacdir = '/home/satokoki/notosac/' + filename
            if os.path.isdir(sacdir) == False:
                os.mkdir(sacdir)

 

                
            with open (betsu, 'w') as chate:
                    

                
                with open(file_path, 'r') as file:
                    read = file.readlines()
                    
                    
                    for j in read:
                        read2 = j[:4].lower() + j[4:]

                        if read2[9:15] == "KU.Not":
                            read2 = read2[0:15] + read2[16:]
                        

                        chate.write(read2)

            



                    # ファイル内の各行を処理
            with open (betsu, 'r') as chate2:
                chate_2 = chate2.readlines()
                for line in chate_2:
                    # 各行の一列目を取得
                    first_column = line.strip().split()[0]



                    with open (winprm, 'w') as winp :
                        winp.write( '.' + '\n' + base_name + '.ch' + '\n' + '.' + '\n' + '.') 

                  
                    
                    os.system (f'win2sac_32 {base_name} {first_column} sac {sacdir} -p{prmfile}')
                
