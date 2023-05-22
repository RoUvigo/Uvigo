function imout = ForgeImage(imin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create forged image (falsificada) % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    n = 2; % LSB bits to be randomized
    r = 0; % Radius for random scrambling
    A = 10; % Angle to rotate and de-rotate
    a = 0.5; % Angle error to allow
    SF = 3; % Scaling factor
    %
    % Initialize
    Nc = size(imin,3); % Number of color planes
    % 
    % Aleatorize n LSB's
    for c=1:Nc
        im2(:,:,c) = RandomizeNBits(imin(:,:,c),n);
    end
    % 
    % Random scrambling
    for c=1:Nc
        im3(:,:,c) = ScramblePx(im2(:,:,c),r);
    end
    %
    % Rotate and de-rotate
    im4 = RotateDeRotate(im3,A,a);
    %
    % Scale and de-scale
    imout = ScaleDeScale(im4,SF);
end

%%%%%%%%%%%%%
% FUNCTIONS %
%%%%%%%%%%%%%
function y = RandomizeNBits(x,n)
% Randomize de n LSB's of a uint8 image
    z = im2uint8(x); % Input image
    y = uint8(zeros(size(z))); % Output image
    m = 2^n-1; % Maximum value with n bits
    masc = 2^8-2^n; % Masc to erase n LSB's
    Npx = length(z(:)); % Number of 8-bit pixels
    % Apply randomization
    for i=1:Npx
        lsb = round(m*rand); % Random value for LSB's
        y(i) = bitand(z(i),masc)+lsb; % Put it there
    end
end

function Iy = ScaleDeScale(Ix,SF)
% Scale and de-scale
    if (SF==1)
        % Contour condition
        Iy = Ix;
        return;
    end
    % Go bigger
    imaux1 = imresize(Ix,SF,'lanczos3');
    % Erase first line and column
    imaux2 = imaux1(2:size(imaux1,1),2:size(imaux1,2),:);
    % Return to original size
    Iy = imresize(imaux2,[size(Ix,1) size(Ix,2)],'lanczos2');
end

function out = ScramblePx(im0,r)
% Scramble pixels
    if (r<1)
        % Contour condition
        out = im0;
        return;
    end
    % Randomize de n LSB's of a uint8 image
    in = im2uint8(im0); % Input image
    out = uint8(zeros(size(im0))); % Output image
    aux = false(size(im0)); % Auxiliary image
    [Ymax,Xmax] = size(im0); % Sizes
    n = 5; % Number of tries per pixel
    %
    % Apply random scrambling
    for y=1:Ymax
        for x=1:Xmax
            % 
            % Try n times
            sc = false;
            for i=1:n
                % Apply random
                Dx = round(r*randn);
                Dy = round(r*randn);
                y1 = y+Dy;
                x1 = x+Dx; % New point
                %
                % Try to scramble pixels
                if (x1<1)
                    continue;
                end
                if (y1<1)
                    continue;
                end
                if (x1>Xmax)
                    continue;
                end
                if (y1>Ymax)
                    continue;
                end
                if (aux(y1,x1))
                    continue;
                end
                % Success
                out(y,x) = in(y1,x1);
                aux(y1,x1) = true;
                sc = true;
                break;
            end
            if (~sc)
                % Not assigned
                out(y,x) = in(y,x);
                aux(y,x) = true;
            end 
        end   
    end
end

function im1 = RotateDeRotate(im0,A,a)
% Rotate and de-rotate
    if (abs(A)<1)
        % Contour condition
        im1 = im0;
        return;
    end
    imaux1 = imrotate(im0,A,'bicubic','loose');
    imaux2 = imrotate(imaux1,-A+a,'bicubic','loose');
    % Correct size
    [m0,n0,~] = size(im0);
    [m2,n2,~] = size(imaux2);
    dm = floor((m2-m0)/2);
    dn = floor((n2-n0)/2);
    dy = ceil((n0/2)*sind(a))+1;
    dx = ceil((m0/2)*sind(a))+1;
    % Eliminate black border completely
    imaux3 = imaux2(dm+dy+1:dm+m0-dy,dn+dx+1:dn+n0-dx,:);
    % Final result
    im1 = imresize(imaux3,[m0 n0]);
end
