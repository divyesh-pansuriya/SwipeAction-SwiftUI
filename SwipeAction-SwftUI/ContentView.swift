import SwiftUI

struct Character {
    let name: String
    let imageName: String
    let description: String
}

struct ContentView: View {
    @State private var characters = [
        Character(name: "Luffy", imageName: "Luffy", description: "The captain of the Straw Hat Pirates."),
        Character(name: "Zoro", imageName: "Zoro", description: "The swordsman of the Straw Hat Pirates."),
        Character(name: "Usop", imageName: "Usop", description: "The sniper of the Straw Hat Pirates."),
        Character(name: "Nami", imageName: "Nami", description: "The navigator of the Straw Hat Pirates."),
        Character(name: "Chanji", imageName: "Chanji", description: "The cook of the Straw Hat Pirates."),
        Character(name: "Chopper", imageName: "Chopper", description: "The doctor of the Straw Hat Pirates.")
    ]
    
    @Environment(\.editMode) var editMode  // Environment variable to track edit mode
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(characters, id: \.name) { character in
                        CharacterRow(character: character)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 4)
                            .listRowSeparator(.hidden)
                            .swipeActions {
                                Button(role: .destructive) {
                                    characters.removeAll { $0.name == character.name }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    print("Editing \(character.name)")
                                } label: {
                                    Label("Edit", systemImage: "square.and.pencil")
                                }
                                .tint(.blue)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    print("Mic action for \(character.name)")
                                } label: {
                                    Label("Mic", systemImage: "mic.fill")
                                }
                                .tint(.green)
                            }
                    }
                    .onMove { indices, newOffset in
                        characters.move(fromOffsets: indices, toOffset: newOffset) // Handle rearranging
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(PlainListStyle())
                .toolbar {
                    EditButton() // Edit button to toggle between normal and edit mode
                }
            }
            .navigationTitle("One Piece Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharacterRow: View {
    var character: Character
    
    var body: some View {
        HStack(alignment: .top) {
            Image(character.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                )
                .shadow(color: .gray, radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    
                Text(character.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
}
