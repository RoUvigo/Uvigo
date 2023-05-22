%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Replicate images in a directory %
% creating forged versions        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Initialize
srcdir = '../DEST/CCsick';
destdir = '../DEST/CCsick2';
n = 1; % Number of new files per original one
%
% Create outpur dir.
mkdir(destdir);
%
% Read dir.
list = dir([srcdir '/*.jpg']);
%
% Open, resize and rewrite all files.
for i=1:length(list)
    % Create new name
    name1 = list(i).name;
    idx = find(name1=='.');
    bname = name1(1:idx-1);
    % Read, process, write
    im1 = imread([srcdir '/' name1]);
    for j=0:n-1
        im2 = ForgeImage(im1);
        name2 = [bname char('a'+j) '.jpg'];
        imwrite(im2,[destdir '/' name2]);
    end
end
