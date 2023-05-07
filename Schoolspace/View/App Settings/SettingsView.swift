import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkModeOn") var isDarkModeOn = false
    @State private var showNotification = true
    @State private var selectedColor = 0
    let colors = ["Red", "Green", "Blue"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkModeOn) {
                        Text("Dark Mode")
                    }
                    
                    Picker(selection: $selectedColor, label: Text("Color")) {
                        ForEach(0 ..< colors.count) {
                            Text(self.colors[$0])
                        }
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $showNotification) {
                        Text("Show Notifications")
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}
