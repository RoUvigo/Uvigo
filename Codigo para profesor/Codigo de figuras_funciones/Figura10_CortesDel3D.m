%Representacion de todos los cortes de una imagen
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D2('C:\Users\gdaf\Desktop\Fractura_Cervical\Práctica\Google-Drive\Tema2-T1-DENTAL\DENTAL\panoramica_dental_tac',8,1,0);
figure;
montage(img);
title('Representación de los diferentes cortes')
