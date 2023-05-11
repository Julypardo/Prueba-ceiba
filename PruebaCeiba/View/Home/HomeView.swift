//
//  HomeView.swift
//  PruebaCeiba
//
//  Created by July Pardo on 10/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(Color("CadmiumGreen"))
                .frame(width: .infinity, height: 80)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading, spacing: 0) {
                TextField("Buscar usuario", text: $viewModel.search)
                    .accentColor(Color("CadmiumGreen"))
                
                Divider()
                    .frame(height: 2)
                    .background(Color("CadmiumGreen"))
                    .padding(.top, 10)
            }
            .padding(.top, 30)
            .padding(.horizontal, 16)
            
            if viewModel.users.isEmpty {
                Text("List is empty")
            } else {
                PublicationListView(items: $viewModel.users)
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Cultured"))
        .onChange(of: viewModel.search) { newValue in
            viewModel.filterUsersByName(newValue)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PublicationListView: View {
    @Binding var items: [User]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(items, id: \.id) { item in
                CardInfoView(item: .constant(item))
            }
        }
    }
}

struct CardInfoView: View {
    
    @Binding var item: User
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0)  {
                    Text(item.name)
                        .foregroundColor(Color("CadmiumGreen"))
                        .font(.system(size: 25, weight: .medium, design: .default))
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color("CadmiumGreen"))
                        Text(item.phone)
                            .font(.system(size: 16, weight: .regular, design: .default))
                    }
                    .padding(.top, 3)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color("CadmiumGreen"))
                        Text(item.email)
                            .font(.system(size: 16, weight: .regular, design: .default))
                    }
                    .padding(.top, 3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            
            Spacer()
            
            Text("VER PUBLICACIONES")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(Color("CadmiumGreen"))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
        }
        .foregroundColor(Color.black)
        .padding(.horizontal, 16)
        .padding(.vertical, 30)
        .frame(width: .infinity, height: 150)
        .background(Color.white.cornerRadius(8).shadow(radius: 3, x: 4, y: 2))
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
    }
}
