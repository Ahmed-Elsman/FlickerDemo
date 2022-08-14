//
//  NoItemsView.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/07/2022.
//

import SwiftUI

struct NoItemsView: View {
    
    @Binding var isEnabledToSearch: Bool
    @State var animate: Bool = false
    private let paddingLength: CGFloat = 40
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                noItemsLabels
                searchNowButton
                    .padding(.horizontal, paddingLength)
            }
            .multilineTextAlignment(.center)
            .padding(paddingLength)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("No Items Found")
        .padding()
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView(isEnabledToSearch: .constant(false))
        }
    }
}


extension NoItemsView {
    
    private var noItemsLabels: some View {
        VStack(spacing: 0){
            Text("There Are No Items!")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.accent)
            Text("You can search on FLICKER images as you want Just!")
                .padding(.bottom, 20)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var searchNowButton: some View {
        Button {
            withAnimation(.easeInOut) {
                isEnabledToSearch.toggle()
            }
        } label: {
            Text("Search Now 🔎")
                .frame(height: 50)
                .frame(maxWidth:.infinity)
                .font(.headline)
                .background(animate ? Color.theme.red : Color.theme.accent)
                .foregroundColor(Color.theme.background)
                .cornerRadius(animate ? 10 : 20)
                .shadow(color: animate ? Color.theme.red.opacity(0.7) : Color.theme.accent.opacity(0.7),
                        radius: animate ? 10 : 20,
                        x: 0,
                        y: animate ? 30 : 0)
                .scaleEffect(animate ? 1.2 : 1.0)
                .offset(x: 0,
                        y: animate ? -7 : 0)
        }
    }
    
    private func addAnimation() {
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
