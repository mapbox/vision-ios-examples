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
                case 5:
                    return Asset.Signs.speedLimitUS5
                case 15:
                    return Asset.Signs.speedLimitUS15
                case 25:
                    return Asset.Signs.speedLimitUS25
                case 35:
                    return Asset.Signs.speedLimitUS35
                case 45:
                    return Asset.Signs.speedLimitUS45
                case 55:
                    return Asset.Signs.speedLimitUS55
                case 65:
                    return Asset.Signs.speedLimitUS65
                case 75:
                    return Asset.Signs.speedLimitUS75
                case 10:
                    return Asset.Signs.speedLimitUS10
                case 20:
                    return Asset.Signs.speedLimitUS20
                case 30:
                    return Asset.Signs.speedLimitUS30
                case 40:
                    return Asset.Signs.speedLimitUS40
                case 50:
                    return Asset.Signs.speedLimitUS50
                case 60:
                    return Asset.Signs.speedLimitUS60
                case 70:
                    return Asset.Signs.speedLimitUS70
                case 80:
                    return Asset.Signs.speedLimitUS80
                case 85:
                    return Asset.Signs.speedLimitUS85
                case 90:
                    return Asset.Signs.speedLimitUS90
                default: return nil
                }
            case .china:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitEU5Over : Asset.Signs.speedLimitEU5
                case 15:
                    return over ? Asset.Signs.speedLimitEU15Over : Asset.Signs.speedLimitEU15
                case 25:
                    return over ? Asset.Signs.speedLimitEU25Over : Asset.Signs.speedLimitEU25
                case 35:
                    return over ? Asset.Signs.speedLimitEU35Over : Asset.Signs.speedLimitEU35
                case 45:
                    return over ? Asset.Signs.speedLimitEU45Over : Asset.Signs.speedLimitEU45
                case 55:
                    return over ? Asset.Signs.speedLimitEU55Over : Asset.Signs.speedLimitEU55
                case 65:
                    return over ? Asset.Signs.speedLimitEU65Over : Asset.Signs.speedLimitEU65
                case 75:
                    return over ? Asset.Signs.speedLimitEU75Over : Asset.Signs.speedLimitEU75
                case 85:
                    return over ? Asset.Signs.speedLimitEU85Over : Asset.Signs.speedLimitEU85
                case 95:
                    return over ? Asset.Signs.speedLimitEU95Over : Asset.Signs.speedLimitEU95
                case 105:
                    return over ? Asset.Signs.speedLimitEU105Over : Asset.Signs.speedLimitEU105
                case 115:
                    return over ? Asset.Signs.speedLimitEU115Over : Asset.Signs.speedLimitEU115
                case 125:
                    return over ? Asset.Signs.speedLimitEU125Over : Asset.Signs.speedLimitEU125
                case 10:
                    return over ? Asset.Signs.speedLimitEU10Over : Asset.Signs.speedLimitEU10
                case 20:
                    return over ? Asset.Signs.speedLimitEU20Over : Asset.Signs.speedLimitEU20
                case 30:
                    return over ? Asset.Signs.speedLimitEU30Over : Asset.Signs.speedLimitEU30
                case 40:
                    return over ? Asset.Signs.speedLimitEU40Over : Asset.Signs.speedLimitEU40
                case 50:
                    return over ? Asset.Signs.speedLimitEU50Over : Asset.Signs.speedLimitEU50
                case 60:
                    return over ? Asset.Signs.speedLimitEU60Over : Asset.Signs.speedLimitEU60
                case 70:
                    return over ? Asset.Signs.speedLimitEU70Over : Asset.Signs.speedLimitEU70
                case 80:
                    return over ? Asset.Signs.speedLimitEU80Over : Asset.Signs.speedLimitEU80
                case 90:
                    return over ? Asset.Signs.speedLimitEU90Over : Asset.Signs.speedLimitEU90
                case 100:
                    return over ? Asset.Signs.speedLimitEU100Over : Asset.Signs.speedLimitEU100
                case 110:
                    return over ? Asset.Signs.speedLimitEU110Over : Asset.Signs.speedLimitEU110
                case 120:
                    return over ? Asset.Signs.speedLimitEU120Over : Asset.Signs.speedLimitEU120
                case 130:
                    return over ? Asset.Signs.speedLimitEU130 : Asset.Signs.speedLimitEU130
                default: return nil
                }
            }
        case .speedLimitEnd:
            switch market {
            case .us:
                switch number {
                case 5:
                    return Asset.Signs.speedLimitEndUS5
                case 15:
                    return Asset.Signs.speedLimitEndUS15
                case 25:
                    return Asset.Signs.speedLimitEndUS25
                case 35:
                    return Asset.Signs.speedLimitEndUS35
                case 45:
                    return Asset.Signs.speedLimitEndUS45
                case 55:
                    return Asset.Signs.speedLimitEndUS55
                case 65:
                    return Asset.Signs.speedLimitEndUS65
                case 75:
                    return Asset.Signs.speedLimitEndUS75
                case 10:
                    return Asset.Signs.speedLimitEndUS10
                case 20:
                    return Asset.Signs.speedLimitEndUS20
                case 30:
                    return Asset.Signs.speedLimitEndUS30
                case 40:
                    return Asset.Signs.speedLimitEndUS40
                case 50:
                    return Asset.Signs.speedLimitEndUS50
                case 60:
                    return Asset.Signs.speedLimitEndUS60
                case 70:
                    return Asset.Signs.speedLimitEndUS70
                case 80:
                    return Asset.Signs.speedLimitEndUS80
                case 85:
                    return Asset.Signs.speedLimitEndUS85
                case 90:
                    return Asset.Signs.speedLimitEndUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitMin:
            switch market {
            case .us:
                switch number {
                case 5:
                    return Asset.Signs.speedLimitMinUS5
                case 15:
                    return Asset.Signs.speedLimitMinUS15
                case 25:
                    return Asset.Signs.speedLimitMinUS25
                case 35:
                    return Asset.Signs.speedLimitMinUS35
                case 45:
                    return Asset.Signs.speedLimitMinUS45
                case 55:
                    return Asset.Signs.speedLimitMinUS55
                case 65:
                    return Asset.Signs.speedLimitMinUS65
                case 75:
                    return Asset.Signs.speedLimitMinUS75
                case 10:
                    return Asset.Signs.speedLimitMinUS10
                case 20:
                    return Asset.Signs.speedLimitMinUS20
                case 30:
                    return Asset.Signs.speedLimitMinUS30
                case 40:
                    return Asset.Signs.speedLimitMinUS40
                case 50:
                    return Asset.Signs.speedLimitMinUS50
                case 60:
                    return Asset.Signs.speedLimitMinUS60
                case 70:
                    return Asset.Signs.speedLimitMinUS70
                case 80:
                    return Asset.Signs.speedLimitMinUS80
                case 85:
                    return Asset.Signs.speedLimitMinUS85
                case 90:
                    return Asset.Signs.speedLimitMinUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitTrucks:
            switch market {
            case .us:
                switch number {
                case 5:
                    return Asset.Signs.speedLimitTrucksUS5
                case 15:
                    return Asset.Signs.speedLimitTrucksUS15
                case 25:
                    return Asset.Signs.speedLimitTrucksUS25
                case 35:
                    return Asset.Signs.speedLimitTrucksUS35
                case 45:
                    return Asset.Signs.speedLimitTrucksUS45
                case 55:
                    return Asset.Signs.speedLimitTrucksUS55
                case 65:
                    return Asset.Signs.speedLimitTrucksUS65
                case 75:
                    return Asset.Signs.speedLimitTrucksUS75
                case 10:
                    return Asset.Signs.speedLimitTrucksUS10
                case 20:
                    return Asset.Signs.speedLimitTrucksUS20
                case 30:
                    return Asset.Signs.speedLimitTrucksUS30
                case 40:
                    return Asset.Signs.speedLimitTrucksUS40
                case 50:
                    return Asset.Signs.speedLimitTrucksUS50
                case 60:
                    return Asset.Signs.speedLimitTrucksUS60
                case 70:
                    return Asset.Signs.speedLimitTrucksUS70
                case 80:
                    return Asset.Signs.speedLimitTrucksUS80
                case 85:
                    return Asset.Signs.speedLimitTrucksUS85
                case 90:
                    return Asset.Signs.speedLimitTrucksUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitNight:
            switch market {
            case .us:
                switch number {
                case 5:
                    return Asset.Signs.speedLimitNightUS5
                case 15:
                    return Asset.Signs.speedLimitNightUS15
                case 25:
                    return Asset.Signs.speedLimitNightUS25
                case 35:
                    return Asset.Signs.speedLimitNightUS35
                case 45:
                    return Asset.Signs.speedLimitNightUS45
                case 55:
                    return Asset.Signs.speedLimitNightUS55
                case 65:
                    return Asset.Signs.speedLimitNightUS65
                case 75:
                    return Asset.Signs.speedLimitNightUS75
                case 10:
                    return Asset.Signs.speedLimitNightUS10
                case 20:
                    return Asset.Signs.speedLimitNightUS20
                case 30:
                    return Asset.Signs.speedLimitNightUS30
                case 40:
                    return Asset.Signs.speedLimitNightUS40
                case 50:
                    return Asset.Signs.speedLimitNightUS50
                case 60:
                    return Asset.Signs.speedLimitNightUS60
                case 70:
                    return Asset.Signs.speedLimitNightUS70
                case 80:
                    return Asset.Signs.speedLimitNightUS80
                case 85:
                    return Asset.Signs.speedLimitNightUS85
                case 90:
                    return Asset.Signs.speedLimitNightUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitComplementary:
            switch number {
            case 5:
                return Asset.Signs.speedLimitCompUS5
            case 15:
                return Asset.Signs.speedLimitCompUS15
            case 25:
                return Asset.Signs.speedLimitCompUS25
            case 35:
                return Asset.Signs.speedLimitCompUS35
            case 45:
                return Asset.Signs.speedLimitCompUS45
            case 55:
                return Asset.Signs.speedLimitCompUS55
            case 65:
                return Asset.Signs.speedLimitCompUS65
            case 75:
                return Asset.Signs.speedLimitCompUS75
            case 85:
                return Asset.Signs.speedLimitCompUS85
            case 10:
                return Asset.Signs.speedLimitCompUS10
            case 20:
                return Asset.Signs.speedLimitCompUS20
            case 30:
                return Asset.Signs.speedLimitCompUS30
            case 40:
                return Asset.Signs.speedLimitCompUS40
            case 50:
                return Asset.Signs.speedLimitCompUS50
            case 60:
                return Asset.Signs.speedLimitCompUS60
            case 70:
                return Asset.Signs.speedLimitCompUS70
            case 80:
                return Asset.Signs.speedLimitCompUS80
            case 90:
                return Asset.Signs.speedLimitCompUS90
            default: return nil
            }
        case .speedLimitExit:
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
        case .speedLimitRamp:
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
        case .warningTurnLeft:
            return Asset.Signs.warningTurnLeftUS
        case .warningTurnRight:
            return Asset.Signs.warningTurnRightUS
        case .warningHairpinCurveLeft:
            return Asset.Signs.warningHairpinCurveLeftUS
        case .warningRoundabout:
            return Asset.Signs.warningRoundaboutUS
        case .warningSpeedBump:
            return Asset.Signs.warningSpeedBumpUS
        case .warningWindingRoad:
            return Asset.Signs.warningWindingRoadUS
        case .informationBikeRoute:
            return Asset.Signs.informationBikeRouteUS
        case .informationParking:
            return Asset.Signs.informationParkingUS
        case .regulatoryAllDirectionsPermitted:
            return Asset.Signs.regulatoryAllDirectionsPermittedUS
        case .regulatoryBicyclesOnly:
            return Asset.Signs.regulatoryBicyclesOnlyUS
        case .regulatoryDoNotPass:
            return Asset.Signs.regulatoryDoNotPassUS
        case .regulatoryDoNotDriveOnShoulder:
            return Asset.Signs.regulatoryDoNotDriveOnShoulderUS
        case .regulatoryDualLanesAllDirectionsOnRight:
            return Asset.Signs.regulatoryDualLanesAllDirectionsOnRightUS
        case .regulatoryDualLanesGoLeftOrRight:
            return Asset.Signs.regulatoryDualLanesGoLeftOrRightUS
        case .regulatoryDualLanesGoStraightOnLeft:
            return Asset.Signs.regulatoryDualLanesGoStraightOnLeftUS
        case .regulatoryDualLanesGoStraightOnRight:
            return Asset.Signs.regulatoryDualLanesGoStraightOnRightUS
        case .regulatoryDualLanesTurnLeft:
            return Asset.Signs.regulatoryDualLanesTurnLeftUS
        case .regulatoryDualLanesTurnLeftOrStraight:
            return Asset.Signs.regulatoryDualLanesTurnLeftOrStraightUS
        case .regulatoryDualLanesTurnRightOrStraight:
            return Asset.Signs.regulatoryDualLanesTurnRightOrStraightUS
        case .regulatoryEndOfSchoolZone:
            return Asset.Signs.regulatoryEndOfSchoolZoneUS
        case .regulatoryGoStraight:
            return Asset.Signs.regulatoryGoStraightUS
        case .regulatoryGoStraightOrTurnLeft:
            return Asset.Signs.regulatoryGoStraightOrTurnLeftUS
        case .regulatoryGoStraightOrTurnRight:
            return Asset.Signs.regulatoryGoStraightOrTurnRightUS
        case .regulatoryHeightLimit:
            return Asset.Signs.regulatoryHeightLimitUS
        case .regulatoryLeftTurnYieldOnGreen:
            return Asset.Signs.regulatoryLeftTurnYieldOnGreenUS
        case .regulatoryNoBicycles:
            return Asset.Signs.regulatoryNoBicyclesUS
        case .regulatoryNoEntry:
            return Asset.Signs.regulatoryNoEntryUS
        case .regulatoryNoLeftOrUTurn:
            return Asset.Signs.regulatoryNoLeftOrUTurnUS
        case .regulatoryNoLeftTurn:
            return Asset.Signs.regulatoryNoLeftTurnUS
        case .regulatoryNoMotorVehicles:
            return Asset.Signs.regulatoryNoMotorVehiclesUS
        case .regulatoryNoParking:
            return Asset.Signs.regulatoryNoParkingUS
        case .regulatoryNoParkingOrNoStopping:
            return Asset.Signs.regulatoryNoParkingOrNoStoppingUS
        case .regulatoryNoPedestrians:
            return Asset.Signs.regulatoryNoPedestriansUS
        case .regulatoryNoRightTurn:
            return Asset.Signs.regulatoryNoRightTurnUS
        case .regulatoryNoStopping:
            return Asset.Signs.regulatoryNoStoppingUS
        case .regulatoryNoStraightThrough:
            return Asset.Signs.regulatoryNoStraightThroughUS
        case .regulatoryNoUTurn:
            return Asset.Signs.regulatoryNoUTurnUS
        case .regulatoryOneWayStraight:
            return Asset.Signs.regulatoryOneWayStraightUS
        case .regulatoryReversibleLanes:
            return Asset.Signs.regulatoryReversibleLanesUS
        case .regulatoryRoadClosedToVehicles:
            return Asset.Signs.regulatoryRoadClosedToVehiclesUS
        case .regulatoryStop:
            return Asset.Signs.regulatoryStopUS
        case .regulatoryTrafficSignalPhotoEnforced:
            return Asset.Signs.regulatoryTrafficSignalPhotoEnforcedUS
        case .regulatoryTripleLanesGoStraightCenterLane:
            return Asset.Signs.regulatoryTripleLanesGoStraightCenterLaneUS
        case .warningBicyclesCrossing:
            return Asset.Signs.warningBicyclesCrossingUS
        case .warningHeightRestriction:
            return Asset.Signs.warningHeightRestrictionUS
        case .warningPassLeftOrRight:
            return Asset.Signs.warningPassLeftOrRightUS
        case .warningPedestriansCrossing:
            return Asset.Signs.warningPedestriansCrossingUS
        case .warningRoadNarrowsLeft:
            return Asset.Signs.warningRoadNarrowsLeftUS
        case .warningRoadNarrowsRight:
            return Asset.Signs.warningRoadNarrowsRightUS
        case .warningSchoolZone:
            return Asset.Signs.warningSchoolZoneUS
        case .warningStopAhead:
            return Asset.Signs.warningStopAheadUS
        case .warningTrafficSignals:
            return Asset.Signs.warningTrafficSignalsUS
        case .warningTwoWayTraffic:
            return Asset.Signs.warningTwoWayTrafficUS
        case .warningYieldAhead:
            return Asset.Signs.warningYieldAheadUS
        case .informationHighway:
            return Asset.Signs.informationHighwayUS
        case .regulatoryDoNotBlockIntersection:
            return Asset.Signs.regulatoryDoNotBlockIntersectionUS
        case .regulatoryKeepRightPicture:
            return Asset.Signs.regulatoryKeepRightPictureUS
        case .regulatoryKeepRightText:
            return Asset.Signs.regulatoryKeepRightTextUS
        case .regulatoryNoHeavyGoodsVehiclesPicture:
            return Asset.Signs.regulatoryNoHeavyGoodsVehiclesPictureUS
        case .regulatoryNoLeftTurnText:
            return Asset.Signs.regulatoryNoLeftTurnTextUS
        case .regulatoryOneWayLeftArrow:
            return Asset.Signs.regulatoryOneWayLeftArrowUS
        case .regulatoryOneWayLeftArrowText:
            return Asset.Signs.regulatoryOneWayLeftArrowTextUS
        case .regulatoryOneWayLeftText:
            return Asset.Signs.regulatoryOneWayLeftTextUS
        case .regulatoryOneWayRightArrow:
            return Asset.Signs.regulatoryOneWayRightArrowUS
        case .regulatoryOneWayRightArrowText:
            return Asset.Signs.regulatoryOneWayRightArrowTextUS
        case .regulatoryOneWayRightText:
            return Asset.Signs.regulatoryOneWayRightTextUS
        case .regulatoryTurnLeftAhead:
            return Asset.Signs.regulatoryTurnLeftAheadUS
        case .regulatoryTurnLeft:
            return Asset.Signs.regulatoryTurnLeftUS
        case .regulatoryTurnLeftOrRight:
            return Asset.Signs.regulatoryTurnLeftOrRightUS
        case .regulatoryTurnRightAhead:
            return Asset.Signs.regulatoryTurnRightAheadUS
        case .regulatoryYield:
            return Asset.Signs.regulatoryYieldUS
        case .warningRailwayCrossing:
            return Asset.Signs.warningRailwayCrossingUS
        case .warningHairpinCurveRight:
            return Asset.Signs.warningHairpinCurveRightUS
        case .complementaryOneDirectionLeft:
            return Asset.Signs.complementaryOneDirectionLeftUS
        case .complementaryOneDirectionRight:
            return Asset.Signs.complementaryOneDirectionRightUS
        case .warningCurveLeft:
            return Asset.Signs.warningCurveLeftUS
        case .warningCurveRight:
            return Asset.Signs.warningCurveRightUS
        case .warningHorizontalAlignmentLeft:
            return Asset.Signs.warningHorizontalAlignmentLeftUS
        case .warningHorizontalAlignmentRight:
            return Asset.Signs.warningHorizontalAlignmentRightUS
        case .regulatoryTurnRight:
            return Asset.Signs.regulatoryTurnRightUS
        case .whiteTablesText:
            return Asset.Signs.whiteTablesTextUS
        case .lanes:
            return Asset.Signs.lanesUS
        case .greenPlates:
            return Asset.Signs.greenPlatesUS
        case .warningText:
            return Asset.Signs.warningTextUS
        case .warningCrossroads:
            return Asset.Signs.warningCrossroadsUS
        case .warningPicture:
            return Asset.Signs.warningPictureUS
        case .complementaryKeepLeft:
            return Asset.Signs.complementaryKeepLeftUS
        case .complementaryKeepRight:
            return Asset.Signs.complementaryKeepRightUS
        case .regulatoryExceptBicycle:
            return Asset.Signs.regulatoryExceptBicycleUS
        case .warningAddedLaneRight:
            return Asset.Signs.warningAddedLaneRightUS
        case .warningDeadEndText:
            return Asset.Signs.warningDeadEndTextUS
        case .warningDipText:
            return Asset.Signs.warningDipTextUS
        case .warningEmergencyVehicles:
            return Asset.Signs.warningEmergencyVehiclesUS
        case .warningEndText:
            return Asset.Signs.warningEndTextUS
        case .warningFallingRocksOrDebrisRight:
            return Asset.Signs.warningFallingRocksOrDebrisRightUS
        case .warningLowGroundClearance:
            return Asset.Signs.warningLowGroundClearanceUS
        case .warningObstructionMarker:
            return Asset.Signs.warningObstructionMarkerUS
        case .warningPlayground:
            return Asset.Signs.warningPlaygroundUS
        case .warningSecondRoadRight:
            return Asset.Signs.warningSecondRoadRightUS
        case .warningTurnLeftOnlyArrow:
            return Asset.Signs.warningTurnLeftOnlyArrowUS
        case .warningTurnLeftOrRightOnlyArrow:
            return Asset.Signs.warningTurnLeftOrRightOnlyArrowUS
        case .warningTramsCrossing:
            return Asset.Signs.warningTramsCrossingUS
        case .warningUnevenRoad:
            return Asset.Signs.warningUnevenRoadUS
        case .warningWildAnimals:
            return Asset.Signs.warningWildAnimalsUS
        case .regulatoryParkingRestrictions:
            return Asset.Signs.regulatoryParkingRestrictionsUS
        case .regulatoryYieldOrStopForPedestrians:
            return Asset.Signs.regulatoryYieldOrStopForPedestriansUS
        }
    }
}
