# ElectroTrainerAU

ElectroTrainerAU is an iOS teaching app designed to help electricians, students, and engineers learn and apply the requirements of AS/NZS 3008 (Cable Selection) and AS/NZS 3017 (Testing Procedures). The app provides interactive calculators, step-by-step testing guides, PDF export, quiz features, and access to offline standards.

## Table of Contents

* [Features](#features)
* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Project Structure](#project-structure)
* [Contributing](#contributing)
* [License](#license)

## Features

### 🛠 Calculators

* **Voltage Drop Calculator** (Single & Three Phase)
* **Zs Compliance Checker**
* **Current-Carrying Capacity (CCC) Calculator** with pre-filled derating factors and tooltips
* **Short-Circuit Withstand Time Calculator**
* **Maximum Demand & Breaker Sizer**

### 📋 Testing Tools

* **Step-by-Step AS/NZS 3017 Testing Procedures** with standard diagrams
* **PDF Test Certificate Generator** (landscape format)
* **Saved Test Logs**
* **Quiz Mode** (“Test Me”) with hint mode

### 📚 Standards & Resources

* **Searchable PDF Viewer** for AS/NZS 3008, 3017, 3000, and DNIPS
* **Offline Regulation Quick Access** with indexed search

### 🔧 Utilities

* **Barcode Scanner** for switchboard labels
* **Unit Converter** (mm² ↔ AWG, °C ↔ °F, W ↔ kW ↔ HP)

### 🔗 Integrations

* **OneDrive** submission of test logs
* **Calendar & Reminders** scheduling for re-tests and inspections

## Requirements

* iOS 17.0 or later
* Xcode 15 or later
* Swift 5.8
* Tested on iPhone and iPad

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Jifinitely/ElectroTrainerAU.git
   ```
2. Open `ElectroTrainerAU/ElectroTrainerAU.xcodeproj` in Xcode.
3. Build and run on the simulator or a physical device.

## Usage

* Navigate via the **Tab Bar**: 🛠 Calculators | 📋 Testing Tools | 📚 Standards & Resources
* Tap a tool to enter inputs or open PDF guides.
* In Calculators, enter values to see real-time results and formula breakdowns.
* In Testing Tools, follow the step-by-step guides and export a PDF certificate.
* Use Quiz Mode to test your knowledge; hints are available when needed.
* Access PDFs offline and search by clause or keyword.
* Scan barcodes on switchboards for quick project identification.
* Convert units fast using the built-in converter.
* Submit completed logs to OneDrive or set reminders for follow-up.

## Project Structure

```
ElectroTrainerAU/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Views/
│   ├── MainMenuView.swift
│   ├── VoltageDropCalculatorView.swift
│   ├── ZsCheckerView.swift
│   ├── CCCCalculatorView.swift
│   ├── ShortCircuitTimeView.swift
│   ├── MaxDemandView.swift
│   ├── TestProcedureView.swift
│   ├── TestCertificateView.swift
│   ├── QuizView.swift
│   ├── PDFViewerView.swift
│   ├── BarcodeScannerView.swift
│   ├── UnitConverterView.swift
│   └── ...  
├── Models/
├── Resources/
│   ├── PDFs/
│   ├── Images/
│   └── Assets.xcassets
└── Helpers/
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests for feature requests, bug fixes, or improvements.

1. Fork the repo.
2. Create a new branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a pull request.

## License

MIT License. See [LICENSE](LICENSE) for details.

