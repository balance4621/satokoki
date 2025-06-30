zishin = '使う地震一覧.txt'
dat = '震源カタログ.txt'
kakikomi = 'datfileと結合.txt'


with open(zishin, 'r', encoding='utf-8') as zishindata, open(dat, 'r', encoding='utf-8') as datdata, open(kakikomi, 'w', encoding='utf-8') as kakikomidata:
    lines1 = zishindata.readlines()
    lines2 = datdata.readlines()


    for i in range(0,len(lines1)):                           #zishinを上から書いてく
        
        lines1split = lines1[i].strip().split()              #列ごとに区切る

        zido = float(lines1split[7])                #気象庁緯度
        zkeido = float(lines1split[8])              #気象庁経度
        zhukasa = float(lines1split[9])             #気象庁深さ
        zmg = float(lines1split[10])                #気象庁Mg


        for j in range(1,len(lines2)):
            lines2split = lines2[j].strip().split()

            dido = float(lines2split[3])             #dat緯度
            dkeido = float(lines2split[4])           #dat経度
            dhukasa = float(lines2split[5])          #dat深さ
            dmg = float(lines2split[6])              #datMg

            if zido == dido and zkeido == dkeido and zhukasa == dhukasa and zmg == dmg:
                kakikomidata.write(lines1[i][:-1] + "\t" + lines2split[7] + "\n")