//
//  ContentView.swift
//  SwiftUIList
//
//  Created by praveen reddy on 10/10/20.
//  Copyright © 2020 praveen reddy. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id: Int
    let username: String
    let message: String?
}

struct ContentView: View {
    
    let users: [User] = [
        User(id: 0, username: "praveen", message: "ios developer at focus."),
        User(id: 1, username: "rajesh", message: "ios developer at focus."),
        User(id: 2, username: "mihir", message: nil)
    ]
    
    var body: some View {
//        Text("Hello World")
        
        NavigationView {
            List(users) { user in
                NavigationLink(destination: Text(user.username)) {
                    ListViewCell(user: user)
                }
            }
            .navigationBarTitle(Text("Home"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* List View Cell */
struct ListViewCell: View {
    var user: User
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.username)
                .font(.headline)
            
            // Adding rest of the view if they are not equal to nil.
            Unwrap(user.message) { msg in
                Text(msg)
                    .font(.subheadline)
                Text(msg)
                    .font(.subheadline)
                Text(msg)
                    .font(.subheadline)
            }
        }
    }
}

// Helper struct to add views based on condition check for optional data, bcos if let and guard doesn't work.
struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
