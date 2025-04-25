import SwiftUI

struct TestLogbookView: View {
    @State private var site = ""
    @State private var date = ""
    @State private var testType = ""
    @State private var result = ""

    @State private var showShareSheet = false
    @State private var exportURL: URL?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Icon header
                VStack {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.teal)
                        .padding(10)
                        .background(Color.teal.opacity(0.1))
                        .clipShape(Circle())

                    Text("Test Logbook")
                        .font(.title2)
                        .bold()
                }

                // Entry form
                GroupBox(label: Text("➕ Add New Entry").font(.headline)) {
                    VStack(spacing: 10) {
                        TextField("Site", text: $site)
                            .textFieldStyle(.roundedBorder)
                        TextField("Date", text: $date)
                            .textFieldStyle(.roundedBorder)
                        TextField("Test Type", text: $testType)
                            .textFieldStyle(.roundedBorder)
                        TextField("Result", text: $result)
                            .textFieldStyle(.roundedBorder)

                        Button("Add Entry") {
                            addEntry()
                        }
                        .disabled(site.isEmpty || date.isEmpty || testType.isEmpty || result.isEmpty)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                // Export button
                Button("📤 Export Log as CSV") {
                    exportLog()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .hideKeyboardOnTap()
        .navigationTitle("📒 Test Logbook")
        .sheet(isPresented: $showShareSheet) {
            if let url = exportURL {
                ShareSheet(activityItems: [url])
            }
        }
    }

    private func addEntry() {
        let newEntry = [site, date, testType, result].joined(separator: ",")
        let newLine = "\n" + newEntry
        let logPath = FileManager.default.temporaryDirectory.appendingPathComponent("TestLogbook.csv")

        do {
            if FileManager.default.fileExists(atPath: logPath.path) {
                let fileHandle = try FileHandle(forWritingTo: logPath)
                fileHandle.seekToEndOfFile()
                if let data = newLine.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            } else {
                let header = "Site,Date,Test Type,Result\n"
                try (header + newEntry).write(to: logPath, atomically: true, encoding: .utf8)
            }
            // Prepare share sheet
            exportURL = logPath
            showShareSheet = true
        } catch {
            print("Error writing entry: \(error)")
        }

        site = ""
        date = ""
        testType = ""
        result = ""
    }

    private func exportLog() {
        let logPath = FileManager.default.temporaryDirectory.appendingPathComponent("TestLogbook.csv")
        if FileManager.default.fileExists(atPath: logPath.path) {
            exportURL = logPath
            showShareSheet = true
        }
    }
}

#Preview {
    NavigationView {
        TestLogbookView()
    }
}
