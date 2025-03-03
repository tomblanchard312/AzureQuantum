namespace BB84.Quantum {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Convert;

    // Main operation that performs the BB84 protocol
    operation PerformBB84Protocol(nBits : Int) : Int[] {
        Message("Starting BB84 protocol with Q# simulator...");
        
        // Perform quantum key distribution using BB84
        let sharedKey = PerformBB84(nBits);
        
        // Display quantum key information
        Message($"BB84 protocol completed with {Length(sharedKey)} key bits");
        
        return sharedKey;
    }

    operation PerformBB84(nBits : Int) : Int[] {
        Message($"Allocating {nBits} qubits...");
        use aliceQubits = Qubit[nBits];  // Alice's qubits
        Message("Qubits allocated successfully");

        mutable aliceBits = [0, size=nBits];
        mutable aliceBases = [0, size=nBits];

        // Alice prepares her qubits
        for i in 0..nBits - 1 {
            let bit = DrawRandomInt(0, 1);   // Random 0 or 1
            let basis = DrawRandomInt(0, 1); // Random basis (0 = Z, 1 = X)
            set aliceBits w/= i <- bit;
            set aliceBases w/= i <- basis;

            // Prepare in X basis if needed
            if (basis == 1) { 
                H(aliceQubits[i]); 
            }
            
            // Apply bit flip if bit is 1
            if (bit == 1) { 
                X(aliceQubits[i]); 
            }
        }

        Message($"Alice prepared {nBits} qubits in random bases with random bit values");

        // Simulate quantum channel with potential eavesdropping
        // This would typically involve noise/decoherence
        let noiseLevel = 0.05; // 5% channel noise
        SimulateQuantumChannel(aliceQubits, noiseLevel);

        // Bob's measurement process
        mutable bobBases = [0, size=nBits];
        mutable bobResults = [0, size=nBits];

        for i in 0..nBits - 1 {
            let basis = DrawRandomInt(0, 1);   // Bob randomly chooses basis
            set bobBases w/= i <- basis;

            // Measure in X basis if chosen
            if (basis == 1) { 
                H(aliceQubits[i]); 
            }
            
            let result = M(aliceQubits[i]);
            set bobResults w/= i <- (result == One ? 1 | 0);
        }

        Message($"Bob measured all qubits in his randomly chosen bases");

        // Perform basis reconciliation - keep only bits where bases match
        mutable siftedKey = [];
        mutable matchingIndices = [];

        for i in 0..nBits - 1 {
            if (aliceBases[i] == bobBases[i]) {
                set siftedKey += [bobResults[i]];
                set matchingIndices += [i];
            }
        }

        // Sacrifice some bits for error detection
        let errorCheckSize = Length(siftedKey) / 4;
        mutable errorCheckBits = [];
        mutable finalKey = [];

        for i in 0..Length(siftedKey) - 1 {
            if (i < errorCheckSize) {
                set errorCheckBits += [siftedKey[i]];
            } else {
                set finalKey += [siftedKey[i]];
            }
        }

        // Perform error checking
        let estimatedErrorRate = EstimateErrorRate(
            errorCheckBits, 
            siftedKey[0..errorCheckSize-1]
        );

        Message($"Basis reconciliation complete. Matching bases: {Length(siftedKey)}/{nBits}");
        Message($"Estimated error rate: {estimatedErrorRate}");
        
        // Simplistic privacy amplification (combine consecutive pairs)
        mutable amplifiedKey = [];
        
        // Only perform privacy amplification if we have enough bits
        if (Length(finalKey) >= 2) {
            for i in 0..(Length(finalKey)/2) - 1 {
                let xorValue = (finalKey[2*i] + finalKey[2*i+1]) % 2; // Simulate XOR
                set amplifiedKey += [xorValue];
            }
        } else {
            // Not enough bits for privacy amplification, just use the final key
            set amplifiedKey = finalKey;
        }

        Message($"Final BB84 key length: {Length(amplifiedKey)} bits");
        Message($"BB84 key: {amplifiedKey}");
        
        // Reset qubits before releasing
        Message("Resetting qubits...");
        ResetAll(aliceQubits);
        
        return amplifiedKey;
    }

    operation SimulateQuantumChannel(qubits : Qubit[], noiseLevel : Double) : Unit {
        // Simple noise model: apply random X errors with probability noiseLevel
        for i in 0..Length(qubits) - 1 {
            let errorOccurs = DrawRandomDouble(0.0, 1.0) < noiseLevel;
            if (errorOccurs) {
                X(qubits[i]); // Apply bit-flip error
            }
        }
        
        Message($"Quantum channel simulated with {noiseLevel*100.0}% noise level");
    }

    function EstimateErrorRate(estimateBits : Int[], referenceBits : Int[]) : Double {
        mutable errorCount = 0;
        let sampleSize = Length(estimateBits);
        
        if (sampleSize == 0) {
            return 0.0; // Avoid division by zero
        }
        
        for i in 0..sampleSize - 1 {
            if (estimateBits[i] != referenceBits[i]) {
                set errorCount += 1;
            }
        }
        
        return IntAsDouble(errorCount) / IntAsDouble(sampleSize);
    }
}