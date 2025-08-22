//
//  SearchBarView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject var viewModel: SearchViewModel
    @FocusState.Binding var focusSearch: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $viewModel.searchText, prompt: Text("Search..."))
                .focused($focusSearch)
                .onLongPressGesture(minimumDuration: 0.0) {
                    focusSearch = true
                }
                .autocorrectionDisabled()
                .overlay {
                        HStack {
                            if !viewModel.isSearching {
                                Spacer()
                                Button {
                                    focusSearch = true
                                    viewModel.resetSearch()
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                }
                                .foregroundColor(.secondary)
                                .padding(.trailing, 4)
                        }
                    }
                }
                .accessibilityInfo(label: "Barra de busqueda",
                                    hint: "Apretar para seleccionar la barra de bsuqueda",
                                    value: "Se esta buscando \(viewModel.searchText)")
            if focusSearch || viewModel.showCancelButton() {
                Button(action:{
                    focusSearch = false
                    viewModel.resetSearch()
                }){
                    Text("Cancel")
                }
                .accessibilityInfo(label: "Cancelar la busqueda",
                                   hint: "Apretar para cancelar la busqueda",
                                   value: "Cancelar")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Material.regular)
                .ignoresSafeArea(edges: .all)
        )
        .shadow(radius: 3)
    }
}

#Preview {
    @FocusState var focusSearch: Bool
    SearchBarView(viewModel: SearchViewModel(), focusSearch: $focusSearch)
}
