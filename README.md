# Temperature-Dependent Consumer-Resource Model

This repository contains MATLAB code used to explore the eco-evolutionary dynamics of a **temperature-dependent consumer-resource model**, incorporating **adaptation**, **dispersal**, and **parameter sensitivity**.

##  Contents

The repository includes:

- 🔁 **Parameter sweep scripts**  
  Explore how different parameter combinations (e.g., attack rate, growth rate, mutation cost) affect the dynamics of the system across multiple species and traits.

- 📈 **Time series simulations**  
  Scripts that solve the model using `ODE45` and generate trajectories for prey, native consumers, exotic consumers, and their traits under different conditions.

- 🌍 **Metapopulation model with dispersal**  
  Code that simulates spatial dynamics by allowing species to disperse across patches (i.e., a spatially explicit metapopulation framework).

- 📊 **Average density and extinction probability analysis**  
  Scripts that calculate average population densities and extinction probabilities under different temperature scenarios and phenotypic change conditions.

- 🌀 **Chaos detection via Poincaré sections**  
  Tools to explore complex dynamical behavior (e.g., periodicity, chaos) by constructing Poincaré sections from long-term numerical simulations.

## 🔧 How to Use

1. Clone or download the repository.
2. Open the desired script in MATLAB.
3. Modify the parameter ranges or initial conditions as needed.
4. Run the script to generate time series, heatmaps, or diagnostic plots.
5. Use the figures and output files to analyze persistence, invasion success, or chaotic behavior.

## 💡 Notes

- Most simulations are solved using `ode45`, with high numerical precision (`RelTol = 1e-8`, `AbsTol = 1e-10`).
- For long simulations (e.g., Poincaré sections), a convergence threshold is used to reduce runtime.
- Parameter values and biological interpretations are included as comments in each script.

## 👩‍🔬 Author

**Viviana Rivera-Estay**  
PhD in Applied Mathematical Modeling  
Email: Viviana Rivera-Estay
