%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Classifiy input images for Mammography studies %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Initialize
srcdir = './SRC';
destdir = './DEST';
csvfile = './train.csv';
splitter = ',';
SIZE = 256;
eqz = true;
%
% Create outpur dirs.
mkdir([destdir '/CChealthy']); % CC views, healthy 
mkdir([destdir '/CCsick']); % CC views, sick 
mkdir([destdir '/MLhealthy']); % ML views, healthy 
mkdir([destdir '/MLsick']); % ML views, sick
mkdir([destdir '/MLOhealthy']); % MLO views, healthy 
mkdir([destdir '/MLOsick']); % MLO views, sick 
mkdir([destdir '/LMhealthy']); % LM views, healthy 
mkdir([destdir '/LMsick']); % LM views, sick
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CC: 'Cranial-Caudal', view from above                  %
% ML: 'mediolateral', view from the center               %
%                     of the chest outward               %
% MLO: 'mediolateral-oblique', oblique or angled view    %
% LM:' latero-medial', view from the outer side          %
%                      of the breast, towards the middle %
%                      of the chest.                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note that if folder already exists no action will be taken
%
% Open CSV file
Fin = fopen(csvfile);
fgets(Fin); % First line (titles)
m=0;
%
% Process file lines.
while(true)
    m = m+1;
    Line = fgets(Fin); % Get line
    if (Line==-1)
        % End of file
        break;
    end
    sp = find(Line==splitter); % Splitters
    %
    % Extract data
    patient_id = Line(sp(1)+1:sp(2)-1);
    image_id = Line(sp(2)+1:sp(3)-1);
    laterality = Line(sp(3)+1:sp(4)-1);
    right = strcmp(laterality,'R');
    viewtype = Line(sp(4)+1:sp(5)-1);
    sick = logical(str2double(Line(sp(6)+1:sp(7)-1)));
    % 
    % Construct file names
    srcfile = [srcdir '/' patient_id '/' image_id '.dcm'];
    if ((strcmp(viewtype,'CC'))&&(~sick))
        destfile = [destdir '/CChealthy/' patient_id '_' image_id '.jpg'];
    elseif ((strcmp(viewtype,'CC'))&&(sick))
        destfile = [destdir '/CCsick/' patient_id '_' image_id '.jpg'];
    elseif ((strcmp(viewtype,'ML'))&&(~sick))
        destfile = [destdir '/MLhealthy/' patient_id '_' image_id '.jpg'];
    elseif ((strcmp(viewtype,'ML'))&&(sick))
        destfile = [destdir '/MLsick/' patient_id '_' image_id '.jpg']; 
    elseif ((strcmp(viewtype,'MLO'))&&(~sick))           
        destfile = [destdir '/MLOhealthy/' patient_id '_' image_id '.jpg'];
    elseif ((strcmp(viewtype,'MLO'))&&(sick))
        destfile = [destdir '/MLOsick/' patient_id '_' image_id '.jpg']; 
    elseif ((strcmp(viewtype,'LM'))&&(~sick))           
        destfile = [destdir '/LMhealthy/' patient_id '_' image_id '.jpg'];
    elseif ((strcmp(viewtype,'LM'))&&(sick))
        destfile = [destdir '/LMsick/' patient_id '_' image_id '.jpg']; 
    else
        % Error ==> saltar el fichero
        destile = [];
    end
    % 
    % Copy file
    if (isfile(srcfile)&&(~isempty(destfile)))
        % Read image and metadata
        info0 = dicominfo(srcfile);
        img0 = dicomread(srcfile);
        %%%%%%%%%%%%%%%%%%%%
        % Preprocess image %
        %%%%%%%%%%%%%%%%%%%%
        imgdef = PreProcess2(img0,info0,SIZE,eqz);
        %
        % Write image
        imwrite(imgdef,destfile);
        % Print message.
        fprintf('%s ==> %s.\n',srcfile,destfile);
    end
end
%
% Close file
fclose(Fin);
