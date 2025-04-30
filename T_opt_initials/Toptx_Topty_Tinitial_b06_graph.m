clc
close all
clear all

load('R_Toptinitial_b06.mat');

Topt_x_0_end=20;
Topt_y_0_end=20;

Topt_x_0=14:0.1:Topt_x_0_end;
Topt_y_0=14:0.1:Topt_y_0_end;

m1=length(Topt_x_0);
m2=length(Topt_y_0);

x5=[13, 15, 17, 19];

color_map_pastel = [255, 102, 102;   % Rojo para 0
                    102, 178, 255;   % Azul para 1
                    153, 255, 153;   % Verde para 2
                    255, 255, 102];  % Amarillo para 3

color_map_pastel = color_map_pastel / 255; % Normalizar los valores a [0, 1]


figure(1);

for p1=1:length(x5)

subplot(1,length(x5),p1)    

[X, Y] = meshgrid(Topt_x_0, Topt_y_0);
contourf(X, Y, R{p1}', 2000, 'LineStyle', 'none');
colormap(color_map_pastel);
ax = gca;
ax.FontSize = 20;
xlim([14, Topt_x_0_end]);
ylim([14, Topt_x_0_end]);
axis square;
xticks([14, 16, 18, 20]);
yticks([14, 16, 18, 20]);
xlabel('T_{opt,x}');  
ylabel('T_{opt,y}');
set(gca, 'TickLabelInterpreter', 'latex', 'Fontsize', 18);
set(gca, 'FontSize', 20); 
end


