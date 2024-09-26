//
//  RankingView.swift
//  WtaTennis
//
//  Created by Johan LACHENAL on 14/05/2024.
//

import SwiftUI

struct InfoTextView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text(value)
            }
            Spacer()
        }
    }
}

struct InfoTextView_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextView(title: "je suis un titre", value: "je suis un contenu")
    }
}

