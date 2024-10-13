//
//  ContentView.swift
//  Word Scramble
//
//  Created by Andrew Emad on 12/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word",text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(submitNewWord)
                }
                ForEach(usedWords, id: \.self){ word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
            }.navigationTitle(rootWord)
             .onAppear(perform: startGame)
             .alert(errorTitle, isPresented: $isShowingAlert) {
                 Button("Ok"){}
             } message: {
                 Text(errorMessage)
             }

        }
    }
    
    private func submitNewWord() {
        let addedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !addedWord.isEmpty else { return }
        
        guard isOriginal(word: addedWord) else {
            showError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: addedWord) else {
            showError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: addedWord) else {
            showError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(addedWord, at: 0)
        }
        newWord = ""
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func showError(title:String, message: String){
        errorTitle = title
        errorMessage = message
        isShowingAlert = true
    }
    
    private func startGame() {
        if let fileUrl = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let contents = try? String(contentsOf: fileUrl){
                let loadedWords = contents.components(separatedBy: "\n")
                rootWord = loadedWords.randomElement() ?? "play"
                return
            }
        }
        fatalError("can't load start.txt file")
    }
}

#Preview {
    ContentView()
}
