%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resize images in a directory %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Initialize
srcdir = './Sick_novo';
destdir = './Sick';
SIZE = 256;
%
% Create outpur dir.
mkdir(destdir);
%
% Read dir.
list = dir([srcdir '/*.png']);
%
% Open, resize and rewrite all files.
for i=1:length(list)
    im1 = imread([srcdir '/' list(i).name]);
    im2 = imresize(im1,[SIZE SIZE]);
    %Make sure ROI is on the left.
    [sy,sx] = size(im2);
    leftroi = sum(sum(im2(:,1:floor(sx/2))))>sum(sum(im2(:,floor(sx/2)+1:end)));
    if (~leftroi)
        im2 = im2(:,end:-1:1);
    end
    % Save the result as JPG
    aux = list(i).name;
    idx = find(aux=='.',1,'last');
    aux(idx:idx+3) = '.jpg';
    imwrite(im2,[destdir '/' aux(1:idx+3)]);
end
