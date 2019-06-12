import Foundation
import MapboxVision

extension Sign {
    func icon(over: Bool, country: Country) -> ImageAsset? {
        let asset = getIcon(over, country)
        assert(asset != nil || country == .unknown, "Icon for \(self) with over: \(over) for country: \(country.rawValue) is not found")
        return asset
    }
    
    private func getIcon(_ over: Bool, _ country: Country) -> ImageAsset? {
        switch country {
        case .USA:
            switch type {
            case .unknown:
                return nil
            case .mass:
                return nil
            case .speedLimit:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitUS5Over : Asset.Signs.speedLimitUS5
                case 15:
                    return over ? Asset.Signs.speedLimitUS15Over : Asset.Signs.speedLimitUS15
                case 25:
                    return over ? Asset.Signs.speedLimitUS25Over : Asset.Signs.speedLimitUS25
                case 35:
                    return over ? Asset.Signs.speedLimitUS35Over : Asset.Signs.speedLimitUS35
                case 45:
                    return over ? Asset.Signs.speedLimitUS45Over : Asset.Signs.speedLimitUS45
                case 55:
                    return over ? Asset.Signs.speedLimitUS55Over : Asset.Signs.speedLimitUS55
                case 65:
                    return over ? Asset.Signs.speedLimitUS65Over : Asset.Signs.speedLimitUS65
                case 75:
                    return over ? Asset.Signs.speedLimitUS75Over : Asset.Signs.speedLimitUS75
                case 10:
                    return over ? Asset.Signs.speedLimitUS10Over : Asset.Signs.speedLimitUS10
                case 20:
                    return over ? Asset.Signs.speedLimitUS20Over : Asset.Signs.speedLimitUS20
                case 30:
                    return over ? Asset.Signs.speedLimitUS30Over : Asset.Signs.speedLimitUS30
                case 40:
                    return over ? Asset.Signs.speedLimitUS40Over : Asset.Signs.speedLimitUS40
                case 50:
                    return over ? Asset.Signs.speedLimitUS50Over : Asset.Signs.speedLimitUS50
                case 60:
                    return over ? Asset.Signs.speedLimitUS60Over : Asset.Signs.speedLimitUS60
                case 70:
                    return over ? Asset.Signs.speedLimitUS70Over : Asset.Signs.speedLimitUS70
                case 80:
                    return over ? Asset.Signs.speedLimitUS80Over : Asset.Signs.speedLimitUS80
                case 85:
                    return over ? Asset.Signs.speedLimitUS85Over : Asset.Signs.speedLimitUS85
                case 90:
                    return over ? Asset.Signs.speedLimitUS90Over : Asset.Signs.speedLimitUS90
                default: return nil
                }
            case .speedLimitEnd:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitEndUS5Over : Asset.Signs.speedLimitEndUS5
                case 15:
                    return over ? Asset.Signs.speedLimitEndUS15Over : Asset.Signs.speedLimitEndUS15
                case 25:
                    return over ? Asset.Signs.speedLimitEndUS25Over : Asset.Signs.speedLimitEndUS25
                case 35:
                    return over ? Asset.Signs.speedLimitEndUS35Over : Asset.Signs.speedLimitEndUS35
                case 45:
                    return over ? Asset.Signs.speedLimitEndUS45Over : Asset.Signs.speedLimitEndUS45
                case 55:
                    return over ? Asset.Signs.speedLimitEndUS55Over : Asset.Signs.speedLimitEndUS55
                case 65:
                    return over ? Asset.Signs.speedLimitEndUS65Over : Asset.Signs.speedLimitEndUS65
                case 75:
                    return over ? Asset.Signs.speedLimitEndUS75Over : Asset.Signs.speedLimitEndUS75
                case 10:
                    return over ? Asset.Signs.speedLimitEndUS10Over : Asset.Signs.speedLimitEndUS10
                case 20:
                    return over ? Asset.Signs.speedLimitEndUS20Over : Asset.Signs.speedLimitEndUS20
                case 30:
                    return over ? Asset.Signs.speedLimitEndUS30Over : Asset.Signs.speedLimitEndUS30
                case 40:
                    return over ? Asset.Signs.speedLimitEndUS40Over : Asset.Signs.speedLimitEndUS40
                case 50:
                    return over ? Asset.Signs.speedLimitEndUS50Over : Asset.Signs.speedLimitEndUS50
                case 60:
                    return over ? Asset.Signs.speedLimitEndUS60Over : Asset.Signs.speedLimitEndUS60
                case 70:
                    return over ? Asset.Signs.speedLimitEndUS70Over : Asset.Signs.speedLimitEndUS70
                case 80:
                    return over ? Asset.Signs.speedLimitEndUS80Over : Asset.Signs.speedLimitEndUS80
                case 85:
                    return over ? Asset.Signs.speedLimitEndUS85Over : Asset.Signs.speedLimitEndUS85
                case 90:
                    return over ? Asset.Signs.speedLimitEndUS90Over : Asset.Signs.speedLimitEndUS90
                default: return nil
                }
            case .speedLimitMin:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitMinUS5Over : Asset.Signs.speedLimitMinUS5
                case 15:
                    return over ? Asset.Signs.speedLimitMinUS15Over : Asset.Signs.speedLimitMinUS15
                case 25:
                    return over ? Asset.Signs.speedLimitMinUS25Over : Asset.Signs.speedLimitMinUS25
                case 35:
                    return over ? Asset.Signs.speedLimitMinUS35Over : Asset.Signs.speedLimitMinUS35
                case 45:
                    return over ? Asset.Signs.speedLimitMinUS45Over : Asset.Signs.speedLimitMinUS45
                case 55:
                    return over ? Asset.Signs.speedLimitMinUS55Over : Asset.Signs.speedLimitMinUS55
                case 65:
                    return over ? Asset.Signs.speedLimitMinUS65Over : Asset.Signs.speedLimitMinUS65
                case 75:
                    return over ? Asset.Signs.speedLimitMinUS75Over : Asset.Signs.speedLimitMinUS75
                case 10:
                    return over ? Asset.Signs.speedLimitMinUS10Over : Asset.Signs.speedLimitMinUS10
                case 20:
                    return over ? Asset.Signs.speedLimitMinUS20Over : Asset.Signs.speedLimitMinUS20
                case 30:
                    return over ? Asset.Signs.speedLimitMinUS30Over : Asset.Signs.speedLimitMinUS30
                case 40:
                    return over ? Asset.Signs.speedLimitMinUS40Over : Asset.Signs.speedLimitMinUS40
                case 50:
                    return over ? Asset.Signs.speedLimitMinUS50Over : Asset.Signs.speedLimitMinUS50
                case 60:
                    return over ? Asset.Signs.speedLimitMinUS60Over : Asset.Signs.speedLimitMinUS60
                case 70:
                    return over ? Asset.Signs.speedLimitMinUS70Over : Asset.Signs.speedLimitMinUS70
                case 80:
                    return over ? Asset.Signs.speedLimitMinUS80Over : Asset.Signs.speedLimitMinUS80
                case 85:
                    return over ? Asset.Signs.speedLimitMinUS85Over : Asset.Signs.speedLimitMinUS85
                case 90:
                    return over ? Asset.Signs.speedLimitMinUS90Over : Asset.Signs.speedLimitMinUS90
                default: return nil
                }
            case .speedLimitTrucks:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitTrucksUS5Over : Asset.Signs.speedLimitTrucksUS5
                case 15:
                    return over ? Asset.Signs.speedLimitTrucksUS15Over : Asset.Signs.speedLimitTrucksUS15
                case 25:
                    return over ? Asset.Signs.speedLimitTrucksUS25Over : Asset.Signs.speedLimitTrucksUS25
                case 35:
                    return over ? Asset.Signs.speedLimitTrucksUS35Over : Asset.Signs.speedLimitTrucksUS35
                case 45:
                    return over ? Asset.Signs.speedLimitTrucksUS45Over : Asset.Signs.speedLimitTrucksUS45
                case 55:
                    return over ? Asset.Signs.speedLimitTrucksUS55Over : Asset.Signs.speedLimitTrucksUS55
                case 65:
                    return over ? Asset.Signs.speedLimitTrucksUS65Over : Asset.Signs.speedLimitTrucksUS65
                case 75:
                    return over ? Asset.Signs.speedLimitTrucksUS75Over : Asset.Signs.speedLimitTrucksUS75
                case 10:
                    return over ? Asset.Signs.speedLimitTrucksUS10Over : Asset.Signs.speedLimitTrucksUS10
                case 20:
                    return over ? Asset.Signs.speedLimitTrucksUS20Over : Asset.Signs.speedLimitTrucksUS20
                case 30:
                    return over ? Asset.Signs.speedLimitTrucksUS30Over : Asset.Signs.speedLimitTrucksUS30
                case 40:
                    return over ? Asset.Signs.speedLimitTrucksUS40Over : Asset.Signs.speedLimitTrucksUS40
                case 50:
                    return over ? Asset.Signs.speedLimitTrucksUS50Over : Asset.Signs.speedLimitTrucksUS50
                case 60:
                    return over ? Asset.Signs.speedLimitTrucksUS60Over : Asset.Signs.speedLimitTrucksUS60
                case 70:
                    return over ? Asset.Signs.speedLimitTrucksUS70Over : Asset.Signs.speedLimitTrucksUS70
                case 80:
                    return over ? Asset.Signs.speedLimitTrucksUS80Over : Asset.Signs.speedLimitTrucksUS80
                case 85:
                    return over ? Asset.Signs.speedLimitTrucksUS85Over : Asset.Signs.speedLimitTrucksUS85
                case 90:
                    return over ? Asset.Signs.speedLimitTrucksUS90Over : Asset.Signs.speedLimitTrucksUS90
                default: return nil
                }
            case .speedLimitNight:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitNightUS5Over : Asset.Signs.speedLimitNightUS5
                case 15:
                    return over ? Asset.Signs.speedLimitNightUS15Over : Asset.Signs.speedLimitNightUS15
                case 25:
                    return over ? Asset.Signs.speedLimitNightUS25Over : Asset.Signs.speedLimitNightUS25
                case 35:
                    return over ? Asset.Signs.speedLimitNightUS35Over : Asset.Signs.speedLimitNightUS35
                case 45:
                    return over ? Asset.Signs.speedLimitNightUS45Over : Asset.Signs.speedLimitNightUS45
                case 55:
                    return over ? Asset.Signs.speedLimitNightUS55Over : Asset.Signs.speedLimitNightUS55
                case 65:
                    return over ? Asset.Signs.speedLimitNightUS65Over : Asset.Signs.speedLimitNightUS65
                case 75:
                    return over ? Asset.Signs.speedLimitNightUS75Over : Asset.Signs.speedLimitNightUS75
                case 10:
                    return over ? Asset.Signs.speedLimitNightUS10Over : Asset.Signs.speedLimitNightUS10
                case 20:
                    return over ? Asset.Signs.speedLimitNightUS20Over : Asset.Signs.speedLimitNightUS20
                case 30:
                    return over ? Asset.Signs.speedLimitNightUS30Over : Asset.Signs.speedLimitNightUS30
                case 40:
                    return over ? Asset.Signs.speedLimitNightUS40Over : Asset.Signs.speedLimitNightUS40
                case 50:
                    return over ? Asset.Signs.speedLimitNightUS50Over : Asset.Signs.speedLimitNightUS50
                case 60:
                    return over ? Asset.Signs.speedLimitNightUS60Over : Asset.Signs.speedLimitNightUS60
                case 70:
                    return over ? Asset.Signs.speedLimitNightUS70Over : Asset.Signs.speedLimitNightUS70
                case 80:
                    return over ? Asset.Signs.speedLimitNightUS80Over : Asset.Signs.speedLimitNightUS80
                case 85:
                    return over ? Asset.Signs.speedLimitNightUS85Over : Asset.Signs.speedLimitNightUS85
                case 90:
                    return over ? Asset.Signs.speedLimitNightUS90Over : Asset.Signs.speedLimitNightUS90
                default: return nil
                }
            case .speedLimitComplementary:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitCompUS5Over : Asset.Signs.speedLimitCompUS5
                case 15:
                    return over ? Asset.Signs.speedLimitCompUS15Over : Asset.Signs.speedLimitCompUS15
                case 25:
                    return over ? Asset.Signs.speedLimitCompUS25Over : Asset.Signs.speedLimitCompUS25
                case 35:
                    return over ? Asset.Signs.speedLimitCompUS35Over : Asset.Signs.speedLimitCompUS35
                case 45:
                    return over ? Asset.Signs.speedLimitCompUS45Over : Asset.Signs.speedLimitCompUS45
                case 55:
                    return over ? Asset.Signs.speedLimitCompUS55Over : Asset.Signs.speedLimitCompUS55
                case 65:
                    return over ? Asset.Signs.speedLimitCompUS65Over : Asset.Signs.speedLimitCompUS65
                case 75:
                    return over ? Asset.Signs.speedLimitCompUS75Over : Asset.Signs.speedLimitCompUS75
                case 85:
                    return over ? Asset.Signs.speedLimitCompUS85Over : Asset.Signs.speedLimitCompUS85
                case 10:
                    return over ? Asset.Signs.speedLimitCompUS10Over : Asset.Signs.speedLimitCompUS10
                case 20:
                    return over ? Asset.Signs.speedLimitCompUS20Over : Asset.Signs.speedLimitCompUS20
                case 30:
                    return over ? Asset.Signs.speedLimitCompUS30Over : Asset.Signs.speedLimitCompUS30
                case 40:
                    return over ? Asset.Signs.speedLimitCompUS40Over : Asset.Signs.speedLimitCompUS40
                case 50:
                    return over ? Asset.Signs.speedLimitCompUS50Over : Asset.Signs.speedLimitCompUS50
                case 60:
                    return over ? Asset.Signs.speedLimitCompUS60Over : Asset.Signs.speedLimitCompUS60
                case 70:
                    return over ? Asset.Signs.speedLimitCompUS70Over : Asset.Signs.speedLimitCompUS70
                case 80:
                    return over ? Asset.Signs.speedLimitCompUS80Over : Asset.Signs.speedLimitCompUS80
                case 90:
                    return over ? Asset.Signs.speedLimitCompUS90Over : Asset.Signs.speedLimitCompUS90
                default: return nil
                }
            case .speedLimitExit:
                switch number {
                case 5:
                    return over ? Asset.Signs.warningExitUS5Over : Asset.Signs.warningExitUS5
                case 15:
                    return over ? Asset.Signs.warningExitUS15Over : Asset.Signs.warningExitUS15
                case 25:
                    return over ? Asset.Signs.warningExitUS25Over : Asset.Signs.warningExitUS25
                case 35:
                    return over ? Asset.Signs.warningExitUS35Over : Asset.Signs.warningExitUS35
                case 45:
                    return over ? Asset.Signs.warningExitUS45Over : Asset.Signs.warningExitUS45
                case 55:
                    return over ? Asset.Signs.warningExitUS55Over : Asset.Signs.warningExitUS55
                case 65:
                    return over ? Asset.Signs.warningExitUS65Over : Asset.Signs.warningExitUS65
                case 75:
                    return over ? Asset.Signs.warningExitUS75Over : Asset.Signs.warningExitUS75
                case 85:
                    return over ? Asset.Signs.warningExitUS85Over : Asset.Signs.warningExitUS85
                case 10:
                    return over ? Asset.Signs.warningExitUS10Over : Asset.Signs.warningExitUS10
                case 20:
                    return over ? Asset.Signs.warningExitUS20Over : Asset.Signs.warningExitUS20
                case 30:
                    return over ? Asset.Signs.warningExitUS30Over : Asset.Signs.warningExitUS30
                case 40:
                    return over ? Asset.Signs.warningExitUS40Over : Asset.Signs.warningExitUS40
                case 50:
                    return over ? Asset.Signs.warningExitUS50Over : Asset.Signs.warningExitUS50
                case 60:
                    return over ? Asset.Signs.warningExitUS60Over : Asset.Signs.warningExitUS60
                case 70:
                    return over ? Asset.Signs.warningExitUS70Over : Asset.Signs.warningExitUS70
                case 80:
                    return over ? Asset.Signs.warningExitUS80Over : Asset.Signs.warningExitUS80
                case 90:
                    return over ? Asset.Signs.warningExitUS90Over : Asset.Signs.warningExitUS90
                default: return nil
                }
            case .speedLimitRamp:
                switch number {
                case 5:
                    return over ? Asset.Signs.warningRampUS5Over : Asset.Signs.warningRampUS5
                case 15:
                    return over ? Asset.Signs.warningRampUS15Over : Asset.Signs.warningRampUS15
                case 25:
                    return over ? Asset.Signs.warningRampUS25Over : Asset.Signs.warningRampUS25
                case 35:
                    return over ? Asset.Signs.warningRampUS35Over : Asset.Signs.warningRampUS35
                case 45:
                    return over ? Asset.Signs.warningRampUS45Over : Asset.Signs.warningRampUS45
                case 55:
                    return over ? Asset.Signs.warningRampUS55Over : Asset.Signs.warningRampUS55
                case 65:
                    return over ? Asset.Signs.warningRampUS65Over : Asset.Signs.warningRampUS65
                case 75:
                    return over ? Asset.Signs.warningRampUS75Over : Asset.Signs.warningRampUS75
                case 85:
                    return over ? Asset.Signs.warningRampUS85Over : Asset.Signs.warningRampUS85
                case 10:
                    return over ? Asset.Signs.warningRampUS10Over : Asset.Signs.warningRampUS10
                case 20:
                    return over ? Asset.Signs.warningRampUS20Over : Asset.Signs.warningRampUS20
                case 30:
                    return over ? Asset.Signs.warningRampUS30Over : Asset.Signs.warningRampUS30
                case 40:
                    return over ? Asset.Signs.warningRampUS40Over : Asset.Signs.warningRampUS40
                case 50:
                    return over ? Asset.Signs.warningRampUS50Over : Asset.Signs.warningRampUS50
                case 60:
                    return over ? Asset.Signs.warningRampUS60Over : Asset.Signs.warningRampUS60
                case 70:
                    return over ? Asset.Signs.warningRampUS70Over : Asset.Signs.warningRampUS70
                case 80:
                    return over ? Asset.Signs.warningRampUS80Over : Asset.Signs.warningRampUS80
                case 90:
                    return over ? Asset.Signs.warningRampUS90Over : Asset.Signs.warningRampUS90
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
            default: return nil
            }
        case .china:
            switch type {
            case .unknown:
                return nil
            case .mass:
                switch number {
                case 5:
                    return Asset.Signs.mass5CN
                case 15:
                    return Asset.Signs.mass15CN
                case 25:
                    return Asset.Signs.mass25CN
                case 35:
                    return Asset.Signs.mass35CN
                case 45:
                    return Asset.Signs.mass45CN
                case 55:
                    return Asset.Signs.mass55CN
                case 65:
                    return Asset.Signs.mass65CN
                case 75:
                    return Asset.Signs.mass75CN
                case 85:
                    return Asset.Signs.mass85CN
                case 95:
                    return Asset.Signs.mass95CN
                case 105:
                    return Asset.Signs.mass105CN
                case 115:
                    return Asset.Signs.mass115CN
                case 10:
                    return Asset.Signs.mass10CN
                case 20:
                    return Asset.Signs.mass20CN
                case 30:
                    return Asset.Signs.mass30CN
                case 40:
                    return Asset.Signs.mass40CN
                case 50:
                    return Asset.Signs.mass50CN
                case 60:
                    return Asset.Signs.mass60CN
                case 70:
                    return Asset.Signs.mass70CN
                case 80:
                    return Asset.Signs.mass80CN
                case 90:
                    return Asset.Signs.mass90CN
                case 100:
                    return Asset.Signs.mass100CN
                case 110:
                    return Asset.Signs.mass110CN
                case 120:
                    return Asset.Signs.mass120CN
                default: return nil
                }
            case .speedLimit:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitCN5Over : Asset.Signs.speedLimitCN5
                case 15:
                    return over ? Asset.Signs.speedLimitCN15Over : Asset.Signs.speedLimitCN15
                case 25:
                    return over ? Asset.Signs.speedLimitCN25Over : Asset.Signs.speedLimitCN25
                case 35:
                    return over ? Asset.Signs.speedLimitCN35Over : Asset.Signs.speedLimitCN35
                case 45:
                    return over ? Asset.Signs.speedLimitCN45Over : Asset.Signs.speedLimitCN45
                case 55:
                    return over ? Asset.Signs.speedLimitCN55Over : Asset.Signs.speedLimitCN55
                case 65:
                    return over ? Asset.Signs.speedLimitCN65Over : Asset.Signs.speedLimitCN65
                case 75:
                    return over ? Asset.Signs.speedLimitCN75Over : Asset.Signs.speedLimitCN75
                case 85:
                    return over ? Asset.Signs.speedLimitCN85Over : Asset.Signs.speedLimitCN85
                case 95:
                    return over ? Asset.Signs.speedLimitCN95Over : Asset.Signs.speedLimitCN95
                case 105:
                    return over ? Asset.Signs.speedLimitCN105Over : Asset.Signs.speedLimitCN105
                case 115:
                    return over ? Asset.Signs.speedLimitCN115Over : Asset.Signs.speedLimitCN115
                case 125:
                    return over ? Asset.Signs.speedLimitCN125Over : Asset.Signs.speedLimitCN125
                case 10:
                    return over ? Asset.Signs.speedLimitCN10Over : Asset.Signs.speedLimitCN10
                case 20:
                    return over ? Asset.Signs.speedLimitCN20Over : Asset.Signs.speedLimitCN20
                case 30:
                    return over ? Asset.Signs.speedLimitCN30Over : Asset.Signs.speedLimitCN30
                case 40:
                    return over ? Asset.Signs.speedLimitCN40Over : Asset.Signs.speedLimitCN40
                case 50:
                    return over ? Asset.Signs.speedLimitCN50Over : Asset.Signs.speedLimitCN50
                case 60:
                    return over ? Asset.Signs.speedLimitCN60Over : Asset.Signs.speedLimitCN60
                case 70:
                    return over ? Asset.Signs.speedLimitCN70Over : Asset.Signs.speedLimitCN70
                case 80:
                    return over ? Asset.Signs.speedLimitCN80Over : Asset.Signs.speedLimitCN80
                case 90:
                    return over ? Asset.Signs.speedLimitCN90Over : Asset.Signs.speedLimitCN90
                case 100:
                    return over ? Asset.Signs.speedLimitCN100Over : Asset.Signs.speedLimitCN100
                case 110:
                    return over ? Asset.Signs.speedLimitCN110Over : Asset.Signs.speedLimitCN110
                case 120:
                    return over ? Asset.Signs.speedLimitCN120Over : Asset.Signs.speedLimitCN120
                case 130:
                    return over ? Asset.Signs.speedLimitCN130Over : Asset.Signs.speedLimitCN130
                default: return nil
                }
            case .speedLimitEnd:
                switch number {
                case 5:
                    return Asset.Signs.speedLimitEnd5CN
                case 15:
                    return Asset.Signs.speedLimitEnd15CN
                case 25:
                    return Asset.Signs.speedLimitEnd25CN
                case 35:
                    return Asset.Signs.speedLimitEnd35CN
                case 45:
                    return Asset.Signs.speedLimitEnd45CN
                case 55:
                    return Asset.Signs.speedLimitEnd55CN
                case 65:
                    return Asset.Signs.speedLimitEnd65CN
                case 75:
                    return Asset.Signs.speedLimitEnd75CN
                case 85:
                    return Asset.Signs.speedLimitEnd85CN
                case 95:
                    return Asset.Signs.speedLimitEnd95CN
                case 105:
                    return Asset.Signs.speedLimitEnd105CN
                case 115:
                    return Asset.Signs.speedLimitEnd115CN
                case 10:
                    return Asset.Signs.speedLimitEnd10CN
                case 20:
                    return Asset.Signs.speedLimitEnd20CN
                case 30:
                    return Asset.Signs.speedLimitEnd30CN
                case 40:
                    return Asset.Signs.speedLimitEnd40CN
                case 50:
                    return Asset.Signs.speedLimitEnd50CN
                case 60:
                    return Asset.Signs.speedLimitEnd60CN
                case 70:
                    return Asset.Signs.speedLimitEnd70CN
                case 80:
                    return Asset.Signs.speedLimitEnd80CN
                case 90:
                    return Asset.Signs.speedLimitEnd90CN
                case 100:
                    return Asset.Signs.speedLimitEnd100CN
                case 110:
                    return Asset.Signs.speedLimitEnd110CN
                case 120:
                    return Asset.Signs.speedLimitEnd120CN
                default: return nil
                }
            case .speedLimitMin:
                switch number {
                case 5:
                    return Asset.Signs.speedMinimum5CN
                case 10:
                    return Asset.Signs.speedMinimum10CN
                case 15:
                    return Asset.Signs.speedMinimum15CN
                case 20:
                    return Asset.Signs.speedMinimum20CN
                case 25:
                    return Asset.Signs.speedMinimum25CN
                case 30:
                    return Asset.Signs.speedMinimum30CN
                case 35:
                    return Asset.Signs.speedMinimum35CN
                case 40:
                    return Asset.Signs.speedMinimum40CN
                case 55:
                    return Asset.Signs.speedMinimum55CN
                case 60:
                    return Asset.Signs.speedMinimum60CN
                case 65:
                    return Asset.Signs.speedMinimum65CN
                case 70:
                    return Asset.Signs.speedMinimum70CN
                case 75:
                    return Asset.Signs.speedMinimum75CN
                case 80:
                    return Asset.Signs.speedMinimum80CN
                case 85:
                    return Asset.Signs.speedMinimum85CN
                case 90:
                    return Asset.Signs.speedMinimum90CN
                case 95:
                    return Asset.Signs.speedMinimum95CN
                case 100:
                    return Asset.Signs.speedMinimum100CN
                case 105:
                    return Asset.Signs.speedMinimum105CN
                case 110:
                    return Asset.Signs.speedMinimum110CN
                case 115:
                    return Asset.Signs.speedMinimum115CN
                case 120:
                    return Asset.Signs.speedMinimum120CN
                default: return nil
                }
            case .speedLimitTrucks:
                return nil
            case .speedLimitNight:
                return nil
            case .speedLimitComplementary:
                return nil
            case .speedLimitExit:
                return nil
            case .speedLimitRamp:
                return nil
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
                return Asset.Signs.warningWindingRoadCN
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
                return Asset.Signs.regulatoryGoStraightCN
            case .regulatoryGoStraightOrTurnLeft:
                return Asset.Signs.regulatoryGoStraightOrTurnLeftUS
            case .regulatoryGoStraightOrTurnRight:
                return Asset.Signs.regulatoryGoStraightOrTurnRightUS
            case .regulatoryHeightLimit:
                return Asset.Signs.regulatoryHeightLimitCN
            case .regulatoryLeftTurnYieldOnGreen:
                return Asset.Signs.regulatoryLeftTurnYieldOnGreenUS
            case .regulatoryNoBicycles:
                return Asset.Signs.regulatoryNoBicyclesUS
            case .regulatoryNoEntry:
                return Asset.Signs.regulatoryNoEntryCN
            case .regulatoryNoLeftOrUTurn:
                return Asset.Signs.regulatoryNoLeftOrUTurnUS
            case .regulatoryNoLeftTurn:
                return Asset.Signs.regulatoryNoLeftTurnCN
            case .regulatoryNoMotorVehicles:
                return Asset.Signs.regulatoryNoMotorVehiclesCN
            case .regulatoryNoParking:
                return Asset.Signs.regulatoryNoParkingCN
            case .regulatoryNoParkingOrNoStopping:
                return Asset.Signs.regulatoryNoParkingOrNoStoppingUS
            case .regulatoryNoPedestrians:
                return Asset.Signs.regulatoryNoPedestriansCN
            case .regulatoryNoRightTurn:
                return Asset.Signs.regulatoryNoRightTurnCN
            case .regulatoryNoStopping:
                return Asset.Signs.regulatoryNoStoppingUS
            case .regulatoryNoStraightThrough:
                return Asset.Signs.regulatoryNoStraightThroughCN
            case .regulatoryNoUTurn:
                return Asset.Signs.regulatoryNoUTurnCN
            case .regulatoryOneWayStraight:
                return Asset.Signs.regulatoryOneWayStraightUS
            case .regulatoryReversibleLanes:
                return Asset.Signs.regulatoryReversibleLanesUS
            case .regulatoryRoadClosedToVehicles:
                return Asset.Signs.regulatoryRoadClosedToVehiclesCN
            case .regulatoryStop:
                return Asset.Signs.regulatoryStopCN
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
                return Asset.Signs.warningPedestriansCrossingCN
            case .warningRoadNarrowsLeft:
                return Asset.Signs.warningRoadNarrowsLeftCN
            case .warningRoadNarrowsRight:
                return Asset.Signs.warningRoadNarrowsRightCN
            case .warningSchoolZone:
                return Asset.Signs.warningSchoolZoneCN
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
                return Asset.Signs.regulatoryNoHeavyGoodsVehiclesPictureCN
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
                return Asset.Signs.regulatoryTurnLeftCN
            case .regulatoryTurnLeftOrRight:
                return Asset.Signs.regulatoryTurnLeftOrTurnRightCN
            case .regulatoryTurnRightAhead:
                return Asset.Signs.regulatoryTurnRightAheadUS
            case .regulatoryYield:
                return Asset.Signs.regulatoryYieldCN
            case .warningRailwayCrossing:
                return Asset.Signs.warningRailwayCrossingUS
            case .warningHairpinCurveRight:
                return Asset.Signs.warningHairpinCurveRightUS
            case .complementaryOneDirectionLeft:
                return Asset.Signs.complementaryOneDirectionLeftUS
            case .complementaryOneDirectionRight:
                return Asset.Signs.complementaryOneDirectionRightUS
            case .warningCurveLeft:
                return Asset.Signs.warningCurveLeftCN
            case .warningCurveRight:
                return Asset.Signs.warningCurveRightCN
            case .warningHorizontalAlignmentLeft:
                return Asset.Signs.warningHorizontalAlignmentLeftUS
            case .warningHorizontalAlignmentRight:
                return Asset.Signs.warningHorizontalAlignmentRightUS
            case .regulatoryTurnRight:
                return Asset.Signs.regulatoryTurnRightCN
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
                return Asset.Signs.complementaryKeepRightCN
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
                return Asset.Signs.warningSecondRoadRightCN
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
            case .regulatoryNoBuses:
                return Asset.Signs.regulatoryNoBusesCN
            case .regulatoryNoMotorcyclesOrMopeds:
                return Asset.Signs.regulatoryNoMotorcyclesOrMopedsCN
            case .regulatoryNoTurnLeftOrTurnRight:
                return Asset.Signs.regulatoryNoTurnLeftOrTurnRightCN
            case .regulatoryNoOvertaking:
                return Asset.Signs.regulatoryNoOvertakingCN
            case .regulatoryNoHonking:
                return Asset.Signs.regulatoryNoHonkingCN
            case .regulatoryWidthLimit:
                return Asset.Signs.regulatoryWidthLimitCN
            case .regulatoryAxleWeightLimit:
                return Asset.Signs.regulatoryAxleWeightLimitCN
            case .regulatoryNoVehiclesCarryingExplosives:
                return Asset.Signs.regulatoryNoVehiclesCarryingExplosivesCN
            case .regulatoryRoundabout:
                return Asset.Signs.regulatoryRoundaboutCN
            case .regulatoryHonking:
                return Asset.Signs.regulatoryHonkingCN
            case .regulatoryPedestriansCrossing:
                return Asset.Signs.regulatoryPedestriansCrossingCN
            case .regulatoryMotorVehicles:
                return Asset.Signs.regulatoryMotorVehiclesCN
            case .regulatoryUTurn:
                return Asset.Signs.regulatoryUTurnCN
            case .regulatoryNoSmallPassengerCar:
                return Asset.Signs.regulatoryNoSmallPassengerCarCN;
            case .warningSteepAscent:
                return Asset.Signs.warningSteepAscentCN
            case .warningSteepDescent:
                return Asset.Signs.warningSteepDescentCN
            case .warningVillage:
                return Asset.Signs.warningVillageCN
            case .warningKeepSlowdown:
                return Asset.Signs.warningKeepSlowdownCN
            case .warningDangerousTraffic:
                return Asset.Signs.warningDangerousTrafficCN
            case .warningRoadworks:
                return Asset.Signs.warningRoadworksCN
            case .warningSecondRoadLeft:
                return Asset.Signs.warningSecondRoadLeftCN
            default: return nil
            }
        case .UK, .other:
            switch type {
            case .unknown:
                return nil
            case .speedLimit:
                switch number {
                case 5: return over ? Asset.Signs.overSpeedLimit5EU : Asset.Signs.speedLimit5EU
                case 10: return over ? Asset.Signs.overSpeedLimit10EU : Asset.Signs.speedLimit10EU
                case 15: return over ? Asset.Signs.overSpeedLimit15EU : Asset.Signs.speedLimit15EU
                case 20: return over ? Asset.Signs.overSpeedLimit20EU : Asset.Signs.speedLimit20EU
                case 25: return over ? Asset.Signs.overSpeedLimit25EU : Asset.Signs.speedLimit25EU
                case 30: return over ? Asset.Signs.overSpeedLimit30EU : Asset.Signs.speedLimit30EU
                case 35: return over ? Asset.Signs.overSpeedLimit35EU : Asset.Signs.speedLimit35EU
                case 40: return over ? Asset.Signs.overSpeedLimit40EU : Asset.Signs.speedLimit40EU
                case 45: return over ? Asset.Signs.overSpeedLimit45EU : Asset.Signs.speedLimit45EU
                case 50: return over ? Asset.Signs.overSpeedLimit50EU : Asset.Signs.speedLimit50EU
                case 55: return over ? Asset.Signs.overSpeedLimit55EU : Asset.Signs.speedLimit55EU
                case 60: return over ? Asset.Signs.overSpeedLimit60EU : Asset.Signs.speedLimit60EU
                case 65: return over ? Asset.Signs.overSpeedLimit65EU : Asset.Signs.speedLimit65EU
                case 70: return over ? Asset.Signs.overSpeedLimit70EU : Asset.Signs.speedLimit70EU
                case 75: return over ? Asset.Signs.overSpeedLimit75EU : Asset.Signs.speedLimit75EU
                case 80: return over ? Asset.Signs.overSpeedLimit80EU : Asset.Signs.speedLimit80EU
                case 85: return over ? Asset.Signs.overSpeedLimit85EU : Asset.Signs.speedLimit85EU
                case 90: return over ? Asset.Signs.overSpeedLimit90EU : Asset.Signs.speedLimit90EU
                case 95: return over ? Asset.Signs.overSpeedLimit95EU : Asset.Signs.speedLimit95EU
                case 100: return over ? Asset.Signs.overSpeedLimit100EU : Asset.Signs.speedLimit100EU
                case 105: return over ? Asset.Signs.overSpeedLimit105EU : Asset.Signs.speedLimit105EU
                case 110: return over ? Asset.Signs.overSpeedLimit110EU : Asset.Signs.speedLimit110EU
                case 115: return over ? Asset.Signs.overSpeedLimit115EU : Asset.Signs.speedLimit115EU
                case 120: return over ? Asset.Signs.overSpeedLimit120EU : Asset.Signs.speedLimit120EU
                default: return nil
                }
            case .speedLimitEnd:
                switch number {
                case 5: return Asset.Signs.speedLimitEnd5EU
                case 10: return Asset.Signs.speedLimitEnd10EU
                case 15: return Asset.Signs.speedLimitEnd15EU
                case 20: return Asset.Signs.speedLimitEnd20EU
                case 25: return Asset.Signs.speedLimitEnd25EU
                case 30: return Asset.Signs.speedLimitEnd30EU
                case 35: return Asset.Signs.speedLimitEnd35EU
                case 40: return Asset.Signs.speedLimitEnd40EU
                case 45: return Asset.Signs.speedLimitEnd45EU
                case 50: return Asset.Signs.speedLimitEnd50EU
                case 55: return Asset.Signs.speedLimitEnd55EU
                case 60: return Asset.Signs.speedLimitEnd60EU
                case 65: return Asset.Signs.speedLimitEnd65EU
                case 70: return Asset.Signs.speedLimitEnd70EU
                case 75: return Asset.Signs.speedLimitEnd75EU
                case 80: return Asset.Signs.speedLimitEnd80EU
                case 85: return Asset.Signs.speedLimitEnd85EU
                case 90: return Asset.Signs.speedLimitEnd90EU
                case 95: return Asset.Signs.speedLimitEnd95EU
                case 100: return Asset.Signs.speedLimitEnd100EU
                case 105: return Asset.Signs.speedLimitEnd105EU
                case 110: return Asset.Signs.speedLimitEnd110EU
                case 115: return Asset.Signs.speedLimitEnd115EU
                case 120: return Asset.Signs.speedLimitEnd120EU
                default: return nil
                }
            case .speedLimitMin:
                switch number {
                case 5: return Asset.Signs.speedLimitMin5EU
                case 10: return Asset.Signs.speedLimitMin10EU
                case 15: return Asset.Signs.speedLimitMin15EU
                case 20: return Asset.Signs.speedLimitMin20EU
                case 25: return Asset.Signs.speedLimitMin25EU
                case 30: return Asset.Signs.speedLimitMin30EU
                case 35: return Asset.Signs.speedLimitMin35EU
                case 40: return Asset.Signs.speedLimitMin40EU
                case 45: return Asset.Signs.speedLimitMin45EU
                case 50: return Asset.Signs.speedLimitMin50EU
                case 55: return Asset.Signs.speedLimitMin55EU
                case 60: return Asset.Signs.speedLimitMin60EU
                case 65: return Asset.Signs.speedLimitMin65EU
                case 70: return Asset.Signs.speedLimitMin70EU
                case 75: return Asset.Signs.speedLimitMin75EU
                case 80: return Asset.Signs.speedLimitMin80EU
                case 85: return Asset.Signs.speedLimitMin85EU
                case 90: return Asset.Signs.speedLimitMin90EU
                case 95: return Asset.Signs.speedLimitMin95EU
                case 100: return Asset.Signs.speedLimitMin100EU
                case 105: return Asset.Signs.speedLimitMin105EU
                case 110: return Asset.Signs.speedLimitMin110EU
                case 115: return Asset.Signs.speedLimitMin115EU
                case 120: return Asset.Signs.speedLimitMin120EU
                default: return nil
                }
            case .speedLimitAdvMax:
                switch number {
                case 5: return Asset.Signs.speedLimitAdvMax5EU
                case 10: return Asset.Signs.speedLimitAdvMax10EU
                case 15: return Asset.Signs.speedLimitAdvMax15EU
                case 20: return Asset.Signs.speedLimitAdvMax20EU
                case 25: return Asset.Signs.speedLimitAdvMax25EU
                case 30: return Asset.Signs.speedLimitAdvMax30EU
                case 35: return Asset.Signs.speedLimitAdvMax35EU
                case 40: return Asset.Signs.speedLimitAdvMax40EU
                case 45: return Asset.Signs.speedLimitAdvMax45EU
                case 50: return Asset.Signs.speedLimitAdvMax50EU
                case 55: return Asset.Signs.speedLimitAdvMax55EU
                case 60: return Asset.Signs.speedLimitAdvMax60EU
                case 65: return Asset.Signs.speedLimitAdvMax65EU
                case 70: return Asset.Signs.speedLimitAdvMax70EU
                case 75: return Asset.Signs.speedLimitAdvMax75EU
                case 80: return Asset.Signs.speedLimitAdvMax80EU
                case 85: return Asset.Signs.speedLimitAdvMax85EU
                case 90: return Asset.Signs.speedLimitAdvMax90EU
                case 95: return Asset.Signs.speedLimitAdvMax95EU
                case 100: return Asset.Signs.speedLimitAdvMax100EU
                case 105: return Asset.Signs.speedLimitAdvMax115EU
                case 110: return Asset.Signs.speedLimitAdvMax110EU
                case 115: return Asset.Signs.speedLimitAdvMax115EU
                case 120: return Asset.Signs.speedLimitAdvMax120EU
                default: return nil
                }
            case .speedLimitEndAdv:
                switch number {
                case 5: return Asset.Signs.speedLimitEndAdv5EU
                case 10: return Asset.Signs.speedLimitEndAdv10EU
                case 15: return Asset.Signs.speedLimitEndAdv15EU
                case 20: return Asset.Signs.speedLimitEndAdv20EU
                case 25: return Asset.Signs.speedLimitEndAdv25EU
                case 30: return Asset.Signs.speedLimitEndAdv30EU
                case 35: return Asset.Signs.speedLimitEndAdv35EU
                case 40: return Asset.Signs.speedLimitEndAdv40EU
                case 45: return Asset.Signs.speedLimitEndAdv45EU
                case 50: return Asset.Signs.speedLimitEndAdv50EU
                case 55: return Asset.Signs.speedLimitEndAdv55EU
                case 60: return Asset.Signs.speedLimitEndAdv60EU
                case 65: return Asset.Signs.speedLimitEndAdv65EU
                case 70: return Asset.Signs.speedLimitEndAdv70EU
                case 75: return Asset.Signs.speedLimitEndAdv75EU
                case 80: return Asset.Signs.speedLimitEndAdv80EU
                case 85: return Asset.Signs.speedLimitEndAdv85EU
                case 90: return Asset.Signs.speedLimitEndAdv90EU
                case 95: return Asset.Signs.speedLimitEndAdv95EU
                case 100: return Asset.Signs.speedLimitEndAdv100EU
                case 105: return Asset.Signs.speedLimitEndAdv115EU
                case 110: return Asset.Signs.speedLimitEndAdv110EU
                case 115: return Asset.Signs.speedLimitEndAdv115EU
                case 120: return Asset.Signs.speedLimitEndAdv120EU
                default: return nil
                }
            case .complementaryKeepLeft:
                return Asset.Signs.complementaryKeepLeftEU
            case .complementaryKeepRight:
                return Asset.Signs.complementaryKeepRightEU
            case .informationHospital:
                return Asset.Signs.informationHospitalEU
            case .informationLivingStreet:
                if country == .UK {
                    return Asset.Signs.informationLivingStreetUK
                } else if country == .other {
                    return Asset.Signs.informationLivingStreetEU
                } else {
                    return nil
                }
            case .informationParking:
                return Asset.Signs.informationParkingEU
            case .regulatoryAxleWeightLimit:
                return Asset.Signs.regulatoryAxleWeightLimitEU
            case .regulatoryBicyclesOnly:
                return Asset.Signs.regulatoryBicyclesOnlyEU
            case .regulatoryBusLane:
                return Asset.Signs.regulatoryBusLaneEU
            case .regulatoryDualLanesTurnLeftOrStraight:
                return Asset.Signs.regulatoryDualLanesTurnLeftOrStraightEU
            case .regulatoryDualLanesTurnRightOrStraight:
                return Asset.Signs.regulatoryDualLanesTurnRightOrStraightEU
            case .regulatoryEndLimitedAccessRoad:
                return Asset.Signs.regulatoryEndLimitedAccessRoadEU
            case .regulatoryEndMotorway:
                if country == .UK {
                    return Asset.Signs.regulatoryEndMotorwayUK
                } else if country == .other {
                    return Asset.Signs.regulatoryEndMotorwayEU
                } else {
                    return nil
                }
            case .regulatoryEndPriorityRoad:
                return Asset.Signs.regulatoryEndPriorityRoadEU
            case .regulatoryEndProhibition:
                if country == .UK {
                    return Asset.Signs.regulatoryEndProhibitionUK
                } else if country == .other {
                    return Asset.Signs.regulatoryEndProhibitionEU
                } else {
                    return nil
                }
            case .regulatoryGiveWayToOncomingTraffic:
                if country == .UK {
                    return Asset.Signs.regulatoryGiveWayToOncomingTrafficUK
                } else if country == .other {
                    return Asset.Signs.regulatoryGiveWayToOncomingTrafficEU
                } else {
                    return nil
                }
            case .regulatoryGoStraight:
                return Asset.Signs.regulatoryGoStraightEU
            case .regulatoryHeightLimit:
                return Asset.Signs.regulatoryHeightLimitEU
            case .regulatoryMinSafeDist:
                return Asset.Signs.regulatoryMinSafeDistEU
            case .regulatoryMotorVehicles:
                return Asset.Signs.regulatoryMotorVehiclesEU
            case .regulatoryMotorWay:
                if country == .UK {
                    return Asset.Signs.regulatoryMotorwayUK
                } else if country == .other {
                    return Asset.Signs.regulatoryMotorwayEU
                } else {
                    return nil
                }
            case .regulatoryNoBicycles:
                return Asset.Signs.regulatoryNoBicyclesEU
            case .regulatoryNoBuses:
                return Asset.Signs.regulatoryNoBusesEU
            case .regulatoryNoDangerGoods:
                if country == .UK {
                    return Asset.Signs.regulatoryNoDangerGoodsUK
                } else if country == .other {
                    return Asset.Signs.regulatoryNoDangerGoodsEU
                } else {
                    return nil
                }
            case .regulatoryNoEntry:
                return Asset.Signs.regulatoryNoEntryEU
            case .regulatoryNoHeavyGoodsVehiclesPicture:
                return Asset.Signs.regulatoryNoHeavyGoodsVehiclesPictureEU
            case .regulatoryNoLeftTurn:
                return Asset.Signs.regulatoryNoLeftTurnEU
            case .regulatoryNoMotorVehicles:
                return Asset.Signs.regulatoryNoMotorVehiclesEU
            case .regulatoryNoMotorcyclesOrMopeds:
                return Asset.Signs.regulatoryNoMotorcyclesOrMopedsEU
            case .regulatoryNoOverHeavy:
                return Asset.Signs.regulatoryNoOverHeavyEU
            case .regulatoryNoOvertaking:
                if country == .UK {
                    return Asset.Signs.regulatoryNoOvertakingUK
                } else if country == .other {
                    return Asset.Signs.regulatoryNoOvertakingEU
                } else {
                    return nil
                }
            case .regulatoryNoParking:
                return Asset.Signs.regulatoryNoParkingEU
            case .regulatoryNoPedestrians:
                if country == .UK {
                    return Asset.Signs.regulatoryNoPedestriansUK
                } else if country == .other {
                    return Asset.Signs.regulatoryNoPedestriansEU
                } else {
                    return nil
                }
            case .regulatoryNoRightTurn:
                return Asset.Signs.regulatoryNoRightTurnEU
            case .regulatoryNoUTurn:
                return Asset.Signs.regulatoryNoUTurnEU
            case .regulatoryNoParkingOrNoStopping:
                return Asset.Signs.regulatoryNoParkingOrNoStoppingEU
            case .regulatoryOneWayLeftArrow:
                return Asset.Signs.regulatoryOneWayLeftArrowEU
            case .regulatoryOneWayRightArrow:
                return Asset.Signs.regulatoryOneWayRightArrowEU
            case .regulatoryOneWayStraight:
                return Asset.Signs.regulatoryOneWayStraightEU
            case .regulatoryPedestriansCrossing:
                return Asset.Signs.regulatoryPedestriansCrossingEU
            case .regulatoryPriorityOverOncomingTraffic:
                if country == .UK {
                    return Asset.Signs.regulatoryPriorityOverOncomingTrafficUK
                } else if country == .other {
                    return Asset.Signs.regulatoryPriorityOverOncomingTrafficEU
                } else {
                    return nil
                }
            case .regulatoryPriorityRoad:
                return Asset.Signs.regulatoryPriorityRoadEU
            case .regulatoryRoadClosedToVehicles:
                return Asset.Signs.regulatoryRoadClosedToVehiclesEU
            case .regulatoryRoundabout:
                return Asset.Signs.regulatoryRoundaboutEU
            case .regulatorySharedLaneBicyclesPedestrians:
                if country == .UK {
                    return Asset.Signs.regulatorySharedLaneBicyclesPedestriansUK
                } else if country == .other {
                    return Asset.Signs.regulatorySharedLaneBicyclesPedestriansEU
                } else {
                    return nil
                }
            case .regulatoryStop:
                return Asset.Signs.regulatoryStopEU
            case .regulatoryTurnLeft:
                return Asset.Signs.regulatoryTurnLeftEU
            case .regulatoryTurnLeftOrRight:
                return Asset.Signs.regulatoryTurnLeftOrRightEU
            case .regulatoryTurnRight:
                return Asset.Signs.regulatoryTurnRightEU
            case .regulatoryWalk:
                return Asset.Signs.regulatoryWalkEU
            case .regulatoryWeightLimit:
                return Asset.Signs.regulatoryWeightLimitEU
            case .regulatoryWidthLimit:
                return Asset.Signs.regulatoryWidthLimitEU
            case .regulatoryYield:
                if country == .UK {
                    return Asset.Signs.regulatoryYieldUK
                } else if country == .other {
                    return Asset.Signs.regulatoryYieldEU
                } else {
                    return nil
                }
            case .warningBicyclesCrossing:
                return Asset.Signs.warningBicyclesCrossingEU
            case .warningCurveLeft:
                return Asset.Signs.warningCurveLeftEU
            case .warningCurveRight:
                return Asset.Signs.warningCurveRightEU
            case .warningDangerousCrosswinds:
                if country == .UK {
                    return Asset.Signs.warningDangerousCrosswindsUK
                } else if country == .other {
                    return Asset.Signs.warningDangerousCrosswindsEU
                } else {
                    return nil
                }
            case .warningDangerousTraffic:
                return Asset.Signs.warningDangerousTrafficEU
            case .warningDeadEndText:
                return Asset.Signs.warningDeadEndTextEU
            case .warningDomesticAnimals:
                if country == .UK {
                    return Asset.Signs.warningDomesticAnimalsUK
                } else if country == .other {
                    return Asset.Signs.warningDomesticAnimalsEU
                } else {
                    return nil
                }
            case .warningFallingRocksOrDebrisLeft:
                return Asset.Signs.warningFallingRocksOrDebrisLeftEU
            case .warningFallingRocksOrDebrisRight:
                return Asset.Signs.warningFallingRocksOrDebrisRightEU
            case .warningIcyRoad:
                return Asset.Signs.warningIcyRoadEU
            case .warningLowFlyingAircraft:
                return Asset.Signs.warningLowFlyingAircraftEU
            case .warningLowGroundClearance:
                if country == .UK {
                    return Asset.Signs.warningLowGroundClearanceUK
                } else if country == .other {
                    return Asset.Signs.warningLowGroundClearanceEU
                } else {
                    return nil
                }
            case .warningOpeningOrSwingBridge:
                return Asset.Signs.warningOpeningOrSwingBridgeEU
            case .warningPassLeftOrRight:
                return Asset.Signs.warningPassLeftOrRightEU
            case .warningPedestriansCrossing:
                if country == .UK {
                    return Asset.Signs.warningPedestriansCrossingUK
                } else if country == .other {
                    return Asset.Signs.warningPedestriansCrossingEU
                } else {
                    return nil
                }
            case .warningRailroadCrossingWithoutBarriers:
                if country == .UK {
                    return Asset.Signs.warningRailroadCrossingWithoutBarriersUK
                } else if country == .other {
                    return Asset.Signs.warningRailroadCrossingWithoutBarriersEU
                } else {
                    return nil
                }
            case .warningRailwayCrossing:
                return Asset.Signs.warningRailwayCrossingEU
            case .warningRailwayCrossingWithBarriers:
                return Asset.Signs.warningRailwayCrossingWithBarriersEU
            case .warningRoadNarrows:
                return Asset.Signs.warningRoadNarrowsEU
            case .warningRoadNarrowsLeft:
                return Asset.Signs.warningRoadNarrowsLeftEU
            case .warningRoadNarrowsRight:
                return Asset.Signs.warningRoadNarrowsRightEU
            case .warningRoadworks:
                if country == .UK {
                    return Asset.Signs.warningRoadworksUK
                } else if country == .other {
                    return Asset.Signs.warningRoadworksEU
                } else {
                    return nil
                }
            case .warningRoundabout:
                if country == .UK {
                    return Asset.Signs.warningRoundAboutUK
                } else if country == .other {
                    return Asset.Signs.warningRoundAboutEU
                } else {
                    return nil
                }
            case .warningSchoolZone:
                if country == .UK {
                    return Asset.Signs.warningSchoolZoneUK
                } else if country == .other {
                    return Asset.Signs.warningSchoolZoneEU
                } else {
                    return nil
                }
            case .warningSlipperyRoadSurface:
                return Asset.Signs.warningSlipperyRoadSurfaceEU
            case .warningSoftShoulderLeft:
                return Asset.Signs.warningSoftShoulderLeftEU
            case .warningSoftShoulderRight:
                return Asset.Signs.warningSoftShoulderRightEU
            case .warningSpeedBump:
                return Asset.Signs.warningSpeedBumpEU
            case .warningSteepAscent:
                return Asset.Signs.warningSteepAscentEU
            case .warningSteepDescent:
                return Asset.Signs.warningSteepDescentEU
            case .warningTrafficQueues:
                if country == .UK {
                    return Asset.Signs.warningTrafficQueuesUK
                } else if country == .other {
                    return Asset.Signs.warningTrafficQueuesEU
                } else {
                    return nil
                }
            case .warningTrafficSignals:
                return Asset.Signs.warningTrafficSignalsEU
            case .warningTramsCrossing:
                return Asset.Signs.warningTramsCrossingEU
            case .warningTwoWayTraffic:
                if country == .UK {
                    return Asset.Signs.warningTwoWayTrafficUK
                } else if country == .other {
                    return Asset.Signs.warningTwoWayTrafficEU
                } else {
                    return nil
                }
            case .warningUnevenRoad:
                return Asset.Signs.warningUnevenRoadEU
            case .warningWildAnimals:
                if country == .UK {
                    return Asset.Signs.warningWildAnimalsUK
                } else if country == .other {
                    return Asset.Signs.warningWildAnimalsEU
                } else {
                    return nil
                }
            case .warningWindingRoad:
                if country == .UK {
                    return Asset.Signs.warningWindingRoadUK
                } else if country == .other {
                    return Asset.Signs.warningWindingRoadEU
                } else {
                    return nil
                }
            default: return nil
            }
        case .unknown:
            return nil
        }
    }
}
