# Quantum Error Correction

This project demonstrates a simple quantum error correction technique using the three-qubit bit-flip code in Q#. It shows how redundant encoding can protect quantum information against specific types of errors.

## Overview

Quantum systems are highly susceptible to errors from environmental interactions. Quantum error correction allows us to detect and correct these errors, making reliable quantum computation possible. This implementation:

1. Encodes a single logical qubit across three physical qubits
2. Deliberately introduces an error
3. Detects and corrects the error
4. Measures the final state

## Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- [Microsoft Quantum Development Kit](https://docs.microsoft.com/azure/quantum/)

## Usage

Run the application:

```bash
dotnet run
```

## How It Works

### Encoding
1. Start with a data qubit and two ancilla (helper) qubits
2. Use CNOT gates to copy the state of the data qubit to the ancilla qubits
3. This creates a redundant encoding: |0⟩ → |000⟩ or |1⟩ → |111⟩

### Error Introduction
- The code deliberately applies an X gate (bit-flip) to the first ancilla qubit
- This simulates an error occurring in the quantum system

### Error Detection and Correction
1. Perform syndrome measurements to detect which qubit has been flipped
2. Based on the syndrome measurements, apply corrective operations:
   - If the data qubit flipped, apply X to the data qubit
   - If ancilla[0] flipped, apply X to ancilla[0]
   - If ancilla[1] flipped, apply X to ancilla[1]
   - If no error detected, do nothing

### Final Measurement
- The data qubit is measured to verify the correction worked

## Code Structure

- `Operations.qs`: Contains the Q# code implementing the three-qubit bit-flip code
  - `ThreeQubitBitFlipCode`: The main entry point operation

## Limitations

- The three-qubit bit-flip code only protects against X (bit-flip) errors
- It cannot correct Z (phase-flip) errors or simultaneous errors on multiple qubits
- More sophisticated codes like the Shor code or surface codes are needed for full error protection

## Related Quantum Projects

Check out other quantum computing projects in this repository:
- [BB84WithQEC](../BB84WithQEC/) - Quantum key distribution with error correction
- [GHZEntanglement](../GHZEntanglement/) - Creates and measures a 3-qubit GHZ entangled state
- [QuantumEntanglement](../QuantumEntanglement/) - Demonstrates basic two-qubit entanglement
- [QuantumHelloWorld](../QuantumHelloWorld/) - Simple "Hello World" quantum program