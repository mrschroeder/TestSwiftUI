//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Mike Schroeder on 4/24/22.
//

import SwiftUI

struct Player: Identifiable {
    var id: Int
    var firstName: String = ""
    var lastName: String = ""
    var jerseyNumber: String = ""

    init(id: Int, firstName: String, lastName: String, jerseyNumber: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.jerseyNumber = jerseyNumber
    }

}

// MARK: to get observable to work this cannot be a class so use a struct

// class Player: Equatable {
//    var id: Int
//    var firstName: String = ""
//    var lastName: String = ""
//    var jerseyNumber: String = ""
//
//    init(id: Int, firstName: String, lastName: String, jerseyNumber: String) {
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.jerseyNumber = jerseyNumber
//    }
//
//    static func == (lhs: Player, rhs: Player) -> Bool {
//        lhs.firstName == rhs.firstName
//       && lhs.lastName == rhs.lastName
//       && lhs.jerseyNumber == rhs.jerseyNumber
//    }
// }

class RosterViewModel: ObservableObject {
    @Published var list: [Player] = []

    init(list: [Player]) {
        self.list = list
    }
}

struct ContentView: View {
    static let list = [Player(id: 1, firstName: "A", lastName: "Alpha", jerseyNumber: "1"),
                Player(id: 2, firstName: "B", lastName: "Beta", jerseyNumber: "2"),
                Player(id: 3, firstName: "G", lastName: "Gamma", jerseyNumber: "3"),
                Player(id: 4, firstName: "D", lastName: "Delta", jerseyNumber: "4")
    ]
    @State private var showingRosterEdit = false
    @ObservedObject var rosterViewModel = RosterViewModel(list: list)

    var body: some View {
        ShowModalContentView(toggleKey: $showingRosterEdit, title: "Players",
                             value: "\(rosterViewModel.list.count)", content:
                                RosterListEditView(model: rosterViewModel))
        .padding()
    }
}

struct ShowModalContentView<Content: View>: View {
    @Binding var toggleKey: Bool
    var title: String
    var value: String
    var content: Content

    var body: some View {
        Button {
            toggleKey.toggle()
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                Text(value)
                    .foregroundColor(.black)
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color(.systemGray2))
                    .font(Font.caption.bold())
            }
        }
        .sheet(isPresented: $toggleKey) {
            VStack(alignment: .center, spacing: 10, content: {content})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
