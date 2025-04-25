import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                sectionHeader("🛠 Calculators")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    toolCard(title: "Cable Selection", icon: "shippingbox", color: .orange, destination: CableSelectionView())
                    toolCard(title: "Voltage Drop Calculator", icon: "bolt.fill", color: .red, destination: VoltageDropView())
                    toolCard(title: "CCC Calculator", icon: "flame", color: .pink, destination: CCCView())
                    toolCard(title: "Zs Checker", icon: "waveform.path.ecg", color: .cyan, destination: ZsCheckerView())
                    toolCard(title: "Short-Circuit Time", icon: "timer", color: .indigo, destination: ShortCircuitView())
                    toolCard(title: "Casio Calculator", icon: "function", color: .purple, destination: CasioCalculatorView())
                }

                sectionHeader("📋 Testing Tools")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    toolCard(title: "Test Certificate", icon: "doc.text.fill", color: .green, destination: LandscapeTestCertificateView())
                    toolCard(title: "Test Logbook", icon: "book.fill", color: .teal, destination: TestLogbookView())
                    toolCard(title: "Testing Procedures", icon: "pencil.and.ruler", color: .blue, destination: TestingProceduresView())
                }

                sectionHeader("📚 Standards & Resources")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    toolCard(title: "PDF Standards", icon: "doc.richtext", color: .gray, destination: PDFReaderView())
                    toolCard(title: "Standards Index", icon: "list.bullet.rectangle", color: .brown, destination: StandardsIndexView())
                }

                // Mascot Footer
                VStack {
                    Image("Icon-1024")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 4)

                    Text("Need help? Tap me!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
            }
            .padding()
        }
        .navigationTitle("📱 ElectroTrainerAU")
    }

    @ViewBuilder
    func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal, 4)
            .padding(.top, 16)
    }

    @ViewBuilder
    func toolCard<Destination: View>(title: String, icon: String, color: Color, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(color)
                    .clipShape(Circle())

                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 3)
        }
    }
}

#Preview {
    NavigationView {
        MainMenuView()
    }
}
