//
//  main.swift
//  nybits
//
//  Created by ny on 9/1/24.
//

import nybits
import Foundation

if CommandLine.arguments.count == 2 {
    let path = CommandLine.arguments[1]
    if FileManager.default.fileExists(atPath: path) {
        let url = URL(fileURLWithPath: path, isDirectory: true)
        let file = url.appendingPathComponent("woo.nyt")
        if !FileManager.default.fileExists(atPath: file.path) {
            let s = "Buh!"
            try? s.write(to: file, atomically: true, encoding: .utf8)
            print("Wrote file!")
        } else {
            print("File already exists!")
            if var d = try? Data(contentsOf: file) {
                print(d.count)
                d.removeFirst(4)
                print(d.hexString)
                print(d.asciiString~)
                print(d.asciiString ?? "")
            }
        }
    }
}
