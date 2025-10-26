import SwiftUI

struct MortgageCalculatorView: View {
    @State private var propertyPrice: Double = 1000000
    @State private var downPayment: Double = 200000
    @State private var interestRate: Double = 4.0
    @State private var loanTerm: Double = 25

    private var monthlyPayment: Double {
        let principal = propertyPrice - downPayment
        let monthlyRate = interestRate / 100 / 12
        let months = loanTerm * 12
        let numerator = principal * monthlyRate * pow(1 + monthlyRate, months)
        let denominator = pow(1 + monthlyRate, months) - 1
        return numerator / denominator
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedGradientBackground()

                VStack(spacing: 20) {
                    Text("Mortgage Calculator")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 30)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Property Price")
                                .foregroundColor(.white)
                            Spacer()
                            Text("AED \(Int(propertyPrice))")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Slider(value: $propertyPrice, in: 200000...5000000, step: 10000)

                        HStack {
                            Text("Down Payment")
                                .foregroundColor(.white)
                            Spacer()
                            Text("AED \(Int(downPayment))")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Slider(value: $downPayment, in: 0...propertyPrice, step: 5000)

                        HStack {
                            Text("Interest Rate: \(String(format: "%.2f", interestRate))%")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Slider(value: $interestRate, in: 1...10, step: 0.1)

                        HStack {
                            Text("Loan Term: \(Int(loanTerm)) years")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Slider(value: $loanTerm, in: 5...30, step: 1)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 10) {
                        Text("Estimated Monthly Payment")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        Text("AED \(Int(monthlyPayment))")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Developed by Faraz Kazmi")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 30)
                }
            }
            .navigationTitle("Mortgage Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
