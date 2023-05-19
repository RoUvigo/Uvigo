im1 = dicomread(['C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678\061.dcm']);
im2 = double(im1)/double(2^11);
h = imhist(im2);
[counts,x] = imhist(im2,16);
stem(x,counts)
T = otsuthresh(counts);
im3 = imbinarize(im2,T);
figure
imshow(im3)


