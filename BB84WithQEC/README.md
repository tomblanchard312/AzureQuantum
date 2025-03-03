# BB84 Quantum Key Distribution with Error Correction

This project implements the BB84 quantum key distribution protocol with a simple error correction mechanism using Q#. The implementation demonstrates the fundamental principles of quantum key distribution, including qubit preparation, measurement in different bases, and error correction using majority voting.

## Overview

BB84 is a quantum key distribution protocol developed by Charles Bennett and Gilles Brassard in 1984. It allows two parties (traditionally named Alice and Bob) to establish a shared secret key using quantum communication. This implementation includes:

1. Alice's qubit preparation in random bases
2. Simulated quantum channel noise
3. Bob's measurements in random bases
4. Error correction using a 3-bit majority voting scheme

## Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- [Microsoft Quantum Development Kit](https://docs.microsoft.com/azure/quantum/)

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd BB84WithQEC
   ```

2. Build the project:
   ```bash
   dotnet build
   ```

## Usage

Run the application with the desired number of bits:

```bash
dotnet run -- --n-bits <number-of-bits>
```

For example, to run with 16 bits:

```bash
dotnet run -- --n-bits 16
```

Note: The number of bits should be a multiple of 3 for the error correction mechanism to work properly (as it uses 3-bit blocks for majority voting).

## How It Works

### Alice's Preparation
1. Alice generates random bits and random bases (Z or X)
2. She prepares qubits according to these bits and bases:
   - Bit 0 in Z-basis: |0⟩
   - Bit 1 in Z-basis: |1⟩
   - Bit 0 in X-basis: |+⟩
   - Bit 1 in X-basis: |-⟩

### Quantum Channel Simulation
- The code simulates noise by randomly applying bit-flip errors to some qubits

### Bob's Measurement
1. Bob randomly selects measurement bases (Z or X) for each qubit
2. He measures each qubit in his chosen basis and records the results

### Error Correction
1. Bob applies a simple 3-bit majority voting scheme to correct errors
2. Every 3 consecutive bits are grouped, and the majority value is used as the corrected bit

## Code Structure

- `Operations.qs`: Contains the main Q# code implementing the BB84 protocol with error correction
  - `BB84WithErrorCorrection`: The main entry point operation
  - `SumArray`: Helper function to sum array elements
  - `CorrectErrors`: Implements 3-bit majority voting error correction

## Limitations

- This implementation is simplified for educational purposes
- In a real BB84 implementation, Alice and Bob would also:
  - Perform basis reconciliation (keeping only the bits where they used the same basis)
  - Implement privacy amplification
  - Perform more sophisticated error correction
- The current error correction assumes the number of bits is divisible by 3


