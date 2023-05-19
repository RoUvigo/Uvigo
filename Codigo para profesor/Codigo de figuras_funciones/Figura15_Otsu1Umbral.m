%Un umbral por Otsu
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2(['C:\Users\gdaf\Desktop\Fractura_Cervical\Práctica\Google-Drive\Tema2-T1-DENTAL\DENTAL\panoramica_dental_tac'],1,0,0);
Umbral = graythresh(img)
Vision3D(img,Umbral,ResX,ResY,ResZ);