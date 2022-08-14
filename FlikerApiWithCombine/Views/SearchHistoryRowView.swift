//
//  ListRowView.swift
//  ToDoList
//
//  Created by Ahmed Elsman on 05/07/2022.
//

import SwiftUI

struct SearchHistoryRowView: View {
    
    var item: SearchItem
    
    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
        }
        .font(.title3)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.1),
                    radius: 5, x: 0, y: 0)
        )
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var itemModel1: SearchItem = SearchItem(title: "First")
    static var itemModel2: SearchItem = SearchItem(title: "Second")
    
    static var previews: some View {
        Group {
            SearchHistoryRowView(item: itemModel1)
        }
        
    }
}
