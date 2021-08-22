//
//  Vigenere Cipher
//
//  Created by deathlezz on 8/07/2021.
//

extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

class Vigenere {
    
    let alphabet: String
    let alphabetSize: Int
    let key: String
    let keySize: Int
    
    init(alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", key: String) {
        
        self.alphabet = alphabet.uppercased()
        self.alphabetSize = alphabet.count
        self.key = key.uppercased()
        self.keySize = key.count
    }
    
    // Index of alphabet
    func alphabetIndex(forCharacter character: Character) -> Int {
        
        var index = 0
        
        for char in alphabet {
            
            if char == character {
                return index
            }
            index += 1
        }
        return -1
    }
    
    // Encrypt
    func encrypt(plainText: String) -> String {
        
        var encryptedText = ""
        var index = 0
        
        for char in plainText.uppercased() {
            
            let indexInAlphabet = alphabetIndex(forCharacter: char)
            
            if indexInAlphabet == -1 {
                encryptedText.append(char)
                continue
            }
            
            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = alphabetIndex(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet + alphabetSize) % alphabetSize
            
            encryptedText.append(alphabet[encryptedLetterIndex])
            index += 1
        }
        return encryptedText
    }
    
    // Decrypt
    func decrypt(encryptedText: String) -> String {
        
        var decryptedText = ""
        var index = 0
        
        for char in encryptedText.uppercased() {
            
            let indexInAlphabet = alphabetIndex(forCharacter: char)
            
            if indexInAlphabet == -1 {
                decryptedText.append(char)
                continue
            }
            
            let keyToDecryptWith = key[index % keySize]
            let keyIndexInAlphabet = alphabetIndex(forCharacter: keyToDecryptWith)
            let decryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet + alphabetSize) % alphabetSize
            
            decryptedText.append(alphabet[decryptedLetterIndex])
            index += 1
        }
        return decryptedText
    }
}

// Output
let vigenere = Vigenere(key: "UNIQUEKEY")
let encrypt = vigenere.encrypt(plainText: "HAVE A NICE DAY")
let decrypt = vigenere.decrypt(encryptedText: "BNDU U RSGC XNG")

print(encrypt)
print(decrypt)
