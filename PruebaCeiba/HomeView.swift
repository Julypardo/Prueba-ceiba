//
//  HomeView.swift
//  PruebaCeiba
//
//  Created by July Pardo on 10/05/23.
//

import SwiftUI

struct HomeView: View {
    @State var search: String = ""
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(Color("CadmiumGreen"))
                .frame(width: .infinity, height: 80)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading, spacing: 0) {
                TextField("Buscar usuario", text: $search)
                    .accentColor(Color("CadmiumGreen"))
                
                Divider()
                    .frame(height: 2)
                    .background(Color("CadmiumGreen"))
                    .padding(.top, 10)
            }
            .padding(.top, 30)
            .padding(.horizontal, 16)
            
            PublicationListView()
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Cultured"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CardPersonalInfo: Identifiable {
    var id = UUID()
    var title: String
    var phoneNumber: String
    var email: String
}

struct PublicationListView: View {
    let items = [
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz"),
        CardPersonalInfo(title: "Leanne Graham", phoneNumber: "1-12334-12345", email: "sincere@april.biz")
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(items) { item in
                CardInfoView(item: .constant(item))
            }
        }
    }
}

struct CardInfoView: View {
    
    @Binding var item: CardPersonalInfo
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0)  {
                    Text(item.title)
                        .foregroundColor(Color("CadmiumGreen"))
                        .font(.system(size: 25, weight: .medium, design: .default))
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color("CadmiumGreen"))
                        Text(item.phoneNumber)
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
