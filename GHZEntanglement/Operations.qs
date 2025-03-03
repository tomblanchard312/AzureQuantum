namespace GHZEntanglement {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation CreateGHZState() : Unit {
        use qs = Qubit[3]; // Allocate 3 qubits

        // Apply a Hadamard gate to the first qubit to create superposition
        H(qs[0]);

        // Apply CNOT gates to entangle all 3 qubits
        CNOT(qs[0], qs[1]);
        CNOT(qs[1], qs[2]);

        // Measure all qubits
        let results = [M(qs[0]), M(qs[1]), M(qs[2])];

        Message($"GHZ State Measurement: {results}");

        // Reset qubits
        for q in qs {
            Reset(q);
        }
    }
}
