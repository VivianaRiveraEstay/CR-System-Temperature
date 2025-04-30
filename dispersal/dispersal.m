clc 
close all
clear all
tic;

% This code give the final density in each patch and plots 

format long
N=15; %number of patches
umbral1 = 1e-5;
umbral2 = 1;

Ax=zeros(N);
Ay=zeros(N);
for k=1:N
    Ax(k,k+1)=0.;
    Ax(k+1,k)=0.;

    Ay(k,k+1)=0.;
    Ay(k+1,k)=0.;
end

bmax=0.5*ones(1,N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=5*ones(1,N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1*ones(1,N); % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001*ones(1,N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01*ones(1,N); %COEF INTRAS COMPETITION -- K0=90
%Topt_x_0=14*ones(1,N); % Topt PREY -- 20 Vasseur chapter book 2014
Topt_x_0=[14 14 14 14 18 18 18 18 18 23 23 23 23 23 23]; % Topt PREDATOR -- 20 Vasseur chapter book 2014
mu=3*ones(1,N); % plasticity of the trait of prey 
epsilon=0.03*ones(1,N); % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.0*ones(1,N); % SPEED OF EVOLUTION 

amax=0.5*ones(1,N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01*ones(1,N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=0.5*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
%Topt_y_0=13*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
Topt_y_0=[13 13 13 13 16 16 16 16 16 21 21 21 21 21 21]; % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.0*ones(1,N); %SPEED OF EVOLUTION 

umbral1 = 1e-5;


% Parameter vector
P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy ];


% initial conditions
x1=20*ones(1,N);
x2=0*ones(1,N);
x3=10*ones(1,N);
x4=0*ones(1,N);
x5=12:(12+N-1);

x0 = [];

for l = 1:N
    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)];
end


% Ode45

t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi_dispersal(t, Y, P), t_custom, x0, options);


% First condition: if Yv < 0, then Yv = 0
Yv(Yv < 0) = 0;

% Second condition: if Yv < umbral1, then Yv = 0
Yv(Yv < umbral1) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% POINCARE MAP

% Parameters
% P_fixed = 2;  % Fixed prey value for the Poincaré map
% D_fixed = 3;  % Fixed prey value for the Poincaré map
% tolerance = 1e-3;  % Tolerance for detecting crossings
% 
% % Initialize an empty vector for predator values when P = P_fixed
% D_poincare = [];
% P_poincare = [];
% 
% % Loop through the trajectory data
% for i = 1:length(Yv)-1
%     % Check if there is a crossing of D = D_fixed
%     if (Yv(i,3) < D_fixed && Yv(i+1,3) > D_fixed) || (Yv(i,3) > D_fixed && Yv(i+1,3) < D_fixed)
%         % Interpolate to find the exact value of P when D = D_fixed
%         % Assumes linear change between time points
%         P_interp = interp1(Yv(i:i+1,3), Yv(i:i+1,1), D_fixed);
% 
%         % Save the interpolated value in P_poincare
%         P_poincare = [P_poincare; P_interp];
%     end
% end



% for i = 1:length(Yv)-1
%     % Check if there is a crossing of P = P_fixed
%     if (Yv(i,1) < P_fixed && Yv(i+1,1) > P_fixed) || (Yv(i,1) > P_fixed && Yv(i+1,1) < P_fixed)
%         % Interpolate to find the exact value of D when P = P_fixed
%         % Assumes linear change between time points
%         D_interp = interp1(Yv(i:i+1,1), Yv(i:i+1,3), P_fixed);
% 
%         % Save the interpolated value in D_poincare
%         D_poincare = [D_poincare; D_interp];
%     end
% end


% Plotting the Poincaré Map
% figure;
% %panel a)
% subplot(1,3,1)
% scatter(1:length(P_poincare), P_poincare, 'filled', 'MarkerFaceColor', 'k', 'SizeData', 40);
% xlabel({'Crossing number'}, 'Interpreter', 'latex');
% ylabel({'Prey density'}, 'Interpreter', 'latex');
% xlim([0, 40]);
% xticks([0, 10, 20, 30, 40]);
% set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);
% %title('Poincaré Map with P = 2 for Prey');
% grid on;
% box on;
% text(-0.2, 1, 'a)', 'Units', 'normalized', 'FontSize', 24, 'Interpreter', 'latex');
% %panel b)
% subplot(1,3,2), plot(tv, Yv(:,1), 'LineWidth', 2, 'color', 'k')
% xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
% ylabel({'Prey density'},'Interpreter', 'latex' ,'FontSize', 24);
% xlim([0, 5000]);
% ylim([0, 60]);
% xticks([0, 2500, 5000]);
% set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);
% text(-0.2, 1, 'b)', 'Units', 'normalized', 'FontSize', 24, 'Interpreter', 'latex');
% %panel c)
% subplot(1,3,3), plot(tv, Yv(:,3), 'LineWidth', 2,'color', 'k');
% xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
% ylabel({'Predator density'},'Interpreter', 'latex' ,'FontSize', 24);
% xlim([0, 5000]); 
% xticks([0, 2500, 5000]);
% set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);
% text(-0.2, 1, 'c)', 'Units', 'normalized', 'FontSize', 24, 'Interpreter', 'latex');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% RISK EXTINCTION 

[m1, m2] = size(Yv);
extinction_count = zeros(m2, 1);

for i2 = 1:m2
    for i1 = 1:m1
        if Yv(i1, i2) == 0
            extinction_count(i2) = extinction_count(i2) + 1;
        end
    end
end

for i3=1:N
  extinction_count_prey (i3) = extinction_count(5*i3-4,:);
  extinction_count_predator(i3) = extinction_count(5*i3-2,:);
  end

 Probability_ext_prey  =   extinction_count_prey./m1;
 Probability_ext_predator  =   extinction_count_predator./m1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %SCENARIO

R1=zeros(1,N);
for l1=1:N

if numel(Yv) >= 501

Topt_x_end(l1)=mu(l1)*Yv(end,5*l1-3)+Topt_x_0(l1);
Topt_y_end(l1)=eta(l1)*Yv(end,5*l1-1)+Topt_y_0(l1);

total_x(l1) = mean(Yv(end-100:end,5*l1-4));
total_y(l1) = mean(Yv(end-100:end,5*l1-2));

max_value_x(l1) = max(Yv(end-100:end,5*l1-4));
max_value_y(l1) = max(Yv(end-100:end,5*l1-2));

min_value_x(l1) = min(Yv(end-100:end,5*l1-4));
min_value_y(l1) = min(Yv(end-100:end,5*l1-2));

metric1_x(l1) = abs (total_x(l1)-Yv(end,5*l1-4));
metric1_y(l1) = abs (total_y(l1)-Yv(end,5*l1-2));

metric2_x(l1) = abs (max_value_x(l1) - min_value_x(l1));
metric2_y(l1) = abs (max_value_y(l1) - min_value_y(l1));

metric3_x(l1) = abs(max_value_x(l1) - Yv(end,5*l1-4));
metric3_y(l1) = abs(max_value_y(l1) - Yv(end,5*l1-2));

else


total_x(l1) = NaN;
            total_y(l1) = NaN;
            max_value_x(l1) = NaN;
            max_value_y(l1) = NaN;
            min_value_x(l1) = NaN;
            min_value_y(l1) = NaN;
            metric1_x(l1) = NaN;
            metric1_y(l1) = NaN;
            metric2_x(l1) = NaN;
            metric2_y(l1) = NaN;
            metric3_x(l1) = NaN;
            metric3_y(l1) = NaN;

end            


if metric1_x(l1)>umbral1 && metric2_x(l1)>umbral2 || metric1_y(l1)>umbral1 && metric2_y(l1)>umbral2 || (metric1_x(l1)>umbral1 && metric3_x(l1)>0.1) || (metric1_y(l1)>umbral1 && metric3_y(l1)>0.1)
R1(l1)=3; % persistence oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) > umbral1   
R1(l1)=2; % persistence not oscillation
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) < umbral1   
R1(l1)=1; %just prey persistence
elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && (Yv(end,5*l1-4) < umbral1 && Yv(end,5*l1-2) < umbral1)   
R1(l1)=0; %extinction 

end
end


R1

 %Yv=Yv(end-299:end,:);

 Yv2=Yv(end-299:end,:);
 Yv3=Yv(end-199:end,:);

for l2=1:N

if R1(l2) == 3
    %x(l2) = (max(Yv(:,5*l2-4)) + min(Yv(:,5*l2-4)))/2;
    %y(l2) = (max(Yv(:,5*l2-2))+ min(Yv(:,5*l2-2)))/2;

    x(l2) = mean(Yv2(:,5*l2-4));
    y(l2) = mean(Yv2(:,5*l2-2));
else % if R1 is not equal to 3 
    x(l2) = mean(Yv3(:,5*l2-4));
    y(l2) = mean(Yv3(:,5*l2-2));
    %x(l2) = Yv2(end,5*l2-4);
    %y(l2) = Yv2(end,5*l2-2);
end
end


% % Graficar el retrato de fase // Plot portrait phase
% figure (4);
% plot(Yv(:,1), Yv(:,3),'LineWidth', 1.5, 'Color', 'k');
% xlabel('x'); 
% ylabel('y');
% %title('Retrato de Fase');
% set(gca, 'FontSize', 16);
% grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GIFT

% nFrames = length(tv); 
% 
% figure;
% axis tight manual;  % Para asegurar que el axis no cambie
% filename = 'retrato_de_fase.gif';  % Nombre del archivo GIF
% 
% for mm = 1:nFrames
%     plot(Yv(1:mm, 1), Yv(1:mm, 3), 'LineWidth', 1.5, 'Color', 'k');
%     xlabel('x');
%     ylabel('y');
%     %title(sprintf('Retrato de Fase - Frame %d', k));  % Opcional: Mostrar el número de frame
%     set(gca, 'FontSize', 16);
%     grid on;
% 
%     % Capturar el frame actual para el GIF
%     frame = getframe(gcf);
%     im = frame2im(frame);
%     [imind, cm] = rgb2ind(im, 256);
% 
%     % Escribir cada frame al archivo GIF
%     if mm == 1
%         imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
%     else
%         imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
%     end
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%FIGURES

% for kk=1:N
% 
% subplot(2,N,kk),plot(tv,Yv(:,5*kk-4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 15000]); 
% ylim([0, 50]);
% set(gca, 'FontSize', 16);
% 
% subplot(2,N,kk+N),plot(tv,Yv(:,5*kk-3),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-1),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Main trait','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 7000]); 
% ylim([0, 1]);
% set(gca, 'FontSize', 16); 
% 
% end



% for kk=1:N
% 
% plot(tv,Yv(:,5*kk-4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 15000]); 
% ylim([0, 50]);
% set(gca, 'FontSize', 16);
% 
% end


% figure (1)
% for kk=1:N
% 
% subplot(1,N,kk),plot(tv,Yv(:,5*kk-4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 15000]); 
% ylim([0, 50]);
% set(gca, 'FontSize', 16);
% 
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure (2)  %Density over time

 subplot(2,3,1), plot(tv, Yv(:,1), 'LineWidth', 2)
 xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
 ylabel({'Prey density'},'Interpreter', 'latex' ,'FontSize', 24);
 hold on
 plot(tv, Yv(:,6), 'LineWidth', 2);
 plot(tv, Yv(:,11), 'LineWidth', 2);
 plot(tv, Yv(:,16), 'LineWidth', 2);
 legend({'Patch 1', 'Patch 2', 'Patch 3', 'Patch 4'},'Interpreter', 'latex' ,'FontSize', 14)
 xlim([0, 5000]);
 ylim([0, 60]);
 title({'Leading Edge'},'Interpreter', 'latex' ,'FontSize', 14);
 xticks([0, 2500, 5000]);
 set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);
 


subplot(2,3,2), plot(tv, Yv(:,21), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Prey density'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,26), 'LineWidth', 2);
plot(tv, Yv(:,31), 'LineWidth', 2);
plot(tv, Yv(:,36), 'LineWidth', 2);
plot(tv, Yv(:,41), 'LineWidth', 2);
legend({'Patch 5', 'Patch 6', 'Patch 7', 'Patch 8', 'Patch 9'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
ylim([0, 60]);
title({'The Core'},'Interpreter', 'latex' ,'FontSize', 14);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,3), plot(tv, Yv(:,46), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Prey density'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,51), 'LineWidth', 2);
plot(tv, Yv(:,56), 'LineWidth', 2);
plot(tv, Yv(:,61), 'LineWidth', 2);
plot(tv, Yv(:,66), 'LineWidth', 2);
plot(tv, Yv(:,71), 'LineWidth', 2);
legend({'Patch 10', 'Patch 11', 'Patch 12', 'Patch 13', 'Patch 14', 'Patch 15'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]);
ylim([0, 60]);
title({'Trailing Edge'},'Interpreter', 'latex' ,'FontSize', 14);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);

subplot(2,3,4), plot(tv, Yv(:,3), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator density'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,8), 'LineWidth', 2);
plot(tv, Yv(:,13), 'LineWidth', 2);
plot(tv, Yv(:,18), 'LineWidth', 2);
legend({'Patch 1', 'Patch 2', 'Patch 3', 'Patch 4'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,5), plot(tv, Yv(:,23), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator density'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,28), 'LineWidth', 2);
plot(tv, Yv(:,33), 'LineWidth', 2);
plot(tv, Yv(:,38), 'LineWidth', 2);
plot(tv, Yv(:,43), 'LineWidth', 2);
legend({'Patch 5', 'Patch 6', 'Patch 7', 'Patch 8', 'Patch 9'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,6), plot(tv, Yv(:,48), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator density'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,53), 'LineWidth', 2);
plot(tv, Yv(:,58), 'LineWidth', 2);
plot(tv, Yv(:,63), 'LineWidth', 2);
plot(tv, Yv(:,68), 'LineWidth', 2);
plot(tv, Yv(:,73), 'LineWidth', 2);
legend({'Patch 10', 'Patch 11', 'Patch 12', 'Patch 13', 'Patch 14', 'Patch 15'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% FIGURE  %Total density in each patch

% figure(3)
% subplot(2,1,1)
% plot(x5, x, 'o','LineWidth',2, 'Color', 'k'); 
% xlabel('Initial mean habitat temperature');
% ylabel('Mean prey density')
% xlim([x5(1), x5(end)])
% ylim([0, 20])
% xticks([12, 14, 16, 18, 20, 22, 24, 26])
% hold on
% plot(18, 0, 'x', 'LineWidth', 1.5, 'Color', 'r');
% set(gca, 'FontSize', 18);
% subplot(2,1,2)
% plot(x5, y, 'o','LineWidth',2, 'Color', 'k'); 
% xlabel('Initial mean habitat temperature');
% ylabel('Mean predator density');
% hold on
% plot(16, 0, 'x', 'LineWidth', 1.5, 'Color', 'r');
% set(gca, 'FontSize', 18);
% xlim([x5(1), x5(end)]);
% ylim([0, 5])
% xticks([12, 14, 16, 18, 20, 22, 24, 26]);



% FIGURE  %probability of risk

% figure(4)
% subplot(2,1,1)
% plot(x5, Probability_ext_prey, 'o','LineWidth',2, 'Color', 'k'); 
% xlabel('Initial mean habitat temperature');
% ylabel('PREY-REP')
% xlim([x5(1), x5(end)])
% ylim([0, 1])
% xticks([12, 14, 16, 18, 20, 22, 24, 26])
% hold on
% plot(18, 0, 'x', 'LineWidth', 1.5, 'Color', 'r');
% set(gca, 'FontSize', 18);
% subplot(2,1,2)
% plot(x5, Probability_ext_predator, 'o','LineWidth',2, 'Color', 'k'); 
% xlabel('Initial mean habitat temperature');
% ylabel('PRED-REP','FontSize', 12);
% hold on
% plot(16, 0, 'x', 'LineWidth', 1.5, 'Color', 'r');
% set(gca, 'FontSize', 18);
% xlim([x5(1), x5(end)]);
% ylim([0, 1])
% xticks([12, 14, 16, 18, 20, 22, 24, 26]);




figure(5)
subplot(1,2,1)
line([18, 18], [0, 20], 'Color', [0.8, 0.1, 0.1], 'LineStyle', '-', 'LineWidth', 2);
hold on
line([16, 16], [0, 20], 'Color', [0.8, 0.1, 0.1], 'LineStyle', '--', 'LineWidth', 2);
hold on
plot(x5, x, '.','LineWidth',2, 'MarkerSize', 20,  'Color', 'k'); 
hold on
plot(x5, y, 'o','LineWidth',2,  'Color', 'k');
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
xlabel({'Initial mean habitat temperature'}, 'Interpreter', 'latex');
ylabel({'Mean population density'}, 'Interpreter', 'latex');
xlim([x5(1), x5(end)]);
ylim([0, 15])
xticks([12, 14, 16, 18, 20, 22, 24, 26]);
fill([12 15 15 12], [0 0 15 15], [0.5 0.7 0.9], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([15 20 20 15], [0 0 15 15], [0.5 0.8 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([20 26 26 20], [0 0 15 15], [0.8 0.1 0.1], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
legend({'$T_{opt,x}$','$T_{opt,y}$','Prey', 'Predator','LE','TC','TE'}, 'Interpreter', 'latex', 'Orientation', 'horizontal', 'FontSize', 15);
box on


subplot(1,2,2)
line([18, 18], [0, 20], 'Color', [0.8, 0.1, 0.1], 'LineStyle', '-', 'LineWidth', 2);
hold on
line([16, 16], [0, 20], 'Color', [0.8, 0.1, 0.1], 'LineStyle', '--', 'LineWidth', 2);
hold on 
plot(x5, Probability_ext_prey, '.','LineWidth',2 , 'MarkerSize', 20, 'Color', 'k');
hold on
plot(x5, Probability_ext_predator, 'o','LineWidth',2, 'Color', 'k'); 
xlabel({'Initial mean habitat temperature'},'Interpreter', 'latex');
ylabel({'PRE'}, 'Interpreter', 'latex');
xlim([x5(1), x5(end)]);
ylim([0, 1.5])
xticks([12, 14, 16, 18, 20, 22, 24, 26]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
fill([12 15 15 12], [0 0 15 15], [0.5 0.7 0.9], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([15 20 20 15], [0 0 15 15], [0.5 0.8 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([20 26 26 20], [0 0 15 15], [0.8 0.1 0.1], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
legend({'$T_{opt,x}$','$T_{opt,y}$','Prey', 'Predator','LE','TC','TE'}, 'Interpreter', 'latex', 'Orientation', 'horizontal', 'FontSize', 15);
box on


figure (6)  %traits over time

subplot(2,3,1), plot(tv, Yv(:,2), 'LineWidth', 2)
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Prey trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,7), 'LineWidth', 2);
plot(tv, Yv(:,12), 'LineWidth', 2);
plot(tv, Yv(:,17), 'LineWidth', 2);
legend({'Patch 1', 'Patch 2', 'Patch 3', 'Patch 4'},'Interpreter', 'latex' ,'FontSize', 14)
xlim([0, 5000]);
ylim([0, 1]);
title({'Leading Edge'},'Interpreter', 'latex' ,'FontSize', 14);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);
 


subplot(2,3,2), plot(tv, Yv(:,22), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Prey trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,27), 'LineWidth', 2);
plot(tv, Yv(:,32), 'LineWidth', 2);
plot(tv, Yv(:,37), 'LineWidth', 2);
plot(tv, Yv(:,42), 'LineWidth', 2);
legend({'Patch 5', 'Patch 6', 'Patch 7', 'Patch 8', 'Patch 9'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
ylim([0, 1]);
title({'The Core'},'Interpreter', 'latex' ,'FontSize', 14);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,3), plot(tv, Yv(:,47), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Prey trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,52), 'LineWidth', 2);
plot(tv, Yv(:,57), 'LineWidth', 2);
plot(tv, Yv(:,62), 'LineWidth', 2);
plot(tv, Yv(:,67), 'LineWidth', 2);
plot(tv, Yv(:,72), 'LineWidth', 2);
legend({'Patch 10', 'Patch 11', 'Patch 12', 'Patch 13', 'Patch 14', 'Patch 15'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]);
ylim([0, 1]);
title({'Trailing Edge'},'Interpreter', 'latex' ,'FontSize', 14);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);

subplot(2,3,4), plot(tv, Yv(:,4), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,9), 'LineWidth', 2);
plot(tv, Yv(:,14), 'LineWidth', 2);
plot(tv, Yv(:,19), 'LineWidth', 2);
legend({'Patch 1', 'Patch 2', 'Patch 3', 'Patch 4'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
ylim([0, 1]);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,5), plot(tv, Yv(:,24), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,29), 'LineWidth', 2);
plot(tv, Yv(:,34), 'LineWidth', 2);
plot(tv, Yv(:,39), 'LineWidth', 2);
plot(tv, Yv(:,44), 'LineWidth', 2);
legend({'Patch 5', 'Patch 6', 'Patch 7', 'Patch 8', 'Patch 9'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
ylim([0, 1]);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


subplot(2,3,6), plot(tv, Yv(:,49), 'LineWidth', 2);
xlabel({'Time'},'Interpreter', 'latex' ,'FontSize', 24); 
ylabel({'Predator trait value'},'Interpreter', 'latex' ,'FontSize', 24);
hold on
plot(tv, Yv(:,54), 'LineWidth', 2);
plot(tv, Yv(:,59), 'LineWidth', 2);
plot(tv, Yv(:,64), 'LineWidth', 2);
plot(tv, Yv(:,69), 'LineWidth', 2);
plot(tv, Yv(:,74), 'LineWidth', 2);
legend({'Patch 10', 'Patch 11', 'Patch 12', 'Patch 13', 'Patch 14', 'Patch 15'},'Interpreter', 'latex','FontSize', 14)
xlim([0, 5000]); 
ylim([0, 1]);
xticks([0, 2500, 5000]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 24);


toc;