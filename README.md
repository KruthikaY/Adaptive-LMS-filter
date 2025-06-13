# 🎯 Adaptive LMS Filter – MATLAB + SystemVerilog + HEX Dataflow

This project demonstrates the implementation of an **Adaptive Least Mean Squares (LMS) Filter** in both **MATLAB** and **SystemVerilog**, with signal and weight logging, input generation using `.hex` files, and visual performance analysis. It highlights how LMS can dynamically adjust weights to minimize error between an input and desired signal, simulating real-time learning behavior.

---

## 📂 Repository Structure

Adaptive-LMS-Filter/
│
├── src/ # Core source files
│ ├── lms.sv # LMS hardware logic (SystemVerilog)
│ ├── top.sv # Top-level hardware wrapper
│ ├── input.sv # Reads input signal from hex
│ ├── desired.sv # Reads desired signal from hex
│ ├── lms.m # MATLAB LMS software model
│
├── test/
│ └── test.sv # LMS testbench for simulation
│
├── data/ # Input/Output logs & .hex files
│ ├── input.hex # Quantized input signal
│ ├── desired.hex # Quantized desired signal
│ └── log.text # Error and weight log from MATLAB
│
├── plots_and_outputs/ # Results and simulations
│ ├── LMS modelsim result.png
│ ├── Waveform - LSM.png
│ ├── Error - LSM.png
│ ├── y vs d - LSM.png
│ ├── weight convergence - LSM.png
│
└── README.md # This file

---

## 📌 Key Features

- **Dual Implementation:** MATLAB script vs hardware (SystemVerilog)
- **Industrial `.hex` Inputs:** Mimics real-world hardware interfacing
- **Weight Update Equation:**  
  $w(n+1) = w(n) + \mu \cdot x(n) \cdot e(n)$  
  where $e(n) = d(n) - y(n)$
- **Quantized Simulation Logs:** LMS behavior logged and plotted
- **ModelSim Output:** RTL-level LMS weight adjustment

---

## ⚙️ How to Run

### 🧠 MATLAB

1. Open `src/lms.m`
2. Ensure `input.hex` and `desired.hex` are in the `/data/` folder
3. Run the script to simulate adaptive learning
4. Output:
   - `log.text` is generated containing error and weights

### 🧪 SystemVerilog (ModelSim)

```sh
vlog src/*.sv test/test.sv
vsim work.test
Open waveform viewer to inspect signal tracking

You’ll observe LED-style weight updates and error convergence

📁 About .hex Format
.hex is the Intel HEX or Verilog Memory Initialization format used to interface hardware with real-world data

It ensures simulation tools (like ModelSim or Quartus) can preload memory blocks in actual FPGA workflows

Commonly used in:

Memory-mapped sensor input

Test vector automation

FPGA DSP pipelines

✅ This makes the LMS filter design directly portable to FPGA hardware testbenches.

📊 Results & Observations
Plot	Description
LMS modelsim result.png	Internal output values from ModelSim
Waveform - LSM.png	Signal activity over time
Error - LSM.png	Convergence of LMS error
y vs d - LSM.png	Output vs Desired signal match
weight convergence - LSM.png	Dynamic weight evolution

🧠 Why LMS Matters
LMS is the foundation of adaptive filters used in:

Echo cancellation

Noise reduction

System identification

Channel equalization

It forms the bridge between signal processing and embedded system intelligence

🛠️ This project shows how LMS logic learns directly from live data using industrial formats, paving the way for deployable, intelligent signal-processing hardware.

