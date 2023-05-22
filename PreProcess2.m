function imgdef = PreProcess2(img0,info0,SIZE,eqz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocess dicom mammography for CNN processing %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Convert to maximum contrast double image (linear enhancement)
    imgd0 = double(img0);       
    M = max(imgd0(:));
    m = min(imgd0(:));
    imgd1 = (imgd0-m)/(M-m);
    %
    % If background is bright, invert it
    if (strcmp(info0.PhotometricInterpretation,'MONOCHROME1'))           
        imgd1 = 1.0-imgd1;
    end
    %
    % Make sure ROI is on the left.
    leftroi = sum(sum(imgd1(:,1:floor(end/2))))>sum(sum(imgd1(:,floor(end/2)+1:end)));
    if (~leftroi)
        imgd1 = imgd1(:,end:-1:1);
    end
    %
    % Crop to ROI
    [mask,BB] = FindMask(imgd1);
    imgd2 = imcrop(imgd1.*double(mask),BB);
    %
    % Normalize size
    imgd3 = imresize(imgd2,[SIZE,SIZE]);
    %
    % Non linear equalization (optional)
    if (eqz)
        %
        % Constant values
        th = 0.50;
        n1 = 1.2;
        n2 = 2;
        % 
        % Weight in the ROI
        s = sum(imgd1(mask))/length(imgd1(mask));
        %
        % Exponent value
        if (s<th)
            n = n1;
        else
            n = n2;
        end
        %
        % Non linear filter
        imgdef = (imgd3).^n;
    else 
        % No filtering
        imgdef = imgd3;
    end
end

%%%%%%%%%%%%%
% FUNCTIONS %
%%%%%%%%%%%%%
function [mask,BB] = FindMask(imin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find a mask for interest part %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Binarization
    imbw = imbinarize(imin);
    %
    % Create mask
    [Label,num] = bwlabel(imbw);
    p = regionprops(Label,'Area','BoundingBox');
    M = -1;
    for i=1:num
        a(i) = p(i).Area;
        if (a(i)>M)
            M = a(i);
            idx = i;
        end
    end
    mask0 = (Label==idx); 
    mask = imfill(mask0,'holes');
    BB = p(idx).BoundingBox;
end
