//
//  File.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 20.01.23.
//

import SwiftUI

var IDCount: Int = 0

struct Post: Identifiable, View {
    var id: Int
    
    let userPicURL: String
    let userName: String
    let postPicURL: String
    let postTextURL: String
    let location: String?
    @State var likeCount: Int
    let date: Date
    @State var postText: String = "\n(loading...)"
    
    init(user: User, userPicUrl: String, postPicURL: String, postTextURL: String, likeCount: Int) {
        self.userPicURL = userPicUrl
        self.userName = user.username
        self.postPicURL = postPicURL
        self.postTextURL = postTextURL
        self.location = user.address.city
        _likeCount = State(initialValue: likeCount)
        self.date = Date.now
        
        id = IDCount
        IDCount += 1
    }
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: userPicURL)!) { userPic in
                    userPic
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(.infinity)
                } placeholder: {
                    ZStack {
                        ProgressView().frame(width: 60, height: 60)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(userName)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    if let unwrappedLocation = location {
                        Text(unwrappedLocation).font(.system(size: 16)).multilineTextAlignment(.leading)
                        
                    }
                }
                Spacer()
                
                Text("...").font(.system(size: 30)).fontWeight(.bold).padding(.bottom)
            }
            .frame(maxHeight: 50)
            .padding(.all)
            
            let likeButton = LikeButton(like: { likeCount+=1 }, unLike: { likeCount-=1 })
            
            
            AsyncImage(url: URL(string: postPicURL)!) { postPic in
                postPic
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1/1, contentMode: .fill)
            } placeholder: {
                ZStack {
                    Image("Placeholder")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1/1, contentMode: .fill)
                        .opacity(0)
                    ProgressView()
                }
            }
            
            VStack {
                HStack {
                    likeButton
                    actionButton(icon: Image(systemName: "bubble.right"))
                    actionButton(icon: Image(systemName: "paperplane"))
                    Spacer()
                    actionButton(icon: Image(systemName: "bookmark"))
                }
                .frame(maxHeight: Constants.bottomIconSize)
                .padding(.horizontal)
                
            }
            
            VStack (alignment: .leading) {
                likeCount(likeCount)
                
                post()
                
                date(date)
                Spacer().frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }
    }
    
    struct LikeButton: View {
        @State var isLiked: Bool = false
        var like: () -> Void
        var unLike: () -> Void
        
        var body: some View {
            Button(action: {
                isLiked.toggle()
                if isLiked {
                    like()
                } else {
                    unLike()
                }
            }) {
                Image(systemName: !isLiked ? "heart" : "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.bottomIconSize, height: Constants.bottomIconSize)
                    .padding(.horizontal, 3.0)
                    .foregroundColor(!isLiked ? .primary : .red)
            }
        }
        
        
    }
    
    private func actionButton (icon: Image) -> some View {
        icon
            .resizable()
            .scaledToFit()
            .frame(width: Constants.bottomIconSize, height: Constants.bottomIconSize)
            .padding(.horizontal, 3.0)
    }
    
    private func likeCount (_ likes: Int) -> some View {
        return Text("\(likes) likes")
            .fontWeight(.semibold)
    }
    
    private func post () -> some View {
        return Text("**\(userName)** \(postText)")
                .lineLimit(2)
                .task {
                    if let url = URL(string: postTextURL) {
                        do {
                            postText = try String(contentsOf: url)
                            postText.removeFirst(2)
                            postText.removeLast(2)
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // the URL was bad!
                    }
                }
    }
    
    private func date (_ date: Date) -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        return Text(dateFormatter.string(from: date))
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 1.0)
            
            
    }
}

struct Constants {
    static let bottomIconSize: CGFloat = 24
}

extension Image {
    
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
