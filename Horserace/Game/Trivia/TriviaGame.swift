import SwiftUI

struct TriviaGame: View {
    @EnvironmentObject var game: Game
    @ObservedObject var model: TriviaModel
    @State var isRulesOpen: Bool = false
    
    init() {
        self.model = TriviaModel()
    }
    
    var body: some View {
        VStack{
            switch model.state {
            case .category:
                cateogries
            case .game:
                gameView
                    .padding(.bottom)
                Button(action: {
                    model.mainButtonAction()
                }) {
                    MainButton(label: model.mainButtonLabel)
                        .padding(.horizontal, 20)
                }
            }
        }
        .navigationModifier(game: .trivia)
        .padding(.bottom)
        .padding(.top)
        .background(DefaultBackground())
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                HomeButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
            }
            ToolbarItem(placement: .principal) {
                GameTitle()
            }
        }
        .sheet(isPresented: $isRulesOpen) {
            RuleView(isOpen: $isRulesOpen)
        }
    }
    
    var cateogries: some View {
        GeometryReader { geo in
            let size = geo.size
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .geography)
                    }) {
                        TriviaCategory(cateogry: .geography, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .sports)
                    }) {
                        TriviaCategory(cateogry: .sports, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .movie)
                    }) {
                        TriviaCategory(cateogry: .movie, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .history)
                    }) {
                        TriviaCategory(cateogry: .history, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .science)
                    }) {
                        TriviaCategory(cateogry: .science, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        model.pickCategory(category: .music)
                    }) {
                        TriviaCategory(cateogry: .music, size: size)
                    }.buttonStyle(GameButtonStyle())
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var gameView: some View {
        VStack{
            GeometryReader { geo in
                let size = geo.size
                let desiredWidth = size.width / 1.25
                VStack(spacing: 40){
                    CustomTicket(desiredWidth: desiredWidth, category: model.pickedCategory, question: model.question, isAnswerRevealed: $model.isAnswerRevealed)
                        .overlay(alignment: .bottom){
                            if !model.isAnswerRevealed {
                                model.pickedCategory.image
                                .resizable()
                                .frame(width: desiredWidth / 3, height: desiredWidth / 3)
                                .padding(.bottom, 24)
                            }
                        }
                }
                .maxWidth()
                .maxHeight()
            }
        }
    }
    
    private struct TriviaCategory: View {
        
        @EnvironmentObject var game: Game
        
        let image: Image
        let size: CGSize
        init(cateogry: TriviaModel.Category, size: CGSize) {
            self.size = size
            self.image = cateogry.image
        }
        
        var body: some View {
            image
                .resizable()
                .padding(32)
                .frame(width: size.width / 2.5, height: size.width / 2.5)
                .background(LinearGradient(colors: game.game.background, startPoint: .top, endPoint: .bottom))
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(game.game.gradient, lineWidth: 8)
                )
        }
    }
    
    struct CustomTicket: View {
        
        @EnvironmentObject var game: Game
        let desiredWidth: Double
        let category: TriviaModel.Category
        let question: TriviaQuestion
        @Binding var isAnswerRevealed: Bool
        
        private let ticketColors = [Colors.ticketColor, Color.init(light: .init(red: 0.95, green: 0.95, blue: 0.95), dark: .init(red: 0.2, green: 0.2, blue: 0.2))]
        
        var body: some View {
            VStack{
                VStack(spacing: 16){
                    Text(category.rawValue)
                        .textCase(.uppercase)
                        .font(.title3.weight(.semibold))
                        .padding(.top, 32)
                        .foregroundColor(Colors.text)
                    Text(question.question)
                        .font(.title3.weight(.medium))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                    if isAnswerRevealed {
                        VStack(alignment: .center, spacing: 8){
                            Spacer()
                            Text("Answer")
                                .textCase(.uppercase)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(Colors.text)
                            Text(question.answer)
                                .font(.headline.weight(.semibold))
                                .foregroundColor(Colors.green)
                            Text(question.answerDescription)
                                .font(.footnote.weight(.regular))
                                .foregroundColor(.gray)
                                .padding(.top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                       
                        
                    } else {
                        VStack(alignment: .leading, spacing: 8){
                            HStack{
                                Image(systemName: "a.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, game.game.gradient)
                                Text(question.a)
                            }
                            HStack{
                                Image(systemName: "b.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, game.game.gradient)
                                Text(question.b)
                            }
                            HStack{
                                Image(systemName: "c.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, game.game.gradient)
                                Text(question.c)
                            }
                            HStack{
                                Image(systemName: "d.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, game.game.gradient)
                                Text(question.d)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(.subheadline.weight(.regular))
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal, 8)
                .frame(height: desiredWidth * 1.5)
                .frame(width: desiredWidth)
                .background(LinearGradient(gradient: Gradient(colors: ticketColors), startPoint: .top, endPoint: .bottom))
                .background(Colors.ticketColor)
                .clipShape(TicketShape())
                .shadow(color: Colors.darkShadow, radius: 6, x: 0, y: 0)
            }
        }
        
        struct TicketShape: Shape {
            func path(in rect: CGRect) -> Path {
                let arcRadius: CGFloat = 25
                let smallArcRadius:CGFloat = 20
                var path = Path()
                path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y + arcRadius))
                path.addArc(center: CGPoint.zero, radius: arcRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0) , clockwise: true)
                path.addArc(center: CGPoint(x: rect.midX, y: rect.origin.y) , radius: arcRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0) , clockwise: true)
                path.addLine(to:  CGPoint(x: rect.size.width - arcRadius, y: rect.origin.y))
                path.addArc(center: CGPoint(x: rect.size.width , y: rect.origin.y), radius: arcRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90) , clockwise: true)
                path.addLine(to:  CGPoint(x: rect.size.width, y: rect.size.height - smallArcRadius))
                path.addArc(center: CGPoint(x: rect.size.width , y: rect.size.height), radius: smallArcRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180) , clockwise: true)
                path.addLine(to:  CGPoint(x: rect.origin.x + smallArcRadius, y: rect.size.height))
                path.addArc(center: CGPoint(x: rect.origin.x , y: rect.size.height), radius: smallArcRadius, startAngle: Angle(degrees: 360), endAngle: Angle(degrees: 270) , clockwise: true)
                path.closeSubpath()
                return path
            }
        }
    }
}
