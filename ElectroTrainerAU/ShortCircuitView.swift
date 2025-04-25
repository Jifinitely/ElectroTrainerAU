import SwiftUI

struct ShortCircuitView: View {
    @State private var selectedMaterial = "Copper (PVC)"
    @State private var csa: String = "" // S in mm²
    @State private var faultCurrent: String = "" // I in A
    @State private var timeResult: Double?

    let kValues: [String: Double] = [
        "Copper (PVC)": 115.0,
        "Copper (XLPE)": 143.0,
        "Aluminium (PVC)": 76.0,
        "Aluminium (XLPE)": 94.0
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Icon Header
                VStack {
                    Image(systemName: "timer")
                        .font(.system(size: 40))
                        .foregroundColor(.indigo)
                        .padding(10)
                        .background(Color.indigo.opacity(0.1))
                        .clipShape(Circle())

                    Text("Short-Circuit Withstand Time")
                        .font(.title2)
                        .bold()
                }

                // Material Picker
                VStack(alignment: .leading) {
                    Text("Conductor Material & Insulation")
                        .font(.headline)
                    Picker("Material", selection: $selectedMaterial) {
                        ForEach(kValues.keys.sorted(), id: \.self) { material in
                            Text(material)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // Inputs
                VStack(alignment: .leading, spacing: 12) {
                    Text("Inputs").font(.headline)
                    Group {
                        inputField("Conductor CSA (S in mm²)", text: $csa)
                        inputField("Fault Current (I in A)", text: $faultCurrent)
                    }
                }
                .padding(.horizontal)

                // Calculate Button
                Button(action: {
                    hideKeyboard()
                    calculateTime()
                }) {
                    Label("Calculate Withstand Time", systemImage: "bolt.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
                .shadow(radius: 4)

                // Result
                if let t = timeResult {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Result")
                            .font(.headline)
                        Text("Withstand Time: \(t, specifier: "%.3f") seconds")
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
        .navigationTitle("⏱ Short-Circuit Time")
        .hideKeyboardOnTap()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    hideKeyboard()
                }
            }
        }
    }

    @ViewBuilder
    func inputField(_ label: String, text: Binding<String>) -> some View {
        TextField(label, text: text)
            .keyboardType(.decimalPad)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }

    func calculateTime() {
        guard let S = Double(csa),
              let I = Double(faultCurrent),
              let k = kValues[selectedMaterial],
              I > 0 else {
            timeResult = nil
            return
        }

        timeResult = (pow(k, 2) * pow(S, 2)) / pow(I, 2)
    }
}

#Preview {
    NavigationView {
        ShortCircuitView()
    }
}
