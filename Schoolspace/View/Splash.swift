//
//  SplashView.swift
//  School space
//
//  Created by Mohamed Abbes on 20/4/2023.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {Color(0xFF016DB1).ignoresSafeArea()
            if self.isActive {
                Login()
            } else {
               
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
