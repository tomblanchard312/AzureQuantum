namespace BB84WithQEC {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Random;

    @EntryPoint()
    operation BB84WithErrorCorrection(nBits : Int) : Unit {
        use aliceQubits = Qubit[nBits];  // Alice's qubits

        mutable aliceBits = [0, size=nBits];
        mutable aliceBases = [0, size=nBits];

        for i in 0..nBits - 1 {
            let bit = DrawRandomInt(0, 1);   // Random 0 or 1
            let basis = DrawRandomInt(0, 1); // Random basis (0 = Z, 1 = X)
            set aliceBits w/= i <- bit;
            set aliceBases w/= i <- basis;

            if (basis == 1) { H(aliceQubits[i]); } // Prepare in X basis if needed
            if (bit == 1) { X(aliceQubits[i]); }  // Apply bit flip if bit is 1
        }

        // Introduce Noise (Simulate a Bit-Flip on some qubits)
        for i in 0..nBits - 1 {
            let flip = (DrawRandomInt(0, 1) == 1);  // Ensures a Boolean type
            if flip { X(aliceQubits[i]); } // Applies X gate if flip is true
        }

        // Bob's measurement process
        mutable bobBases = [0, size=nBits];
        mutable bobResults = [0, size=nBits];

        for i in 0..nBits - 1 {
            let basis = DrawRandomInt(0, 1);   // Random basis (0 = Z, 1 = X)
            set bobBases w/= i <- basis;

            if (basis == 1) { H(aliceQubits[i]); } // Apply Hadamard before measurement
            let result = M(aliceQubits[i]);
            set bobResults w/= i <- (result == One ? 1 | 0);
        }

        // Error Correction (Majority Vote for Every 3-bit Block)
        let correctedKey = CorrectErrors(bobResults);

        Message($"Alice Bits: {aliceBits}");
        Message($"Alice Bases: {aliceBases}");
        Message($"Bob Bases: {bobBases}");
        Message($"Bob Results (Before Correction): {bobResults}");
        Message($"Corrected Key: {correctedKey}");
    }

    // Function to sum elements in an array
    function SumArray(inputArray: Int[]) : Int {
        mutable sum = 0;
        for elem in inputArray {
            set sum += elem;  // Corrected sum update
        }
        return sum;
    }

    // Simple 3-bit Majority Voting Error Correction
    function CorrectErrors(bits: Int[]) : Int[] {
        let n = Length(bits);
        mutable correctedBits = [0, size=(n / 3)];

        for i in 0..(n / 3) - 1 {
            let bitBlock = [bits[3*i], bits[3*i+1], bits[3*i+2]];
            let majority = SumArray(bitBlock) > 1 ? 1 | 0;
            set correctedBits w/= i <- majority;
        }

        return correctedBits;
    }
}