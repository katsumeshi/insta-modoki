//
//  PhotoRow.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/4/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct PhotoRow: View {
    var body: some View {
        VStack {
            HeaderView()
            Image("cat").resizable().scaledToFit()
            ActionView()
            DescriptionView()
        }.padding(.vertical)
    }
}

struct MenuView: View {
    var body: some View {
        VStack {
            Circle().foregroundColor(Color.black).frame(width: 4, height: 4)
            Circle().foregroundColor(Color.black).frame(width: 4, height: 4)
            Circle().foregroundColor(Color.black).frame(width: 4, height: 4)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("cat")
                .resizable()
                .frame(width:40, height: 40)
                .scaledToFit()
                .cornerRadius(20)
                .padding(2)
                .overlay(Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.red))
            VStack(alignment: .leading) {
                Text("Mr cat")
                Text("Underground")
            }
            Spacer()
            MenuView()
        }.padding(.horizontal)
    }
}

struct ActionView: View {
    var body: some View {
        HStack {
            Image(systemName: "suit.heart")
            Image(systemName: "message")
            Image(systemName: "paperplane")
            Spacer()
        }.padding(.horizontal)
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment:.top) {
                Text("yuki").bold() + Text(" test test test test test test test test test test test test test test test test ")
                Spacer()
            }.padding()
            Text("View all 5 comments").padding(.horizontal)
        }
    }
}


struct PhotoRow_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRow()
    }
}
