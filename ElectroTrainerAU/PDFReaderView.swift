import SwiftUI
import PDFKit

struct PDFReaderView: View {
    @State private var selectedStandard = "AS/NZS 3017"
    @State private var searchText = ""
    @State private var pdf3017: PDFDocument?
    @State private var pdf3008: PDFDocument?
    @State private var pdf3000: PDFDocument?
    @State private var pdfDNIPS: PDFDocument?
    @State private var selectedDocument: PDFDocument?
    @State private var pdfView = PDFView()

    var body: some View {
        VStack(spacing: 16) {
            // Icon Header
            VStack {
                Image(systemName: "doc.richtext.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                    .padding(10)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())

                Text("Standards Viewer")
                    .font(.title2)
                    .bold()
            }

            // Standard Picker
            Picker("Standard", selection: $selectedStandard) {
                Text("AS/NZS 3017").tag("AS/NZS 3017")
                Text("AS/NZS 3008").tag("AS/NZS 3008")
                Text("AS/NZS 3000").tag("AS/NZS 3000")
                Text("DNIPS").tag("DNIPS")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .onChange(of: selectedStandard) { _ in
                updateDocument()
            }

            // Search bar
            HStack(spacing: 12) {
                TextField("Search term", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                Button(action: performSearch) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            // PDF View
            PDFKitViewController(document: selectedDocument ?? PDFDocument(), pdfView: $pdfView)
                .cornerRadius(12)
                .padding(.horizontal)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .onAppear {
            loadPDFs()
        }
        .navigationTitle("📘 Standards")
        .padding(.bottom)
    }

    func loadPDFs() {
        if let url3017 = Bundle.main.url(forResource: "AS 3017-2022 ( Testing:Verification))", withExtension: "pdf"),
           let url3008 = Bundle.main.url(forResource: "AS 3008-2017 ( Cable selection)", withExtension: "pdf"),
           let url3000 = Bundle.main.url(forResource: "AS 3000-2023", withExtension: "pdf"),
           let urlDNIPS = Bundle.main.url(forResource: "dnips 2", withExtension: "pdf") {
            pdf3017 = PDFDocument(url: url3017)
            pdf3008 = PDFDocument(url: url3008)
            pdf3000 = PDFDocument(url: url3000)
            pdfDNIPS = PDFDocument(url: urlDNIPS)
            updateDocument()
        }
    }

    func updateDocument() {
        switch selectedStandard {
        case "AS/NZS 3017": selectedDocument = pdf3017
        case "AS/NZS 3008": selectedDocument = pdf3008
        case "AS/NZS 3000": selectedDocument = pdf3000
        case "DNIPS": selectedDocument = pdfDNIPS
        default: selectedDocument = nil
        }
        pdfView.document = selectedDocument
    }

    func performSearch() {
        guard let doc = selectedDocument else { return }
        let results = doc.findString(searchText, withOptions: .caseInsensitive)
        if let first = results.first {
            pdfView.go(to: first)
        }
    }
}

struct PDFKitViewController: UIViewRepresentable {
    let document: PDFDocument
    @Binding var pdfView: PDFView

    func makeUIView(context: Context) -> PDFView {
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = document
    }
}

#Preview {
    NavigationView {
        PDFReaderView()
    }
}
