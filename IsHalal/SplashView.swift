//
//  SplashView.swift
//  IsHalal
//
//  Created by لجين إبراهيم الكنهل on 14/03/1445 AH.
//

import SwiftUI

struct SplashView: View {
    
    @AppStorage("new_user") var currentUserNew: Bool = true
    @State var isActive:Bool = false
    @State var size = 0.8
    @State var opacity = 0.5
   
    let screenHeight : CGFloat = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            if self.isActive {
                if currentUserNew{
                    OnboardingView()
            } else {
                ContentView()
            }
            } else {
                VStack {
                    ZStack{
                        Color("Color")
                            .ignoresSafeArea()
                        
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                                //VStack{
                                Image("Logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                            }.frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .padding(120)
                            .padding(.vertical,80)
                        .multilineTextAlignment(.center)
                        .padding(.vertical,40)
                        .padding(.vertical,40)
                        .padding(.vertical,40)
                        .padding(.vertical,40)
                        .padding()
                        
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            
                            withAnimation {
                           
                                self.size = 1.5
                                self.opacity = 1.0

                            }
                        }
                    }.onAppear {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                           
                            withAnimation {
                              
                                   self.isActive = true
                                
                                
                            }
                        }
                    }
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
