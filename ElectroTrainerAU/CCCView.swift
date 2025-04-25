import SwiftUI

struct CCCView: View {
    @State private var selectedCable = "2.5 mm² Cu"
    @State private var baseCurrent: Double = 18.0
    @State private var adjustedCurrent: Double?

    @State private var selectedTemp = "30°C"
    @State private var selectedGroup = "1 Circuit"
    @State private var selectedInsulation = "None"

    let cableRatings: [String: Double] = [
        "1.5 mm² Cu": 14.0, "2.5 mm² Cu": 18.0, "4.0 mm² Cu": 24.0,
        "6.0 mm² Cu": 31.0, "10 mm² Cu": 42.0, "16 mm² Cu": 57.0
    ]

    let ambientOptions: [String: Double] = [
        "25°C": 1.04, "30°C": 1.00, "35°C": 0.96,
        "40°C": 0.91, "45°C": 0.87, "50°C": 0.82
    ]

    let groupingOptions: [String: Double] = [
        "1 Circuit": 1.00, "2 Circuits": 0.80, "3 Circuits": 0.70,
        "4 Circuits": 0.65, "6+ Circuits": 0.50
    ]

    let insulationOptions: [String: Double] = [
        "None": 1.00, "Partially Surrounded": 0.75, "Fully Surrounded": 0.60
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.pink)
                        .padding(10)
                        .background(Color.pink.opacity(0.1))
                        .clipShape(Circle())

                    Text("CCC Derating Calculator")
                        .font(.title2)
                        .bold()
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Cable Size").font(.headline)
                    Picker("Cable", selection: $selectedCable) {
                        ForEach(cableRatings.keys.sorted(), id: \ .self) { key in
                            Text(String(format: "%@ — %.0f A", key, cableRatings[key]!))
                        }
                    }
                    .onChange(of: selectedCable) { newValue in
                        baseCurrent = cableRatings[newValue] ?? 0
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Derating Factors").font(.headline)

                    factorPicker(title: "Ambient Temp", selection: $selectedTemp, options: ambientOptions, tooltip: "Ref: AS/NZS 3008 Table 32")
                    factorPicker(title: "Grouping", selection: $selectedGroup, options: groupingOptions, tooltip: "Ref: AS/NZS 3008 Table 27")
                    factorPicker(title: "Thermal Insulation", selection: $selectedInsulation, options: insulationOptions, tooltip: "Ref: AS/NZS 3008 Table 34")
                }
                .padding(.horizontal)

                Button(action: calculateCCC) {
                    Label("Calculate CCC", systemImage: "equal.circle.fill")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
                .shadow(radius: 4)

                if let result = adjustedCurrent {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Adjusted CCC")
                            .font(.headline)
                        Text(String(format: "%.2f A", result))
                            .font(.title2)
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
        .navigationTitle("🔥 CCC Calculator")
    }

    @ViewBuilder
    func factorPicker(title: String, selection: Binding<String>, options: [String: Double], tooltip: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .help(tooltip)
            }
            Picker(title, selection: selection) {
                ForEach(options.keys.sorted(), id: \ .self) { Text($0) }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }

    func calculateCCC() {
        let f1 = ambientOptions[selectedTemp] ?? 1.0
        let f2 = groupingOptions[selectedGroup] ?? 1.0
        let f3 = insulationOptions[selectedInsulation] ?? 1.0
        adjustedCurrent = baseCurrent * f1 * f2 * f3
    }
}

#Preview {
    NavigationView {
        CCCView()
    }
}
