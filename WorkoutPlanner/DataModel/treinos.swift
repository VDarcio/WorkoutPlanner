//
//  treinos.swift
//  WorkoutPlanner
//
//  Created by VD on 23/07/2021.
//

import Foundation
import RealmSwift

class treino: Object{
    @objc dynamic var treino:String=""
    var parentday=LinkingObjects(fromType: Dias.self, property: "treinos")
}
