im1 =dicomread('C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678\061.dcm');
im2 = double(im1)/double(2^11);
k = fspecial('gaussian',5, 1);
im3=im2double(im2);
%Filtra la imagen de entrada
imout = filter2(k,im3);
imshow([im3 imout]);
im4 = imgaussfilt(im3);
figure;
imshow([im3 im4])