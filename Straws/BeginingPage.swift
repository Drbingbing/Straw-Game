//
//  BeginingPage.swift
//  Straws
//
//  Created by Bing Bing on 2022/10/24.
//

import SwiftUI

struct BeginingPage: View {
    
    @State var results = Array(repeating: "", count: 28)
    @State var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(results.indices, id: \.self) { index in
                    let result = results[index]
                    let bindingValue = $results[index]
                    TextField(result, text: bindingValue)
                        .textFieldStyle(.roundedBorder)
                        .placeholder(display: result.isEmpty, value: "\(index).")
                }
                Color.clear
                    .frame(height: disableButton() ? 0 : 60)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                alignment: .bottom,
                content: {
                    Button(action: {
                        showDetail = true
                    }) {
                        HStack {
                            Text("Next")
                            Image(systemName: "arrow.forward")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .foregroundColor(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(buttonColor())
                        }
                    }
                    .disabled(disableButton())
                    
                    .animation(.easeOut, value: disableButton())
                }
            )
            .padding()
            .navigationTitle(Text("Setting Results"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        results = Array(repeating: "", count: 29)
                    }) {
                        Text("Reset")
                    }
                }
            }
            .navigationDestination(isPresented: $showDetail) {
                ContentView(words: results.filter({ !$0.isEmpty }))
            }
        }
    }
    
    func disableButton() -> Bool {
        if results.filter({ !$0.isEmpty }).isEmpty {
            return true
        }
        return false
    }
    
    func buttonColor() -> Color {
        if disableButton() {
            return Color.secondary.opacity(0)
        }
        return .indigo
    }
}

struct BeginingPage_Previews: PreviewProvider {
    static var previews: some View {
        BeginingPage()
    }
}
