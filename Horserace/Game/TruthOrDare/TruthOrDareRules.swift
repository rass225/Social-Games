import SwiftUI

struct TruthOrDareRules: View {
    
    var body: some View {
        ForEach(1..<100, id: \.self) { item in
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .maxWidth()
        }
    }
}
