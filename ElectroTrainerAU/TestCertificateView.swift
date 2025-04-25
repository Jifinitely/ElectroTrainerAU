import SwiftUI

struct TestCertificateView: View {
    @State private var siteName: String = ""
    @State private var testerName: String = ""
    @State private var date = Date()
    @State private var zs: String = ""
    @State private var insulation: String = ""
    @State private var polarity: Bool = true
    @State private var rcdTrip: String = ""
    @State private var outputSummary: String?

    var body: some View {
        Form {
            Section(header: Text("Site Information").bold()) {
                TextField("Site Name", text: $siteName)
                TextField("Tester Name", text: $testerName)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }

            Section(header: Text("Test Results").bold()) {
                TextField("Zs Reading (Ω)", text: $zs)
                    .keyboardType(.decimalPad)

                TextField("Insulation Resistance (MΩ)", text: $insulation)
                    .keyboardType(.decimalPad)

                Toggle("Polarity Correct", isOn: $polarity)

                TextField("RCD Trip Time (ms)", text: $rcdTrip)
                    .keyboardType(.decimalPad)
            }

            Section {
                Button("Generate Summary") {
                    hideKeyboard()
                    generateSummary()
                }
            }

            if let summary = outputSummary {
                Section(header: Text("Test Certificate Summary")) {
                    ScrollView {
                        Text(summary)
                            .font(.body)
                            .padding()
                            .textSelection(.enabled)
                    }
                }
            }
        }
        .navigationTitle("📄 Test Certificate")
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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }

    func generateSummary() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let summary = """
📄 Electrical Test Certificate

Site: \(siteName)
Tester: \(testerName)
Date: \(formatter.string(from: date))

✅ Test Results:
- Zs: \(zs) Ω
- Insulation Resistance: \(insulation) MΩ
- Polarity: \(polarity ? "Correct" : "Incorrect")
- RCD Trip Time: \(rcdTrip) ms

Declaration:
The above tests were carried out in accordance with AS/NZS 3017:2022.
"""
        outputSummary = summary
    }
}

#Preview {
    TestCertificateView()
}
