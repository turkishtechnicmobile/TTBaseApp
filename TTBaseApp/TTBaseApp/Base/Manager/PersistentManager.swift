//
//  Persistent.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 13.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol Persistent: AnyObject {
    var themeMode: Int { get set }
    var accessToken: String? { get set }
    var token: String? { get set }
    var sessionExpireDate: Date? { get set }
    var deviceToken: String? { get set }
//    var applicationID: Int? { get set }
    var registerID: String? { get set }
    var employeeID: String? { get }
    var fullName: String? { get set }
    var staffName: String? { get set }
    var department: String? { get set}
    var departmentType: DepartmentType { get set }
    var selectedAirplane: String? { get set }
    var selectedLocation: String? { get set }
    var acSeries: String? { get set }
    var acType: String? { get set }
    var fleet: String { get }
    var locations: [String] { get set }
    var airCrafts: [String] { get set }
    var isValidToken: Bool { get }
    func update(with value: Any?, forKey: String)
    func getValue(forKey: String) -> Any?
    func getValue(forKey: String) -> Bool
    func getValue(forKey: String) -> Int
    func getValue(forKey: String) -> String?
    func getValue(forKey: String) -> Date?
    func getValue(forKey: String) -> Data?
    
    func logout()
}

open class PersistentManager: Persistent {
    public static let shared = PersistentManager()
    
    
    public init() {
        
    }
    
    // MARK: - Saved
    public var themeMode: Int {
        get {
            return getValue(forKey: PersistentKeys.themeMode)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.themeMode)
        }
    }
    
    public var accessToken: String? {
        get {
            return getValue(forKey: PersistentKeys.accessToken)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.accessToken)
        }
    }
    
    public var token: String? {
        get {
            return getValue(forKey: PersistentKeys.token)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.token)
        }
    }

    public var sessionExpireDate: Date? {
        get {
            return getValue(forKey: PersistentKeys.sessionExpireDate)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.sessionExpireDate)
        }
    }
    
    public var deviceToken: String? {
        get {
            return getValue(forKey: PersistentKeys.deviceToken)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.deviceToken)
        }
    }
    
//    public var applicationID: Int? {
//        get {
//            return getValue(forKey: PersistentKeys.applicationID)
//        }
//        set {
//            update(with: newValue, forKey: PersistentKeys.applicationID)
//        }
//    }
    
    public var registerID: String? {
        get {
            return getValue(forKey: PersistentKeys.registerID)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.registerID)
        }
    }
    
    public var employeeID: String? {
        guard let registerID = registerID else { return nil }
        
        if registerID.hasPrefix("0") {
            return "E\(registerID.dropFirst())"
        }
        return registerID.hasPrefix("E") ? registerID : "E\(registerID)"
    }
    
    public var fullName: String? {
        get {
            return getValue(forKey: PersistentKeys.fullName)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.fullName)
        }
    }
    
    public var staffName: String? {
        get {
            return getValue(forKey: PersistentKeys.staffName)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.staffName)
        }
    }
    
    public var department: String? {
        get {
            return getValue(forKey: PersistentKeys.department)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.department)
        }
    }
    
    public var departmentType = DepartmentType.base
    
    public var selectedAirplane: String? {
        get {
            return getValue(forKey: PersistentKeys.selectedAirPlane)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.selectedAirPlane)
        }
    }
    
    public var selectedLocation: String? {
        get {
            return getValue(forKey: PersistentKeys.selectedLocation)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.selectedLocation)
        }
    }
    
    public var acSeries: String? {
        get {
            return getValue(forKey: PersistentKeys.acSeries)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.acSeries)
        }
    }
    
    public var acType: String? {
        get {
            return getValue(forKey: PersistentKeys.acType)
        }
        set {
            update(with: newValue, forKey: PersistentKeys.acType)
        }
    }
    
    public var fleet: String {
        guard let acType = acType else { return "" }
        return (acType == "A318" || acType == "A319" || acType == "A321") ? "A320" : acType
    }
    
    public var airCrafts = [String]()
    public var locations = [String]()
    
    public var isValidToken: Bool {
        guard let accessToken = accessToken, !accessToken.isEmpty, let expireDate = sessionExpireDate, expireDate > Date() else {
            return false
        }
        return true
    }
}

extension PersistentManager {
    struct PersistentKeys {
        static let themeMode = "themeMode"
        static let accessToken = "accessToken"
        static let token = "token"
        static let sessionExpireDate = "sessionExpireDate"
        static let deviceToken = "deviceToken"
//        static let applicationID = "applicationID"
        static let registerID = "registerID"
        static let fullName = "fullName"
        static let selectedAirPlane = "selectedAirPlane" //ac
        static let selectedLocation = "selectedLocation" //location
        static let acSeries = "AcSeries"
        static let acType = "AcType"
        static let staffName = "staffName"
        static let department = "department"
    }
}

public extension PersistentManager {
    func getValue(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    func getValue(forKey: String) -> Int {
        return UserDefaults.standard.integer(forKey: forKey)
    }
    
    func getValue(forKey: String) -> Any? {
        return UserDefaults.standard.value(forKey: forKey)
    }
    
    func getValue(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    func getValue(forKey: String) -> Date? {
        return UserDefaults.standard.object(forKey: forKey) as? Date
    }
    
    func getValue(forKey: String) -> Data? {
        return UserDefaults.standard.value(forKey: forKey) as? Data
    }
    
    /// set UserrDefaults value
    func update(with value: Any?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    func logout() {
        registerID  = ""
        fullName = ""
        accessToken = nil
        sessionExpireDate = nil
    }
}
