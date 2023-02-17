//
//  StartView.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 27.01.23.
//

import SwiftUI

struct StartView: View {
    @State var isActive: Bool = false
    @State var opacity: Double = 0.0
    @State var scale: Double = 0.8
    
    var body: some View {
        VStack {
            if !isActive {
                VStack {
                    Image("LaunchPic")
                    Text("Sigmagram")
                        .font(.custom("FONTSPRINGDEMO-BlueVinylBold", size: 50))
                        .foregroundStyle(LinearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .opacity(opacity)
                .scaleEffect(scale)
                .onAppear() {
                    withAnimation(.easeIn(duration: 1)) {
                        scale = 1.0
                        opacity = 1.0
                    }
                }
            } else {
                MainView()
            }
        }.onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation() {
                    isActive = true
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
