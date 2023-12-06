//
//  ContentView.swift
//  IsHalal
//
//  Created by لجين إبراهيم الكنهل on 06/03/1445 AH.
//

//COLOR: F0F0F3
//AEAEC0
import SwiftUI
import Vision
import Neumorphic

struct ContentView: View {
    
    @State var toggleIsOn = false
    @State var x = false
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    let screenHeight : CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
      
        NavigationStack{
            
            ZStack{
                Color("Color")
                VStack{
                    
                   
                    VStack{
                        VStack{
                            HStack{
                                
                                Spacer()
                                
                                Toggle("Toggle", isOn: $toggleIsOn)
                                    .softSwitchToggleStyle(tint: Color("Shadow2"), labelsHidden: true)
                            }
                        
                        }.padding(.top)
                      
                    }.padding(.vertical)
                    VStack{
                      
                        ZStack{

                            RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                    
                            Image("5")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                       
                        }  .frame(maxWidth: .infinity)
                           .frame(maxHeight: .infinity)
                           .padding()
                        
                        Button(action: {}) {
                            VStack{
                                
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal,50)
                                    .foregroundColor(Color("Shadow2"))
                                    //.bold()
                                    .padding(.bottom, 4)
                                    //.padding(.horizontal, 32)
                                NavigationLink(toggleIsOn ? "التقط الصورة" : "Take a picture",destination: SecondView())
                                
                            } .foregroundColor(Color("Shadow2"))
                                .bold()
                               // .font(.title3)
                        
                           .frame(maxWidth: .infinity , maxHeight: .infinity)
                            
                        }.softButtonStyle(Circle())
                            .padding(75)
                            .padding(24)
                      
                       
                      
                    }.padding(.vertical)
                        
                }  .padding()

                
            }.ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
        }
    
   }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

