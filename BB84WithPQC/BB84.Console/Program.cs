using System;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation.Core;
using BB84.ConsoleApp.Classical;
using BB84.Quantum;

namespace BB84.ConsoleApp
{
    class Program
    {
        static async Task Main(string[] args)
        {
            System.Console.WriteLine("======================================================");
            System.Console.WriteLine("   BB84 Quantum Key Distribution with PQC Integration");
            System.Console.WriteLine("======================================================");
            System.Console.WriteLine();

            try
            {
                // Parse command line arguments, but limit max qubits
                int nBits = 12; // Default to a much smaller size
                
                if (args.Length > 0)
                {
                    if (int.TryParse(args[0], out int parsedBits))
                    {
                        // Cap the maximum number of qubits at 24 to avoid simulator limits
                        nBits = Math.Min(parsedBits, 24);
                        if (parsedBits > 24)
                        {
                            System.Console.WriteLine($"Warning: Requested {parsedBits} qubits exceeds simulator capacity. Limiting to 24 qubits.");
                        }
                    }
                    else
                    {
                        System.Console.WriteLine($"Warning: '{args[0]}' is not a valid number of bits. Using default of {nBits}.");
                    }
                }

                // Ensure nBits is divisible by 3 for proper error correction
                if (nBits % 3 != 0)
                {
                    int adjustedBits = (nBits / 3 + 1) * 3;
                    System.Console.WriteLine($"Adjusting number of bits from {nBits} to {adjustedBits} for optimal error correction");
                    nBits = adjustedBits;
                }

                System.Console.WriteLine($"Running BB84 protocol with {nBits} qubits...");
                
                // Create a quantum simulator
                using var simulator = new QuantumSimulator();
                System.Console.WriteLine("Quantum simulator initialized");
                
                // Run the BB84 protocol via Q# operation
                System.Console.WriteLine("Starting BB84 protocol...");
                var bb84KeyArray = await PerformBB84Protocol.Run(simulator, nBits);
                
                // Convert IQArray<long> to long[] for use with our PQC implementation
                long[] bb84Key = bb84KeyArray.ToArray();
                
                System.Console.WriteLine();
                System.Console.WriteLine("BB84 protocol completed successfully!");
                System.Console.WriteLine($"Generated quantum key: [{string.Join(", ", bb84Key)}]");
                System.Console.WriteLine();
                
                // Demonstrate PQC integration with the quantum-derived key
                System.Console.WriteLine("====== Demonstrating Post-Quantum Cryptography Integration ======");
                
                // Process the quantum key for use with PQC
                var message = "This message is secured using quantum-derived keys and post-quantum cryptography!";
                System.Console.WriteLine($"Original message: {message}");
                System.Console.WriteLine();
                
                // Demonstrate the hybrid quantum + post-quantum system
                PostQuantumCrypto.DemonstrateHybridSystem(bb84Key, message);
            }
            catch (Exception ex)
            {
                System.Console.WriteLine($"Error: {ex.Message}");
                System.Console.WriteLine(ex.StackTrace);
            }
        }
    }
}