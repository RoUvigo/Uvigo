%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resize images in a directory %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Initialize
srcdir = 'C:\Users\gdaf\Desktop\Fractura_Cervical\Probar\1.2.826.0.1.3680043.10678';
destdir = 'C:\Users\gdaf\Desktop\Nuevas';
% SIZE = 256;
%
% Create outpur dir.
mkdir(destdir);
%
% Read dir.
list = dir([srcdir '/*.dcm']);
%
% Open, resize and rewrite all files.
for i=1:length(list)
    im1 = dicomread([srcdir '/' list(i).name]);
    im2 = double(im1)/double(2^10);
    % Save the result as JPG
    aux = list(i).name;
    idx = find(aux=='.',1,'last');
    aux(idx:idx+3) = '.dcm';
    imwrite(im2,[destdir '/' aux(1:idx+3)]);
end
