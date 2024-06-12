//
//  Unit.swift
//  UnitConversion
//
//  Created by Andrew Emad on 12/06/2024.
//

import Foundation


class UnitFactory {
    static let shared = UnitFactory()
    private init() {}
    
    func getAvailableUnits() -> [any Unitable] {
        var units:[any Unitable] = []
        units.append(temperatureUnitsGenerator())
        units.append(distanceUnitsGenerator())
        return units
    }
    
    private func temperatureUnitsGenerator() -> any Unitable {
        let celsius = UnitData(unitName: "Celsius", unitConversions: ["Celsius":"*1",
                                                                      "Kelvin":"+273.15",
                                                                      "Fehrenheit":"*1.8+32"])
        let kelvin = UnitData(unitName: "Kelvin", unitConversions: ["Celsius":"-273.15",
                                                                      "Kelvin":"*1",
                                                                      "Fehrenheit":"−273.15*1.8+32"])
        let fehrenheit = UnitData(unitName: "Fehrenheit", unitConversions: ["Celsius":"-32*1.8",
                                                                      "Kelvin":"-32*1.8+273.15",
                                                                      "Fehrenheit":"*1"])
        return Unit(name: "Temperature", subUnits: [celsius,kelvin,fehrenheit])
    }
    
    private func distanceUnitsGenerator() -> any Unitable {
        let meter = UnitData(unitName: "Meter", unitConversions: ["Meter":"*1",
                                                                      "Kilometer":"/1000"])
        let kilometer = UnitData(unitName: "Kilometer", unitConversions: ["Meter":"*1000",
                                                                      "Kilometer":"*1"])
        return Unit(name: "Distance", subUnits: [meter,kilometer])
    }
}

protocol Unitable: Identifiable  {
    var id: UUID { get set }
    var name: String { get set }
    var subUnits:[UnitData] { get set }
}

class Unit: Unitable {
    var id: UUID = UUID()
    var name: String
    var subUnits: [UnitData]
    init(name: String, subUnits: [UnitData]) {
        self.name = name
        self.subUnits = subUnits
    }
}


struct UnitData {
    let unitName: String
    let unitConversions: [String:String]
}
