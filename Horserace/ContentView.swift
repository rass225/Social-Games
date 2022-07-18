import SwiftUI

struct ContentView: View {
    
    @State var showingAlert = false
    private let alertMessage = "This game is being developed and will be released in the coming weeks"
    private let spacing: Double = 20
    
    var body: some View {
        NavigationView{
            ZStack{
                DefaultBackground()
                content
            }
            .navigationBarHidden(true)
        }.accentColor(.white)
    }
    
    var content: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 32){
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Social Games")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing){
                                GameButton(.truthDare, size: size, willPulse: true)
                                GameButton(.neverHaveIEver, size: size, willPulse: true)
                                GameButton(.whosMostLikely, size: size, willPulse: true)
                                GameButton(.trivia, size: size, willPulse: true)
                                GameButton(.millionaire, size: size, willPulse: true)
//                                    .isGameDisabled($showingAlert)
                                GameButton(.explain, size: size, willPulse: true)
                                    .isGameDisabled($showingAlert)
                            }.padding([.horizontal, .bottom], spacing)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12){
                        SectionHeader(title: "Card Games")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing){
                                GameButton(.horseRace, size: size)
                                GameButton(.pyramid, size: size, willPulse: true)
                                GameButton(.higherLower, size: size, willRotate: true)
                            }.padding([.horizontal, .bottom], spacing)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Spinning Games")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing){
                                GameButton(.spinBottle, size: size, tilt: 45, willRotate: true)
                                GameButton(.roulette, size: size, willRotate: true)
                                GameButton(.wheel, size: size, willRotate: true)
                            }.padding([.horizontal, .bottom], spacing)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Other Games")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing){
                                GameButton(.chooser, size: size, willPulse: true)
                                GameButton(.mancala, size: size, tilt: -45, willPulse: true)
                                    .isGameDisabled($showingAlert)
                            }.padding([.horizontal, .bottom], spacing)
                        }
                    }
                }
                copyright
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Coming Soon"), message: Text(alertMessage), dismissButton: .default(Text("Done")))
        }
    }
    
    var copyright: some View {
        VStack{
            Text("Copyright © 2022 Rasmus Tauts. All rights reserved.")
            Text("Designed and developed by Rasmus Tauts.")
        }
        .font(.footnote)
        .foregroundStyle(.gray)
        .padding(.top, 48)
        .padding(.bottom)
    }
    
    private struct SectionHeader: View {
        let title: String
        let spacing: CGFloat = 20
        var body: some View {
            Text(title)
                .font(.title.weight(.semibold))
                .padding(.horizontal, spacing)
        }
    } 
}
