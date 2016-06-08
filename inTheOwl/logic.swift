//
//  logic.swift
//  inTheOwl
//
//  Created by Brandon Wallace on 6/4/16.
//  Copyright © 2016 Made On Planes. All rights reserved.
//

import Foundation
import SceneKit

var cannonAngle: Int = 0
var cannonPower: Int = 50

let cannonMax = 90
let cannonMin = 0

let cannonPowerMax = 100
let cannonPowerMin = 0

func adjustAngle(by: Int){
    if (cannonAngle + by <= cannonMax && cannonAngle + by >= cannonMin) {
        cannonAngle += by
    }
}

func adjustPower(by: Int){
    if (cannonPower + by <= cannonPowerMax && cannonPower + by >= cannonPowerMin){
        cannonPower += by
    }
}

func getRelativeScale(screenThingy: CGFloat, itemThingy: CGFloat, desiredRatio: CGFloat)->CGFloat {
    return desiredRatio * screenThingy / itemThingy
}

func force() -> CGVector {
    let yBoost: Double = Double(1.0 * Float(cannonPower))
    
    let s = sin(GLKMathDegreesToRadians(Float(cannonAngle)))
    let c = cos(GLKMathDegreesToRadians(Float(cannonAngle)))
    
    let x = c * 5
    let y = s * 5
    
    let xS: Double = Double(x * Float(cannonPower))
    let yS: Double = Double(y * Float(cannonPower))
    
    let v = CGVector(dx: xS, dy: yS + yBoost)
    return v
}
