function [tv, Yv] = vivi_combined()

% Parámetros del modelo
N = 12; % Número de parches

Ax = zeros(N); % Tasa de dispersión de presas
Ay = zeros(N); % Tasa de dispersión de depredadores

for k = 1:N
    Ax(k,k+1) = 0.;
    Ax(k+1,k) = 0.;

    Ay(k,k+1) = 0.;
    Ay(k+1,k) = 0.;
end

bmax = 0.5 * ones(1,N); %[0,1] Máxima tasa de natalidad de presas
theta = 4 * ones(1,N); % Ancho de la función de tasa de natalidad
m0 = 0.1 * ones(1,N); % Tasa de mortalidad a la temperatura de referencia
alpha = 0.01 * ones(1,N); % Sensibilidad a la temperatura en la tasa de mortalidad
gamma = 0.0001 * ones(1,N); % Adaptación al calentamiento en la tasa de mortalidad
c = 0.01 * ones(1,N); % Coeficiente de competencia intraespecífica
Topt_x_0 = 18 * ones(1,N); % Temperatura óptima de las presas
mu = 3 * ones(1,N); % Plasticidad del rasgo de las presas
epsilon = 0.03 * ones(1,N); % Tasa de cambio de temperatura
Gx = 0.01 * ones(1,N); % Velocidad de evolución de las presas

amax = 0.5 * ones(1,N); % Tasa máxima de ataque
phi = 0.01 * ones(1,N); % Sensibilidad a la temperatura en la tasa de mortalidad de los depredadores
h_opt = 1 * ones(1,N); % Tiempo de manipulación inicial
p = 0.1 * ones(1,N); % Coeficiente de conversión
q0 = 0.01 * ones(1,N); % Tasa de mortalidad de los depredadores a la temperatura de referencia
delta = 0.0001 * ones(1,N); % Adaptación al calentamiento en la tasa de mortalidad de los depredadores
beta = 0.01 * ones(1,N); % Sensibilidad a la temperatura en la tasa de mortalidad de los depredadores
sigma = 3 * ones(1,N); % Ancho de la función de tasa de ataque
Topt_y_0 = 18 * ones(1,N); % Temperatura óptima de los depredadores
eta = 3 * ones(1,N); % Plasticidad del rasgo de los depredadores
Gy = 0.01 * ones(1,N); % Velocidad de evolución de los depredadores

umbral1 = 1e-5;
umbral2 = 1;

% Condiciones iniciales
x1 = 20 * ones(1,N);
x2 = 0 * ones(1,N);
x3 = 10 * ones(1,N);
x4 = 0 * ones(1,N);
x5 = 14:(14+N-1);

x0 = [];

for l = 1:N
    x0 = [x0, x1(l), x2(l), x3(l), x4(l), x5(l)]; 
end

% Intervalo de tiempo
t_custom = linspace(0, 5000, 1000); % Aquí 1000 es el número de puntos de tiempo

% Simulación del modelo
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[tv, Yv] = ode45(@(t, Y) vivi_combined_diff_eq(t, Y, bmax, theta, m0, alpha, gamma, c, Topt_x_0, mu, epsilon, Gx, amax, phi, h_opt, p, q0, delta, beta, sigma, Topt_y_0, eta, Gy, Ax, Ay, N), t_custom, x0, options);
Yv(Yv < 0) = 0;

end

function dY = vivi_combined_diff_eq(~, Y, bmax, theta, m0, alpha, gamma, c, Topt_x_0, mu, epsilon, Gx, amax, phi, h_opt, p, q0, delta, beta, sigma, Topt_y_0, eta, Gy, Ax, Ay, N)
% Cálculo de dY

% Inicializar el vector de salida
dY = zeros(5*N,1);

for i = 1:N
    dispersion_prey_left = 0;
    dispersion_prey_right = 0;
    dispersion_predator_left = 0;
    dispersion_predator_right = 0;

    if i > 1
        dispersion_prey_left = Ax(i-1,i) * Y(5*(i-1)-4) - Ax(i,i-1) * Y(5*i-4);
    end

    if i < N
        dispersion_prey_right = Ax(i+1,i) * Y(5*(i+1)-4) - Ax(i,i+1) * Y(5*i-4);
    end

    if i > 1
        dispersion_predator_left = Ay(i-1,i) * Y(5*(i-1)-2) - Ay(i,i-1) * Y(5*i-2);
    end

    if i < N
        dispersion_predator_right = Ay(i+1,i) * Y(5*(i+1)-2) - Ay(i,i+1) * Y(5*i-2);
    end

    b = bmax(i) * exp((-(Y(5*i) - (mu(i) * Y(5*i-3) + Topt_x_0(i)))^2) / (2 * theta(i)^2));
    b_u = b * mu(i) * (Y(5*i) - (mu(i) * Y(5*i-3) + Topt_x_0(i))) / (theta(i))^2;
    m = (m0(i) - gamma(i) * Y(5*i-3)) * exp(alpha(i) * Y(5*i));
    m_u = -gamma(i) * exp(alpha(i) * Y(5*i));
    a = amax(i) * exp((-(Y(5*i) - (eta(i) * Y(5*i-1) + Topt_y_0(i)))^2) / (2 * sigma(i)^2));
    h = phi(i) * (Y(5*i) - (eta(i) * Y(5*i-1) + Topt_y_0(i)))^2 + h_opt(i);
    q = (q0(i) - delta(i) * Y(5*i-1)) * exp(beta(i) * Y(5*i));
    F = Y(5*i-4) * a / (1 + a * h * Y(5*i-4));
    a_v = amax(i) * (exp((-(Y(5*i) - (eta(i) * Y(5*i-1) + Topt_y_0(i)))^2) / (2 * sigma(i)^2))) * eta(i) * (Y(5*i) - (eta(i) * Y(5*i-1) + Topt_y_0(i))) / sigma(i);
    h_v = -2 * phi(i) * (Y(5*i) - (eta(i) * Y(5*i-1) + Topt_y_0(i))) * eta(i);
    q_v = -delta(i) * exp(beta(i) * Y(5*i));
    F_v = (a_v * Y(5*i-4) * (1 + a * h * Y(5*i-4)) - (a_v * h * Y(5*i-4) + a * h_v * Y(5*i-4)) * a(i) * Y(5*i-4)) / (1 + a(i) * h(i) * Y(5*i-4))^2;

    dY(5*i-4) = Y(5*i-4) * (b - m) - c(i) * (Y(5*i-4))^2 - Y(5*i-2) * F + dispersion_prey_left + dispersion_prey_right;
    dY(5*i-3) = (1 - Y(5*i-3)) * Gx(i) * (b_u - m_u);
    dY(5*i-2) = p(i) * Y(5*i-2) * F - Y(5*i-2) * q(i) + dispersion_predator_left + dispersion_predator_right;
    dY(5*i-1) = (1 - Y(5*i-1)) * Gy(i) * (p(i) * F_v - q_v(i));
    dY(5*i) = epsilon(i);

    % Adaptación cuando T_{h} es mayor que T_{opt,0}
    if Y(5*i) < epsilon(i) * 200 + x5(i)
        dY(5*i) = epsilon(i);
    else
        dY(5*i) = 0;
    end

    if Y(5*i) <= Topt_x_0(i) + Y(5*k-3) * 3
        dY(5*i-3) = 0;
    else
        dY(5*i-3) = (1 - Y(5*i-3)) * Gx(i) * (b_u(i) - m_u(i)); 
    end

    if Y(5*i) <= Topt_y_0(i) + Y(5*k-1) * 3
        dY(5*i-1) = 0;
    else
        dY(5*i-1) = (1 - Y(5*i-1)) * Gy(i) * (p(i) * F_v(i) - q_v(i));
    end
end

end
