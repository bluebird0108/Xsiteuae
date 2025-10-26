import SwiftUI

struct MortgageCalculatorView: View {
    @State private var propertyPrice: Double = 2_000_000
    @State private var downPaymentPct: Double = 20
    @State private var annualRatePct: Double = 4.25
    @State private var years: Double = 25

    private var loanAmount: Double {
        propertyPrice * (1 - downPaymentPct / 100)
    }

    private var monthlyPayment: Double {
        let r = (annualRatePct / 100) / 12
        let n = years * 12
        guard r > 0 else { return loanAmount / n }
        return loanAmount * (r * pow(1 + r, n)) / (pow(1 + r, n) - 1)
    }

    var body: some View {
        ZStack {
            AnimatedGradientBackground()

            Form {
                Section(header: Text("Inputs")) {
                    HStack {
                        Text("Property Price")
                        Spacer()
                        Text("AED \(Int(propertyPrice).formattedWithSeparator())")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $propertyPrice, in: 300_000...10_000_000, step: 50_000)

                    HStack {
                        Text("Down Payment")
                        Spacer()
                        Text("\(Int(downPaymentPct))%")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $downPaymentPct, in: 0...50, step: 1)

                    HStack {
                        Text("Rate (p.a.)")
                        Spacer()
                        Text("\(annualRatePct, specifier: "%.2f")%")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $annualRatePct, in: 1...10, step: 0.05)

                    HStack {
                        Text("Tenure (years)")
                        Spacer()
                        Text("\(Int(years))")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $years, in: 5...30, step: 1)
                }

                Section(header: Text("Results")) {
                    HStack {
                        Text("Loan Amount")
                        Spacer()
                        Text("AED \(Int(loanAmount).formattedWithSeparator())")
                            .foregroundColor(Theme.goldAccent)
                    }
                    HStack {
                        Text("Monthly Payment")
                        Spacer()
                        Text("AED \(Int(monthlyPayment).formattedWithSeparator())")
                            .foregroundColor(Theme.goldAccent)
                            .fontWeight(.semibold)
                    }
                }

                Section(footer: Text("Figures are estimates only and do not constitute financial advice.")) {
                    EmptyView()
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}
