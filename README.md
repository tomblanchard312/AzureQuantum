# Azure Quantum Project

## Overview
The **Azure Quantum Project** is a collection of Q# programs designed to explore **Quantum Computing** concepts. Each program focuses on different quantum algorithms and cryptographic techniques, leveraging the power of **Q# and Azure Quantum**.

🔹 **Current Programs:**
-  [`QuantumHelloWorld`](QuantumHelloWorld/) → **Basic Quantum Circuit (Superposition)**
-  [`QuantumEntanglement`](QuantumEntanglement/) → **Bell State Entanglement Experiment**
-  [`GHZ Entanglement`](GHZ Entanglement/) → **GHZ Entanglement in Q#**

---

## How to Set Up & Run

### ** Install QDK (Quantum Development Kit) **
Ensure you have the **.NET SDK and QDK installed**:
```bash
dotnet new install Microsoft.Quantum.ProjectTemplates
Running on Azure Quantum
To execute programs on real quantum hardware, authenticate with Azure Quantum:

# Sign in to Azure

```
    az login

# Set up Azure Quantum workspace

```
    az quantum workspace set --resource-group YOUR_RESOURCE_GROUP --workspace-name YOUR_WORKSPACE

# Submit a job

```
    dotnet run -- --target ionq.qpu

This runs the quantum algorithm on real quantum hardware!