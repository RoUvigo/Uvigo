%Fijar el directorio con el dataset de imágenes de mamografías con
%proyección cráneo-caudal (CC)
CC_dir = fullfile('CC_Rotada');

%Almacenar las imágenes en un Datastore de Matlab 
CC_datos = imageDatastore(CC_dir,'IncludeSubfolders',true, ...
    'LabelSource','foldernames');

%Mostrar alguna imagen aleatoria del almacén de datos
perm = randperm(2264,9);
for i = 1:9
    subplot(3,3,i);
    imshow(CC_datos.Files{perm(i)});
end

%Calcular el número de imágenes de cada categoría
recuentoClases = countEachLabel(CC_datos)

%Coger alguna imagen cualquiera y comprobar el tamaño
im1_CC = readimage(CC_datos, 1);
tam1 = size(im1_CC)
im2_CC = readimage(CC_datos,100);
tam2 = size(im2_CC)

%Especificar los datos de entrenamiento y validación
nImtrain = 1000; %numero de imagenes de cada carpeta
[CC_train,CC_valid] = splitEachLabel(CC_datos,nImtrain,'randomized');

%Definir la arquitectura de la red. Capas de la CNN
Capas = [
    imageInputLayer([256 256 1])
    
    convolution2dLayer(3,8,'padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(4,'Stride',4)
    
    convolution2dLayer(3,8, 'padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(3,'Stride',3)

    convolution2dLayer(3,16,'padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

%Especificar las opciones de entrenamiento
opciones = trainingOptions('sgdm','InitialLearnRate',0.005, ...
    'MaxEpochs',20,'Shuffle','every-epoch', ...
    'ValidationData',CC_valid,'ValidationFrequency',5, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Entrenar la red con datos de entrenamiento
train = true;
%  if (train)
%     net2 = trainNetwork(CC_train,Capas,opciones);
%      save net-rot.mat net2
%  else
%      load net-rot.mat;
%  end
% 
% % Clasificar imágenes de validación y calcular la precisión 
% [Y_Pred,prob] = classify(net2,CC_valid); %Lo que sale
% Y_Valid = CC_valid.Labels; %Lo que debería salir
% 
% accuracy = sum(Y_Pred==Y_Valid)/numel(Y_Valid)
% CM = confusionmat(Y_Valid,Y_Pred)
% 
% TN = CM(1,1);
% FP = CM(1,2);
% FN = CM(2,1);
% TP = CM(2,2);
% P = TP/(TP+FP) % Precision
% R = TP/(TP+FN) % Recall
% F1 = 2*P*R/(P+R) % F1-score


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Oversampling
CC2_dir = fullfile('CC_Rotada_X2');
%Cargar las imágenes en un DataStore de Matlab
CC2_datos=imageDatastore(CC2_dir, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% Oversample everything
Y_valid2=CC2_datos.Labels;
[G,classes] = findgroups(Y_valid2);
numImclase = splitapply(@numel,Y_valid2,G);

%Número máximo de muestras de entre todas las clases
maxnumImclase = max(numImclase)

files = splitapply(@(x){randReplicateFiles(x,maxnumImclase)},CC2_datos.Files,G);
files = vertcat(files{:});

Y_valid2=[];info=strfind(files,'\');
for i=1:numel(files)
    idx=info{i};
    dirName=files{i};
    targetStr=dirName(idx(end-1)+1:idx(end)-1);
    targetStr2=cellstr(targetStr);
    Y_valid2=[Y_valid2;categorical(targetStr2)];
end
CC2_datos.Files = files;
CC2_datos.Labels=Y_valid2;

% Ahora separar
[CC2_train,CC2_valid]=splitEachLabel(CC2_datos,0.85);

%Especificar las opciones de entrenamiento
opciones = trainingOptions('sgdm','InitialLearnRate',0.005, ...
    'MaxEpochs',20,'Shuffle','every-epoch', ...
    'ValidationData',CC2_valid,'ValidationFrequency',5, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Entrenar (o no)
if (train)
    net = trainNetwork(CC2_train,Capas,opciones);
    save net_rotx2.mat net;
else
    load net_rotx2.mat;
end


[Y2_Pred,prob2] = classify(net,CC2_valid); %Lo que sale
Y2_Valid = CC2_valid.Labels; %Lo que debería salir

accuracy2 = sum(Y2_Pred==Y2_Valid)/numel(Y2_Valid)
CM2 = confusionmat(Y2_Valid,Y2_Pred) %Matriz de confusión
TN2 = CM2(1,1);
FP2 = CM2(1,2);
FN2 = CM2(2,1);
TP2 = CM2(2,2);
P2 = TP2/(TP2+FP2) % Precision
R2 = TP2/(TP2+FN2) % Recall
F1_2 = 2*P2*R2/(P2+R2) % F1 score 
% Grabar
save results CM CM2 accuracy accuracy2 P P2 R R2 F1 F1_2
