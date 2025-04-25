import SwiftUI

struct ZsCheckerView: View {
    @State private var selectedVoltage = "230V"
    @State private var faultCurrent: String = ""
    @State private var measuredZs: String = ""
    @State private var isCompliant: Bool?

    let voltageOptions = [
        "230V": 230.0,
        "240V": 240.0,
        "415V": 415.0
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 40))
                        .foregroundColor(.cyan)
                        .padding(10)
                        .background(Color.cyan.opacity(0.1))
                        .clipShape(Circle())

                    Text("Zs Compliance Checker")
                        .font(.title2)
                        .bold()
                }

                // Voltage Picker
                VStack(alignment: .leading) {
                    Text("Nominal Voltage (U₀)")
                        .font(.headline)

                    Picker("Voltage", selection: $selectedVoltage) {
                        ForEach(voltageOptions.keys.sorted(), id: \.self) { key in
                            Text(key)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // Fault Current Input
                VStack(alignment: .leading, spacing: 12) {
                    Text("Required Fault Current (Iₐ in A)").font(.headline)
                    TextField("e.g. 1600", text: $faultCurrent)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Measured Zs
                VStack(alignment: .leading, spacing: 12) {
                    Text("Measured Zs (Ω)").font(.headline)
                    TextField("e.g. 0.3", text: $measuredZs)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Button
                Button(action: checkZsCompliance) {
                    Label("Check Compliance", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
                .shadow(radius: 4)

                // Result
                if let result = isCompliant {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Result").font(.headline)
                        Text(result ? "✅ Compliant" : "❌ Not Compliant")
                            .font(.title3)
                            .foregroundColor(result ? .green : .red)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .hideKeyboardOnTap()              // ← Dismiss keyboard on tap
        .navigationTitle("⚡ Zs Checker")
    }

    func checkZsCompliance() {
        guard let u0 = voltageOptions[selectedVoltage],
              let ia = Double(faultCurrent),
              let zs = Double(measuredZs),
              ia > 0 else {
            isCompliant = nil
            return
        }

        let maxZs = u0 / ia
        isCompliant = zs <= maxZs
    }
}

#Preview {
    NavigationView {
        ZsCheckerView()
    }
}
