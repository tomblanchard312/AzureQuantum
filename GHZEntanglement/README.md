# GHZ State Entanglement

This project demonstrates the creation and measurement of a GHZ (Greenberger-Horne-Zeilinger) entangled state using Q#. The GHZ state is a type of multipartite entangled quantum state that has important applications in quantum information theory and quantum networking.

## Overview

The GHZ state is a maximally entangled state of three or more qubits. This implementation:

1. Creates a 3-qubit GHZ state of the form: |000⟩ + |111⟩ (unnormalized)
2. Measures all qubits in the standard basis
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

### Creating the GHZ State
1. Initialize three qubits to |000⟩
2. Apply a Hadamard gate to the first qubit, creating a superposition: (|0⟩ + |1⟩)|00⟩
3. Apply CNOT gates to entangle all three qubits, creating the state: |000⟩ + |111⟩

### Measurement
- All three qubits are measured in the standard basis
- Due to entanglement, all qubits will be measured as 0 or all will be measured as 1

## Code Structure

- `Operations.qs`: Contains the Q# code that creates and measures the GHZ state
  - `CreateGHZState`: The main entry point operation

## Significance of GHZ States

GHZ states are important in quantum information for several reasons:
- They demonstrate genuine multipartite entanglement
- They can be used to disprove local hidden variable theories more strongly than Bell pairs
- They have applications in quantum secret sharing and quantum networking
- They're useful in quantum error correction codes

## Properties of GHZ States

- Perfect correlations: If one qubit is measured, all other qubits must be in the same state
- Maximum entanglement: GHZ states are maximally entangled across all partitions
- Sensitivity to errors: A single bit-flip error on any qubit destroys the entanglement

## Related Quantum Projects

Check out other quantum computing projects in this repository:
- [BB84WithQEC](../BB84WithQEC/) - Quantum key distribution with error correction
- [QuantumEntanglement](../QuantumEntanglement/) - Demonstrates basic two-qubit entanglement
- [QuantumErrorCorrection](../QuantumErrorCorrection/) - Implements a three-qubit bit-flip code
- [QuantumHelloWorld](../QuantumHelloWorld/) - Simple "Hello World" quantum program