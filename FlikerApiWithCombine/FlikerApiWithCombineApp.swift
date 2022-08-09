//
//  FlikerApiWithCombineApp.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import SwiftUI

@main
struct FlikerApiWithCombineApp: App {
    var body: some Scene {
        
        let vm = SearchListViewModel()
        
        WindowGroup {
            SearchListView(vm: vm)
        }
    }
}
