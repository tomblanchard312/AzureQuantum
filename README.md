# Azure Quantum Projects

This repository contains a collection of Q# projects demonstrating various quantum computing concepts. Each project is a standalone application that showcases different aspects of quantum computation.

## Projects Overview

### [BB84WithQEC](./BB84WithQEC/)
Implementation of the BB84 quantum key distribution protocol with simple error correction. This project demonstrates how quantum mechanics can be used for secure communication.

### [GHZEntanglement](./GHZEntanglement/)
Creates and measures a 3-qubit GHZ (Greenberger-Horne-Zeilinger) entangled state, demonstrating multipartite quantum entanglement.

### [QuantumEntanglement](./QuantumEntanglement/)
A simple demonstration of quantum entanglement between two qubits, creating and measuring a Bell pair.

### [QuantumErrorCorrection](./QuantumErrorCorrection/)
Implementation of the three-qubit bit-flip code for quantum error correction, showing how quantum information can be protected against errors.

### [QuantumHelloWorld](./QuantumHelloWorld/)
A basic "Hello World" program in Q#, serving as a starting point for quantum programming.

## Prerequisites

- [.NET Core SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- [Microsoft Quantum Development Kit](https://docs.microsoft.com/azure/quantum/)

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/tomblanchard312/AzureQuantum.git
   cd AzureQuantum
   ```

2. Navigate to any of the project directories:
   ```bash
   cd BB84WithQEC
   ```

3. Build the project:
   ```bash
   dotnet build
   ```

4. Run the project:
   ```bash
   dotnet run
   ```
   
   Note: Some projects like BB84WithQEC require command-line arguments:
   ```bash
   dotnet run -- --n-bits 16
   ```

## Learning Path

If you're new to quantum computing, here's a suggested order to explore these projects:

1. **QuantumHelloWorld**: Start with the basics
2. **QuantumEntanglement**: Learn about quantum entanglement with two qubits
3. **GHZEntanglement**: Explore multi-qubit entanglement
4. **QuantumErrorCorrection**: Understand how quantum information can be protected
5. **BB84WithQEC**: See a practical application of quantum principles in cryptography

## Additional Resources

- [Microsoft Quantum Documentation](https://docs.microsoft.com/quantum/)
- [Q# Language Guide](https://docs.microsoft.com/quantum/language/)
- [Azure Quantum](https://azure.microsoft.com/services/quantum/)
- [Q# Samples Repository](https://github.com/microsoft/Quantum)

To execute programs on real quantum hardware, authenticate with Azure Quantum:

# Sign in to Azure

   ```bash
    az login
   ```
# Set up Azure Quantum workspace

   ```bash
    az quantum workspace set --resource-group YOUR_RESOURCE_GROUP --workspace-name YOUR_WORKSPACE
   ```

# Submit a job

   ```bash
    dotnet run -- --target ionq.qpu
   ```
   
This runs the quantum algorithm on real quantum hardware!
