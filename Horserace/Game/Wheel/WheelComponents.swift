import SwiftUI
import Combine

struct WheelComponents: View {
    
    @EnvironmentObject var game: Game
    
    enum Focusable: Hashable {
        case none
        case row(id: Int)
    }
    
    let players: [String]
    @State var components: [String] = ["", "", "", "", "", "", "", "", "", ""]
    @State var finalizedComponents: [String] = []
    @State var toNext: Bool = false
    @State var numberOfComponents: Int = 2
    @State var isRulesOpened: Bool = false
    private let textLimit: Int = 15
    @FocusState private var focusField: Focusable?
    
    var body: some View {
        VStack{
            NavigationLink(destination: WheelGame(players: players, components: finalizedComponents).environmentObject(game), isActive: $toNext) {
                EmptyView()
            }
            ScrollView{
                VStack(spacing: 16){
                    ForEach(0..<numberOfComponents, id: \.self) { index in
                        TextField("", text: $components[index])
                            .onReceive(components[index].publisher.collect()) {
                                let s = String($0.prefix(textLimit))
                                if components[index] != s {
                                    components[index] = s
                                }
                            }
                            .placeholder(when: components[index].isEmpty) {
                                Text("\(index + 1). Item").foregroundColor(Colors.text)
                            }
                        
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .row(id: index) ? 0.4 : 1))
                            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
                            .focused($focusField, equals: .row(id: index))
                            .overlay(
                                Button(action: {
                                    removeAt(index: index)
                                }) {
                                    RemoveButton()
                                }
                                    .disabled(index < 2)
                                    .opacity(index < 2 ? 0 : 1)
                                , alignment: .trailing
                            )
                    }
                    if numberOfComponents < 10 {
                        Button(action: {
                            addComponent()
                        }) {
                            AddButton()
                        }.padding(.top)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
                .padding(.top)
            }
            
            Button(action: {
                finalizeComponents()
            }) {
                MainButton(label: "Next")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom)
        }
        .padding(.top, 1)
        .background(DefaultBackground())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(Games.wheel.rawValue))
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpened)
            }
        }
        .sheet(isPresented: $isRulesOpened) {
            RuleView(isOpen: $isRulesOpened)
        }
    }
    
    func areMaxComponents() -> Bool {
        for item in components {
            guard !item.isEmpty else { return false }
        }
        return true
    }
    
    func addComponent() {
        withAnimation{
            numberOfComponents += 1
            print(numberOfComponents)
        }
    }
    
    func finalizeComponents() {
        var pickedComponents = components.prefix(numberOfComponents)
        for (index, item) in pickedComponents.enumerated() {
            if item.isEmpty {
                pickedComponents[index] = "\(index + 1). Item"
            }
        }
        finalizedComponents = pickedComponents.filter({ !$0.isEmpty })
        toNext.toggle()
    }
    
    func removeAt(index: Int) {
        components.remove(at: index)
        numberOfComponents -= 1
        components.append("")
    }
}
