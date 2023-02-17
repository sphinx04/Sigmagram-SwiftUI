//
//  ContentView.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 19.01.23.
//

import SwiftUI

struct FeedView: View {

    @State var users: [User] = []
    @State var posts: [Post] = []
    
    var body: some View {
        VStack {
            topBar()
            
            ScrollView(showsIndicators: false) {
                ForEach(posts, id: \.id) { post in
                    post
                }
                if posts.count > 0 {
                    Button(action: {
                        apiCall().getUsers(url: "https://random-data-api.com/api/v2/users?size=5") { (users) in
                            self.users = users
                            for index in 0..<users.count {
                                posts.append(Post(user: users[index],
                                                  userPicUrl: "https://xsgames.co/randomusers/avatar.php?g=male",
                                                  postPicURL: "https://picsum.photos/1000",
                                                  postTextURL: "https://baconipsum.com/api/?type=all-meat&sentences=1",
                                                  likeCount: Int.random(in: 5...1000)))
                            }
                        }
                    }) {
                        Text("Load more")
                    }
                } else {
                    ProgressView() {
                        Text("Loading...")
                    }
                }
            }
                .task {
                    apiCall().getUsers(url: "https://random-data-api.com/api/v2/users?size=5") { (users) in
                        self.users = users
                        for index in 0..<users.count {
                            posts.append(Post(user: users[index],
                                 userPicUrl: "https://xsgames.co/randomusers/avatar.php?g=male",
                                 postPicURL: "https://picsum.photos/300",
                                 postTextURL: "https://baconipsum.com/api/?type=all-meat&sentences=1",
                                 likeCount: Int.random(in: 5...1000)))
                        }
                    }
                }
        }
    }
}

func topBar() -> some View {
    HStack {
        Text("Sigmagram").font(.custom("FONTSPRINGDEMO-BlueVinylBold", size: 29))
        Spacer()
        Image(systemName: "plus.app")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.bottomIconSize, height: Constants.bottomIconSize)
            .padding(.horizontal, 6.0)
        Image(systemName: "heart")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.bottomIconSize, height: Constants.bottomIconSize)
            .padding(.horizontal, 6.0)
        Image(systemName: "bubble.right")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.bottomIconSize, height: Constants.bottomIconSize)
            .padding(.horizontal, 6.0)
    }
    .padding(.horizontal)
    .frame(maxHeight: 40)
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()//.preferredColorScheme(.dark)
    }
}
