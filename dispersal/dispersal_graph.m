
clc;
close all;
clear all;
tic;

load('R.mat');  

%without adapt without dispersal
%load('dispersal1.mat');  
%load('dispersal1_density_prey.mat');
%load('dispersal1_density_predator.mat');

%without adapt with dispersal
%load('dispersal2.mat');  
%load('dispersal2_density_prey.mat');
%load('dispersal2_density_predator.mat');

%with adapt with dispersal
%load('dispersal3.mat');  
%load('dispersal3_density_prey.mat');
%load('dispersal3_density_predator.mat');

%with adapt without dispersal
%load('dispersal4.mat');  
%load('dispersal4_density_prey.mat');
%load('dispersal4_density_predator.mat');

M = cell(15, 1);
Density_prey = cell(15,1);
Density_predator = cell(15,1);

Topt_x=12:0.5:26;
Topt_y=12:0.5:26;

T_initial = 12:1:26;

LE = 12:1:15;
TC = 16:1:20;
TE = 21:1:26;

for k = 1:15
    Mk = zeros(29, 29);
    %Dx = zeros(29, 29);
    %Dy = zeros(29, 29);
    for i = 1:29
        for j = 1:29
            Mk(i,j) = R{i,j}(k);  
            %Dx(i,j)=D_x{i,j}(k);
            %Dy(i,j)=D_y{i,j}(k);
        end
    end
    M{k} = Mk;
    %Density_prey{k} = Dx;
    %Density_predator{k} = Dy;
end

% Ejemplo de cómo acceder a una matriz específica dentro de la celda M
%disp('Ejemplo de acceso a una matriz específica:');
%disp(M{1});  % Muestra la matriz M1

toc;

% GRAPH 

figure(1)

% Define la matriz de colores
color_map_pastel2 = [ 153, 255, 153;   % Verde para 2
                     255, 255, 102];  % Amarillo para 3

color_map_pastel2 = color_map_pastel2 / 255; % Normalizar los valores a [0, 1]


% Define la matriz de colores
color_map_pastel3 = [ 153, 255, 153];   % Verde para 2
                 

color_map_pastel3 = color_map_pastel3 / 255;


% Define la matriz de colores
color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]

% Asigna la paleta de colores personalizada
colormap(color_map_pastel);

contourLevels = [0, 1, 2, 3]; % Para tus datos discretos de 0 a 3


%Crear la cuadrícula de datos
[X, Y] = meshgrid(Topt_x, Topt_y);


figure(1);


for p1 = 1:4
    [~, h] = contourf(X, Y, M{p1}', contourLevels, 'LineStyle', 'none');
    view(3);
    colormap(color_map_pastel); % Utiliza color_map_pastel
    h.ContourZLevel = T_initial(p1);
    xlabel('$T_{opt,x}$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$T_{opt,y}$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$T(0)$','Interpreter','latex','FontSize', 24);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
    xlim([12, 26]);
    ylim([12, 26]); 
    zlim([min(LE), max(LE)]); % Ajustar según los límites de T_initial
    xticks([12, 14, 16, 18, 20, 22, 24, 26]);
    yticks([12, 14, 16, 18, 20, 22, 24, 26]);
    zticks([12, 13, 14, 15]);
    hold on;
    x_square = [12, 26, 26, 12];
    y_square = [12, 12, 26, 26];
    z_square = [15, 15, 15, 15];  
    patch(x_square, y_square, z_square, 'k', 'FaceAlpha', 0, 'LineWidth', 0.0001); 
end

figure(2)

for p2 = 5:9
    [~, h] = contourf(X, Y, M{p2}', contourLevels, 'LineStyle', 'none');
    view(3);
    colormap(color_map_pastel); % Utiliza color_map_pastel
    h.ContourZLevel = T_initial(p2);
    xlabel('$T_{opt,x}$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$T_{opt,y}$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$T(0)$','Interpreter','latex','FontSize', 30);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
    xlim([12, 26]);
    ylim([12, 26]); 
    zlim([min(TC), max(TC)]); % Ajustar según los límites de T_initial
    xticks([12, 14, 16, 18, 20, 22, 24, 26]);
    yticks([12, 14, 16, 18, 20, 22, 24, 26]);
    zticks([16, 17, 18, 19, 20]);
    hold on;
    x_square2 = [12, 26, 26, 12];
    y_square2 = [12, 12, 26, 26];
    z_square2 = [20, 20, 20, 20];  % Z = 20
    patch(x_square2, y_square2, z_square2, 'r', 'FaceAlpha', 0, 'LineWidth', 0.0001);
    
end

view(60,15)

figure(3)

for p3 = 10:15
    [~, h] = contourf(X, Y, M{p3}', contourLevels, 'LineStyle', 'none');
    view(3);
    colormap(color_map_pastel); % Utiliza color_map_pastel
    h.ContourZLevel = T_initial(p3);
    xlabel('$T_{opt,x}$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$T_{opt,y}$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$T(0)$','Interpreter','latex','FontSize', 30);
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
    xlim([12, 26]);
    ylim([12, 26]); 
    zlim([min(TE), max(TE)]); % Ajustar según los límites de T_initial
    xticks([12, 14, 16, 18, 20, 22, 24, 26]);
    yticks([12, 14, 16, 18, 20, 22, 24, 26]);
    zticks([21, 22, 23, 24, 25, 26]);
    hold on;
    x_square = [12, 26, 26, 12];
    y_square = [12, 12, 26, 26];
    z_square = [26, 26, 26, 26];  
    patch(x_square, y_square, z_square, 'k', 'FaceAlpha', 0, 'LineWidth', 0.0001);  
end

view(60,15);






% figure(4)
% 
% [X, Y] = meshgrid(Topt_x, Topt_y);
% contourf(X, Y, M{5}', 2000, 'LineStyle', 'none');
% colormap(color_map_pastel);
% ax = gca;
% ax.FontSize = 20;
% xlim([15, 19]);
% ylim([15, 19]);
% axis square;
% xticks([15, 16, 17, 18, 19]);
% yticks([15, 16, 17, 18, 19]);
% %xlabel('a_{max}');  
% %ylabel('\sigma');  
% set(gca, 'FontSize', 20);



%figure(5);


% for p4 = 1:length(T_initial)
%     [~, h] = contourf(X, Y, M{p4}', contourLevels, 'LineStyle', 'none');
%     view(3);
%     colormap(color_map_pastel); % Utiliza color_map_pastel
%     h.ContourZLevel = T_initial(p4);
%     xlabel('$T_{opt,x}$', 'Interpreter', 'latex', 'FontSize', 24);
%     ylabel('$T_{opt,y}$', 'Interpreter', 'latex', 'FontSize', 24);
%     zlabel('$T(0)$','Interpreter','latex','FontSize', 24);
%     set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 20);
%     xlim([15, 19]);
%     ylim([15, 19]); 
%     zlim([min(T_initial), max(T_initial)]); % Ajustar según los límites de T_initial
%     hold on; 
% end