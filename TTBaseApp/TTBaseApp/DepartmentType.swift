//
//  DepartmentType.swift
//  TTBaseApp
//
//  Created by Remzi YILDIRIM on 13.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public enum DepartmentType: Int {
    case others = 0, airCraft, base, line, component, corporation
    
    public static func department(by directorateID:String) -> DepartmentType {
        switch directorateID {
        case "10011723": return .corporation// .CORPORATION  Olacak KURUMSAL COZUMLER MD. / MNG. | CORPORATIONAL SOLUTIONS
        case "10000784": return .airCraft // ESB UCAK BAKIM MUDURLUGU/ YUKLENICI
        case "10011934": return .airCraft // UCAK BAKIM MD./MNG.AIRCRAFT MAINTENANCE
        case "10011960": return .airCraft //             ESB UCAK BAKIM MUDURLUGU/MNG.AIRCRAFT MAINTENANCE (ESB)
        case "10013178": return .airCraft //             UCAK BAKIM MUDURLUGU (AHL)/MNG. AIRCRAFT MAINTENANCE (AHL)
        case "10013194": return .airCraft //            UCAK BAKIM MUDURLUGU (SAW)/MNG. AIRCRAFT MAINTENANCE
        case "10013205": return .airCraft //             UCAK BAKIM ATOLYELERI MUDURLUGU (SAW)/MNG. AIRCRAFT MAINT.SHOPS (SAW)
        case "10013240": return .airCraft //            UCAK BAKIM ATOLYELERI MUDURLUGU (AHL)/ MNG. AIRCRAFT MAINT. SHOPS (AHL)
        case "10014058": return .airCraft //             UCAK BAKIM ATOLYELER MUDURLUGU (IST-2)/UCAK BAKIM ATOLYELER MUDURLUGU (IST-2)
        case "10014114": return .airCraft //             UCAK BAKIM ATOLYELER MUDURLUGU (IST-1)/UCAK BAKIM ATOLYELER MUDURLUGU (IST-1)
        case "10014140": return .airCraft //             UCAK BAKIM ATL. MD. (IST-2) / YUKLENICI/
        case "10014148": return .airCraft //             UCAK BAKIM ATL. MD. (IST-1) / YUKLENICI/
        case "10015085": return .airCraft //             ESB UCAK BAKIM MD. / MNG. | AIRCRAFT MAINTENANCE (ESB)
        case "10013491": return .line //             HAT BAKIM MD.(ISTANBUL) / MNG. | LINE MAINTENANCE (ISTANBUL)
        case "10013493": return .line //              DESTEK MD.(HAT BAKIM)/MNG.SUPPORT(LINE MAINTENANCE)
        case "10013495": return .line //              HAT BAKIM DIS ISTASYONLAR MD. / MNG. | LINE MAINTENANCE (OTHER STATIONS)
        case "10013512": return .line //              HAT BAKIM BSK./YUKLENICI /
        case "10013516": return .line //              HAT BAKIM NOBETCI MD. A / DEPUTY MNG. | LINE MAINTENANCE A
        case "10013517": return .line //              HAT BAKIM NOBETCI MD. B / DEPUTY MNG. | LINE MAINTENANCE B
        case "10013518": return .line //              HAT BAKIM NOBETCI MD. C / DEPUTY MNG. | LINE MAINTENANCE C
        case "10013519": return .line //              HAT BAKIM NOBETCI MD. D / DEPUTY MNG. | LINE MAINTENANCE D
        case "10013587": return .line //              HAT BAKIM MD.(ISTANBUL)/YUKLENICI /
        case "10013592": return .line //              HAT BAKIM NOBETCI MD. 4 /YUKLENICI /
        case "10013594": return .line //              HAT BAKIM NOBETCI MD. 3 /YUKLENICI /
        case "10013596": return .line //              HAT BAKIM NOBETCI MD. 2 /YUKLENICI /
        case "10013597": return .line //              HAT BAKIM NOBETCI MD. 1/YUKLENICI /
        case "10013636": return .line //              HAT BAKIM DIS ISTASYONLAR MD./YUKLENICI /
        case "10014108": return .line //              HAT BAKIM PLANLAMA MD. / MNG. | MAINTENANCE PLANNING
        case "10014109": return .line //              HAT BAKIM PLANLAMA MD./YUKLENICI /
        case "10015092": return .line //              HAT BAKIM MD.(SAW) / MNG. | LINE MAINTENANCE (SAW)
        case "10016050": return .line //              HAT BAKIM MD.(SAW) / YUKLENICI /
        case "10000789": return .component //             KOMPONENT ATL.BSK./YUKLENICI /
        case "10011716": return .component //             KOMPONENT-MALZ.YON.& LOJISTIK MD./MNG.COMP.-MAT.MNG.&LOGISTICS
        case "10013210": return .component //             KOMPONENT ATOLYELER MUDURLUGU (SAW)/MNG. COMPONENT SHOPS (SAW)
        case "10013246": return .component //             KOMPONENT ATOLYELER MUDURLUGU (AHL)/MNG. COMPONENT SHOPS
        case "10014104": return .component //             KOMPONENT MUHENDISLIK VE PLANLAMA MD. / MNG. | COMPONENT ENGINEERING AND PLANNING
        case "10014105": return .component //             KOMPONENT MUH. VE PLANLAMA MD./YUKLENICI /
        case "10014107": return .component //             KOMPONENT HIZMET BASKANLIGI / YUKLENICI /
        case "10014122": return .component //             KOMPONENT PLANLAMA MD. / MNG. | COMPONENT PLANNING
        case "10014123": return .component //             KOMPONENT PLANLAMA MD./YUKLENICI /

        default: return .others
        }
    }
}
