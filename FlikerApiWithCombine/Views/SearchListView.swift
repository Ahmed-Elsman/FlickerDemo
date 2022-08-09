//
//  SearchListView.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import SwiftUI

struct SearchListView: View {
    
    @State var isEnabledToSearch: Bool = false
    @StateObject private var vm: SearchListViewModel
    private let columnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(vm: SearchListViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            searchBar
            Spacer()
            if vm.searchText.isEmpty {
                if vm.previousSearchList.isEmpty {
                    NoItemsView(isEnabledToSearch: $isEnabledToSearch)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                } else {
                    previousSearchList
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
            }
            else {
                gridSearchResult
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(vm: dev.searchVM)
    }
}

// MARK: extension
extension SearchListView {
    
    private var searchBar: some View {
        HStack {
            searchIcon
            TextField(vm.searchTextPlacholder, text: $vm.searchText)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .frame(height: 35)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(vm.searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            vm.searchText = ""
                            vm.flickerItems = []
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
    
    private var previousSearchList: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Search History")
                .font(.title2)
                .bold()
                .underline()
                .padding(.horizontal)
            List {
                ForEach(vm.previousSearchList) { item in
                    ListRowView(item: item)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                vm.searchText = item.title
                            }
                        }
                }
                .onDelete(perform: vm.deleteItem)
                .onMove(perform: vm.moveItem)
            }
            .listStyle(InsetListStyle())
        }
    }
    
    private var gridSearchResult: some View {
        ScrollView {
            LazyVGrid(columns: columnGrid, spacing: 20) {
                ForEach(vm.flickerItems) { item in
                    FlickerItemView(flickerItem: item)
                }
            }
            .padding()
        }
    }
    
    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .scaledToFit()
            .font(.largeTitle)
            .foregroundColor(vm.searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            .frame(width: 20, height: 20)
    }
}
