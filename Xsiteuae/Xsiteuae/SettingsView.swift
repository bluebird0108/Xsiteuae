// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var useDarkMode = true

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $useDarkMode)
                        .onChange(of: useDarkMode) { _, newValue in
                            // This is a demo. For a real app-wide setting, store in AppStorage and read at the app entry.
                        }
                }

                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }

                Section(header: Text("About")) {
                    HStack {
                        Text("App")
                        Spacer()
                        Text("Xsite UAE").foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0").foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
