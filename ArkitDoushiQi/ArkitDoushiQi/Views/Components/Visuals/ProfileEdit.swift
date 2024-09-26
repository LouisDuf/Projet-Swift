//
//  ProfileEdit.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL, Louis DUFOUR on 28/05/2024.
//

import SwiftUI
import PhotosUI

struct ProfileEdit: View, KeyboardReadable {
    let color: Color
    let profileWidth: CGFloat
    let profileHeight: CGFloat
    let defaultImage: Image
    let imageTextChange: LocalizedStringKey
    let playerNameKey: LocalizedStringKey
    @Binding var playerName: String
    @Binding var playerImage: UIImage
    @State private var selectedImageItem: PhotosPickerItem? = nil
    @State private var keyboardHeight: CGFloat = 0
    @State private var isKeyboardVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: playerImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
            .padding(.horizontal)

            EditTextComponent(explanation: playerNameKey, name: $playerName)
                .padding(.horizontal)
        }
        .padding(.bottom, isKeyboardVisible ? keyboardHeight : 0)
        .animation(.easeOut(duration: 0.3), value: keyboardHeight)
        .onReceive(keyboardPublisher) { height in
            withAnimation {
                self.keyboardHeight = height
                self.isKeyboardVisible = height > 0
            }
        }
    }
}

struct ProfileEdit_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEdit(color: Color(.red),
                    profileWidth: 100,
                    profileHeight: 100,
                    defaultImage: Image("profil"),
                    imageTextChange: "Changer l'avatar",
                    playerNameKey: "Nom du Joueur 1",
                    playerName: .constant("Joueur 1"),
                    playerImage: .constant(UIImage(named: "profil")!)
        )
    }
}
