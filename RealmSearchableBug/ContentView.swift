import SwiftUI
import RealmSwift

class TodoModel: Object, ObjectKeyIdentifiable {
    @Persisted var content: String
}

struct ContentView: View {
    @ObservedResults(TodoModel.self) var list
    @State var searchText: String = ""
    init() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            
            let todo1 = TodoModel()
            todo1.content = "todo1"
            
            let todo2 = TodoModel()
            todo2.content = "todo2"
            
            realm.add([todo1, todo2])
        }
    }
    var body: some View {
        NavigationView {
            Form {
                    ForEach(list) {
                        Text($0.content)
                    }.onDelete(perform: $list.remove)
            }
            // this made onDelete swipe not work
            .searchable(text: $searchText, collection: $list, keyPath: \.content)
            
            // use system builtin modifier is well
            // .searchable(text: $searchText)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
