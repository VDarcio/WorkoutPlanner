//
//  Dias.swift
//  WorkoutPlanner
//
//  Created by VD on 23/07/2021.
//

import Foundation
import RealmSwift

class Dias: Object{
    @objc dynamic var dia:String=""
    let treinos=List<treino>()
}
