//
//  Placeholder.swift
//  Straws
//
//  Created by Bing Bing on 2022/10/24.
//

import SwiftUI

struct Placeholder: ViewModifier {
    
    var display: Bool = false
    var placeholder: String = "this is placeholder"
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
            if display {
                Text(placeholder)
                    .padding(.horizontal, 12)
                    .foregroundColor(.gray)
            }
        }
    }
}

extension View {
    func placeholder(display: Bool, value: String) -> some View {
        self
            .modifier(Placeholder(display: display, placeholder: value))
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        TextField("1", text: .constant(""))
            .modifier(Placeholder(display: true))
    }
}
