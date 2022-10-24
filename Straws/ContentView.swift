//
//  ContentView.swift
//  Straws
//
//  Created by Bing Bing on 2022/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var namespace
    @State var isCircle: Bool = true
    @State var angle: Angle = .zero
    @State var keyword: String = ""

    var words: [String]
    
    init(words: [String]) {
        if words.count < 29 {
            var values = Array(repeating: "Unknown", count: 29)
            for (index, word) in words.enumerated() {
                values[index] = word
            }
            self.words = values.shuffled()
        } else {
            self.words = words
        }
    }
    
    var body: some View {
        ZStack {
            Color("Color").ignoresSafeArea()
            GeometryReader { proxy in
                let padding: CGFloat = 12
                let midX = Int(proxy.size.width / 2.0)
                let midY = Int(proxy.size.height / 2.0)

                ZStack {
                    Color.clear
                    ZStack {
                        Color.clear
                        ForEach(Array(words.enumerated()), id: \.offset) { index, word in
                            if isCircle {
                                RowView(word: word, width: CGFloat(min(midX, midY)))
                                    .matchedGeometryEffect(id: "\(index)", in: namespace)
                                    .foregroundColor(word == "Unknown" ? Color(uiColor: .lightGray) : Color.orange)
                                    .frame(width: min(proxy.size.width, proxy.size.height) - padding * 2)
                                    .rotationEffect(.degrees(Double(index) / Double(words.count)) * 360)
                            } else {
                                let opacity = CGFloat.random(in: 0.2...1.0)
                                RowView(word: word, width: CGFloat(min(midX, midY)))
                                    .matchedGeometryEffect(id: "\(index)", in: namespace)
                                    .frame(width: min(proxy.size.width, proxy.size.height))
                                    .foregroundColor(Color.secondary)
                                    .rotationEffect(Angle(degrees: CGFloat(Int.random(in: 0...270))))
                                    .offset(x: CGFloat(Int.random(in: -midX...midX)),
                                            y: CGFloat(Int.random(in: -midY...midY)))
                                    .scaleEffect(index % 2 == 0 ? opacity * 2.0 : opacity * 5.0)
                                    .opacity(opacity)
                            }
                        }
                        .rotationEffect(angle)
                        
                        Text("Touch")
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
                            .font(.title)
                            .opacity(isCircle ? 1 : 0)
                            .animation(.easeInOut(duration: 0.2).delay(isCircle ? 2 : 0), value: isCircle)
                            .transition(.opacity)
                        
                        Text(keyword)
                            .opacity(isCircle ? 0 : 1)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 0)
                            .font(.title)
                            .animation(.easeInOut(duration: 0.24).delay(isCircle ? 0 : 2), value: keyword)
                            .transition(.opacity.combined(with: .slide))
                    }
                }
                .padding(.horizontal, padding)
            }
        }
        .onTapGesture {
            withAnimation(.easeOut(duration: 2.0)) {
                isCircle.toggle()
                keyword = ""
                if !isCircle {
                    let values = words.filter { $0 != "Unknown" }
                    keyword = values.randomElement()!
                }
            }
            withAnimation(.easeInOut(duration: 3.0)) {
                angle = Angle(degrees: CGFloat(Int.random(in: 0...270)))
            }
        }
    }
}

fileprivate
struct RowView: View {
    let word: String
    let width: CGFloat
    
    var body: some View {
        HStack {
            Text(word)
                .font(.caption)
                .fontWeight(.bold)
                .fixedSize()
            Rectangle()
                .frame(width: width, height: 1)
            Circle()
                .frame(width: 5, height: 5)
                .offset(x: -3)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(words: ["Lambda", "Simba", "Null"])
    }
}
