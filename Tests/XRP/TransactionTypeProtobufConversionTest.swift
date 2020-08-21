import XCTest
@testable import XpringKit

/// Tests conversion of XRPL Transaction Type protocol buffers to native Swift structs.
final class TransactionTypeProtobufConversionTests: XCTestCase {

  // MARK: - Org_Xrpl_Rpc_V1_AccountSet

  func testConvertAccountSetAllFields() {
    // GIVEN an AccountSet protocol buffer with all fields set.
    let accountSetProto = Org_Xrpl_Rpc_V1_AccountSet.testAccountSetAllFields

    // WHEN the protocol buffer is converted to a native Swift type.
    let xrpAccountSet: XRPAccountSet = XRPAccountSet(accountSet: accountSetProto)!

    // THEN the protocol buffer converted as expected.
    XCTAssertEqual(xrpAccountSet.clearFlag, accountSetProto.clearFlag_p.value)
    XCTAssertEqual(xrpAccountSet.domain, accountSetProto.domain.value)
    XCTAssertEqual(xrpAccountSet.emailHash, accountSetProto.emailHash.value)
    XCTAssertEqual(xrpAccountSet.messageKey, accountSetProto.messageKey.value)
    XCTAssertEqual(xrpAccountSet.setFlag, accountSetProto.setFlag.value)
    XCTAssertEqual(xrpAccountSet.transferRate, accountSetProto.transferRate.value)
    XCTAssertEqual(xrpAccountSet.tickSize, accountSetProto.tickSize.value)
  }

  func testConvertAccountSetOneField() {
    // GIVEN an AccountSet protocol buffer with one field set.
    let accountSetProto = Org_Xrpl_Rpc_V1_AccountSet.testAccountSetOneField

    // WHEN the protocol buffer is converted to a native Swift type.
    let xrpAccountSet: XRPAccountSet = XRPAccountSet(accountSet: accountSetProto)!

    // THEN the protocol buffer converted as expected.
    XCTAssertEqual(xrpAccountSet.clearFlag, accountSetProto.clearFlag_p.value)
    XCTAssertNil(xrpAccountSet.domain)
    XCTAssertNil(xrpAccountSet.emailHash)
    XCTAssertNil(xrpAccountSet.messageKey)
    XCTAssertNil(xrpAccountSet.setFlag)
    XCTAssertNil(xrpAccountSet.transferRate)
    XCTAssertNil(xrpAccountSet.tickSize)
  }

  // MARK: - Org_Xrpl_Rpc_V1_AccountDelete

  func testConvertAccountDeleteAllFields() {
    // GIVEN an AccountDelete protocol buffer with all fields set.
    let accountDelete = Org_Xrpl_Rpc_V1_AccountDelete.testAccountDeleteAllFields

    // WHEN the protocol buffer is converted to a native Swift type.
    let xrpAccountDelete = XRPAccountDelete(accountDelete: accountDelete, xrplNetwork: XRPLNetwork.test)

    // THEN the AccountDelete converted as expected.
    let expectedXAddress = Utils.encode(
      classicAddress: accountDelete.destination.value.address,
      tag: accountDelete.destinationTag.value,
      isTest: true
    )
    XCTAssertEqual(xrpAccountDelete!.destinationXAddress, expectedXAddress)
  }

  func testConvertAccountDeleteNoTag() {
    // GIVEN an AccountDelete protocol buffer with only destination field set.
    let accountDelete = Org_Xrpl_Rpc_V1_AccountDelete.testAccountDeleteNoTag

    // WHEN the protocol buffer is converted to a native Swift type.
    let xrpAccountDelete = XRPAccountDelete(accountDelete: accountDelete, xrplNetwork: XRPLNetwork.test)

    // THEN the AccountDelete converted as expected.
    let expectedXAddress = Utils.encode(
      classicAddress: accountDelete.destination.value.address,
      tag: accountDelete.destinationTag.value,
      isTest: true
    )
    XCTAssertEqual(xrpAccountDelete!.destinationXAddress, expectedXAddress)
  }

  func testConvertAccountDeleteNoFields() {
    // GIVEN an AccountDelete protocol buffer missing the destination field.
    let accountDelete = Org_Xrpl_Rpc_V1_AccountDelete.testAccountDeleteNoFields

    // WHEN the protocol buffer is converted to a native Swift type.
    let xrpAccountDelete = XRPAccountDelete(accountDelete: accountDelete, xrplNetwork: XRPLNetwork.test)

    // THEN the result is nil.
    XCTAssertNil(xrpAccountDelete)
  }
}