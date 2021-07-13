//
//  Vigenere Cipher
//
//  Created by deathlezz on 12/07/2021.
//

import Foundation


extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

print("* Welcome to Vigenere Cipher *")

func vigenere() {

    class Vigenere {
        
        let alphabet: String
        let alphabetSize: Int
        let key: String
        let keySize: Int
        
        
        init(alphabet: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'!?.,", key: String) {
            
            self.alphabet = alphabet
            self.alphabetSize = alphabet.count
            self.key = key
            self.keySize = key.count
        }
        
        
        // Index of alphabet
        
        func alphabetIndex(forCharacter character: Character) -> Int {
            
            var index = 0
            
            for chr in alphabet {
                
                if chr == character {
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
            
            for character in plainText {
                
                let indexInAlphabet = alphabetIndex(forCharacter: character)
                
                if indexInAlphabet == -1 {
                    
                    encryptedText.append(character)
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
            
            for character in encryptedText {
                
                let indexInAlphabet = alphabetIndex(forCharacter: character)
                
                if indexInAlphabet == -1 {
                    decryptedText.append(character)
                    continue
                }
                
                let keyToEncryptWith = key[index % keySize]
                let keyIndexInAlphabet = alphabetIndex(forCharacter: keyToEncryptWith)
                let encryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet + alphabetSize) % alphabetSize
                
                decryptedText.append(alphabet[encryptedLetterIndex])
                index += 1
            }
            
            return decryptedText
        }
    }

    print()
    print("Select operation:")
    print("[1] Encrypt")
    print("[2] Decrypt")

    let userChoice = Int(readLine()!)

    if userChoice == 1 {     // Encrypt
        
        func enterKey() {
        
            print("Enter key:")
            
            let key = readLine()
            
            let keyChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
            
            if (key!.rangeOfCharacter(from: keyChar.inverted) != nil) {
                
                print()
                print("* Enter letters or numbers only *")
                print()
                return enterKey()
                
            } else if key!.count >= 2 {
                
                func enterText() {
                
                    let vigenereKey = Vigenere(key: key!)
                    
                    print("Enter text to encrypt:")
                    
                    let text = readLine()
                    
                    let textChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'!?., ")

                    if (text!.rangeOfCharacter(from: textChar.inverted) != nil) {
                        
                        print()
                        print("* Bad input, try again *")
                        print()
                        return enterText()
                        
                    } else if text != "" && !text!.hasPrefix(" ") && !text!.hasSuffix(" ") {
                        
                        let encrypt = vigenereKey.encrypt(plainText: text!)
                        
                        print()
                        print("Your key: \(key!)")
                        print("Plain text: \(text!)")
                        print("Encrypted text: \(encrypt)")
                        return vigenere()
                        
                    } else {
                        
                        print()
                        print("* Avoid whitespaces *")
                        print()
                        return enterText()
                    }
                }
                enterText()
                
            } else {
                
                print()
                print("* Enter at least 2 characters *")
                print()
                return enterKey()
            }
        }
        enterKey()
        
    } else if userChoice == 2 {     // Decrypt
        
        func enterKey() {
        
            print("Enter key:")
            
            let key = readLine()
            
            let keyChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
            
            if (key!.rangeOfCharacter(from: keyChar.inverted) != nil) {
                
                print()
                print("* Enter letters or numbers only *")
                print()
                return enterKey()
                
            } else if key!.count >= 2 {
                
                func enterText() {
                
                    let vigenereKey = Vigenere(key: key!)
                    
                    print("Enter text to decrypt:")
                    
                    let text = readLine()
                    
                    let textChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'!?., ")
                    
                    if (text!.rangeOfCharacter(from: textChar.inverted) != nil) {
                        
                        print()
                        print("* Bad input, try again *")
                        print()
                        return enterText()
                        
                    } else if text != "" && !text!.hasPrefix(" ") && !text!.hasSuffix(" ") {
                        
                        let decrypt = vigenereKey.decrypt(encryptedText: text!)
                        
                        print()
                        print("Your key: \(key!)")
                        print("Encrypted text: \(text!)")
                        print("Plain text: \(decrypt)")
                        return vigenere()
                        
                    } else {
                        
                        print()
                        print("* Avoid whitespaces *")
                        print()
                        return enterText()
                        
                    }
                }
                enterText()
                
            } else {
                
                print()
                print("* Enter at least 2 characters *")
                print()
                return enterKey()
            }
        }
        enterKey()
        
    } else {
        
        print()
        print("* Enter 1 or 2 *")
        return vigenere()
    }
}
vigenere()
