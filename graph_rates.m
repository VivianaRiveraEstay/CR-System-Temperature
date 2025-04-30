%graph of rate 

clc 
close all
clear all
tic;

load('Yv1.mat'); % not dispersal no adapt 
%load('Yv2.mat'); % ax=0.1 and ay=0 , no adapt and dispersal just prey
%load('Yv3.mat'); % ax=0.1 and ay=0.1 , no adapt and dispersal both species
%load('Yv4.mat'); % ax=0.1 and ay=0.1 , adapt and dispersal both species
%load('Yv5.mat'); % ax=0. and ay=0. , adapt and no dispersal



N=12;


Ax=zeros(N);
Ay=zeros(N);
for k=1:N
    Ax(k,k+1)=0.7;
    Ax(k+1,k)=0.7;

    Ay(k,k+1)=0.;
    Ay(k+1,k)=0.;
end

bmax=0.5*ones(1,N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta=4*ones(1,N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
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
h_opt=1*ones(1,N); % INITIAL HANDDLING TIME -- 0.3 Dee LE 2020
p=0.1*ones(1,N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0=0.01*ones(1,N); %  MORTLITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta=0.0001*ones(1,N); %WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta=0.01*ones(1,N); %TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma=3*ones(1,N); %BREADTH OF ATTACK RATE FUNCTION
Topt_y_0=16*ones(1,N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta=3*ones(1,N); % plasticity of the trait of predator
Gy=0.01*ones(1,N); %SPEED OF EVOLUTION 

b=zeros(length(Yv1),N);
m=zeros(length(Yv1),N);
a=zeros(length(Yv1),N);
h=zeros(length(Yv1),N);
q=zeros(length(Yv1),N);
F=zeros(length(Yv1),N);
pF=zeros(length(Yv1),N);
my=zeros(length(Yv1),N);

T_initial=14:(14+N-1);

for i=1:N
for j=1:length(Yv1)


dispersion_prey_left = 0;
dispersion_prey_right = 0;

dispersion_predator_left = 0;
dispersion_predator_right = 0;

if i > 1
    dispersion_prey_left = Ax(i-1,i) * Yv1(5*(i-1)-4) - Ax(i,i-1) * Yv1(5*i-4);
end

if i < N
    dispersion_prey_right = Ax(i+1,i) * Yv1(5*(i+1)-4) - Ax(i,i+1) * Yv1(5*i-4);
end

if i > 1
    dispersion_predator_left = Ay(i-1,i) * Yv1(5*(i-1)-2) - Ay(i,i-1) * Yv1(5*i-2);
end

if i < N
    dispersion_predator_right = Ay(i+1,i) * Yv1(5*(i+1)-2) - Ay(i,i+1) * Yv1(5*i-2);
end


b(j,i) = bmax(i)*exp((-(Yv1(j,5*i)-(mu(i)*Yv1(j,5*i-3)+Topt_x_0(i)))^2)/(2*theta(i)^2));
m(j,i) = (m0(i)-gamma(i)*Yv1(j,5*i-3))*exp(alpha(i)*Yv1(j,5*i));
a(j,i) = amax(i)*exp((-(Yv1(j,5*i)-(eta(i)*Yv1(j,5*i-1)+Topt_y_0(i)))^2)/(2*sigma(i)^2));
h(j,i) = phi(i)*(Yv1(j,5*i)-(eta(i)*Yv1(j,5*i-1)+Topt_y_0(i)))^2+h_opt(i);
q(j,i) = (q0(i)-delta(i)*Yv1(j,5*i-1))*exp(beta(i)*Yv1(j,5*i));
F(j,i) = Yv1(j,5*i-4)*a(i)/(1+a(i)*h(i)*Yv1(j,5*i-4));
pF(j,i) = p(i)*Yv1(j,5*i-4)*a(i)/(1+a(i)*h(i)*Yv1(j,5*i-4)); %growth predator
my(j,i) = Yv1(j,5*i-2)*q(j,i); %mortality predator
growth_prey(j,i) = Yv1(j,5*i-4) * (b(j,i)-m(j,i)) + dispersion_predator_left + dispersion_predator_right; %growth prey
consumption_loss(j,i) = Yv1(j,5*i-2) * F(j,i); %consumtion loss

percapitarate_y(j,i)= pF(j,i) - q(j,i);

prey(j,i)=Yv1(j,5*i-4);
predator(j,i)=Yv1(j,5*i-2);

rateofchange_y(j,i) = p(i)*Yv1(j,5*i-2)*F(i)-Yv1(j,5*i-2)*q(i) + dispersion_predator_left + dispersion_predator_right; 
rateofchange_x(j,i) = Yv1(j,5*i-4)*(b(i)-m(i)) - c(i)*Yv1(j,5*i-4)^2 - Yv1(j,5*i-2)*F(i) + dispersion_prey_left + dispersion_prey_right; 

in_x(j,i) =  dispersion_predator_left + dispersion_predator_right;

end
end

b_end = b(end,:);
a_end = a(end,:);
m_end = m(end,:);
h_end = h(end,:);
q_end = q(end,:);
F_end = F(end,:);
pF_end = pF(end,:);
my_end = my(end,:);
rateofchange_y_end = rateofchange_y(end,:);
growth_prey_end = growth_prey(end,:);
rateofchange_x_end = rateofchange_x(end,:);
consumption_loss_end=consumption_loss(end,:);
percapitarate_y_end=percapitarate_y(end,:);





figure (1)
subplot(1,3,1)
plot(b(:,1),'LineWidth',2); 
hold on 
plot(b(:,2),'LineWidth',2); 
hold on 
plot(b(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Birth rate of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);


subplot(1,3,2)
plot(b(:,4),'LineWidth',2); 
hold on 
plot(b(:,5),'LineWidth',2); 
hold on 
plot(b(:,6),'LineWidth',2);
hold on 
plot(b(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Birth rate of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);




subplot(1,3,3)
plot(b(:,8),'LineWidth',2); 
hold on 
plot(b(:,9),'LineWidth',2); 
hold on 
plot(b(:,10),'LineWidth',2);
hold on 
plot(b(:,11),'LineWidth',2);
hold on 
plot(b(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Birth rate of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);



%--------------------------------------------------------------

figure (2)

subplot(1,3,1)
plot(F(:,1),'LineWidth',2); 
hold on 
plot(F(:,2),'LineWidth',2); 
hold on 
plot(F(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Fuctional response','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);
%xticks([0, 5000]);

subplot(1,3,2)
plot(F(:,4),'LineWidth',2); 
hold on 
plot(F(:,5),'LineWidth',2); 
hold on 
plot(F(:,6),'LineWidth',2);
hold on 
plot(F(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Fuctional response','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);


subplot(1,3,3)
plot(F(:,8),'LineWidth',2); 
hold on 
plot(F(:,9),'LineWidth',2); 
hold on 
plot(F(:,10),'LineWidth',2);
hold on 
plot(F(:,11),'LineWidth',2);
hold on 
plot(F(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Fuctional response','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

%-----------------------------------------------------------


figure (3)

subplot(1,3,1)
plot(growth_prey(:,1),'LineWidth',2); 
hold on 
plot(growth_prey(:,2),'LineWidth',2); 
hold on 
plot(growth_prey(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Growth prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,2)
plot(growth_prey(:,4),'LineWidth',2); 
hold on 
plot(growth_prey(:,5),'LineWidth',2); 
hold on 
plot(growth_prey(:,6),'LineWidth',2);
hold on 
plot(growth_prey(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Growth prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,3)
plot(growth_prey(:,8),'LineWidth',2); 
hold on 
plot(growth_prey(:,9),'LineWidth',2); 
hold on 
plot(growth_prey(:,10),'LineWidth',2);
hold on 
plot(growth_prey(:,11),'LineWidth',2);
hold on 
plot(growth_prey(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Growth prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);
%ylim([2, 8]); 


%-----------------------------------------------------------


figure (4)

subplot(1,3,1)
plot(prey(:,1),'LineWidth',2); 
hold on 
plot(prey(:,2),'LineWidth',2); 
hold on 
plot(prey(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,2)
plot(prey(:,4),'LineWidth',2); 
hold on 
plot(prey(:,5),'LineWidth',2); 
hold on 
plot(prey(:,6),'LineWidth',2);
hold on 
plot(prey(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,3)
plot(prey(:,8),'LineWidth',2); 
hold on 
plot(prey(:,9),'LineWidth',2); 
hold on 
plot(prey(:,10),'LineWidth',2);
hold on 
plot(prey(:,11),'LineWidth',2);
hold on 
plot(prey(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of prey','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);
%ylim([2, 8]); 


%-----------------------------------------------------------


figure (5)

subplot(1,3,1)
plot(predator(:,1),'LineWidth',2); 
hold on 
plot(predator(:,2),'LineWidth',2); 
hold on 
plot(predator(:,3),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,2)
plot(predator(:,4),'LineWidth',2); 
hold on 
plot(predator(:,5),'LineWidth',2); 
hold on 
plot(predator(:,6),'LineWidth',2);
hold on 
plot(predator(:,7),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);

subplot(1,3,3)
plot(predator(:,8),'LineWidth',2); 
hold on 
plot(predator(:,9),'LineWidth',2); 
hold on 
plot(predator(:,10),'LineWidth',2);
hold on 
plot(predator(:,11),'LineWidth',2);
hold on 
plot(predator(:,12),'LineWidth',2);
xlabel('Time','Interpreter', 'latex');
ylabel('Density of predator','Interpreter', 'latex')
set(gca, 'FontSize', 20);
xlim([0, length(Yv1)]);
%ylim([2, 8]); 





toc;