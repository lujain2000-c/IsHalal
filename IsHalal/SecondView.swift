//
//  SecondView.swift
//  IsHalal
//
//  Created by لجين إبراهيم الكنهل on 08/03/1445 AH.
//

import SwiftUI
import Vision

struct SecondView: View {
    @State private var imageTaken: UIImage?
    @State private var recognizedTexts = [String]()
    @State var recognizedTextArr = [String]() // divide recognizedTexts each  word alone
    @State var allWords = [String]()
    @State var haramIngredientsPresent =  [String]()
    @State var mushboohIngredientsPresent =  [String]()
    @State private var isLoading = false
    @State private var isHalal = true
    @State private var isMushbooh = false
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    let screenHeight : CGFloat = UIScreen.main.bounds.height
    
    func recognizeCardText() {
      print("reading text")
        let requestHandler = VNImageRequestHandler(cgImage: self.imageTaken!.cgImage!)
        
        let recognizeTextRequest = VNRecognizeTextRequest { ( request, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
             
            
                  for observation  in observations {
                      let recognizedText = observation.topCandidates(1).first!.string
                      self.recognizedTextArr = recognizedText.components(separatedBy: ",")
                
                      for i in 0..<recognizedTextArr.count{
                          var ol: String
    
                          if recognizedTextArr[i].count > 1 {
                              ol = String(recognizedTextArr[i].suffix(2))
                        
                              if ol.lowercased() == "ol" {
                                  if recognizedTextArr[i].lowercased().trimmingCharacters(in: .whitespaces) == "cholesterol" {
                                      recognizedTextArr[i] = ""
                                  }
                                  
                                  if recognizedTextArr[i] != "" {
                                        haramIngredientsPresent.append(recognizedTextArr[i].trimmingCharacters(in: .whitespaces))
                              }
                                   
                              }
                          }

                          allWords.append(recognizedTextArr[i].trimmingCharacters(in: .whitespaces))
                      }
                           self.recognizedTexts.append(recognizedText)
                      }

            haramIngredientsPresent = haramIngredientsPresent + allWords.filter{item in
                
                non_halalIngredients.contains(where: {$0.name.lowercased() == item.lowercased() })
            }
            
            mushboohIngredientsPresent = mushboohIngredientsPresent + allWords.filter{item in
                
                MushboohIngredients.contains(where: {$0.name.lowercased() == item.lowercased() })
            }

            if !haramIngredientsPresent.isEmpty {
                
                isHalal = false
                
            } else if !mushboohIngredientsPresent.isEmpty{
                
                isMushbooh = true
            }
        }
        recognizeTextRequest.recognitionLevel = .accurate
        recognizeTextRequest.usesLanguageCorrection = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                try requestHandler.perform([recognizeTextRequest])
                
                self.isLoading = false
            }
            catch {
                print(error)
            }
        }
    }
    
    var pictureTakenView: some View {
        VStack {
            Image(uiImage: self.imageTaken!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(24)
            

            Button(action: {
                self.imageTaken = nil
                self.recognizedTexts = [String]()
                
            }, label: {
                HStack{
                    Image(systemName: "camera")
                    Text("Re-take picture").fontWeight(.bold)
                }
            } ).softButtonStyle(Capsule(), pressedEffect: .hard)
            
            ZStack{
                if !isHalal {
                    Rectangle()
                        .fill()
                        .foregroundColor(.red)
                        .cornerRadius(10)
                    
                    Text( "Haram")
                }else if isMushbooh{
                    Rectangle()
                        .fill()
                        .foregroundColor( .yellow)
                        .cornerRadius(10)
                    
                    VStack{
                        Text("Mushbooh")
                            .font(.title)
                        VStack{
                            Text("mean: Depends on what the Exxx is created from")
                                .lineLimit(0)
                            Text("like E320: Halal if only vegetable oil is used as a carrier.")
                                .lineLimit(0)
                            Text(" Haraam if the carrier is from pork fat.")
                                .lineLimit(0)
                        }.font(.caption)
                    }
                }else{
                    Rectangle()
                        .fill()
                        .foregroundColor( .green)
                        .cornerRadius(10)
                    
                    Text("Halal")
                }
            }.frame( height: screenHeight / 10)
                .frame(maxWidth: .infinity)
                .padding()
            ZStack{
                RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
                if !isHalal {
                List{
                    ForEach(self.haramIngredientsPresent, id: \.self){
                        Text("\($0)")
                    }
                    
                }.scrollContentBackground(.hidden)
                }else if isMushbooh {
                    List{
                        ForEach(self.mushboohIngredientsPresent, id: \.self){
                            Text("\($0)")
                        }
                    }.scrollContentBackground(.hidden)
                }
            }.padding()
        }.padding()
        .background(Color("Color"))
    }
    var body: some View {
        
            VStack {
                
                if (self.imageTaken == nil) {
                    CameraView(image: self.$imageTaken)
                }else {
                    if (!self.isLoading){
                        self.pictureTakenView
                            .onAppear {
                                self.recognizeCardText()
                            }
                    } else {
                        ProgressView()
                    }
                }
            }.padding(.top,32)
            .background(.black)
            .ignoresSafeArea()
        
//            .task{
//                await fetchData()
//            }
        }
//    func fetchData() async {
//            let dbUrl = "rm-l4ve1232eeclvo8uh.mysql.me-central-1.rds.aliyuncs.com"
//
//            guard let url = URL(string: dbUrl) else {
//                print("OH ... THE URL DOES NOT WORK")
//                return
//            }
//
//            do {
//                let (data, response) = try await URLSession.shared.data(from: url)
//
//                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
//                    print("Can not get status code")
//                    return
//                }
//
//                if statusCode < 200 || statusCode > 299 {
//                    print("Status code: (statusCode), is not in 200s.")
//                    return
//                }
//
//                guard let dataAsString = String(data: data, encoding: .utf8) else {
//                    print("Can not convert data to string")
//                    return
//                }
//
//                print("Data as String: (dataAsString)")
//
//                let apiData = try JSONDecoder().decode([NonHalalIngredient].self, from: data)
//                //non_halalIngredients.append(apiData)//or [apiData]
//                non_halalIngredients = apiData
//                print(non_halalIngredients)
//            } catch {
//                print("Error (error)")
//            }
//        }
    }
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
