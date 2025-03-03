# Quantum Entanglement

This project demonstrates the fundamental concept of quantum entanglement using Q#. It creates and measures a Bell pair, which is the simplest form of quantum entanglement between two qubits.

## Overview

Quantum entanglement is a phenomenon where two or more particles become correlated in such a way that the quantum state of each particle cannot be described independently of the others. This implementation:

1. Creates a Bell pair (an entangled state of two qubits)
2. Measures both qubits
3. Demonstrates the correlated measurement outcomes

## Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- [Microsoft Quantum Development Kit](https://docs.microsoft.com/azure/quantum/)

## Usage

Run the application:

```bash
dotnet run
```

## How It Works

### Creating Entanglement
1. Initialize two qubits to |00⟩
2. Apply a Hadamard gate to the first qubit, creating a superposition: (|0⟩ + |1⟩)|0⟩
3. Apply a CNOT gate with the first qubit as control and the second as target
4. This creates the Bell state: |00⟩ + |11⟩ (unnormalized)

### Measurement
- Both qubits are measured in the standard basis
- Due to entanglement, the measurements will always yield the same result
- If the first qubit is measured as 0, the second will also be 0
- If the first qubit is measured as 1, the second will also be 1

## Code Structure

- `Operations.qs`: Contains the Q# code that creates and measures the entangled state
  - `CreateEntanglement`: The main entry point operation

## Significance of Entanglement

Entanglement is a fundamental quantum resource that enables:
- Quantum teleportation
- Superdense coding
- Quantum key distribution
- Quantum computing speedups
- Violations of Bell inequalities, demonstrating the non-local nature of quantum mechanics

## Related Quantum Projects

Check out other quantum computing projects in this repository:
- [BB84WithQEC](../BB84WithQEC/) - Quantum key distribution with error correction
- [GHZEntanglement](../GHZEntanglement/) - Creates and measures a 3-qubit GHZ entangled state
- [QuantumErrorCorrection](../QuantumErrorCorrection/) - Implements a three-qubit bit-flip code
- [QuantumHelloWorld](../QuantumHelloWorld/) - Simple "Hello World" quantum program