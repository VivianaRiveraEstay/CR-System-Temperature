% Parámetros
N = 15; % Asegúrate de definir N en algún lugar de tu código
bmax = 0.5*ones(1, N); %[0,1] MAX BIRTH RATE OF PREY -- 1 Priyanga 2015
theta = 5*ones(1, N); % BREADTH OF BIRTH RATE FUNCTION-- [1,5]  5 Priyanga 2015
m0 = 0.1*ones(1, N); % MORTALITY RATE AT THE REFERENCE TEMPERATURE -- 0.2 Priyanga 2015, 0.01 Vasseur chapter book 2014
alpha = 0.01*ones(1, N); % TEMPERATURE SENSITIVITY IN MORTALITY RATE  -- 0.2 Vasseur chapter book
gamma = 0.0001*ones(1, N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
c = 0.01*ones(1, N); % COEF INTRAS COMPETITION -- K0=90
Topt_x_0 = 18*ones(1, N); % Topt PREY -- 20 Vasseur chapter book 2014
mu = 3*ones(1, N); % Plasticity of the trait of prey 
epsilon = 0.03*ones(1, N); % RATE OF CHANGE OF TEMPERATURE -- .02 and 0.04 Chaparro-Pedraza 2021
Gx = 0.01*ones(1, N); % SPEED OF EVOLUTION 
amax = 0.5*ones(1, N); % MAXIMUN ATTACK RATE -- [0.3,0.5] Dee LE 2020
phi = 0.01*ones(1, N); % TEMPERATURE SENSITIVITY OF MORTALITY RATE 
h_opt = 0.5*ones(1, N); % INITIAL HANDLING TIME -- 0.3 Dee LE 2020
p = 0.1*ones(1, N); % CONVERSION COEFF -- 0.1 Dee LE 2020
q0 = 0.01*ones(1, N); % MORTALITY RATE AT THE REFERENCE TEMPERATURE -- [0.01,0.02] % Dee LE 2020 where mortality predator is 0.2 
delta = 0.0001*ones(1, N); % WARMING ADAPT ON MORTALITY RATE -- it has to be tiny
beta = 0.01*ones(1, N); % TEMPERATURE SENSITIVITY IN MORTALITY RATE -- 0.2 Vasseur chapter book
sigma = 3*ones(1, N); % BREADTH OF ATTACK RATE FUNCTION
Topt_y_0 = 16*ones(1, N); % Topt PREDATOR -- 20 Vasseur chapter book 2014
eta = 3*ones(1, N); % Plasticity of the trait of predator
Gy = 0.01*ones(1, N); % SPEED OF EVOLUTION 

umbral1 = 1e-5;

P=[bmax theta m0 alpha gamma c Topt_x_0 mu epsilon Gx amax phi h_opt p q0 delta beta sigma Topt_y_0 eta Gy ];


% Condiciones iniciales
x1 = 20*ones(1, N);
x2 = 0*ones(1, N);
x3 = 10*ones(1, N);
x4 = 0*ones(1, N);
x5 = 12:(12+N-1);

x0 = [];
for l = 1:N
    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)];
end


% Opciones de Ode45
t_custom = linspace(0, 5000, 1000); 
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);

% Ejecutar múltiples simulaciones y calcular la probabilidad de extinción
num_simulations = 1000;
extinction_threshold = umbral1;
extinction_count = 0;

for i = 1:num_simulations
    [tv, Yv] = simulate_once(P, x0, t_custom, options);
    
    % Verificar si alguna población cae por debajo del umbral de extinción
    if any(Yv(:, 1:N) < extinction_threshold, 'all')
        extinction_count = extinction_count + 1;
    end
end

% Calcular la probabilidad de extinción
probability_of_extinction = extinction_count / num_simulations;
disp(['Probabilidad de extinción: ', num2str(probability_of_extinction)]);

% Funciones Locales
function [tv, Yv] = simulate_once(P, x0, t_custom, options)
    [tv, Yv] = ode45(@(t, Y) vivi_dispersal(t, Y, P), t_custom, x0, options);
end
