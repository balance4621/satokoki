from geopy.distance import geodesic

# 使用ファイル
noto_file = 'pickと対応使う地震一覽.txt'
teq_file = 'teq地震.txt'
egf_file = 'egf地震.txt'


# 読み込むやつと書き込むやつを開いておく
with open(teq_file, 'r', encoding='utf-8') as teqdata, open(noto_file, 'r', encoding='utf-8') as notodata, open(egf_file, 'w', encoding='utf-8') as egfdata:
    lines1 = teqdata.readlines()
    lines2 = notodata.readlines()
    
   
    for i in range(0,len(lines1)):    #teq地震を上から順に書いていく
        egfdata.write(lines1[i])
        lines1split = lines1[i].strip().split()      #情報をカンマで区切る[YYMMDD,HHMMSS,緯度,経度,深さ...]みたいに
        

        teqinf1 = float(lines1split[7])      #teq地震の緯度
        teqinf2 = float(lines1split[8])      #teq地震の経度
        teqinf3 = float(lines1split[9])      #twq地震の深さ

        for j in range(0,len(lines2)):          #notoの全地震をループさせてく
            lines2split = lines2[j].split()

            c = lines2split[10]
            c = float(c)

            d = lines1split[10]
            d = float(d)

            if c<2.5:
                continue

            if d<c:
                continue

            if abs(c-d)<=0.5:
                continue
            
                
           

            notoinf1 = float(lines2split[7])    #余震リストの緯度 
            notoinf2 = float(lines2split[8])    #余震リストの経度
            notoinf3 = float(lines2split[9])    #余震リストの深さ


            location = (teqinf1, teqinf2)
            epi_dis = geodesic((notoinf1, notoinf2), location).km
            depth = (teqinf3 - notoinf3)
            a = (epi_dis**2 + depth**2)
            b = a**(1/2)

            if b<1:                                 #震源間距離が1より小さいのは書かない
                egfdata.write(lines2[j])

           
        

        egfdata.write("-"*120 + "\n")                #teq地震とegf地震のセットごとに空白を入れる
