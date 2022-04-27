//
//  RosterListEditView.swift
//  TestSwiftUI
//
//  Created by Mike Schroeder on 4/24/22.
//

import SwiftUI

struct RosterListEditView: View {
    @ObservedObject var model: RosterViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingPlayerEdit = false

    var body: some View {
        NavigationView {
            List {
                ForEach(model.list, id: \.jerseyNumber) { player in
                    Button {
                        showingPlayerEdit.toggle()
                    } label: {
                        PlayerRow(player: player)
                    }
                    .sheet(isPresented: $showingPlayerEdit) {
                        RosterPlayerEditView(rosterViewModel: model, player: player)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: Button("done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct PlayerRow: View {
    let player: Player

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    let name = [player.firstName, player.lastName]
                        .compactMap { $0 }.joined(separator: " ")
                    Text(name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.75)
                }
            }
        }
    }
}
