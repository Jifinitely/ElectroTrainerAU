import SwiftUI
import PDFKit

struct TestRow: Identifiable {
    let id = UUID()
    var equipment: String
    var circuitNo: String
    var cableSize: String
    var protection: String
    var neutralNo: String
    var earthContinuity: String
    var insulationResistance: String
    var polarity: String
    var loopImpedance: String
    var operationalTest: String
}

struct LandscapeTestCertificateView: View {
    @State private var customer = ""
    @State private var site = ""
    @State private var jobNumber = ""
    @State private var workActivity = ""
    @State private var date = ""
    @State private var testedBy = ""
    @State private var licenceNumber = ""

    @State private var testRows: [TestRow] = [
        TestRow(equipment: "", circuitNo: "", cableSize: "", protection: "", neutralNo: "", earthContinuity: "", insulationResistance: "", polarity: "", loopImpedance: "", operationalTest: "")
    ]

    @State private var generatedPDFURL: URL?
    @State private var showShareSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                        .padding(10)
                        .background(Color.green.opacity(0.1))
                        .clipShape(Circle())

                    Text("Test Certificate")
                        .font(.title2)
                        .bold()
                }

                GroupBox(label: Text("📍 Site Info").font(.headline)) {
                    VStack(alignment: .leading) {
                        TextField("Customer", text: $customer)
                        TextField("Site Address", text: $site)
                        TextField("Work Activity", text: $workActivity)
                        TextField("Job No.", text: $jobNumber)
                        TextField("Date", text: $date)
                    }
                    .padding(.vertical, 4)
                }

                GroupBox(label: Text("🧪 Tested By").font(.headline)) {
                    VStack(alignment: .leading) {
                        TextField("Name", text: $testedBy)
                        TextField("Licence Number", text: $licenceNumber)
                    }
                    .padding(.vertical, 4)
                }

                GroupBox(label: Text("📊 Test Results").font(.headline)) {
                    ForEach($testRows) { $row in
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Circuit / Equipment", text: $row.equipment)

                            HStack {
                                TextField("Circuit No.", text: $row.circuitNo)
                                TextField("Cable Size", text: $row.cableSize)
                            }

                            HStack {
                                TextField("Protection Type", text: $row.protection)
                                TextField("Neutral No.", text: $row.neutralNo)
                            }

                            HStack {
                                TextField("Earth Continuity (Ω)", text: $row.earthContinuity)
                                TextField("Insulation Resistance (MΩ)", text: $row.insulationResistance)
                            }

                            HStack {
                                TextField("Polarity (Pass/Fail)", text: $row.polarity)
                                TextField("Loop Impedance (Ω)", text: $row.loopImpedance)
                            }

                            TextField("Operational Test (Pass/Fail)", text: $row.operationalTest)
                            Divider()
                        }
                    }

                    Button("➕ Add Row") {
                        testRows.append(TestRow(equipment: "", circuitNo: "", cableSize: "", protection: "", neutralNo: "", earthContinuity: "", insulationResistance: "", polarity: "", loopImpedance: "", operationalTest: ""))
                    }
                    .padding(.top)
                }

                VStack(spacing: 16) {
                    Button("Generate PDF") {
                        hideKeyboard()
                        generateLandscapePDF()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    if generatedPDFURL != nil {
                        Button("Share PDF") {
                            showShareSheet = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
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
        .sheet(isPresented: $showShareSheet) {
            if let url = generatedPDFURL {
                ShareSheet(activityItems: [url])
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }

    func generateLandscapePDF() {
        let pageWidth: CGFloat = 842
        let pageHeight: CGFloat = 595
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))

        let data = renderer.pdfData { ctx in
            ctx.beginPage()

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10),
                .paragraphStyle: paragraphStyle
            ]

            var y: CGFloat = 20
            let leftMargin: CGFloat = 20
            let lineHeight: CGFloat = 16

            func draw(_ text: String) {
                text.draw(in: CGRect(x: leftMargin, y: y, width: pageWidth - 40, height: lineHeight), withAttributes: attrs)
                y += lineHeight
            }

            draw("Customer: \(customer)    Site Address: \(site)    Job No: \(jobNumber)")
            draw("Work Activity: \(workActivity)    Date: \(date)")
            draw("Tested By: \(testedBy)    Licence No: \(licenceNumber)")
            y += 10
            draw("----------------------------------------------------------------------------------------------------------")
            draw("Equip. | Cct# | Cable | Protect | Neutral | Earth Ω | IR MΩ | Polarity | Zs Ω | Operational")
            draw("----------------------------------------------------------------------------------------------------------")

            for row in testRows {
                let line = "\(row.equipment) | \(row.circuitNo) | \(row.cableSize) | \(row.protection) | \(row.neutralNo) | \(row.earthContinuity) | \(row.insulationResistance) | \(row.polarity) | \(row.loopImpedance) | \(row.operationalTest)"
                draw(line)
            }
        }

        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("TestCertificate_Landscape.pdf")
        try? data.write(to: outputURL)
        generatedPDFURL = outputURL
    }
}

#Preview {
    NavigationView {
        LandscapeTestCertificateView()
    }
}
