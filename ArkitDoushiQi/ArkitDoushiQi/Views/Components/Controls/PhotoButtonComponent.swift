//
//  PhotoButtonComponent.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 27/05/2024.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

struct PhotoButtonComponent: View {
    let Value : String
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    var body: some View {
        VStack {
                    if let selectedImage{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button(Value) {
                        self.showCamera.toggle()
                    }
                    .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                    }
                }
    }
}

struct PhotoButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        PhotoButtonComponent(Value : "Prendre Photo")
    }
}
