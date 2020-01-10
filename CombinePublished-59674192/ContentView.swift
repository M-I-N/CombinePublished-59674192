//
//  ContentView.swift
//  CombinePublished-59674192
//
//  Created by Mufakkharul Islam Nayem on 1/10/20.
//  Copyright © 2020 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @ObservedObject var model = Model()

    var body: some View {
        HStack {
            Text("ValueEq is \(model.valueEq)")
            .onTapGesture {
                self.count = (self.count + 1) % 3
                self.model.valueEq = self.model.valueEq + (self.count == 0 ? 1 : 0)
            }
            .onReceive(self.model.$valueEq) { val in
                print("ValueEq is \(val)")
            }

            Text("ValueAlways is \(model.valueAlways)")
            .onTapGesture {
                self.count = (self.count + 1) % 3
                self.model.valueAlways = self.model.valueAlways + (self.count == 0 ? 1 : 0)
            }
            .onReceive(self.model.$valueAlways) { val in
                print("ValueAlways is \(val)")
            }
        }
        .onReceive(self.model.objectWillChange) { _ in
            print("Object Changed")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
