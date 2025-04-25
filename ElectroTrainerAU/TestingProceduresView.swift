import SwiftUI

struct TestingProceduresView: View {
    let procedures: [String] = [
        "1. Confirm De-energized: Use a two-contact voltage tester. Always prove-test-prove.",
        "2. Visual Inspection: Check wiring, MEN link, labeling, earth continuity, damage.",
        "3. Earth Continuity Test: Use low-ohm meter from exposed metal to main earth.",
        "4. Insulation Resistance: Apply 500V DC. Must exceed 1 MΩ across all combinations.",
        "5. Polarity Test: Confirm active to switches, socket pin locations, test each outlet.",
        "6. Phase Rotation (3ph): Use phase rotation meter to verify A-B-C sequence.",
        "7. Earth Fault Loop Impedance (Zs): Measure between active and earth under load.",
        "8. RCD Test: Use tester to simulate fault current. Must trip within 300 ms (30 mA).",
        "9. Earth Electrode Resistance: Use earth resistance tester, must be < 25 Ω typically.",
        "10. Touch Voltage: Confirm touch voltages do not exceed 50V during fault.",
        "11. Incoming Neutral Integrity: Check continuity between neutral bar and supply.",
        "12. Record Results: Complete test sheets with date, signature, all values."
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Icon Header
                VStack {
                    Image(systemName: "checklist.checked")
                        .font(.system(size: 40))
                        .foregroundColor(.purple)
                        .padding(10)
                        .background(Color.purple.opacity(0.1))
                        .clipShape(Circle())

                    Text("Testing Procedures")
                        .font(.title2)
                        .bold()
                }

                // Steps List
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(procedures, id: \.self) { step in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.purple)
                                .padding(.top, 3)

                            Text(step)
                                .font(.body)
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("🧪 Testing Procedures")
    }
}

#Preview {
    NavigationView {
        TestingProceduresView()
    }
}
