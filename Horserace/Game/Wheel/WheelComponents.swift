import SwiftUI
import Combine

struct WheelComponents: View {
    
    @EnvironmentObject var game: Game
    
    enum Focusable: Hashable {
        case none
        case row(id: Int)
    }
    
    let players: [String]
    @State var presets: [WheelPreset]
    @State var components: [String] = ["", "", "", "", "", "", "", "", "", ""]
    @State var finalizedComponents: [String] = []
    @State var toNext: Bool = false
    @State var numberOfComponents: Int = 2
    @State var isRulesOpened: Bool = false
    @State var isAlertOpened: Bool = false
    @State var isEditingPresets: Bool = false
    private let textLimit: Int = 15
    @FocusState private var focusField: Focusable?
    
    let rows = [
        GridItem(.flexible(minimum: 40), spacing: 6),
        GridItem(.flexible(minimum: 40), spacing: 6),
        GridItem(.flexible(minimum: 40), spacing: 6),
    ]
    
    init(players: [String]) {
        self.players = players
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "WheelPresets") as? Data {
            let decoder = JSONDecoder()
            if let wheelPresets = try? decoder.decode([WheelPreset].self, from: data) {
                presets = wheelPresets
            } else {
                presets = []
            }
        } else {
            presets = []
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            NavigationLink(destination: WheelGame(players: players, components: finalizedComponents).environmentObject(game), isActive: $toNext) {
                EmptyView()
            }
            
            
            ScrollView{
                if !presets.isEmpty {
                    VStack(spacing: 8){
                        HStack{
                            Text("Presets")
                                .foregroundColor(Colors.text)
                                .font(.subheadline.weight(.semibold))
                                .textCase(.uppercase)
                                .maxWidth(alignment: .leading)
                            
                            Spacer()
                            Button(action: {
                                isEditingPresets.toggle()
                            }) {
                                Text(isEditingPresets ? "Done" : "Edit")
                                    .foregroundColor(.blue)
                                
                            }
                        }.padding(.horizontal, 20)
                        
                        //                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyVGrid(columns: rows) {
                            ForEach(presets) { item in
                                Button(action: {
                                    if isEditingPresets {
                                        removePreset(item)
                                    } else {
                                        applyPreset(item)
                                    }
                                }) {
                                    Text(item.name)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .maxWidth()
                                        .background(game.game.gradient.opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .overlay(alignment: .top) {
                                            if isEditingPresets {
                                                Image(systemName: "x.circle.fill")
                                                    .font(.title3.weight(.light))
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(.white, .red)
                                                    .offset(x: 0, y: -10)
                                            }
                                        }
                                }
                                //.padding(.vertical, 16)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 6)
                        .maxWidth()
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                }
                
                HStack{
                    Text("Components")
                        .foregroundColor(Colors.text)
                        .font(.subheadline.weight(.semibold))
                        .textCase(.uppercase)
                        .maxWidth(alignment: .leading)
                    
                    Spacer()
                    Button(action: {
                        isAlertOpened.toggle()
                    }) {
                        Text("Save")
                            .foregroundColor(.blue)
                        
                    }
                }
                .padding(.top, 24)
                .padding(.horizontal, 20)
                
                VStack(spacing: 12){
                    ForEach(0..<numberOfComponents, id: \.self) { index in
                        TextField("", text: $components[index])
                            .onReceive(components[index].publisher.collect()) {
                                let s = String($0.prefix(textLimit))
                                if components[index] != s {
                                    components[index] = s
                                }
                            }
                            .placeholder(when: components[index].isEmpty) {
                                Text("\(index + 1). Item")
                                    .foregroundColor(Colors.text)
                                    .opacity(focusField == .row(id: index) ? 0.4 : 1)
                            }
                            .accentColor(game.game.background[0])
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(BlurEffect().opacity(focusField == .row(id: index) ? 0.4 : 1))
                            .mask(RoundCorners(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(lineWidth: 0.5).fill(Colors.buttonBorder))
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
                .padding(.bottom, 32)
            }
            
            Button("Next", action: finalizeComponents)
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom)
        }
        .padding(.top, 1)
        .background(DefaultBackground())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                RulesButton(isOpen: $isRulesOpened)
            }
            ToolbarItem(placement: .principal) {
                Text("Components")
                    .textCase(.uppercase)
                    .font(.callout.weight(.semibold))
                    .foregroundColor(Colors.text)
            }
        }
        .sheet(isPresented: $isRulesOpened) {
            RuleView(isOpen: $isRulesOpened)
        }
        .alert(isPresented: $isAlertOpened, TextFieldAlert(title: "Preset", message: "Name your preset") { (text) in
            if let text = text {
                saveToPresets(name: text)
            } else {
                print("Noku")
            }
        })
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
    
    func saveToPresets(name: String) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        let components = Array(self.components.prefix(numberOfComponents))
        let preset = WheelPreset(name: name, components: components)
        var newPresets = self.presets
        newPresets.append(preset)
        if let encodedUser = try? encoder.encode(newPresets) {
            defaults.set(encodedUser, forKey: "WheelPresets")
        }
        updatePresets()
    }
    
    func applyPreset(_ preset: WheelPreset) {
        components = ["", "", "", "", "", "", "", "", "", ""]
        for (index, element) in preset.components.enumerated() {
            components[index] = element
        }
        
        numberOfComponents = preset.components.count
    }
    
    func removePreset(_ preset: WheelPreset) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        presets.removeAll(where: { $0.name == preset.name })
        if let encodedUser = try? encoder.encode(presets) {
            defaults.set(encodedUser, forKey: "WheelPresets")
        }
        updatePresets()
    }
    
    func updatePresets() {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "WheelPresets") as? Data {
            let decoder = JSONDecoder()
            if let wheelPresets = try? decoder.decode([WheelPreset].self, from: data) {
                presets = wheelPresets
            } else {
                presets = []
            }
        } else {
            presets = []
        }
    }
    
    struct WheelPreset: Identifiable, Codable {
        var id = UUID()
        let name: String
        let components: [String]
    }
}

import Foundation
import Combine
import SwiftUI

class TextFieldAlertViewController: UIViewController, UITextFieldDelegate {
    
    /// Presents a UIAlertController (alert style) with a UITextField and a `Done` button
    /// - Parameters:
    ///   - title: to be used as title of the UIAlertController
    ///   - message: to be used as optional message of the UIAlertController
    ///   - text: binding for the text typed into the UITextField
    ///   - isPresented: binding to be set to false when the alert is dismissed (`Done` button tapped)
    init(isPresented: Binding<Bool>, alert: TextFieldAlert) {
        self._isPresented = isPresented
        self.alert = alert
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @Binding
    private var isPresented: Bool
    private var alert: TextFieldAlert
    private let limitLength = 9
    
    // MARK: - Private Properties
    private var subscription: AnyCancellable?
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAlertController()
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= limitLength
    }
    
    private func presentAlertController() {
        guard subscription == nil else { return } // present only once
        
        let vc = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        // add a textField and create a subscription to update the `text` binding
        vc.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.text = self.alert.defaultText
            textField.delegate = self // Set the delegate
        })
//        vc.addTextField {
//            // TODO: 需要补充这些参数
//            // $0.placeholder = alert.placeholder
//            // $0.keyboardType = alert.keyboardType
//            // $0.text = alert.defaultValue ?? ""
//            $0.text = self.alert.defaultText
//        }
        if let cancel = alert.cancel {
            vc.addAction(UIAlertAction(title: cancel, style: .destructive) { _ in
                //                self.action(nil)
                self.isPresented = false
            })
        }
        let textField = vc.textFields?.first
        vc.addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            self.isPresented = false
            self.alert.action(textField?.text)
        })
        present(vc, animated: true, completion: nil)
    }
}

struct TextFieldAlert {
    
    let title: String
    let message: String?
    var defaultText: String = ""
    public var accept: String = "Save" // The left-most button label
    public var cancel: String? = "Cancel" // The optional cancel (right-most) button label
    public var action: (String?) -> Void // Triggers when either of the two buttons closes the dialog
    
}

struct AlertWrapper:  UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    let alert: TextFieldAlert
    
    typealias UIViewControllerType = TextFieldAlertViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIViewControllerType {
        TextFieldAlertViewController(isPresented: $isPresented, alert: alert)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        // no update needed
    }
}

struct TextFieldWrapper<PresentingView: View>: View {
    
    @Binding var isPresented: Bool
    let presentingView: PresentingView
    let content: TextFieldAlert
    
    
    var body: some View {
        ZStack {
            if (isPresented) {
                AlertWrapper(isPresented: $isPresented, alert: content)
            }
            presentingView
        }
    }
}

extension View {
    
    func alert(isPresented: Binding<Bool>, _ content: TextFieldAlert) -> some View {
        TextFieldWrapper(isPresented: isPresented, presentingView: self, content: content)
    }
    
}
