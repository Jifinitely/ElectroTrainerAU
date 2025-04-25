import SwiftUI

struct VoltageDropView: View {
    @State private var selectedCable = "2.5 mm² Cu 1ph"
    @State private var current: String = ""
    @State private var length: String = ""
    @State private var voltageDrop: Double?

    let cableOptions = [
        "1.5 mm² Cu 1ph": 29.0,
        "2.5 mm² Cu 1ph": 18.0,
        "4.0 mm² Cu 1ph": 11.0,
        "6.0 mm² Cu 1ph": 7.3,
        "10 mm² Cu 1ph": 4.4,
        "16 mm² Cu 1ph": 2.8,
        "2.5 mm² Cu 3ph": 12.0,
        "4.0 mm² Cu 3ph": 7.3,
        "6.0 mm² Cu 3ph": 4.9,
        "10 mm² Cu 3ph": 3.0,
        "16 mm² Cu 3ph": 1.9
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack {
                    Image(systemName: "bolt.fill.batteryblock")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .padding(10)
                        .background(Color.yellow.opacity(0.15))
                        .clipShape(Circle())

                    Text("Voltage Drop Calculator")
                        .font(.title2)
                        .bold()
                }

                // Cable Picker
                VStack(alignment: .leading) {
                    Text("Select Cable Type (mV/A·m)")
                        .font(.headline)
                    Picker("Cable", selection: $selectedCable) {
                        ForEach(cableOptions.keys.sorted(), id: \.self) { key in
                            Text(key)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // Input Fields
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enter Load Values").font(.headline)
                    TextField("Load Current (A)", text: $current)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)

                    TextField("Cable Length (m)", text: $length)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Button
                Button(action: calculateVoltageDrop) {
                    Label("Calculate Voltage Drop", systemImage: "bolt.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
                .shadow(radius: 4)

                // Result
                if let result = voltageDrop {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Result")
                            .font(.headline)
                        // Corrected format specifier here:
                        Text(String(format: "Voltage Drop: %.2f V", result))
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
        .hideKeyboardOnTap()
        .navigationTitle("⚡ Voltage Drop")
    }

    func calculateVoltageDrop() {
        guard let currentVal = Double(current),
              let lengthVal = Double(length),
              let mvpa = cableOptions[selectedCable] else {
            voltageDrop = nil
            return
        }

        voltageDrop = (mvpa * currentVal * lengthVal) / 1000.0
    }
}

#Preview {
    NavigationView {
        VoltageDropView()
    }
}
