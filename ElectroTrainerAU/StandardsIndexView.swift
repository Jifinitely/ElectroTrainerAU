import SwiftUI

struct StandardEntry: Identifiable {
    let id = UUID()
    let term: String
    let detail: String
}

struct StandardsIndexView: View {
    @State private var searchText = ""

    let entries: [StandardEntry] = [
        StandardEntry(term: "MEN", detail: "Multiple Earthed Neutral system. The MEN link must be located at the main switchboard."),
        StandardEntry(term: "Voltage Drop", detail: "VD = (mV/A·m) × I × L / 1000. Max limit: 5% of nominal voltage per AS/NZS 3000."),
        StandardEntry(term: "Zs Limits", detail: "Zs ≤ Uo / Ia. Ensure disconnection within required time under earth fault condition."),
        StandardEntry(term: "Insulation Resistance", detail: "Min 1 MΩ between all live conductors and earth, tested with 500 V DC."),
        StandardEntry(term: "Earth Electrode Resistance", detail: "Recommended <25Ω for standard electrodes unless otherwise specified."),
        StandardEntry(term: "RCD Trip Time", detail: "30 mA RCD must trip within 300 ms under test button or external tester."),
        StandardEntry(term: "Visual Inspection", detail: "Ensure correct connections, MEN link, cable sizes, and earth continuity."),
        StandardEntry(term: "Loop Impedance", detail: "Zs should be verified to ensure fast disconnection. Use earth-loop tester."),
        StandardEntry(term: "Cable Grouping", detail: "Use derating factors if cables are bunched together (AS/NZS 3008)."),
        StandardEntry(term: "Ambient Derating", detail: "Adjust CCC when ambient temp exceeds 30°C. Use correction factors from tables."),
        StandardEntry(term: "Short-Circuit Withstand", detail: "t = (k² × S²) / I². Ensure cable withstand time exceeds fault clearance time.")
    ]

    var body: some View {
        VStack(spacing: 16) {
            // Icon Header
            VStack {
                Image(systemName: "book.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.brown)
                    .padding(10)
                    .background(Color.brown.opacity(0.1))
                    .clipShape(Circle())

                Text("Standards Quick Index")
                    .font(.title2)
                    .bold()
            }

            // Search & List
            List {
                ForEach(filteredEntries) { entry in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.term)
                            .font(.headline)
                        Text(entry.detail)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, prompt: "Search terms (e.g. Zs, RCD, MEN)")
        }
        .padding(.bottom)
        .navigationTitle("📖 Standards Index")
    }

    var filteredEntries: [StandardEntry] {
        if searchText.isEmpty {
            return entries
        } else {
            return entries.filter {
                $0.term.localizedCaseInsensitiveContains(searchText) ||
                $0.detail.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    NavigationView {
        StandardsIndexView()
    }
}
