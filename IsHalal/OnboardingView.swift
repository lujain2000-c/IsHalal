//
//  OnboardingView.swift
//  IsHalal
//
//  Created by لجين إبراهيم الكنهل on 12/03/1445 AH.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("new_user") var currentUserNew: Bool = true
    @State private var  currentStep = 0
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    let screenHeight : CGFloat = UIScreen.main.bounds.height
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    @State var clickGetStarted = false
    var body: some View {
        NavigationStack {
            ZStack{
                Color("Color")
                if clickGetStarted {
                    ContentView()
                } else {
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {}) {
                                NavigationLink("Skip"){
                                    ContentView()
                                }.fontWeight(.bold)
                                
                                
                            }
                            .softButtonStyle(Capsule(), pressedEffect: .hard)
                            
                        }
                        .padding(.top)
                        
                        TabView(selection: $currentStep,  content:  {
                            VStack{
                                
                                ZStack{
                               
                                    RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                                    
                                    VStack{
                                        Image("5")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        Text("Take a picture of the ingredients")
                                            .font(.headline)
                                    }
                                }  .frame(maxWidth: .infinity)
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .transition(transition)
                                
                            }.tag(0)
                                .frame( height:  screenHeight / 2)
                                .transition(transition)
                            
                            VStack{
                                ZStack{
                                  
                                    RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                                    
                                    VStack{
                                        Image("6")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        Text("The App will tell you if it is halal or haram")
                                            .font(.headline)
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                    }
                                }  .frame(maxWidth: .infinity)
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .transition(transition)
                                  
                            }.tag(1)
                                .transition(transition)
                                .frame( height:  screenHeight / 2)
                            
                            
                        }) .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .transition(transition)
                        
                        Button(action: {
                            if currentStep == 0 {
                                currentStep = 1
                            }else{
                                self.clickGetStarted = true
                                withAnimation(.spring()){
                                    currentUserNew = false
                                }
                            }
                            
                        }, label: {
                            HStack{
                                
                                Text(currentStep == 0 ? "Next" : "Get Started").fontWeight(.bold)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                            }
                        } )
                        .softButtonStyle(Capsule(), pressedEffect: .hard)
                        
                    }.padding()
                        .padding(.vertical,32)
                }
            }.ignoresSafeArea()
        }.tint(Color("Shadow2"))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
