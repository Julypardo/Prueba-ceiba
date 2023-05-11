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
                PublicationListView(items: $viewModel.users, viewModel: viewModel)
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
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(items, id: \.id) { item in
                CardInfoView(item: .constant(item), viewModel: viewModel)
            }
        }
    }
}

struct CardInfoView: View {
    @State var showPublications = false
    
    @Binding var item: User
    
    @ObservedObject var viewModel: HomeViewModel
    
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
                    
                    if showPublications {
                        PublicationView(viewModel: viewModel, userId: item.id)
                            .padding(.top, 10)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                self.showPublications.toggle()
            }) {
                Text(self.showPublications ? "OCULTAR PUBLICACIONES" : "VER PUBLICACIONES")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(Color("CadmiumGreen"))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
        }
        .foregroundColor(Color.black)
        .padding(.horizontal, 16)
        .padding(.vertical, 30)
        .frame(width: .infinity)
        .background(Color.white.cornerRadius(8).shadow(radius: 3, x: 4, y: 2))
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
    }
}

struct PublicationView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State var posts = [Post]()
    let userId: Int
    
    var body: some View {
        VStack {
            if posts.isEmpty {
                ProgressView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(posts, id: \.id) { post in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(post.title)
                                .foregroundColor(Color("CadmiumGreen"))
                                .font(.system(size: 18, weight: .medium, design: .default))
                            
                            Text(post.body)
                                .font(.system(size: 16, weight: .light, design: .default))
                                .padding(.top, 3)
                            
                            Divider()
                                .frame(height: 0.3)
                                .background(Color("CadmiumGreen"))
                                .padding(.vertical, 15)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPosts(userId){ post in
                self.posts = post
            }
        }
    }
}
