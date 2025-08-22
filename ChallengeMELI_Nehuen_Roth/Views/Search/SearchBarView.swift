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
            if focusSearch || viewModel.showCancelButton() {
                Button(action:{
                    focusSearch = false
                    viewModel.resetSearch()
                }){
                    Text("Cancel")
                }
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
