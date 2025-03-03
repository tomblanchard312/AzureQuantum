namespace QuantumEntanglement {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation CreateEntanglement() : Unit {
        use q1 = Qubit();
        use q2 = Qubit();

        // Apply Hadamard to q1
        H(q1);

        // Apply CNOT to create entanglement
        CNOT(q1, q2);

        // Measure both qubits
        let result1 = M(q1);
        let result2 = M(q2);

        Message($"Qubit 1: {result1}");
        Message($"Qubit 2: {result2}");

        // Reset qubits before releasing them
        Reset(q1);
        Reset(q2);
    }
}
