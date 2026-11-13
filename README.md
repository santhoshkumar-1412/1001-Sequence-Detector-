
# 1001 Sequence Detector using Verilog HDL

### RTL Design | Finite State Machine | Functional Verification

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![FSM](https://img.shields.io/badge/Architecture-Moore%20FSM-green)
![VCS](https://img.shields.io/badge/Simulation-Synopsys%20VCS-orange)
![Verdi](https://img.shields.io/badge/Debugging-Synopsys%20Verdi-purple)

---

## 1. Project Overview

This project presents the RTL design and functional verification of a **1001 Sequence Detector** using Verilog Hardware Description Language (HDL).

A sequence detector is a sequential digital circuit designed to identify a specific binary pattern in a serial input stream.

The objective of this project is to implement a **Moore Finite State Machine (FSM)** that detects the binary sequence `1001` and generates an output signal when the complete sequence is detected.

The design consists of five states, with state transitions controlled by the serial input and positive-edge-triggered clock. An asynchronous active-high reset initializes the FSM to its initial state.

The RTL design is simulated using **Synopsys VCS**, and waveform visualization and debugging are performed using **Synopsys Verdi**.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Project Name | 1001 Sequence Detector |
| Design Type | Sequential Logic |
| FSM Architecture | Moore FSM |
| Target Sequence | 1001 |
| Input | 1-bit serial input (x) |
| Output | 1-bit detection output (y) |
| Clock | Positive-edge triggered |
| Reset | Asynchronous active-high |
| Number of States | 5 |
| HDL | Verilog |
| Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | FSDB |

## 3. FSM Architecture

The design uses a Moore Finite State Machine, where the output depends only on the present state.

Five states are defined to identify the incoming binary sequence `1001`.

### 3.1 State Description

| State | Binary Encoding | Description | Output |
|---|---|---|---|
| A | 000 | Initial state | 0 |
| B | 001 | Detected `1` | 0 |
| C | 010 | Detected `10` | 0 |
| D | 011 | Detected `100` | 0 |
| E | 100 | Detected `1001` | 1 |

### 3.2 State Transition Table

The next state is determined by the present state and current input.

| Present State | Input = 0 | Input = 1 |
|---|---|---|
| A | A | B |
| B | C | B |
| C | D | B |
| D | A | E |
| E | C | B |

### 3.3 Output Logic

The output becomes HIGH only when the FSM reaches state E.

- State A: Output = 0
- State B: Output = 0
- State C: Output = 0
- State D: Output = 0
- State E: Output = 1

The design supports overlapping sequence detection by retaining the relevant suffix of the detected input pattern.

## 4. Design Methodology

The RTL implementation is divided into three major functional blocks.

### 4.1 State Register

- Stores the current FSM state.
- Triggered by the positive edge of the clock.
- Supports asynchronous active-high reset.
- Initializes the FSM to state A when reset is asserted.

### 4.2 Next State Logic

- Determines the next FSM state.
- Uses the current state and serial input as decision variables.
- Implements state transitions using a Verilog case statement.
- Handles different input combinations for all five states.

### 4.3 Output Logic

- Generates the sequence detection output.
- Depends only on the current FSM state.
- Produces HIGH when the FSM enters state E.

## 5. RTL Module Description

**Module Name:** `seq_det_1001`

| Port | Direction | Width | Description |
|---|---|---|---|
| y | Output | 1-bit | Sequence detection output |
| x | Input | 1-bit | Serial data input |
| clk | Input | 1-bit | Clock signal |
| rst | Input | 1-bit | Asynchronous active-high reset |

### Internal Registers

| Register | Width | Description |
|---|---|---|
| state | 3-bit | Present FSM state |
| next_state | 3-bit | Next FSM state |

The FSM uses five encoded states represented by 3-bit parameters.

## 6. Repository Structure

```text
1001-sequence-detector/
│
├── seq_det_1001.v
│   └── FSM RTL design
│
├── seq_det_1001_tb.v
│   └── Verilog testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

## 7. Functional Verification

A Verilog testbench is developed to verify the functionality of the sequence detector.

The testbench generates a clock signal with a 10 ns period and applies reset and serial input patterns to the Device Under Test (DUT).

### 7.1 Testbench Configuration

- Clock period: 10 ns
- Clock frequency: 100 MHz
- Reset type: Asynchronous active-high
- Input: Serial binary data
- Output: Sequence detection signal
- Simulation duration: 110 ns

### 7.2 Test Input Sequence

The testbench applies the following serial input pattern:

`1 → 0 → 0 → 1 → 1 → 0 → 0 → 1`

The first four bits represent the target sequence `1001`.

The FSM follows the state transition sequence:

`A → B → C → D → E`

When the FSM reaches state E, the output becomes HIGH.

The subsequent input bits also contain another occurrence of `1001`, allowing the detection behavior to be observed again.

### 7.3 Expected Detection Behavior

| Input Pattern | FSM State | Expected Output |
|---|---|---|
| Initial | A | 0 |
| 1 | B | 0 |
| 10 | C | 0 |
| 100 | D | 0 |
| 1001 | E | 1 |

The output remains HIGH while the FSM is in state E. At the next active clock edge, the FSM transitions according to the next input and the output returns LOW.

## 8. Simulation Using Synopsys VCS

Synopsys VCS is used to compile and simulate the Verilog RTL design and testbench.

### 8.1 Compilation

Compile the RTL and testbench files using:

```bash
vcs -full64 -debug_access+all \
seq_det_1001.v \
seq_det_1001_tb.v \
-o simv
```

Ensure the appropriate FSDB PLI integration is configured if FSDB dumping is enabled.

### 8.2 Execute Simulation

```bash
./simv
```

The testbench executes the input sequence and displays simulation results using the `$monitor` system task.

### 8.3 FSDB Waveform Generation

The testbench uses FSDB dump commands to generate waveform data.

```verilog
initial
begin
    $fsdbDumpfile("seq_det_1001.fsdb");
    $fsdbDumpvars(0, seq_det_1001_tb);
end
```

Ensure that the appropriate Verdi FSDB PLI integration is enabled during VCS compilation.

For FSDB-only generation, remove the `$dumpfile` and `$dumpvars` commands from the testbench.

### 8.4 Open Waveform in Synopsys Verdi

```bash
verdi -ssf seq_det_1001.fsdb &
```

The generated waveform can be inspected using the Verdi waveform viewer.

## 9. Waveform Analysis Using Synopsys Verdi

Synopsys Verdi is used to visualize and analyze the simulation waveforms.

The following signals are observed:

| Signal | Description |
|---|---|
| x | Serial input data |
| y | Sequence detection output |
| clk | Clock signal |
| rst | Asynchronous reset |

Waveform analysis helps verify:

- Correct clock generation.
- Asynchronous reset functionality.
- FSM state transitions.
- Detection of the input sequence `1001`.
- Output assertion after successful sequence detection.
- Correct sequential behavior of the design.

### Simulation Waveform

![1001 Sequence Detector Verdi Waveform](screenshots/verdi_waveform.png)

*Synopsys Verdi waveform showing the input, output, clock, and reset signals.*

## 10. Tools and Technologies

| Tool / Technology | Application |
|---|---|
| Verilog HDL | RTL design implementation |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| FSDB | Simulation waveform database |
| Git | Version control |
| GitHub | Project hosting and documentation |

## 11. Key Learning Outcomes

Through this project, the following concepts are explored:

- Sequential digital circuit design.
- Finite State Machine (FSM) implementation.
- Moore FSM architecture.
- Sequence detection using Verilog.
- State encoding and transition logic.
- Asynchronous reset implementation.
- Clock-driven sequential logic.
- Verilog testbench development.
- Functional verification.
- RTL simulation using Synopsys VCS.
- Waveform debugging using Synopsys Verdi.
- FSDB waveform generation and analysis.

## 12. Future Enhancements

- Implement the same sequence detector using Mealy FSM architecture.
- Compare Moore and Mealy FSM implementations.
- Extend the design to detect different binary sequences.
- Implement parameterized sequence detection.
- Perform RTL synthesis and area analysis.
- Compare different FSM state encoding techniques.
- Perform gate-level simulation.

## 13. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Electronics | VLSI Engineering

- GitHub: [Your GitHub Profile](https://github.com/your-username)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

## 14. License

This project is intended for educational and learning purposes.

Feel free to explore, modify, and extend the implementation with appropriate attribution.

---

**Designed with Verilog HDL | Simulated using Synopsys VCS | Debugged using Synopsys Verdi**

⭐ If you find this project useful, consider giving the repository a star!

---

### GitHub Topics

`verilog` `sequence-detector` `1001-sequence-detector` `moore-fsm` `finite-state-machine` `rtl-design` `digital-design` `vlsi` `synopsys-vcs` `synopsys-verdi` `fsdb` `rtl-verification`
