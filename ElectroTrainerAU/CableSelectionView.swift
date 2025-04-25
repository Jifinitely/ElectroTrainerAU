import SwiftUI

struct CableSelectionView: View {
    @State private var current: String = ""
    @State private var voltage: String = "230"
    @State private var powerFactor: String = "0.8"
    @State private var cableSize: String?
    @State private var useCopper = true

    let copperSizes: [(String, Double)] = [
        ("1.5 mm²", 14), ("2.5 mm²", 18), ("4.0 mm²", 24), ("6.0 mm²", 31),
        ("10 mm²", 42), ("16 mm²", 57), ("25 mm²", 75), ("35 mm²", 90),
        ("50 mm²", 110), ("70 mm²", 140), ("95 mm²", 170), ("120 mm²", 200),
        ("150 mm²", 225), ("185 mm²", 250), ("240 mm²", 290), ("300 mm²", 330)
    ]

    let aluminiumSizes: [(String, Double)] = [
        ("6 mm² Al", 28), ("10 mm² Al", 38), ("16 mm² Al", 50), ("25 mm² Al", 65),
        ("35 mm² Al", 80), ("50 mm² Al", 95), ("70 mm² Al", 120), ("95 mm² Al", 150),
        ("120 mm² Al", 175), ("150 mm² Al", 200), ("185 mm² Al", 225),
        ("240 mm² Al", 265), ("300 mm² Al", 300)
    ]

    var availableSizes: [(String, Double)] {
        useCopper ? copperSizes : aluminiumSizes
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.orange)
                        .padding(10)
                        .background(Color.orange.opacity(0.1))
                        .clipShape(Circle())

                    Text("Cable Selection")
                        .font(.title2)
                        .bold()
                }

                // Material Toggle
                VStack(alignment: .leading, spacing: 8) {
                    Text("Material Type")
                        .font(.headline)
                    Toggle("Use Copper (Cu)", isOn: $useCopper)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Inputs
                VStack(alignment: .leading, spacing: 12) {
                    Text("Load Inputs").font(.headline)
                    Group {
                        inputField("Current (A)", text: $current)
                        inputField("Voltage (V)", text: $voltage)
                        inputField("Power Factor", text: $powerFactor)
                    }
                }
                .padding(.horizontal)

                // Button
                Button(action: calculateCableSize) {
                    Label("Calculate Cable Size", systemImage: "bolt.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
                .shadow(radius: 4)

                // Result
                if let result = cableSize {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recommended Size")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text(result)
                            .font(.title3)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .navigationTitle("🔌 Cable Selection")
        .hideKeyboardOnTap()  // Add this line to enable tap-to-dismiss
    }

    @ViewBuilder
    func inputField(_ label: String, text: Binding<String>) -> some View {
        TextField(label, text: text)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }

    func calculateCableSize() {
        guard let currentVal = Double(current),
              let pf = Double(powerFactor),
              let v = Double(voltage), v > 0 else {
            cableSize = "Invalid input"
            return
        }

        _ = (currentVal * v * pf) / 1000

        if let match = availableSizes.first(where: { $0.1 >= currentVal }) {
            let formatted = String(format: "%.0f", match.1)
            cableSize = "\(match.0) — Rated \(formatted) A"
        } else {
            cableSize = "⚠️ No size found for \(currentVal) A"
        }
    }
}
