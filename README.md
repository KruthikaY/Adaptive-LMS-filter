# 🎯 Adaptive LMS Filter – MATLAB + SystemVerilog + HEX Dataflow

This repository demonstrates the design and simulation of an **Adaptive Least Mean Squares (LMS) Filter** using both **MATLAB** and **SystemVerilog**. The project integrates `.hex`-formatted signal data, simulates real-time weight learning, and outputs quantized performance metrics including error and convergence behavior.

---

## 📁 Repository Structure

- `lms.sv` – LMS core logic in SystemVerilog  
- `top.sv` – Top-level hardware wrapper  
- `input.sv` – Reads input signal from `.hex` file  
- `desired.sv` – Reads desired signal from `.hex` file  
- `lms.m` – MATLAB model of LMS algorithm  
- `test/test.sv` – LMS testbench for simulation  

- `data/` – Input and log data  
  - `input.hex` – Quantized input signal  
  - `desired.hex` – Quantized desired signal  
  - `log.text` – Error and weight log during LMS update  

- `plots_and_outputs/` – Simulation results and figures  
  - `Waveform - LSM.png` – Output waveform  
  - `Error - LSM.png` – Learning error over time  
  - `y vs d - LSM.png` – Output signal vs. desired signal  
  - `weight convergence - LSM.png` – Coefficient evolution  
  - `LMS modelsim result.png` – ModelSim terminal/output log 




---

## 📌 Key Highlights

- **Dual Implementation:** MATLAB (floating-point reference) and SystemVerilog (bit-accurate design)
- **Data Interfacing:** Input and desired signals provided via `.hex` files, aligned with real-world embedded pipelines
- **Weight Update Rule:**  
  $w(n+1) = w(n) + \mu \cdot x(n) \cdot (d(n) - y(n))$
- **Simulation-Ready:** Testbench-ready format for RTL simulation in ModelSim
- **Quantized Logs:** System response (output, error, weights) logged and plotted

---

## 🔧 How to Run

### MATLAB Simulation

1. Place `input.hex` and `desired.hex` in the `data/` directory.
2. Open and run `src/lms.m`.
3. Generated logs (e.g., `log.text`) and convergence plots appear in the `plots_and_outputs/` directory.

### 🖥️ SystemVerilog Simulation (ModelSim)
vlog src/*.sv test/test.sv  
vsim work.test
Run simulation and inspect waveform:

Waveform - LSM.png

LMS modelsim result.png

---

## 📄 About .hex Files
The .hex format used in this project adheres to industry-standard Verilog Memory Initialization.

It enables:

- FPGA prototyping
- Memory–mapped I/O
- Filter coefficient loading
- Data–driven digital design flows

By using .hex, the project ensures cross-compatibility between MATLAB simulations and Verilog hardware implementation.

---

## 📊 Output Plots
Plot File	Description
Waveform - LSM.png	Simulated LMS signal waveform
Error - LSM.png	LMS output error over time
y vs d - LSM.png	Output signal vs. desired signal
weight convergence - LSM.png	Per-weight evolution (adaptive behavior)
LMS modelsim result.png	ModelSim terminal/output log capture

---

## 🧠 Importance of LMS in Real Applications
LMS filters are widely applied in:

- Adaptive noise cancellation
- Echo suppression
- Channel equalization
- System identification
- Biomedical signal denoising

