//
//  ContentView.swift
//  Day60Challenge
//
//  Created by Ifang Lee on 12/6/21.
//

/**
 https://www.hackingwithswift.com/guide/ios-swiftui/5/3/challenge
 It’s time for you to build an app from scratch, and it’s a particularly expansive challenge today:
 your job is to use URLSession to download some JSON from the internet, use Codable to convert it to Swift types, then use NavigationView, List, and more to display it to the user.

 Your first step should be to examine the JSON.
 The URL you want to use is this: https://www.hackingwithswift.com/samples/friendface.json – that’s a massive collection of randomly generated data for example users.

 As you can see, there is an array of people, and each person has an ID, name, age, email address, and more.
 They also have an array of tag strings, and an array of friends, where each friend has a name and ID.

 How far you implement this is down to you, but at the very least you should:

 Fetch the data and parse it into User and Friend structs.
 Display a list of users with a little information about them, such as their name and whether they are active right now.
 Create a detail view shown when a user is tapped, presenting more information about them, including the names of their friends.
 Before you start your download, check that your User array is empty so that you don’t keep starting the download every time the view is shown.
 If you’re not sure where to begin, start by designing your types: build a User struct with properties for name, age, company, and so on,
 then a Friend struct with id and name. After that, move onto some URLSession code to fetch the data and decode it into your types.

 You might notice that the date each user registered has a very specific format: 2015-11-10T01:47:18-00:00. This is known as ISO-8601,
 and is so common that there’s a built-in dateDecodingStrategy called .iso8601 that decodes it automatically.

 While you’re building this, I want you to keep one thing in mind: this kind of app is the bread and butter of iOS app development –
 if you can nail this with confidence, you’re well on your way to a full-time job as an app developer.

 Tip: As always, the best way to solve this challenge is to keep it simple – write as little code as you can to solve the challenge,
 and for you to feel comfortable that it works well.


 Day 61: Add coredata to the project
 https://www.hackingwithswift.com/100/swiftui/61
 Yes, your job today is to expand your app so that it uses Core Data. Your boss just emailed you to say the app is great, but once the JSON has been fetched they really want it to work offline.
 This means you need to use Core Data to store the information you download, then use your Core Data entities to display the views you designed – you should only need to fetch the data once.
 You still need to try to fetch the data every time your app loads, just in case it has changed somehow, but if that fetch fails it’s okay because you still have your Core Data back up.

 The end result will hopefully be the same as if I had given you the task all at once,
 but segmenting it in two like this hopefully makes it seem more within reach,
 while also giving you the chance to think about how well you structured your code to be adaptable as change requests come in.

 First, the new thing: when we fetch data from the internet we do so using an asynchronous function –
 we’re writing a function that can go to sleep while our download happens, then wake up and continue working.

 Now think about this: what happens if SwiftUI is busy rendering our view, and suddenly our network task wakes up and announces that is has new data?
 To fix this problem you need to make sure you update Core Data in the same place as SwiftUI updates its user interface,
 so that they can’t happen at the same time – we queue up the work, and it will happen only when SwiftUI is ready.

 In Swift this is called the main actor, and among other things it’s the job of the main actor to update the user interface.

 1. You need to keep your original User and Friend structs, which will be used to decode the remote data.
 2. When you create Core Data entities, give them different names such as CachedUser and CachedFriend, so they don’t conflict with your structs.
 3. Add constraints on the id attributes for CachedUser and CachedFriend, to avoid duplicates.
 4. You’ll need to create some wrapped properties that either return the underlying Core Data attributes if they have something in there, or sensible default values otherwise.
 5. If you chose to use it, the tags attribute is an interesting challenge because it’s not something that fits into Core Data neatly.
 I would recommend you use something like user.tags.joined(separator: ",") to create one string from the array, using commas to separate the values –
 you can then use components(separatedBy:) later on to display them if needed.
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
