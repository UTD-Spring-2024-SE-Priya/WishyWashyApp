//
//  InputView.swift
//  WishyWashyApp
//
//  Created by Wajih Anwar on 4/8/24.
//

import SwiftUI

//Fields that are going to taken by login and sign in
struct InputView: View {
    @Binding var text:String
    let title:String
    let placeholder : String
    var isSecureField = false;
    
    var body: some View{
        VStack {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField{
                SecureField(placeholder , text: $text)
                    .font(.system(size: 14))
    
            }else{
                TextField(placeholder , text: $text)
                    .font(.system(size: 14))
    
            }
            
            Divider()
            
        }
    }
}

struct InputView_Previews : PreviewProvider{
    static var previews : some View {
        InputView (text: .constant(""), title: "Email Address", placeholder : "name@example.com")
    }
}
