//
//  ErrorView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.colorScheme) var colorScheme
    var error: Error
    var errorString: String = ""
    var retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.primary)
            Text(errorString)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Text("Por favor intenta de nuevo mas tarde")
                .font(.headline)
            if let retryAction {
                Button(action:{
                    retryAction()
                }){
                    Text("Reintentar")
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                        .padding()
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray.opacity(0.5))
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Material.thick)
                            }
                        }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ErrorView(error: GetErrors.decodeError) {}
}
