// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: signal.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct Signal_BaseResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var error: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// ----- SIGNAL PEER TO PEER KEY -----
/// Request: register client key
public struct Signal_PeerRegisterClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var registrationID: Int32 = 0

  public var deviceID: Int32 = 0

  public var identityKeyPublic: Data = Data()

  public var preKeyID: Int32 = 0

  public var preKey: Data = Data()

  public var signedPreKeyID: Int32 = 0

  public var signedPreKey: Data = Data()

  public var signedPreKeySignature: Data = Data()

  public var identityKeyEncrypted: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Request: Get client key via clientId
public struct Signal_PeerGetClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workspaceDomain: String = String()

  public var clientID: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Response
public struct Signal_PeerGetClientKeyResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var clientID: String = String()

  public var workspaceDomain: String = String()

  public var registrationID: Int32 = 0

  public var deviceID: Int32 = 0

  public var identityKeyPublic: Data = Data()

  public var preKeyID: Int32 = 0

  public var preKey: Data = Data()

  public var signedPreKeyID: Int32 = 0

  public var signedPreKey: Data = Data()

  public var signedPreKeySignature: Data = Data()

  public var identityKeyEncrypted: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// ----- SIGNAL GROUP KEY -----
/// Request: register key of client when join to group
public struct Signal_GroupRegisterClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var deviceID: Int32 = 0

  public var clientKeyDistribution: Data = Data()

  public var senderKeyID: Int64 = 0

  public var senderKey: Data = Data()

  public var publicKey: Data = Data()

  public var privateKey: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Signal_GroupUpdateClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var listGroupClientKey: [Signal_GroupRegisterClientKeyRequest] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

///object
public struct Signal_GroupClientKeyObject {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workspaceDomain: String = String()

  public var clientID: String = String()

  public var deviceID: Int32 = 0

  public var clientKeyDistribution: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

///Request: Get client key via clientId and groupId
public struct Signal_GroupGetClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var clientID: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

///Response
public struct Signal_GroupGetClientKeyResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var clientKey: Signal_GroupClientKeyObject {
    get {return _clientKey ?? Signal_GroupClientKeyObject()}
    set {_clientKey = newValue}
  }
  /// Returns true if `clientKey` has been explicitly set.
  public var hasClientKey: Bool {return self._clientKey != nil}
  /// Clears the value of `clientKey`. Subsequent reads from it will return its default value.
  public mutating func clearClientKey() {self._clientKey = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _clientKey: Signal_GroupClientKeyObject? = nil
}

///Request: Get client key via clientId and groupId
public struct Signal_WorkspaceGroupGetClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var clientID: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

///Response
public struct Signal_WorkspaceGroupGetClientKeyResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var clientKey: Signal_GroupClientKeyObject {
    get {return _clientKey ?? Signal_GroupClientKeyObject()}
    set {_clientKey = newValue}
  }
  /// Returns true if `clientKey` has been explicitly set.
  public var hasClientKey: Bool {return self._clientKey != nil}
  /// Clears the value of `clientKey`. Subsequent reads from it will return its default value.
  public mutating func clearClientKey() {self._clientKey = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _clientKey: Signal_GroupClientKeyObject? = nil
}

/// Request: Get all client key via groupId
public struct Signal_GroupGetAllClientKeyRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Response
public struct Signal_GroupGetAllClientKeyResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var groupID: Int64 = 0

  public var lstClientKey: [Signal_GroupClientKeyObject] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "signal"

extension Signal_BaseResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".BaseResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "error"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.error) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.error.isEmpty {
      try visitor.visitSingularStringField(value: self.error, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_BaseResponse, rhs: Signal_BaseResponse) -> Bool {
    if lhs.error != rhs.error {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_PeerRegisterClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PeerRegisterClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "registrationId"),
    2: .same(proto: "deviceId"),
    3: .same(proto: "identityKeyPublic"),
    4: .same(proto: "preKeyId"),
    5: .same(proto: "preKey"),
    6: .same(proto: "signedPreKeyId"),
    7: .same(proto: "signedPreKey"),
    8: .same(proto: "signedPreKeySignature"),
    9: .same(proto: "identityKeyEncrypted"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.registrationID) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.deviceID) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.identityKeyPublic) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.preKeyID) }()
      case 5: try { try decoder.decodeSingularBytesField(value: &self.preKey) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self.signedPreKeyID) }()
      case 7: try { try decoder.decodeSingularBytesField(value: &self.signedPreKey) }()
      case 8: try { try decoder.decodeSingularBytesField(value: &self.signedPreKeySignature) }()
      case 9: try { try decoder.decodeSingularStringField(value: &self.identityKeyEncrypted) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.registrationID != 0 {
      try visitor.visitSingularInt32Field(value: self.registrationID, fieldNumber: 1)
    }
    if self.deviceID != 0 {
      try visitor.visitSingularInt32Field(value: self.deviceID, fieldNumber: 2)
    }
    if !self.identityKeyPublic.isEmpty {
      try visitor.visitSingularBytesField(value: self.identityKeyPublic, fieldNumber: 3)
    }
    if self.preKeyID != 0 {
      try visitor.visitSingularInt32Field(value: self.preKeyID, fieldNumber: 4)
    }
    if !self.preKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.preKey, fieldNumber: 5)
    }
    if self.signedPreKeyID != 0 {
      try visitor.visitSingularInt32Field(value: self.signedPreKeyID, fieldNumber: 6)
    }
    if !self.signedPreKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.signedPreKey, fieldNumber: 7)
    }
    if !self.signedPreKeySignature.isEmpty {
      try visitor.visitSingularBytesField(value: self.signedPreKeySignature, fieldNumber: 8)
    }
    if !self.identityKeyEncrypted.isEmpty {
      try visitor.visitSingularStringField(value: self.identityKeyEncrypted, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_PeerRegisterClientKeyRequest, rhs: Signal_PeerRegisterClientKeyRequest) -> Bool {
    if lhs.registrationID != rhs.registrationID {return false}
    if lhs.deviceID != rhs.deviceID {return false}
    if lhs.identityKeyPublic != rhs.identityKeyPublic {return false}
    if lhs.preKeyID != rhs.preKeyID {return false}
    if lhs.preKey != rhs.preKey {return false}
    if lhs.signedPreKeyID != rhs.signedPreKeyID {return false}
    if lhs.signedPreKey != rhs.signedPreKey {return false}
    if lhs.signedPreKeySignature != rhs.signedPreKeySignature {return false}
    if lhs.identityKeyEncrypted != rhs.identityKeyEncrypted {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_PeerGetClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PeerGetClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "workspace_domain"),
    2: .same(proto: "clientId"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.workspaceDomain) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.clientID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.workspaceDomain.isEmpty {
      try visitor.visitSingularStringField(value: self.workspaceDomain, fieldNumber: 1)
    }
    if !self.clientID.isEmpty {
      try visitor.visitSingularStringField(value: self.clientID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_PeerGetClientKeyRequest, rhs: Signal_PeerGetClientKeyRequest) -> Bool {
    if lhs.workspaceDomain != rhs.workspaceDomain {return false}
    if lhs.clientID != rhs.clientID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_PeerGetClientKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PeerGetClientKeyResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "clientId"),
    2: .standard(proto: "workspace_domain"),
    3: .same(proto: "registrationId"),
    4: .same(proto: "deviceId"),
    5: .same(proto: "identityKeyPublic"),
    6: .same(proto: "preKeyId"),
    7: .same(proto: "preKey"),
    8: .same(proto: "signedPreKeyId"),
    9: .same(proto: "signedPreKey"),
    10: .same(proto: "signedPreKeySignature"),
    11: .same(proto: "identityKeyEncrypted"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.clientID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.workspaceDomain) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.registrationID) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.deviceID) }()
      case 5: try { try decoder.decodeSingularBytesField(value: &self.identityKeyPublic) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self.preKeyID) }()
      case 7: try { try decoder.decodeSingularBytesField(value: &self.preKey) }()
      case 8: try { try decoder.decodeSingularInt32Field(value: &self.signedPreKeyID) }()
      case 9: try { try decoder.decodeSingularBytesField(value: &self.signedPreKey) }()
      case 10: try { try decoder.decodeSingularBytesField(value: &self.signedPreKeySignature) }()
      case 11: try { try decoder.decodeSingularStringField(value: &self.identityKeyEncrypted) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.clientID.isEmpty {
      try visitor.visitSingularStringField(value: self.clientID, fieldNumber: 1)
    }
    if !self.workspaceDomain.isEmpty {
      try visitor.visitSingularStringField(value: self.workspaceDomain, fieldNumber: 2)
    }
    if self.registrationID != 0 {
      try visitor.visitSingularInt32Field(value: self.registrationID, fieldNumber: 3)
    }
    if self.deviceID != 0 {
      try visitor.visitSingularInt32Field(value: self.deviceID, fieldNumber: 4)
    }
    if !self.identityKeyPublic.isEmpty {
      try visitor.visitSingularBytesField(value: self.identityKeyPublic, fieldNumber: 5)
    }
    if self.preKeyID != 0 {
      try visitor.visitSingularInt32Field(value: self.preKeyID, fieldNumber: 6)
    }
    if !self.preKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.preKey, fieldNumber: 7)
    }
    if self.signedPreKeyID != 0 {
      try visitor.visitSingularInt32Field(value: self.signedPreKeyID, fieldNumber: 8)
    }
    if !self.signedPreKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.signedPreKey, fieldNumber: 9)
    }
    if !self.signedPreKeySignature.isEmpty {
      try visitor.visitSingularBytesField(value: self.signedPreKeySignature, fieldNumber: 10)
    }
    if !self.identityKeyEncrypted.isEmpty {
      try visitor.visitSingularStringField(value: self.identityKeyEncrypted, fieldNumber: 11)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_PeerGetClientKeyResponse, rhs: Signal_PeerGetClientKeyResponse) -> Bool {
    if lhs.clientID != rhs.clientID {return false}
    if lhs.workspaceDomain != rhs.workspaceDomain {return false}
    if lhs.registrationID != rhs.registrationID {return false}
    if lhs.deviceID != rhs.deviceID {return false}
    if lhs.identityKeyPublic != rhs.identityKeyPublic {return false}
    if lhs.preKeyID != rhs.preKeyID {return false}
    if lhs.preKey != rhs.preKey {return false}
    if lhs.signedPreKeyID != rhs.signedPreKeyID {return false}
    if lhs.signedPreKey != rhs.signedPreKey {return false}
    if lhs.signedPreKeySignature != rhs.signedPreKeySignature {return false}
    if lhs.identityKeyEncrypted != rhs.identityKeyEncrypted {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupRegisterClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupRegisterClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "deviceId"),
    3: .same(proto: "clientKeyDistribution"),
    4: .same(proto: "senderKeyId"),
    5: .same(proto: "senderKey"),
    6: .same(proto: "publicKey"),
    7: .same(proto: "privateKey"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.deviceID) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.clientKeyDistribution) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self.senderKeyID) }()
      case 5: try { try decoder.decodeSingularBytesField(value: &self.senderKey) }()
      case 6: try { try decoder.decodeSingularBytesField(value: &self.publicKey) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.privateKey) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    if self.deviceID != 0 {
      try visitor.visitSingularInt32Field(value: self.deviceID, fieldNumber: 2)
    }
    if !self.clientKeyDistribution.isEmpty {
      try visitor.visitSingularBytesField(value: self.clientKeyDistribution, fieldNumber: 3)
    }
    if self.senderKeyID != 0 {
      try visitor.visitSingularInt64Field(value: self.senderKeyID, fieldNumber: 4)
    }
    if !self.senderKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.senderKey, fieldNumber: 5)
    }
    if !self.publicKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.publicKey, fieldNumber: 6)
    }
    if !self.privateKey.isEmpty {
      try visitor.visitSingularStringField(value: self.privateKey, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupRegisterClientKeyRequest, rhs: Signal_GroupRegisterClientKeyRequest) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs.deviceID != rhs.deviceID {return false}
    if lhs.clientKeyDistribution != rhs.clientKeyDistribution {return false}
    if lhs.senderKeyID != rhs.senderKeyID {return false}
    if lhs.senderKey != rhs.senderKey {return false}
    if lhs.publicKey != rhs.publicKey {return false}
    if lhs.privateKey != rhs.privateKey {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupUpdateClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupUpdateClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "listGroupClientKey"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.listGroupClientKey) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.listGroupClientKey.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.listGroupClientKey, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupUpdateClientKeyRequest, rhs: Signal_GroupUpdateClientKeyRequest) -> Bool {
    if lhs.listGroupClientKey != rhs.listGroupClientKey {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupClientKeyObject: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupClientKeyObject"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "workspace_domain"),
    2: .same(proto: "clientId"),
    3: .same(proto: "deviceId"),
    4: .same(proto: "clientKeyDistribution"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.workspaceDomain) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.clientID) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.deviceID) }()
      case 4: try { try decoder.decodeSingularBytesField(value: &self.clientKeyDistribution) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.workspaceDomain.isEmpty {
      try visitor.visitSingularStringField(value: self.workspaceDomain, fieldNumber: 1)
    }
    if !self.clientID.isEmpty {
      try visitor.visitSingularStringField(value: self.clientID, fieldNumber: 2)
    }
    if self.deviceID != 0 {
      try visitor.visitSingularInt32Field(value: self.deviceID, fieldNumber: 3)
    }
    if !self.clientKeyDistribution.isEmpty {
      try visitor.visitSingularBytesField(value: self.clientKeyDistribution, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupClientKeyObject, rhs: Signal_GroupClientKeyObject) -> Bool {
    if lhs.workspaceDomain != rhs.workspaceDomain {return false}
    if lhs.clientID != rhs.clientID {return false}
    if lhs.deviceID != rhs.deviceID {return false}
    if lhs.clientKeyDistribution != rhs.clientKeyDistribution {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupGetClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupGetClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "clientId"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.clientID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    if !self.clientID.isEmpty {
      try visitor.visitSingularStringField(value: self.clientID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupGetClientKeyRequest, rhs: Signal_GroupGetClientKeyRequest) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs.clientID != rhs.clientID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupGetClientKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupGetClientKeyResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "clientKey"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._clientKey) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    try { if let v = self._clientKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupGetClientKeyResponse, rhs: Signal_GroupGetClientKeyResponse) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs._clientKey != rhs._clientKey {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_WorkspaceGroupGetClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".WorkspaceGroupGetClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "clientId"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.clientID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    if !self.clientID.isEmpty {
      try visitor.visitSingularStringField(value: self.clientID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_WorkspaceGroupGetClientKeyRequest, rhs: Signal_WorkspaceGroupGetClientKeyRequest) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs.clientID != rhs.clientID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_WorkspaceGroupGetClientKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".WorkspaceGroupGetClientKeyResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "clientKey"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._clientKey) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    try { if let v = self._clientKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_WorkspaceGroupGetClientKeyResponse, rhs: Signal_WorkspaceGroupGetClientKeyResponse) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs._clientKey != rhs._clientKey {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupGetAllClientKeyRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupGetAllClientKeyRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupGetAllClientKeyRequest, rhs: Signal_GroupGetAllClientKeyRequest) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Signal_GroupGetAllClientKeyResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GroupGetAllClientKeyResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "groupId"),
    2: .same(proto: "lstClientKey"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.groupID) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.lstClientKey) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.groupID != 0 {
      try visitor.visitSingularInt64Field(value: self.groupID, fieldNumber: 1)
    }
    if !self.lstClientKey.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.lstClientKey, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Signal_GroupGetAllClientKeyResponse, rhs: Signal_GroupGetAllClientKeyResponse) -> Bool {
    if lhs.groupID != rhs.groupID {return false}
    if lhs.lstClientKey != rhs.lstClientKey {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
