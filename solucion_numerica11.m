clc 
close all
clear all
tic;

N=12; %number of patches
t_custom = linspace(0, 5000, 1000); % Aquí 1000 es el número de puntos de tiempo

Ax=zeros(N); %prey dispersal rate
Ay=zeros(N); %predator dispersal rate 
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
Gx=0.0*ones(1,N); % SPEED OF EVOLUTION 

amax=0.5*ones(1,N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi=0.01*ones(1,N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt=0.5*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=18*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.0*ones(1,N); %SPEED OF EVOLUTION 


umbral1 = 1e-5;
umbral2 = 1;



P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy];


x1=20*ones(1,N);
x2=0*ones(1,N);
x3=10*ones(1,N);
x4=0*ones(1,N);
x5=14:(14+N-1);

x0 = [];

 
for l = 1:N


    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)]; 
end





t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi11(t, Y, P), t_custom, x0, options);

% if Yv<0
%     Yv =0;
% end 
% if Yv < umbral1
%     Yv=0;
% end



% what kind of orbit it is
R1=zeros(1,N);

total_x = zeros(1,N);
total_y = zeros(1,N);

max_value_x = zeros(1,N);
max_value_y = zeros(1,N);

min_value_x = zeros(1,N);
min_value_y = zeros(1,N);

metric1_x = zeros(1,N);
metric1_y = zeros(1,N);

metric2_x = zeros(1,N);
metric2_y = zeros(1,N);

metric3_x = zeros(1,N);
metric3_y = zeros(1,N);


Topt_x_end=zeros(1,N);
Topt_y_end=zeros(1,N);




% for l1=1:N
% 
% %Optimal temperatures at the end 
% 
% Topt_x_end(l1)=mu(l1)*Yv(end,5*l1-3)+Topt_x_0(l1);
% Topt_y_end(l1)=eta(l1)*Yv(end,5*l1-1)+Topt_y_0(l1);
% 
% total_x(l1) = mean(Yv(end-100:end,5*l1-4));
% total_y(l1) = mean(Yv(end-100:end,5*l1-2));
% 
% max_value_x(l1) = max(Yv(end-100:end,5*l1-4));
% max_value_y(l1) = max(Yv(end-100:end,5*l1-2));
% 
% min_value_x(l1) = min(Yv(end-100:end,5*l1-4));
% min_value_y(l1) = min(Yv(end-100:end,5*l1-2));
% 
% metric1_x(l1) = abs (total_x(l1)-Yv(end,5*l1-4));
% metric1_y(l1) = abs (total_y(l1)-Yv(end,5*l1-2));
% 
% metric2_x(l1) = abs (max_value_x(l1) - min_value_x(l1));
% metric2_y(l1) = abs (max_value_y(l1) - min_value_y(l1));
% 
% metric3_x(l1) = abs(max_value_x(l1) - Yv(end,5*l1-4));
% metric3_y(l1) = abs(max_value_y(l1) - Yv(end,5*l1-2));
% 
% if metric1_x(l1)>umbral1 && metric2_x(l1)>umbral2 || metric1_y(l1)>umbral1 && metric2_y(l1)>umbral2 || (metric1_x(l1)>umbral1 && metric3_x(l1)>0.1) || (metric1_y(l1)>umbral1 && metric3_y(l1)>0.1)
% R1(l1)=3; % persistence oscillation
% elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) > umbral1   
% R1(l1)=2; % persistence not oscillation
% elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && Yv(end,5*l1-4) > umbral1 && Yv(end,5*l1-2) < umbral1   
% R1(l1)=1; %just prey persistence
% elseif (metric1_x(l1)<umbral1 && metric1_y(l1)<umbral1 || metric2_x(l1)<umbral2 && metric2_y(l1)<umbral2) && (Yv(end,5*l1-4) < umbral1 && Yv(end,5*l1-2) < umbral1)   
% R1(l1)=0; %extinction 
% 
% end
%end


% 
% R1
% 
% 
% for l2=1:N
% 
% if R1(l2) == 3
%     x(l2) = max(Yv(:,5*l2-4))/2;
%     y(l2) = max(Yv(:,5*l2-2))/2;
% else % if R1 is not equal to 3 
%     x(l2) = Yv(end,5*l2-4);
%     y(l2) = Yv(end,5*l2-2);
% end
% end


% b=zeros(length(Yv),N);
% m=zeros(length(Yv),N);
% a=zeros(length(Yv),N);
% h=zeros(length(Yv),N);
% q=zeros(length(Yv),N);
% F=zeros(length(Yv),N);
% pF=zeros(length(Yv),N);
% my=zeros(length(Yv),N);
% lambda2=zeros(length(Yv),N);
% K=zeros(length(Yv),N);

for t1=1:N
for t2=1:length(Yv)

%b(t2,t1) = bmax(t1)*exp((-(Yv(t2,5*t1)-(mu(t1)*Yv(t2,5*t1-3)+Topt_x_0(t1)))^2)/(2*theta(t1)^2));
% m(t2,t1) = (m0(t1)-gamma(t1)*Yv(t2,5*t1-3))*exp(alpha(t1)*Yv(t2,5*t1));
% a(t2,t1) = amax(t1)*exp((-(Yv(t2,5*t1)-(eta(t1)*Yv(t2,5*t1-1)+Topt_y_0(t1)))^2)/(2*sigma(t1)^2)); %attack rate
% h(t2,t1) = phi(t1)*(Yv(t2,5*t1)-(eta(t1)*Yv(t2,5*t1-1)+Topt_y_0(t1)))^2+h_opt(t1);
% q(t2,t1) = (q0(t1)-delta(t1)*Yv(t2,5*t1-1))*exp(beta(t1)*Yv(t2,5*t1));
% F(t2,t1) = Yv(t2,5*t1-4)*a(t1)/(1+a(t1)*h(t1)*Yv(t2,5*t1-4));
% pF(t2,t1) = p(t1)*Yv(t2,5*t1-4)*a(t1)/(1+a(t1)*h(t1)*Yv(t2,5*t1-4)); %growth predator
% my(t2,t1) = Yv(t2,5*t1-2)*q(t2,t1); %mortality predator
% consumption_loss(t2,t1) = Yv(t2,5*t1-2) * F(t2,t1); %consumtion loss
% percapitarate_y(t2,t1)= pF(t2,t1) - q(t2,t1);

prey(t2,t1)=Yv(t2,5*t1-4);
predator(t2,t1)=Yv(t2,5*t1-2);
temperaturee(t2,t1)=Yv(t2,5*t1);


% %stability condition
% 
% lambda2(t2,t1) = ( a(t2,t1)*(b(t2,t1)-m(t2,t1))*p(t1)/(c(t1)+ a(t2,t1)*h(t2,t1) *(b(t2,t1)-m(t2,t1))) )-q(t2,t1);
% K(t2,t1) = (b(t2,t1)-m(t2,t1))/c(t1);
% max_F(t2,t1) = K(t2,t1)*a(t2,t1)/(1+a(t2,t1)*h(t2,t1)*K(t2,t1));
% max_growth_predator(t2,t1) = p(t1)*max_F(t2,t1);
% end 
% end




% figure(2)
% subplot(2,1,1)
% plot(x5, Topt_x_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Optimal temperature')
% set(gca, 'FontSize', 20);
% subplot(2,1,2)
% plot(x5, Topt_y_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Optimal temperature')
% set(gca, 'FontSize', 20);


% figure (3)
% 
% subplot(1,5,1)
% plot(x5, K_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Carrying capacity of prey')
% set(gca, 'FontSize', 20);
% 
% subplot(1,5,2)
% plot(x5, max_F_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Max consumption')
% set(gca, 'FontSize', 20);
% 
% subplot(1,5,3)
% plot(x5, max_growth_predator_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Max growth of predator')
% set(gca, 'FontSize', 20);
% 
% subplot(1,5,4)
% plot(x5, q_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Mortality rate')
% set(gca, 'FontSize', 20);
% 
% 
% subplot(1,5,5)
% plot(x5, lambda2_end, 'o','LineWidth',2); 
% xlabel('$T(0)$','Interpreter', 'latex');
% ylabel('Stability condition')
% set(gca, 'FontSize', 20);
% 
% 
% toc;





% figure(1)
% 
% for kk=1:N
% 
% 
% subplot(2,N,kk),plot(tv,Yv(:,5*kk-4),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-2),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 5000]); 
% ylim([0, 30]);
% set(gca, 'FontSize', 16);
% 
% subplot(2,N,kk+N),plot(tv,Yv(:,5*kk-3),'LineWidth',2),xlabel('Time','FontSize', 14),ylabel('Density','FontSize', 14);
% hold on
% plot(tv,Yv(:,5*kk-1),'LineWidth',2),xlabel('Time','FontSize', 15),ylabel('Density','FontSize', 15);
% %legend('Prey', 'Predator')
% xlim([0, 5000]); 
% ylim([0, 1]);
% set(gca, 'FontSize', 16); 
% 
 end
end



%figure (2)

% subplot(3,1,1)
% plot(tv,b(:,1),'LineWidth',2); 
% hold on 
% plot(tv,b(:,2),'LineWidth',2); 
% hold on 
% plot(tv,b(:,3),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Birth rate of prey','Interpreter', 'latex')
% set(gca, 'FontSize', 20);
% legend('Patch 1', 'Patch 2', 'Patch 3')
% legend('FontSize', 10);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);


% subplot(3,1,2)
% plot(tv,b(:,4),'LineWidth',2); 
% hold on 
% plot(tv,b(:,5),'LineWidth',2); 
% hold on 
% plot(tv,b(:,6),'LineWidth',2);
% hold on 
% plot(tv,b(:,7),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Birth rate of prey','Interpreter', 'latex')
% set(gca, 'FontSize', 20);
% legend('Patch 4', 'Patch 5', 'Patch 6', 'Patch 7')
% legend('FontSize', 10);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);
% 
% 
% 
% subplot(3,1,3)
% plot(tv,b(:,8),'LineWidth',2); 
% hold on 
% plot(tv,b(:,9),'LineWidth',2); 
% hold on 
% plot(tv,b(:,10),'LineWidth',2);
% hold on 
% plot(tv,b(:,11),'LineWidth',2);
% hold on 
% plot(tv,b(:,12),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Birth rate of prey','Interpreter', 'latex')
% set(gca, 'FontSize', 20);
% legend('Patch 8', 'Patch 9', 'Patch 10', 'Patch 11', 'Patch 12')
% legend('FontSize', 10);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);



%--------------------------------------------------------------

% figure (3)
% 
% subplot(3,1,1)
% plot(tv,a(:,1),'LineWidth',2); 
% hold on 
% plot(tv,a(:,2),'LineWidth',2); 
% hold on 
% plot(tv,a(:,3),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Attack rate','Interpreter', 'latex')
% set(gca, 'FontSize', 20);
% legend('Patch 1', 'Patch 2', 'Patch 3')
% legend('FontSize', 10);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);
% 
% 
% 
% 
% subplot(3,1,2)
% plot(tv,a(:,4),'LineWidth',2); 
% hold on 
% plot(tv,a(:,5),'LineWidth',2); 
% hold on 
% plot(tv,a(:,6),'LineWidth',2);
% hold on 
% plot(tv,F(:,7),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Attack rate','Interpreter', 'latex')
% legend('Patch 4', 'Patch 5', 'Patch 6', 'Patch 7')
% legend('FontSize', 10);
% set(gca, 'FontSize', 20);
% xlim([0, 5000]);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);
% 
% 
% 
% 
% subplot(3,1,3)
% plot(tv,a(:,8),'LineWidth',2); 
% hold on 
% plot(tv,a(:,9),'LineWidth',2); 
% hold on 
% plot(tv,a(:,10),'LineWidth',2);
% hold on 
% plot(tv,a(:,11),'LineWidth',2);
% hold on 
% plot(tv,a(:,12),'LineWidth',2);
% xlabel('Time','Interpreter', 'latex');
% ylabel('Attack rate','Interpreter', 'latex')
% set(gca, 'FontSize', 20);
% legend('Patch 8', 'Patch 9', 'Patch 10', 'Patch 11', 'Patch 12')
% legend('FontSize', 10);
% xticks([0, 2500, 5000])
% xlim([0, 5000]);
% ylim([0, 1]);





%-----------------------------------------------------------




figure (4)

subplot(3,1,1)
plot(tv,prey(:,1),'LineWidth',2); 
hold on 
plot(tv,prey(:,2),'LineWidth',2); 
hold on 
plot(tv,prey(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
legend('Patch 1', 'Patch 2', 'Patch 3')
legend('FontSize', 10);
xticks([0, 2500, 5000])
xlim([0, 5000]);
ylim([0, 40]);


subplot(3,1,2)
plot(tv,prey(:,4),'LineWidth',2); 
hold on 
plot(tv,prey(:,5),'LineWidth',2); 
hold on 
plot(tv,prey(:,6),'LineWidth',2);
hold on 
plot(tv,prey(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
legend('Patch 4', 'Patch 5', 'Patch 6', 'Patch 7')
legend('FontSize', 10);
xticks([0, 2500, 5000])
xlim([0, 5000]);
ylim([0, 40]);


subplot(3,1,3)
plot(tv,prey(:,8),'LineWidth',2); 
hold on 
plot(tv,prey(:,9),'LineWidth',2); 
hold on 
plot(tv,prey(:,10),'LineWidth',2);
hold on 
plot(tv,prey(:,11),'LineWidth',2);
hold on 
plot(tv,prey(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
legend('Patch 8', 'Patch 9', 'Patch 10', 'Patch 11', 'Patch 12')
legend('FontSize', 10);
xticks([0, 2500, 5000])
xlim([0, 5000]);
ylim([0, 10]);



%-----------------------------------------------------------


figure (5)

subplot(3,1,1)
plot(tv,predator(:,1),'LineWidth',2); 
hold on 
plot(tv,predator(:,2),'LineWidth',2); 
hold on 
plot(tv,predator(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
set(gca, 'FontSize', 20);
legend('Patch 1', 'Patch 2', 'Patch 3')
legend('FontSize', 10);
xticks([0, 2500, 5000])
xlim([0, 5000]);


subplot(3,1,2)
plot(tv,predator(:,4),'LineWidth',2); 
hold on 
plot(tv,predator(:,5),'LineWidth',2); 
hold on 
plot(tv,predator(:,6),'LineWidth',2);
hold on 
plot(tv,predator(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
legend('Patch 4', 'Patch 5', 'Patch 6', 'Patch 7')
legend('FontSize', 10);
set(gca, 'FontSize', 20);
xticks([0, 2500, 5000])
xlim([0, 5000]);


subplot(3,1,3)
plot(tv,predator(:,8),'LineWidth',2);
hold on 
plot(tv,predator(:,9),'LineWidth',2); 
hold on 
plot(tv,predator(:,10),'LineWidth',2);
hold on 
plot(tv,predator(:,11),'LineWidth',2);
hold on 
plot(tv,predator(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
legend('Patch 8', 'Patch 9', 'Patch 10', 'Patch 11', 'Patch 12')
legend('FontSize', 10);
set(gca, 'FontSize', 20);
xticks([0, 2500, 5000])
xlim([0, 5000]);






toc;