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
                case 5: return over ? Asset.Signs.overSpeedLimitUS5 : Asset.Signs.speedLimitUS5
                case 15: return over ? Asset.Signs.overSpeedLimitUS15 : Asset.Signs.speedLimitUS15
                case 25: return over ? Asset.Signs.overSpeedLimitUS25 : Asset.Signs.speedLimitUS25
                case 35: return over ? Asset.Signs.overSpeedLimitUS35 : Asset.Signs.speedLimitUS35
                case 45: return over ? Asset.Signs.overSpeedLimitUS45 : Asset.Signs.speedLimitUS45
                case 55: return over ? Asset.Signs.overSpeedLimitUS55 : Asset.Signs.speedLimitUS55
                case 65: return over ? Asset.Signs.overSpeedLimitUS65 : Asset.Signs.speedLimitUS65
                case 75: return over ? Asset.Signs.overSpeedLimitUS75 : Asset.Signs.speedLimitUS75
                case 10: return over ? Asset.Signs.overSpeedLimitUS10 : Asset.Signs.speedLimitUS10
                case 20: return over ? Asset.Signs.overSpeedLimitUS20 : Asset.Signs.speedLimitUS20
                case 30: return over ? Asset.Signs.overSpeedLimitUS30 : Asset.Signs.speedLimitUS30
                case 40: return over ? Asset.Signs.overSpeedLimitUS40 : Asset.Signs.speedLimitUS40
                case 50: return over ? Asset.Signs.overSpeedLimitUS50 : Asset.Signs.speedLimitUS50
                case 60: return over ? Asset.Signs.overSpeedLimitUS60 : Asset.Signs.speedLimitUS60
                case 70: return over ? Asset.Signs.overSpeedLimitUS70 : Asset.Signs.speedLimitUS70
                case 80: return over ? Asset.Signs.overSpeedLimitUS80 : Asset.Signs.speedLimitUS80
                case 85: return over ? Asset.Signs.overSpeedLimitUS85 : Asset.Signs.speedLimitUS85
                case 90: return over ? Asset.Signs.overSpeedLimitUS90 : Asset.Signs.speedLimitUS90
                default: return nil
                }
            case .china:
                switch number {
                case 5: return over ? Asset.Signs.overSpeedLimitEU5 : Asset.Signs.speedLimitEU5
                case 15: return over ? Asset.Signs.overSpeedLimitEU15 : Asset.Signs.speedLimitEU15
                case 25: return over ? Asset.Signs.overSpeedLimitEU25 : Asset.Signs.speedLimitEU25
                case 35: return over ? Asset.Signs.overSpeedLimitEU35 : Asset.Signs.speedLimitEU35
                case 45: return over ? Asset.Signs.overSpeedLimitEU45 : Asset.Signs.speedLimitEU45
                case 55: return over ? Asset.Signs.overSpeedLimitEU55 : Asset.Signs.speedLimitEU55
                case 65: return over ? Asset.Signs.overSpeedLimitEU65 : Asset.Signs.speedLimitEU65
                case 75: return over ? Asset.Signs.overSpeedLimitEU75 : Asset.Signs.speedLimitEU75
                case 85: return over ? Asset.Signs.overSpeedLimitEU85 : Asset.Signs.speedLimitEU85
                case 10: return over ? Asset.Signs.overSpeedLimitEU10 : Asset.Signs.speedLimitEU10
                case 20: return over ? Asset.Signs.overSpeedLimitEU20 : Asset.Signs.speedLimitEU20
                case 30: return over ? Asset.Signs.overSpeedLimitEU30 : Asset.Signs.speedLimitEU30
                case 40: return over ? Asset.Signs.overSpeedLimitEU40 : Asset.Signs.speedLimitEU40
                case 50: return over ? Asset.Signs.overSpeedLimitEU50 : Asset.Signs.speedLimitEU50
                case 60: return over ? Asset.Signs.overSpeedLimitEU60 : Asset.Signs.speedLimitEU60
                case 70: return over ? Asset.Signs.overSpeedLimitEU70 : Asset.Signs.speedLimitEU70
                case 80: return over ? Asset.Signs.overSpeedLimitEU80 : Asset.Signs.speedLimitEU80
                case 90: return over ? Asset.Signs.overSpeedLimitEU90 : Asset.Signs.speedLimitEU90
                case 100: return over ? Asset.Signs.overSpeedLimitEU100 : Asset.Signs.speedLimitEU100
                case 110: return over ? Asset.Signs.overSpeedLimitEU110 : Asset.Signs.speedLimitEU110
                case 120: return over ? Asset.Signs.overSpeedLimitEU120 : Asset.Signs.speedLimitEU120
                default: return nil
                }
            }
        case .end:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.overSpeedLimitEndUS5 : Asset.Signs.speedLimitEndUS5
                case 15: return over ? Asset.Signs.overSpeedLimitEndUS15 : Asset.Signs.speedLimitEndUS15
                case 25: return over ? Asset.Signs.overSpeedLimitEndUS25 : Asset.Signs.speedLimitEndUS25
                case 35: return over ? Asset.Signs.overSpeedLimitEndUS35 : Asset.Signs.speedLimitEndUS35
                case 45: return over ? Asset.Signs.overSpeedLimitEndUS45 : Asset.Signs.speedLimitEndUS45
                case 55: return over ? Asset.Signs.overSpeedLimitEndUS55 : Asset.Signs.speedLimitEndUS55
                case 65: return over ? Asset.Signs.overSpeedLimitEndUS65 : Asset.Signs.speedLimitEndUS65
                case 75: return over ? Asset.Signs.overSpeedLimitEndUS75 : Asset.Signs.speedLimitEndUS75
                case 10: return over ? Asset.Signs.overSpeedLimitEndUS10 : Asset.Signs.speedLimitEndUS10
                case 20: return over ? Asset.Signs.overSpeedLimitEndUS20 : Asset.Signs.speedLimitEndUS20
                case 30: return over ? Asset.Signs.overSpeedLimitEndUS30 : Asset.Signs.speedLimitEndUS30
                case 40: return over ? Asset.Signs.overSpeedLimitEndUS40 : Asset.Signs.speedLimitEndUS40
                case 50: return over ? Asset.Signs.overSpeedLimitEndUS50 : Asset.Signs.speedLimitEndUS50
                case 60: return over ? Asset.Signs.overSpeedLimitEndUS60 : Asset.Signs.speedLimitEndUS60
                case 70: return over ? Asset.Signs.overSpeedLimitEndUS70 : Asset.Signs.speedLimitEndUS70
                case 80: return over ? Asset.Signs.overSpeedLimitEndUS80 : Asset.Signs.speedLimitEndUS80
                case 85: return over ? Asset.Signs.overSpeedLimitEndUS85 : Asset.Signs.speedLimitEndUS85
                case 90: return over ? Asset.Signs.overSpeedLimitEndUS90 : Asset.Signs.speedLimitEndUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .min:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.overSpeedLimitMinUS5 : Asset.Signs.speedLimitMinUS5
                case 15: return over ? Asset.Signs.overSpeedLimitMinUS15 : Asset.Signs.speedLimitMinUS15
                case 25: return over ? Asset.Signs.overSpeedLimitMinUS25 : Asset.Signs.speedLimitMinUS25
                case 35: return over ? Asset.Signs.overSpeedLimitMinUS35 : Asset.Signs.speedLimitMinUS35
                case 45: return over ? Asset.Signs.overSpeedLimitMinUS45 : Asset.Signs.speedLimitMinUS45
                case 55: return over ? Asset.Signs.overSpeedLimitMinUS55 : Asset.Signs.speedLimitMinUS55
                case 65: return over ? Asset.Signs.overSpeedLimitMinUS65 : Asset.Signs.speedLimitMinUS65
                case 75: return over ? Asset.Signs.overSpeedLimitMinUS75 : Asset.Signs.speedLimitMinUS75
                case 10: return over ? Asset.Signs.overSpeedLimitMinUS10 : Asset.Signs.speedLimitMinUS10
                case 20: return over ? Asset.Signs.overSpeedLimitMinUS20 : Asset.Signs.speedLimitMinUS20
                case 30: return over ? Asset.Signs.overSpeedLimitMinUS30 : Asset.Signs.speedLimitMinUS30
                case 40: return over ? Asset.Signs.overSpeedLimitMinUS40 : Asset.Signs.speedLimitMinUS40
                case 50: return over ? Asset.Signs.overSpeedLimitMinUS50 : Asset.Signs.speedLimitMinUS50
                case 60: return over ? Asset.Signs.overSpeedLimitMinUS60 : Asset.Signs.speedLimitMinUS60
                case 70: return over ? Asset.Signs.overSpeedLimitMinUS70 : Asset.Signs.speedLimitMinUS70
                case 80: return over ? Asset.Signs.overSpeedLimitMinUS80 : Asset.Signs.speedLimitMinUS80
                case 85: return over ? Asset.Signs.overSpeedLimitMinUS85 : Asset.Signs.speedLimitMinUS85
                case 90: return over ? Asset.Signs.overSpeedLimitMinUS90 : Asset.Signs.speedLimitMinUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .trucks:
            switch market {
            case .us:
                switch number {
                case 5: return over ? Asset.Signs.overSpeedLimitTrucksUS5 : Asset.Signs.speedLimitTrucksUS5
                case 15: return over ? Asset.Signs.overSpeedLimitTrucksUS15 : Asset.Signs.speedLimitTrucksUS15
                case 25: return over ? Asset.Signs.overSpeedLimitTrucksUS25 : Asset.Signs.speedLimitTrucksUS25
                case 35: return over ? Asset.Signs.overSpeedLimitTrucksUS35 : Asset.Signs.speedLimitTrucksUS35
                case 45: return over ? Asset.Signs.overSpeedLimitTrucksUS45 : Asset.Signs.speedLimitTrucksUS45
                case 55: return over ? Asset.Signs.overSpeedLimitTrucksUS55 : Asset.Signs.speedLimitTrucksUS55
                case 65: return over ? Asset.Signs.overSpeedLimitTrucksUS65 : Asset.Signs.speedLimitTrucksUS65
                case 75: return over ? Asset.Signs.overSpeedLimitTrucksUS75 : Asset.Signs.speedLimitTrucksUS75
                case 10: return over ? Asset.Signs.overSpeedLimitTrucksUS10 : Asset.Signs.speedLimitTrucksUS10
                case 20: return over ? Asset.Signs.overSpeedLimitTrucksUS20 : Asset.Signs.speedLimitTrucksUS20
                case 30: return over ? Asset.Signs.overSpeedLimitTrucksUS30 : Asset.Signs.speedLimitTrucksUS30
                case 40: return over ? Asset.Signs.overSpeedLimitTrucksUS40 : Asset.Signs.speedLimitTrucksUS40
                case 50: return over ? Asset.Signs.overSpeedLimitTrucksUS50 : Asset.Signs.speedLimitTrucksUS50
                case 60: return over ? Asset.Signs.overSpeedLimitTrucksUS60 : Asset.Signs.speedLimitTrucksUS60
                case 70: return over ? Asset.Signs.overSpeedLimitTrucksUS70 : Asset.Signs.speedLimitTrucksUS70
                case 80: return over ? Asset.Signs.overSpeedLimitTrucksUS80 : Asset.Signs.speedLimitTrucksUS80
                case 85: return over ? Asset.Signs.overSpeedLimitTrucksUS85 : Asset.Signs.speedLimitTrucksUS85
                case 90: return over ? Asset.Signs.overSpeedLimitTrucksUS90 : Asset.Signs.speedLimitTrucksUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .night:
            switch market {
            case .us:
                switch number {
                case 5:  return over ? Asset.Signs.overSpeedLimitNightUS5 : Asset.Signs.speedLimitNightUS5
                case 15: return over ? Asset.Signs.overSpeedLimitNightUS15 : Asset.Signs.speedLimitNightUS15
                case 25: return over ? Asset.Signs.overSpeedLimitNightUS25 : Asset.Signs.speedLimitNightUS25
                case 35: return over ? Asset.Signs.overSpeedLimitNightUS35 : Asset.Signs.speedLimitNightUS35
                case 45: return over ? Asset.Signs.overSpeedLimitNightUS45 : Asset.Signs.speedLimitNightUS45
                case 55: return over ? Asset.Signs.overSpeedLimitNightUS55 : Asset.Signs.speedLimitNightUS55
                case 65: return over ? Asset.Signs.overSpeedLimitNightUS65 : Asset.Signs.speedLimitNightUS65
                case 75: return over ? Asset.Signs.overSpeedLimitNightUS75 : Asset.Signs.speedLimitNightUS75
                case 10: return over ? Asset.Signs.overSpeedLimitNightUS10 : Asset.Signs.speedLimitNightUS10
                case 20: return over ? Asset.Signs.overSpeedLimitNightUS20 : Asset.Signs.speedLimitNightUS20
                case 30: return over ? Asset.Signs.overSpeedLimitNightUS30 : Asset.Signs.speedLimitNightUS30
                case 40: return over ? Asset.Signs.overSpeedLimitNightUS40 : Asset.Signs.speedLimitNightUS40
                case 50: return over ? Asset.Signs.overSpeedLimitNightUS50 : Asset.Signs.speedLimitNightUS50
                case 60: return over ? Asset.Signs.overSpeedLimitNightUS60 : Asset.Signs.speedLimitNightUS60
                case 70: return over ? Asset.Signs.overSpeedLimitNightUS70 : Asset.Signs.speedLimitNightUS70
                case 80: return over ? Asset.Signs.overSpeedLimitNightUS80 : Asset.Signs.speedLimitNightUS80
                case 85: return over ? Asset.Signs.overSpeedLimitNightUS85 : Asset.Signs.speedLimitNightUS85
                case 90: return over ? Asset.Signs.overSpeedLimitNightUS90 : Asset.Signs.speedLimitNightUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .pure:
            switch number {
            case 5:
                return Asset.Signs.overSpeedLimitCompUS5
            case 15:
                return Asset.Signs.overSpeedLimitCompUS15
            case 25:
                return Asset.Signs.overSpeedLimitCompUS25
            case 35:
                return Asset.Signs.overSpeedLimitCompUS35
            case 45:
                return Asset.Signs.overSpeedLimitCompUS45
            case 55:
                return Asset.Signs.overSpeedLimitCompUS55
            case 65:
                return Asset.Signs.overSpeedLimitCompUS65
            case 75:
                return Asset.Signs.overSpeedLimitCompUS75
            case 85:
                return Asset.Signs.overSpeedLimitCompUS85
            case 10:
                return Asset.Signs.overSpeedLimitCompUS10
            case 20:
                return Asset.Signs.overSpeedLimitCompUS20
            case 30:
                return Asset.Signs.overSpeedLimitCompUS30
            case 40:
                return Asset.Signs.overSpeedLimitCompUS40
            case 50:
                return Asset.Signs.overSpeedLimitCompUS50
            case 60:
                return Asset.Signs.overSpeedLimitCompUS60
            case 70:
                return Asset.Signs.overSpeedLimitCompUS70
            case 80:
                return Asset.Signs.overSpeedLimitCompUS80
            case 90:
                return Asset.Signs.overSpeedLimitCompUS90
            default: return nil
            }
        case .exit:
            switch number {
            case 5:
                return Asset.Signs.warningExitUS5
            case 15:
                return Asset.Signs.warningExitUS15
            case 25:
                return Asset.Signs.warningExitUS25
            case 35:
                return Asset.Signs.warningExitUS35
            case 45:
                return Asset.Signs.warningExitUS45
            case 55:
                return Asset.Signs.warningExitUS55
            case 65:
                return Asset.Signs.warningExitUS65
            case 75:
                return Asset.Signs.warningExitUS75
            case 85:
                return Asset.Signs.warningExitUS85
            case 10:
                return Asset.Signs.warningExitUS10
            case 20:
                return Asset.Signs.warningExitUS20
            case 30:
                return Asset.Signs.warningExitUS30
            case 40:
                return Asset.Signs.warningExitUS40
            case 50:
                return Asset.Signs.warningExitUS50
            case 60:
                return Asset.Signs.warningExitUS60
            case 70:
                return Asset.Signs.warningExitUS70
            case 80:
                return Asset.Signs.warningExitUS80
            case 90:
                return Asset.Signs.warningExitUS90
            default: return nil
            }
        case .ramp:
            switch number {
            case 5:
                return Asset.Signs.warningRampUS5
            case 15:
                return Asset.Signs.warningRampUS15
            case 25:
                return Asset.Signs.warningRampUS25
            case 35:
                return Asset.Signs.warningRampUS35
            case 45:
                return Asset.Signs.warningRampUS45
            case 55:
                return Asset.Signs.warningRampUS55
            case 65:
                return Asset.Signs.warningRampUS65
            case 75:
                return Asset.Signs.warningRampUS75
            case 85:
                return Asset.Signs.warningRampUS85
            case 10:
                return Asset.Signs.warningRampUS10
            case 20:
                return Asset.Signs.warningRampUS20
            case 30:
                return Asset.Signs.warningRampUS30
            case 40:
                return Asset.Signs.warningRampUS40
            case 50:
                return Asset.Signs.warningRampUS50
            case 60:
                return Asset.Signs.warningRampUS60
            case 70:
                return Asset.Signs.warningRampUS70
            case 80:
                return Asset.Signs.warningRampUS80
            case 90:
                return Asset.Signs.warningRampUS90
            default: return nil
            }
        case .left:
            return Asset.Signs.warningTurnLeftUS
        case .right:
            return Asset.Signs.warningTurnRightUS
        case .backLeft:
            return Asset.Signs.warningTurnBackUS
        case .roundAbout:
            return Asset.Signs.warningRoundaboutUS
        case .bamp:
            return Asset.Signs.warningSpeedbumpUS
        case .winding:
            return Asset.Signs.warningWindingRoadUS
        case .informationBikeRoute:
            return nil
        case .informationParking:
            return Asset.Signs.informationParkingUS
        case .regulatoryAllDirectionsPermitted:
            return nil
        case .regulatoryBicyclesOnly:
            return Asset.Signs.regulatoryBicyclesOnlyV1US
        case .regulatoryDoNotpass:
            return Asset.Signs.regulatoryDoNotPassUS
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
            return Asset.Signs.regulatoryHeightLimitUS
        case .regulatoryLeftTurnYieldOnGreen:
            return nil
        case .regulatoryNoBicycles:
            return nil
        case .regulatoryNoEntry:
            return Asset.Signs.regulatoryNoEntryUS
        case .regulatoryNoLeftOrUTurn:
            return Asset.Signs.regulatoryNoLeftOrUTurnUS
        case .regulatoryNoLeftTurn:
            return Asset.Signs.regulatoryNoLeftTurnV1US
        case .regulatoryNoMotorVehicles:
            return nil
        case .regulatoryNoParking:
            return nil
        case .regulatoryNoParkingOrNoStopping:
            return Asset.Signs.regulatoryNoParkingOrNoStoppingV1US
        case .regulatoryNoPedestrians:
            return nil
        case .regulatoryNoRightTurn:
            return Asset.Signs.regulatoryNoRightTurnUS
        case .regulatoryMoStopping:
            return nil
        case .regulatoryNoStraightThrough:
            return nil
        case .regulatoryNoUTurn:
            return Asset.Signs.regulatoryNoUTurnUS
        case .regulatoryOneWayStraight:
            return nil
        case .regulatoryReversibleLanes:
            return nil
        case .regulatoryRoadClosedToVehicles:
            return nil
        case .regulatoryStop:
            return Asset.Signs.regulatoryStopUS
        case .regulatoryTrafficSignalPhotoEnforced:
            return nil
        case .regulatoryTripleLanesGoStraightCenterLane:
            return Asset.Signs.regulatoryTipleLanesGoStraightCenterLane
        case .warningBicyclesCrossing:
            return Asset.Signs.warningBicyclesCrossingUS
        case .warningHeightRestriction:
            return nil
        case .warningPassLeftOrRight:
            return Asset.Signs.warningPassLeftOrRightUS
        case .warningPedestriansCrossing:
            return Asset.Signs.warningPedestriansCrossingUS
        case .warningRoadNarrowsLeft:
            return nil
        case .warningRoadNarrowsRight:
            return nil
        case .warningSchoolZone:
            return Asset.Signs.warningSchoolZoneUS
        case .warningStopAhead:
            return Asset.Signs.warningStopAheadUS
        case .warningTrafficSignals:
            return nil
        case .warningTwoWayTraffic:
            return Asset.Signs.warningTwoWayTrafficUS
        case .warningYieldAhead:
            return nil
        case .informationHighway:
            return nil
        }
    }
}
