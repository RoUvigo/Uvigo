%Reconstrucción 3D%
[img,ResX,ResY,ResZ,matrizhist3D]=Reconstruye3D2('C:\Users\gdaf\Desktop\Fractura - Cervical\Práctica\Google-Drive\Tema2-T1-DENTAL\DENTAL\panoramica_dental_tac',2,0,0);

%Mostrar volumen
Vision3D(img,0.4,ResX,ResY,ResZ);