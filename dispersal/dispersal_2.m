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
    Ax(k,k+1)=0.1;
    Ax(k+1,k)=0.1;

    Ay(k,k+1)=0.1;
    Ay(k+1,k)=0.1;
end

bmax=0.5*ones(1,N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=5*ones(1,N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0=0.1*ones(1,N); % MORTLITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma=0.0001*ones(1,N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c=0.01*ones(1,N); %COEF INTRAS COMPETITION -- K0=90
Topt_x_0=18*ones(1,N); % Topt PREY -- 20 Vasseur chapter book 2014
mu=3*ones(1,N); % plasticity of the trait of prey 
epsilon=0.03*ones(1,N); % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx=0.01*ones(1,N); % SPEED OF EVOLUTION 

amax=0.5*ones(1,N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01*ones(1,N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=0.5*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.01*ones(1,N); %SPEED OF EVOLUTION 

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
options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);
[tv, Yv] = ode45(@(t, Y) vivi_dispersal(t, Y, P), t_custom, x0, options);


% First condition: if Yv < 0, then Yv = 0
Yv(Yv < 0) = 0;

% Second condition: if Yv < umbral1, then Yv = 0
Yv(Yv < umbral1) = 0;



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
ylabel({'PoE'}, 'Interpreter', 'latex');
xlim([x5(1), x5(end)]);
ylim([0, 1.5])
xticks([12, 14, 16, 18, 20, 22, 24, 26]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);
fill([12 15 15 12], [0 0 15 15], [0.5 0.7 0.9], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([15 20 20 15], [0 0 15 15], [0.5 0.8 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
fill([20 26 26 20], [0 0 15 15], [0.8 0.1 0.1], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
legend({'$T_{opt,x}$','$T_{opt,y}$','Prey', 'Predator','LE','TC','TE'}, 'Interpreter', 'latex', 'Orientation', 'horizontal', 'FontSize', 15);
box on



toc;