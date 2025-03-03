namespace QuantumErrorCorrection {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation ThreeQubitBitFlipCode() : Unit {
        use dataQubit = Qubit();
        use ancilla = Qubit[2];

        // Encode: Copy data qubit to ancilla qubits
        CNOT(dataQubit, ancilla[0]);
        CNOT(dataQubit, ancilla[1]);

        Message("Encoding Complete: Qubits are now redundant copies.");

        // Introduce an error (simulate a bit-flip on the first ancilla)
        X(ancilla[0]); // Simulating a bit-flip error on ancilla[0]

        Message("Error introduced on ancilla[0].");

        // Syndrome Measurement: Detect which qubit flipped
        let syndrome0 = M(ancilla[0]);
        let syndrome1 = M(ancilla[1]);

        // Compare individual elements instead of using `==` on arrays
        if (syndrome0 == One and syndrome1 == Zero) {
            X(dataQubit); // Correct data qubit
            Message("Error detected and corrected on data qubit.");
        }
        elif (syndrome0 == Zero and syndrome1 == One) {
            X(ancilla[0]); // Correct first ancilla
            Message("Error detected and corrected on ancilla[0].");
        }
        elif (syndrome0 == One and syndrome1 == One) {
            X(ancilla[1]); // Correct second ancilla
            Message("Error detected and corrected on ancilla[1].");
        }
        else {
            Message("No error detected.");
        }

        // Final measurement
        let finalState = M(dataQubit);
        Message($"Final Data Qubit State: {finalState}");

        // Reset qubits before releasing
        Reset(dataQubit);
        for q in ancilla {
            Reset(q);
        }
    }
}
