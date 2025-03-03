#  GHZ Entanglement in Q#

##  What is GHZ Entanglement?
GHZ (Greenberger-Horne-Zeilinger) states are a form of **multi-qubit entanglement** where **all qubits share the same quantum state**. This means measuring one qubit **instantly determines the state of the others**.

**Quantum Property:**  
For a 3-qubit GHZ state, the only possible measurements are: 000 or 111

This **correlation is preserved across all qubits**, even when measured independently.

---

## How This Q# Program Works
1. **Creates 3 qubits in the |0⟩ state**.
2. **Applies a Hadamard gate** to the first qubit to create superposition.
3. **Uses two CNOT gates** to entangle the second and third qubits.
4. **Measures all 3 qubits** and displays the results.

---

## How to Run This Program
### **1️⃣ Clone This Repository**
```bash
git clone https://github.com/tomblanchard312/azurequantum.git
cd azurequantum/GHZEntanglement
