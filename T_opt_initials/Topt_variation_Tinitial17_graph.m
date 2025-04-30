clc 
close all
clear all
tic;

load('R_Toptvariation_T17_withoutadaptation.mat');
load('R_Toptvariation_T17_withadaptprey.mat');
load('R_Toptvariation_T17_withadaptation.mat');



Topt_x_0_end=20;
Topt_y_0_end=20;

Topt_x_0=14:0.1:Topt_x_0_end;
Topt_y_0=14:0.1:Topt_y_0_end;

m1=length(Topt_x_0);
m2=length(Topt_y_0);


color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]




color_map_pastel2 = [102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel2 = color_map_pastel2 / 255; % Normalizar los valores a [0, 1]


figure (1)   
[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([14, Topt_x_0_end]);
ylim([14, Topt_x_0_end]);
axis square;
xticks([14, 16, 18, 20]);
yticks([14, 16, 18, 20]);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);


figure (2)

[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(color_map_pastel2);
ax = gca;
ax.FontSize = 20;
xlim([14, Topt_x_0_end]);
ylim([14, Topt_x_0_end]);
axis square;
xticks([14, 16, 18, 20]);
yticks([14, 16, 18, 20]);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);


figure (3)

[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(color_map_pastel2);
ax = gca;
ax.FontSize = 20;
xlim([14, Topt_x_0_end]);
ylim([14, Topt_x_0_end]);
axis square;
xticks([14, 16, 18, 20]);
yticks([14, 16, 18, 20]);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);
