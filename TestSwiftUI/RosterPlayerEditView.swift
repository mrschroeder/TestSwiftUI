//
//  RosterPlayerEditView.swift
//  TestSwiftUI
//
//  Created by Mike Schroeder on 4/24/22.
//

import SwiftUI

struct RosterPlayerEditView: View {
    @ObservedObject var rosterViewModel: RosterViewModel
    @State var player: Player
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                VStack {
                    TextField("first name", text: $player.firstName)
                    TextField("last name", text: $player.lastName)
                    Spacer()
                }
            }
            .navigationBarItems(leading: Button("cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarItems(trailing: Button("save") {
                doSave()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    func doSave() {
        for (index, element) in rosterViewModel.list.enumerated() {
            if element.id == player.id {
                rosterViewModel.list[index] = player
                break
            }
        }
    }
}
