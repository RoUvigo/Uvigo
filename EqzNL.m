function imgout = EqzNL(imgin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adaptive non linear equalization %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Constant values
    th = 0.50;
    n1 = 1.2;
    n2 = 2;
    %
    % Binarization
    imbw = imbinarize(imgin);
    %
    % Create mask
    [Label,num] = bwlabel(imbw);
    p = regionprops(Label,'Area');
    M = -1;
    for i=1:num
        a(i) = p(i).Area;
        if (a(i)>M)
            M = a(i);
            idx = i;
        end
    end
    mask = (Label==idx);  
    % 
    % Weight in the ROI
    s = sum(imgin(mask))/length(imgin(mask));
    %     imleft = imbw(:,1:floor(end/2));
    %     s = sum(imleft(:))/length(imleft(:));
    %
    % Exponent value
    if (s<th)
        n = n1;
    else
        n = n2;
    end
    %
    % Non linear filter
    imgout = (imgin).^n;
end
