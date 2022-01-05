//
//  veriYukleyici.swift
//  eticapp
//
//  Created by Baris on 23.09.2021.
//

import Foundation
public class veriYukleyici {
    
    @Published var veriTipleri = [urunlerjson]()
    
    init() {
        load()
        sort()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "veriler", withExtension: "json"){
            
            //do catch in case of an error
            do {
                let data = try Data(contentsOf: fileLocation)
                
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([urunlerjson].self, from: data)
                
                self.veriTipleri = dataFromJson
                
            }
            catch {
                print(error)
            }
        }
    }
    func sort() {
        self.veriTipleri = self.veriTipleri.sorted(by: {$0.id < $1.id})
    }
}

