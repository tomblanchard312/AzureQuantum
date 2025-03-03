# BB84 Quantum Key Distribution with Post-Quantum Cryptography

This project demonstrates a hybrid quantum-classical cryptographic system that combines the BB84 quantum key distribution protocol with post-quantum cryptography (PQC). It showcases how quantum mechanics can be used for secure key establishment while classical post-quantum algorithms protect against both classical and quantum attacks.

## Overview

The solution consists of two projects:

1. **BB84.Quantum**: A Q# library that implements the BB84 quantum key distribution protocol
2. **BB84.ConsoleApp**: A C# console application that integrates with the Q# library and implements post-quantum cryptographic algorithms

Together, they create a complete hybrid security system that is resistant to attacks from both classical and quantum computers.

## Prerequisites

- [.NET SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- [Microsoft Quantum Development Kit](https://docs.microsoft.com/azure/quantum/)

## Building and Running

To build the solution:

```bash
dotnet build
```

To run the application:

```bash
cd BB84.Console
dotnet run [number-of-qubits]
```

For example, to run with 12 qubits:

```bash
dotnet run 12
```

**Note**: The local quantum simulator has limitations on the number of qubits it can handle. I recommend using 12-18 qubits for optimal performance. The program will automatically cap the maximum at 24 qubits to prevent simulator crashes.

## How It Works

### Quantum Key Distribution (BB84 Protocol)

The BB84 protocol, implemented in Q#, works as follows:

1. **Qubit Preparation**:
   - Alice generates random bits and random bases (Z or X)
   - She prepares qubits according to these bits and bases:
     - Bit 0 in Z-basis: |0⟩
     - Bit 1 in Z-basis: |1⟩
     - Bit 0 in X-basis: |+⟩
     - Bit 1 in X-basis: |-⟩

2. **Quantum Channel**:
   - The qubits are transmitted through a simulated quantum channel
   - The channel introduces noise at a 5% level (simulating potential eavesdropping)

3. **Bob's Measurement**:
   - Bob randomly selects measurement bases (Z or X) for each qubit
   - He measures each qubit in his chosen basis
   - If Bob measures in the same basis that Alice prepared the qubit, he should get the same result (except for noise)

4. **Basis Reconciliation**:
   - Alice and Bob publicly compare their basis choices
   - They keep only the bits where they used the same basis
   - This process doesn't reveal the actual bit values, just which bases matched

5. **Error Estimation and Privacy Amplification**:
   - Some bits are sacrificed to estimate the error rate
   - If the error rate is too high, it could indicate eavesdropping
   - The remaining bits undergo privacy amplification to reduce any information an eavesdropper might have

### Post-Quantum Cryptography Integration

The C# code implements simulated versions of these post-quantum algorithms:

1. **CRYSTALS-Kyber** - A lattice-based Key Encapsulation Mechanism (KEM):
   - Uses the quantum-derived key as seed material
   - Generates a public/private key pair
   - Encapsulates a shared secret
   - The shared secret is used for symmetric encryption

2. **CRYSTALS-Dilithium** - A lattice-based digital signature scheme:
   - Uses the quantum-derived key as seed material
   - Generates a signing key pair
   - Signs messages to ensure authenticity
   - Verifies signatures to prevent tampering

3. **AES-256-GCM** - A symmetric encryption algorithm:
   - Uses the Kyber-derived shared secret as the encryption key
   - Provides confidentiality and integrity for the message
   - Protects against tampering and unauthorized access

## Project Structure

- **BB84.Quantum/**
  - `Operations.qs`: Q# implementation of the BB84 protocol
  - `BB84.Quantum.csproj`: Project file for the Q# library

- **BB84.Console/**
  - `Program.cs`: Main entry point coordinating Q# and C#
  - `Classical/PostQuantumCrypto.cs`: Implementation of PQC algorithms
  - `BB84.Console.csproj`: Project file for the C# console application

## Security Benefits

This hybrid approach offers multiple layers of security:

1. **Quantum-Secure Key Distribution**:
   - BB84 provides information-theoretic security based on quantum mechanics
   - Eavesdropping on the quantum channel can be detected through increased error rates
   - The quantum no-cloning theorem prevents copying of the qubits

2. **Post-Quantum Security**:
   - CRYSTALS-Kyber (lattice-based) is designed to resist quantum algorithms
   - CRYSTALS-Dilithium (lattice-based) provides signatures that resist quantum attacks
   - Both are NIST Post-Quantum Cryptography standardization finalists

3. **Defense in Depth**:
   - An attacker would need to compromise both the quantum and post-quantum components
   - Multiple layers of encryption and authentication protect the data

## Implementation Notes

- This is a simulation for educational purposes
- In a real implementation, you would use:
  - Actual quantum hardware for BB84 (or a trusted QKD device)
  - Production-ready PQC libraries (e.g., liboqs, BouncyCastle PQC)
  - Proper key management and secure storage solutions

- The current implementation simulates PQC algorithms and doesn't use real implementations
- The local quantum simulator has limitations on the number of qubits it can handle

## Future Enhancements

- Improve error handling in the quantum channel simulation
- Add parameter estimation to detect eavesdropping
- Implement more sophisticated privacy amplification techniques
- Add authentication during the classical post-processing phase
- Integrate with actual PQC libraries for real post-quantum security

## References

- NIST Post-Quantum Cryptography: https://csrc.nist.gov/projects/post-quantum-cryptography
- CRYSTALS-Kyber: https://pq-crystals.org/kyber/
- CRYSTALS-Dilithium: https://pq-crystals.org/dilithium/
- BB84 Protocol: Bennett, C. H., & Brassard, G. (1984). Quantum cryptography: Public key distribution and coin tossing.
- Microsoft Quantum Development Kit: https://docs.microsoft.com/quantum/
