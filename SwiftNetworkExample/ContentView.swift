//
//  ContentView.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var selectedIndex: Int = 0
    let clients: [(String, HTTPClient)] = [
        ("URLSession", URLClient()),
        ("Alamofire", AlamofireClient())
    ]
    @State var response: String = ""
    
    var body: some View {
        VStack {
            TextField("username", text: self.$username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("password", text: self.$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: self.login, label: {
                Text("로그인")
            })
            Spacer()
            Text("통신 라이브러리 선택: \(self.clients[self.selectedIndex].0)")
            Picker(selection: self.$selectedIndex, label: Text(""), content: {
                ForEach(0 ..< self.clients.count, content: { (index) in
                    Text(self.clients[index].0).tag(index)
                })
            })
            Spacer()
            Text("응답")
            Text(self.response)
                .frame(height: 200)
        }.padding()
    }
    
    func login() {
        let request = LoginRequest(username: self.username, password: self.password)
        _ = self.clients[selectedIndex].1.submit(request)
            .do(onSubscribe: {
                print("통신 시작")
                self.response = ""
            })
            .do(onSuccess: { (response) in
                print("response: \(response.statusCode)")
                self.response = JSON(response.data).description
            })
            .do(onError: { (error) in
                print("에러 발생: \(error.localizedDescription)")
            })
            .do(onDispose: {
                print("통신 종료")
            })
            .subscribe()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
