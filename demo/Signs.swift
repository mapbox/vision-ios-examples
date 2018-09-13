//
//  Signs.swift
//  cv-assist-ios
//
//  Created by Maksim Vaniukevich on 3/21/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

extension SignClassification {
    func icon(over: Bool, market: Market) -> ImageAsset? {
        switch type {
        case .unknown:
            return nil
        case .mass:
            return nil
        case .speedLimit:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS5 : Asset.Signs.SpeedLimits.speedLimitUS5
                case 15: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS15 : Asset.Signs.SpeedLimits.speedLimitUS15
                case 25: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS25 : Asset.Signs.SpeedLimits.speedLimitUS25
                case 35: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS35 : Asset.Signs.SpeedLimits.speedLimitUS35
                case 45: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS45 : Asset.Signs.SpeedLimits.speedLimitUS45
                case 55: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS55 : Asset.Signs.SpeedLimits.speedLimitUS55
                case 65: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS65 : Asset.Signs.SpeedLimits.speedLimitUS65
                case 75: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS75 : Asset.Signs.SpeedLimits.speedLimitUS75
                case 10: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS10 : Asset.Signs.SpeedLimits.speedLimitUS10
                case 20: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS20 : Asset.Signs.SpeedLimits.speedLimitUS20
                case 30: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS30 : Asset.Signs.SpeedLimits.speedLimitUS30
                case 40: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS40 : Asset.Signs.SpeedLimits.speedLimitUS40
                case 50: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS50 : Asset.Signs.SpeedLimits.speedLimitUS50
                case 60: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS60 : Asset.Signs.SpeedLimits.speedLimitUS60
                case 70: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS70 : Asset.Signs.SpeedLimits.speedLimitUS70
                case 80: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS80 : Asset.Signs.SpeedLimits.speedLimitUS80
                case 85: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS85 : Asset.Signs.SpeedLimits.speedLimitUS85
                case 90: return over ? Asset.Signs.SpeedLimits.overSpeedLimitUS90 : Asset.Signs.SpeedLimits.speedLimitUS90
                default: return nil
                }
            case .china:
                switch number {
                case 5: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU5 : Asset.Signs.SpeedLimitsEU.speedLimitEU5
                case 15: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU15 : Asset.Signs.SpeedLimitsEU.speedLimitEU15
                case 25: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU25 : Asset.Signs.SpeedLimitsEU.speedLimitEU25
                case 35: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU35 : Asset.Signs.SpeedLimitsEU.speedLimitEU35
                case 45: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU45 : Asset.Signs.SpeedLimitsEU.speedLimitEU45
                case 55: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU55 : Asset.Signs.SpeedLimitsEU.speedLimitEU55
                case 65: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU65 : Asset.Signs.SpeedLimitsEU.speedLimitEU65
                case 75: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU75 : Asset.Signs.SpeedLimitsEU.speedLimitEU75
                case 85: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU85 : Asset.Signs.SpeedLimitsEU.speedLimitEU85
                case 10: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU10 : Asset.Signs.SpeedLimitsEU.speedLimitEU10
                case 20: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU20 : Asset.Signs.SpeedLimitsEU.speedLimitEU20
                case 30: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU30 : Asset.Signs.SpeedLimitsEU.speedLimitEU30
                case 40: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU40 : Asset.Signs.SpeedLimitsEU.speedLimitEU40
                case 50: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU50 : Asset.Signs.SpeedLimitsEU.speedLimitEU50
                case 60: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU60 : Asset.Signs.SpeedLimitsEU.speedLimitEU60
                case 70: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU70 : Asset.Signs.SpeedLimitsEU.speedLimitEU70
                case 80: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU80 : Asset.Signs.SpeedLimitsEU.speedLimitEU80
                case 90: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU90 : Asset.Signs.SpeedLimitsEU.speedLimitEU90
                case 100: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU100 : Asset.Signs.SpeedLimitsEU.speedLimitEU100
                case 110: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU110 : Asset.Signs.SpeedLimitsEU.speedLimitEU110
                case 120: return over ? Asset.Signs.SpeedLimitsEU.overSpeedLimitEU120 : Asset.Signs.SpeedLimitsEU.speedLimitEU120
                default: return nil
                }
            }
        case .end:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS5 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS5
                case 15: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS15 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS15
                case 25: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS25 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS25
                case 35: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS35 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS35
                case 45: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS45 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS45
                case 55: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS55 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS55
                case 65: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS65 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS65
                case 75: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS75 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS75
                case 10: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS10 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS10
                case 20: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS20 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS20
                case 30: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS30 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS30
                case 40: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS40 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS40
                case 50: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS50 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS50
                case 60: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS60 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS60
                case 70: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS70 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS70
                case 80: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS80 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS80
                case 85: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS85 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS85
                case 90: return over ? Asset.Signs.SpeedLimitsEnd.overSpeedLimitEndUS90 : Asset.Signs.SpeedLimitsEnd.speedLimitEndUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .min:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS5 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS5
                case 15: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS15 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS15
                case 25: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS25 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS25
                case 35: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS35 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS35
                case 45: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS45 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS45
                case 55: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS55 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS55
                case 65: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS65 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS65
                case 75: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS75 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS75
                case 10: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS10 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS10
                case 20: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS20 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS20
                case 30: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS30 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS30
                case 40: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS40 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS40
                case 50: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS50 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS50
                case 60: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS60 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS60
                case 70: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS70 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS70
                case 80: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS80 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS80
                case 85: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS85 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS85
                case 90: return over ? Asset.Signs.SpeedLimitsMin.overSpeedLimitMinUS90 : Asset.Signs.SpeedLimitsMin.speedLimitMinUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .trucks:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS5 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS5
                case 15: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS15 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS15
                case 25: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS25 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS25
                case 35: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS35 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS35
                case 45: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS45 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS45
                case 55: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS55 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS55
                case 65: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS65 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS65
                case 75: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS75 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS75
                case 10: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS10 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS10
                case 20: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS20 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS20
                case 30: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS30 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS30
                case 40: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS40 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS40
                case 50: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS50 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS50
                case 60: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS60 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS60
                case 70: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS70 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS70
                case 80: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS80 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS80
                case 85: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS85 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS85
                case 90: return over ? Asset.Signs.SpeedLimitsTrucks.overSpeedLimitTrucksUS90 : Asset.Signs.SpeedLimitsTrucks.speedLimitTrucksUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .night:
            switch market {
            case .us:
                switch number {
                case 5:  return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS5 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS5
                case 15: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS15 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS15
                case 25: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS25 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS25
                case 35: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS35 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS35
                case 45: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS45 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS45
                case 55: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS55 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS55
                case 65: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS65 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS65
                case 75: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS75 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS75
                case 10: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS10 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS10
                case 20: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS20 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS20
                case 30: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS30 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS30
                case 40: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS40 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS40
                case 50: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS50 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS50
                case 60: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS60 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS60
                case 70: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS70 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS70
                case 80: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS80 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS80
                case 85: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS85 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS85
                case 90: return over ? Asset.Signs.SpeedLimitsNight.overSpeedLimitNightUS90 : Asset.Signs.SpeedLimitsNight.speedLimitNightUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .pure:
            switch number {
            case 5:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS5
            case 15:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS15
            case 25:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS25
            case 35:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS35
            case 45:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS45
            case 55:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS55
            case 65:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS65
            case 75:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS75
            case 85:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS85
            case 10:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS10
            case 20:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS20
            case 30:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS30
            case 40:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS40
            case 50:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS50
            case 60:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS60
            case 70:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS70
            case 80:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS80
            case 90:
                return Asset.Signs.SpeedLimitsComplementary.overSpeedLimitCompUS90
            default: return nil
            }
        case .exit:
            switch number {
            case 5:
                return Asset.Signs.Warnings.warningExitUS5
            case 15:
                return Asset.Signs.Warnings.warningExitUS15
            case 25:
                return Asset.Signs.Warnings.warningExitUS25
            case 35:
                return Asset.Signs.Warnings.warningExitUS35
            case 45:
                return Asset.Signs.Warnings.warningExitUS45
            case 55:
                return Asset.Signs.Warnings.warningExitUS55
            case 65:
                return Asset.Signs.Warnings.warningExitUS65
            case 75:
                return Asset.Signs.Warnings.warningExitUS75
            case 85:
                return Asset.Signs.Warnings.warningExitUS85
            case 10:
                return Asset.Signs.Warnings.warningExitUS10
            case 20:
                return Asset.Signs.Warnings.warningExitUS20
            case 30:
                return Asset.Signs.Warnings.warningExitUS30
            case 40:
                return Asset.Signs.Warnings.warningExitUS40
            case 50:
                return Asset.Signs.Warnings.warningExitUS50
            case 60:
                return Asset.Signs.Warnings.warningExitUS60
            case 70:
                return Asset.Signs.Warnings.warningExitUS70
            case 80:
                return Asset.Signs.Warnings.warningExitUS80
            case 90:
                return Asset.Signs.Warnings.warningExitUS90
            default: return nil
            }
        case .ramp:
            switch number {
            case 5:
                return Asset.Signs.Warnings.warningRampUS5
            case 15:
                return Asset.Signs.Warnings.warningRampUS15
            case 25:
                return Asset.Signs.Warnings.warningRampUS25
            case 35:
                return Asset.Signs.Warnings.warningRampUS35
            case 45:
                return Asset.Signs.Warnings.warningRampUS45
            case 55:
                return Asset.Signs.Warnings.warningRampUS55
            case 65:
                return Asset.Signs.Warnings.warningRampUS65
            case 75:
                return Asset.Signs.Warnings.warningRampUS75
            case 85:
                return Asset.Signs.Warnings.warningRampUS85
            case 10:
                return Asset.Signs.Warnings.warningRampUS10
            case 20:
                return Asset.Signs.Warnings.warningRampUS20
            case 30:
                return Asset.Signs.Warnings.warningRampUS30
            case 40:
                return Asset.Signs.Warnings.warningRampUS40
            case 50:
                return Asset.Signs.Warnings.warningRampUS50
            case 60:
                return Asset.Signs.Warnings.warningRampUS60
            case 70:
                return Asset.Signs.Warnings.warningRampUS70
            case 80:
                return Asset.Signs.Warnings.warningRampUS80
            case 90:
                return Asset.Signs.Warnings.warningRampUS90
            default: return nil
            }
        case .left:
            return Asset.Signs.Warnings.warningTurnLeftUS
        case .right:
            return Asset.Signs.Warnings.warningTurnRightUS
        case .backLeft:
            return Asset.Signs.Warnings.warningTurnBackUS
        case .roundAbout:
            return Asset.Signs.Warnings.warningRoundaboutUS
        case .bamp:
            return Asset.Signs.Warnings.warningSpeedbumpUS
        case .winding:
            return Asset.Signs.Warnings.warningWindingRoadUS
        case .informationBikeRoute:
            return nil
        case .informationParking:
            return Asset.Signs.Information.informationParkingUS
        case .regulatoryAllDirectionsPermitted:
            return nil
        case .regulatoryBicyclesOnly:
            return Asset.Signs.Regulatory.regulatoryBicyclesOnlyV1US
        case .regulatoryDoNotpass:
            return Asset.Signs.Regulatory.regulatoryDoNotPassUS
        case .regulatoryDoNotstopOnTracks:
            return nil
        case .regulatoryDualLanesAllDirectionsOnRight:
            return nil
        case .regulatoryDualLanesGoLeftOrRight:
            return nil
        case .regulatoryDualLanesGoStraightOnLeft:
            return nil
        case .regulatoryDualLanesGoStraightOnRight:
            return nil
        case .regulatoryDualLanesTurnLeft:
            return nil
        case .regulatoryDualLanesTurnLeftOrStraight:
            return nil
        case .regulatoryDualLanesTurnRightOrStraight:
            return nil
        case .regulatoryEndOfSchoolZone:
            return nil
        case .regulatoryGoStraight:
            return nil
        case .regulatoryGoStraightOrTurnLeft:
            return nil
        case .regulatoryGoStraightOrTurnRight:
            return nil
        case .regulatoryHeightLimit:
            return Asset.Signs.Regulatory.regulatoryHeightLimitUS
        case .regulatoryLeftTurnYieldOnGreen:
            return nil
        case .regulatoryNoBicycles:
            return nil
        case .regulatoryNoEntry:
            return Asset.Signs.Regulatory.regulatoryNoEntryUS
        case .regulatoryNoLeftOrUTurn:
            return Asset.Signs.Regulatory.regulatoryNoLeftOrUTurnUS
        case .regulatoryNoLeftTurn:
            return Asset.Signs.Regulatory.regulatoryNoLeftTurnV1US
        case .regulatoryNoMotorVehicles:
            return nil
        case .regulatoryNoParking:
            return nil
        case .regulatoryNoParkingOrNoStopping:
            return Asset.Signs.Regulatory.regulatoryNoParkingOrNoStoppingV1US
        case .regulatoryNoPedestrians:
            return nil
        case .regulatoryNoRightTurn:
            return Asset.Signs.Regulatory.regulatoryNoRightTurnUS
        case .regulatoryMoStopping:
            return nil
        case .regulatoryNoStraightThrough:
            return nil
        case .regulatoryNoUTurn:
            return Asset.Signs.Regulatory.regulatoryNoUTurnUS
        case .regulatoryOneWayStraight:
            return nil
        case .regulatoryReversibleLanes:
            return nil
        case .regulatoryRoadClosedToVehicles:
            return nil
        case .regulatoryStop:
            return Asset.Signs.Regulatory.regulatoryStopUS
        case .regulatoryTrafficSignalPhotoEnforced:
            return nil
        case .regulatoryTripleLanesGoStraightCenterLane:
            return Asset.Signs.Regulatory.regulatoryTipleLanesGoStraightCenterLane
        case .warningBicyclesCrossing:
            return Asset.Signs.Warnings.warningBicyclesCrossingUS
        case .warningHeightRestriction:
            return nil
        case .warningPassLeftOrRight:
            return Asset.Signs.Warnings.warningPassLeftOrRightUS
        case .warningPedestriansCrossing:
            return Asset.Signs.Warnings.warningPedestriansCrossingUS
        case .warningRoadNarrowsLeft:
            return nil
        case .warningRoadNarrowsRight:
            return nil
        case .warningSchoolZone:
            return Asset.Signs.Warnings.warningSchoolZoneUS
        case .warningStopAhead:
            return Asset.Signs.Warnings.warningStopAheadUS
        case .warningTrafficSignals:
            return nil
        case .warningTwoWayTraffic:
            return Asset.Signs.Warnings.warningTwoWayTrafficUS
        case .warningYieldAhead:
            return nil
        case .informationHighway:
            return nil
        }
    }
}
