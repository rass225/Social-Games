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
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpen)
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
        GeometryReader { geo in
            let desiredWidth = geo.size.width / 1.2
            CustomTicket(model: model, desiredWidth: desiredWidth)
                .maxWidth()
                .maxHeight()
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
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(game.game.gradient, lineWidth: 8)
                )
        }
    }
    
    struct CustomTicket: View {
        
        @EnvironmentObject var game: Game
        @ObservedObject var model: TriviaModel
        let desiredWidth: Double
        
        private let ticketColors = [
            Colors.ticketColor,
            Color.init(light: .init(red: 0.95, green: 0.95, blue: 0.95), dark: .init(red: 0.2, green: 0.2, blue: 0.2))
        ]
        
        var body: some View {
            VStack(spacing: 0){
                Text(model.question.question)
                    .font(.title3.weight(.medium))
                    .foregroundColor(Colors.text)
                    .padding(.top, 24)
//                    .padding(.horizontal, 8)
                    .padding(.bottom, 16)
                    .maxWidth()
                VStack(alignment: .leading, spacing: 8){
                    HStack{
                        Image(systemName: "a.circle.fill")
                            .font(.title3.weight(.medium))
                        if model.isAnswerRevealed {
                            Text(model.question.a)
                                .foregroundColor(model.question.a == model.question.answer ? Colors.green : Color.init(red: 0.4, green: 0.4, blue: 0.4))
                        } else {
                            Text(model.question.a)
                                .foregroundColor(Colors.text)
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "b.circle.fill")
                            .font(.title3.weight(.medium))
                        if model.isAnswerRevealed {
                            Text(model.question.b)
                                .foregroundColor(model.question.b == model.question.answer ? Colors.green : Color.init(red: 0.4, green: 0.4, blue: 0.4))
                        } else {
                            Text(model.question.b)
                                .foregroundColor(Colors.text)
                        }
                    }
                    HStack{
                        Image(systemName: "c.circle.fill")
                            .font(.title3.weight(.medium))
                        if model.isAnswerRevealed {
                            Text(model.question.c)
                                .foregroundColor(model.question.c == model.question.answer ? Colors.green : Color.init(red: 0.4, green: 0.4, blue: 0.4))
                        } else {
                            Text(model.question.c)
                                .foregroundColor(Colors.text)
                        }
                    }
                    HStack{
                        Image(systemName: "d.circle.fill")
                            .font(.title3.weight(.medium))
                        if model.isAnswerRevealed {
                            Text(model.question.d)
                                .foregroundColor(model.question.d == model.question.answer ? Colors.green : Color.init(red: 0.4, green: 0.4, blue: 0.4))
                        } else {
                            Text(model.question.d)
                                .foregroundColor(Colors.text)
                        }
                    }
                }
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, game.game.gradient)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body.weight(.medium))
                
//                if model.isAnswerRevealed {
                    Text(model.question.answerDescription)
                        .font(.footnote.weight(.regular))
                        .foregroundColor(Colors.grayText)
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        .padding(.top)
                        .opacity(model.isAnswerRevealed ? 1 : 0)
                        .animation(.linear(duration: 0.4), value: model.isAnswerRevealed)
//                }
                Spacer()
                model.pickedCategory.image
                    .resizable()
                    .frame(height: model.isAnswerRevealed ? desiredWidth / 6 : desiredWidth / 4.5)
                    .frame(width: model.isAnswerRevealed ? desiredWidth / 6 : desiredWidth / 4.5)
                    .animation(.linear(duration: 0.4), value: model.isAnswerRevealed)
                    .padding(.bottom, 16)
                    

                
            }
            .padding(.top, 25)
            .padding(.horizontal, 16)
            .frame(height: desiredWidth * 1.65)
            .frame(width: desiredWidth)
            .background(
                LinearGradient(gradient: Gradient(colors: ticketColors), startPoint: .top, endPoint: .bottom)
                    .clipShape(TicketShape())
                    .shadow(color: Colors.darkShadow, radius: 6, x: 0, y: 0)
            )
            
        }
        
        
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
