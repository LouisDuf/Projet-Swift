//
//  ProfileComponent.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 27/05/2024.
//

import SwiftUI

struct ProfileComponent: View {
    let color : Color
    let profileWidth : CGFloat
    let profileHeight : CGFloat
    let image : Image
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color
                color
                
                // Profile Image
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95) // Smaller than the ZStack
            }
            // Ensure the ZStack takes the size of the GeometryReader
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipShape(Circle())
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(width: profileWidth, height: profileHeight) // Optional fixed size
    }
}

struct ProfileComponent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileComponent(
            color: Color(.red),
            profileWidth: 200,
            profileHeight : 200,
            image: Image("profil")
        )
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
