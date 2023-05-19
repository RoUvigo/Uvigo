function CortesXY(objeto3d,ResX,ResY)
%
% Representa cortes del objeto en el plano XY.
%
[M, N, H] = size(objeto3d); % Dimensiones
%
% Extraer los cortes e irlos viendo.
%
fig = figure;
colormap('gray');
x = [0:N-1]*ResX;
y = [0:M-1]*ResY;
for z=1:H
    %
    % Cortar a altura z.
    %
    img = objeto3d(:,:,z);
    figure(fig);
    imagesc(x,y,img);
    axis on;
    aux = sprintf('Corte XY, z=%d.',z);
    title(aux);
    pause;    
end
close(fig);
