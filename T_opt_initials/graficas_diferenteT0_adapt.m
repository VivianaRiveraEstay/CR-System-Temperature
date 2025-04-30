clc 
close all
clear all
tic;

load('R1_T0_18_adapt.mat');
load('R2_T0_19_adapt.mat');
load('R3_T0_20_adapt.mat');

x1 = [18, 18];
y1 = [0, 22];


x2 = [19, 19];
y2 = [0, 22];

x3 = [20, 20];
y3 = [0, 22];


x4 = [0, 22];
y4 = [18, 18];

x5 = [0, 22];
y5 = [19, 19];


x6 = [0, 22];
y6 = [20, 20];




Topt_x_0_end=22;
Topt_y_0_end=22;

Topt_x_0=12:0.1:Topt_x_0_end;
Topt_y_0=12:0.1:Topt_y_0_end;

m1=length(Topt_x_0);
m2=length(Topt_y_0);


color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]






figure (1)   
[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([12, Topt_x_0_end]);
ylim([12, Topt_x_0_end]);
axis square;
xticks([12, 14, 16, 18, 20, 22]);
yticks([12, 14, 16, 18, 20, 22]);
hold on
plot(x1, y1, 'k-', 'LineWidth', 2);
plot(x4, y4, 'k-', 'LineWidth', 2);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);

figure (2)   
[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([12, Topt_x_0_end]);
ylim([12, Topt_x_0_end]);
axis square;
xticks([12, 14, 16, 18, 20, 22]);
yticks([12, 14, 16, 18, 20, 22]);
hold on
plot(x2, y2, 'k-', 'LineWidth', 2);
plot(x5, y5, 'k-', 'LineWidth', 2);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);

figure (3)   
[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([12, Topt_x_0_end]);
ylim([12, Topt_x_0_end]);
axis square;
xticks([12, 14, 16, 18, 20, 22]);
yticks([12, 14, 16, 18, 20, 22]);
hold on
plot(x3, y3, 'k-', 'LineWidth', 2);
plot(x6, y6, 'k-', 'LineWidth', 2);
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 20);
