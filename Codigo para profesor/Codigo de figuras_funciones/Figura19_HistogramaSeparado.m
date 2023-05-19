%Reconstrucción 3D
[img,ResX,ResY,ResZ,hist3D]=Reconstruye3D1('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.1062',4,0,0);
%Visualización histograma
figure;
semilogy(hist3D)
%Marcas de separación
hold on; 
plot([33 33],[hist3D(40) 3e6],'r');
plot([79 79],[hist3D(79) 3e6],'r');
plot([150 150],[hist3D(150) 3e6],'r');
%Texto de cada región
text(10,1e6,'Vacío');
text(50,1e6,{'Tejido','Blando'});
text(90,1e6,'Hueso y aorta');
text(180,1e6,{'Elemento','Metálico'});