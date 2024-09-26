//
//  EditImageComponent.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 31/05/2024.
//

import SwiftUI
import PhotosUI

struct EditImageComponent: View {
    let color: Color
    let profileWidth: CGFloat
    let profileHeight: CGFloat
    let defaultImage: Image
    let imageTextChange: LocalizedStringKey
    @Binding var playerImage: UIImage
    @State private var selectedImageItem: PhotosPickerItem? = nil

    var body: some View {
        HStack {
            Image(uiImage: playerImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: profileWidth, height: profileHeight)
                .clipShape(Circle())
                .overlay(Circle().stroke(color, lineWidth: 2))
            
            PhotosPicker(selection: $selectedImageItem, matching: .images) {
                Text(imageTextChange)
                    .foregroundColor(.blue)
                    .padding(.leading)
            }
            .onChange(of: selectedImageItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        playerImage = uiImage
                    }
                }
            }
        }
    }
}

struct EditImageComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditImageComponent(
            color: Color(.red),
            profileWidth: 100,
            profileHeight: 100,
            defaultImage: Image("profil"),
            imageTextChange: "Changer l'avatar",
            playerImage: .constant(UIImage(named: "profil")!)
        )
    }
}
