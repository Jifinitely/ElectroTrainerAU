import SwiftUI

struct CasioFormula {
    let name: String
    let steps: [String]
    let result: String
}

struct CasioCalculatorView: View {
    let formulas: [CasioFormula] = [
        CasioFormula(name: "Ohm's Law: V = I × R", steps: ["1. Enter I", "2. Press ×", "3. Enter R", "4. Press ="], result: "Voltage (V)"),
        CasioFormula(name: "Ohm's Law: I = V ÷ R", steps: ["1. Enter V", "2. Press ÷", "3. Enter R", "4. Press ="], result: "Current (A)"),
        CasioFormula(name: "Ohm's Law: R = V ÷ I", steps: ["1. Enter V", "2. Press ÷", "3. Enter I", "4. Press ="], result: "Resistance (Ω)"),
        CasioFormula(name: "Voltage Drop (Z method)", steps: ["1. Enter Z", "2. × I", "3. × L", "4. × √3", "5. ÷ 1000", "6. Press ="], result: "Voltage Drop (V)"),
        CasioFormula(name: "CCC with Derating", steps: ["1. Enter I_rated", "2. × Ambient", "3. × Grouping", "4. × Thermal", "5. Press ="], result: "Adjusted CCC (A)"),
        CasioFormula(name: "Zs Compliance: Zs ≤ Uo / Ia", steps: ["1. Enter Uo", "2. ÷ Ia", "3. Press ="], result: "Max Zs (Ω)"),
        CasioFormula(name: "Short-Circuit Time", steps: ["1. Enter k", "2. x²", "3. × S", "4. x²", "5. ÷ I", "6. x²", "7. Press ="], result: "Time (s)"),
        CasioFormula(name: "Power Factor (PF)", steps: ["1. Enter kW", "2. ÷ kVA", "3. Press ="], result: "PF (unitless)"),
        CasioFormula(name: "Impedance: Z = √(R² + X²)", steps: ["1. Enter R", "2. x²", "3. +", "4. Enter X", "5. x²", "6. =", "7. √"], result: "Impedance (Ω)"),
        CasioFormula(name: "Max Demand (3-Phase)", steps: ["1. Enter V", "2. × I", "3. × √3", "4. × PF", "5. Press ="], result: "Power (W)"),
        CasioFormula(name: "Circuit Breaker (I × SF)", steps: ["1. Enter Load I", "2. × 1.25", "3. Press ="], result: "CB Rating (A)"),
        CasioFormula(name: "Power: Single Phase", steps: ["1. Enter V", "2. × I", "3. × PF", "4. Press ="], result: "Power (W)"),
        CasioFormula(name: "Power: 3 Phase", steps: ["1. Enter V", "2. × I", "3. × √3", "4. × PF", "5. Press ="], result: "Power (W)"),
        CasioFormula(name: "Apparent Power: S = V × I", steps: ["1. Enter V", "2. × I", "3. Press ="], result: "VA")
    ]

    @State private var selectedIndex = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    Image(systemName: "function")
                        .font(.system(size: 40))
                        .foregroundColor(.purple)
                        .padding(10)
                        .background(Color.purple.opacity(0.1))
                        .clipShape(Circle())

                    Text("Casio Formula Walkthrough")
                        .font(.title2)
                        .bold()
                }

                VStack(alignment: .leading) {
                    Text("Choose Formula").font(.headline)
                    Picker("Formula", selection: $selectedIndex) {
                        ForEach(0..<formulas.count, id: \.self) { i in
                            Text(formulas[i].name).tag(i)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Steps for: \(formulas[selectedIndex].name)").font(.headline)
                    ForEach(formulas[selectedIndex].steps, id: \.self) { step in
                        Text("• \(step)")
                    }

                    Text("Result: \(formulas[selectedIndex].result)")
                        .foregroundColor(.blue)
                        .padding(.top)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("➗ Casio Mode")
    }
}
