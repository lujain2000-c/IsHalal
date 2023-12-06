//
//  CameraView.swift
//  IsHalal
//
//  Created by لجين إبراهيم الكنهل on 06/03/1445 AH.
//
import Foundation
import UIKit
import SwiftUI



struct CameraView: UIViewControllerRepresentable{
   
    @Binding var image: UIImage?
    
  
    typealias UIViewControllerType = UIImagePickerController
    
    
    func makeUIViewController(context: Context) -> UIViewControllerType{
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        viewController.cameraDevice = .rear
        viewController.cameraOverlayView = .none
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
    
   
    
}

extension CameraView{
   // @MainActor
    class Coordinator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: CameraView
        //@Published var isCancel = false
       // var didCancelScanning: () -> Void
        init(_ parent: CameraView) {
            self.parent = parent
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            //self.isCancel = true
           
            //ContentView()
            
        }

        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
            image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                print("Image taken")
                print("width: " + image.size.width.description)
                print("Heigh: " + image.size.height.description)
                
                if (image.size.width > image.size.height) {
                    self.parent.image = image.imageResized(to: CGSize(width: 3000, height: 2250))
                    
                } else {
                    
                    self.parent.image = image.imageResized(to: CGSize(width: 3000, height: 2250))
                }
            }
            
            
        }
    }
}


extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image{ _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
//struct CameraView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
