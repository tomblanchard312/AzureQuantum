# Quantum Entanglement in Q#

## What is Quantum Entanglement?
Quantum entanglement is a phenomenon in which **two or more qubits become linked** so that their states are **always correlated**, no matter how far apart they are.

If you measure one entangled qubit, the result **immediately determines** the state of the other, even if they are **light-years apart**.

This property is fundamental for **Quantum Computing, Quantum Cryptography, and Quantum Teleportation**.

---

## How This Q# Program Works
This Q# program **creates and measures an entangled Bell state** between two qubits.

### **Steps:**
1. Start with **two qubits** in the |0⟩ state.
2. Apply a **Hadamard (H) gate** to the first qubit to create superposition.
3. Use a **CNOT gate** to entangle the second qubit with the first.
4. Measure both qubits.
5. Display the results.

🔹 **Expected Output:**  
Both qubits will always have the **same measurement** (`00` or `11`), proving entanglement!

---

## How to Run This Program
### ** Install QDK (Quantum Development Kit)**
Make sure you have the **.NET SDK and QDK** installed:

```
   dotnet new install Microsoft.Quantum.ProjectTemplates

## *1. Clone This Repository

```
    git clone https://github.com/tomblanchard312/azurequantum.git
    cd azurequantum/QuantumEntanglement

## *2. Run the Q# Program

```
    dotnet run

## *3. Expected Results

When you run the program, you will see:

Qubit 1: One
Qubit 2: One

or 

Qubit 1: One
Qubit 2: One

