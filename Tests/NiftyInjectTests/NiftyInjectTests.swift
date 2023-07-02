import XCTest
@testable import NiftyInject

final class NiftyInjectTests: XCTestCase {

  override func setUp() {
    NiftyInject.removeAll()
  }

  override func tearDown() {
    NiftyInject.removeAll()
  }

  func testResolveOptionalGivesNil() {
    let holder = Holder<String>()
    XCTAssertNil(holder.resolveOptional)
  }

  func testResolveAfterSet() {
    let holder = Holder<String>()
    holder.register = "some string"
    XCTAssertEqual(holder.resolve, "some string")
    XCTAssertEqual(holder.resolveOptional!, "some string")
  }

  func testRegisterMultipleTimes() {
    let holder = Holder<String>()
    holder.register = "some string"
    holder.register = "another string"
    XCTAssertEqual(holder.resolve, "another string")
    XCTAssertEqual(holder.resolveOptional!, "another string")
  }

  func testInterfaceResolveOptionalGivesNil() {
    let holder = Holder<any Comparable>()
    XCTAssertNil(holder.resolveOptional)
  }

  func testInterfaceResolveAfterSet() {
    let holder = Holder<any Comparable>()
    holder.register = 5
    XCTAssertEqual(holder.resolve as! Int, 5)
    XCTAssertEqual(holder.resolveOptional as! Int, 5)
  }

  func testInterfaceRegisterMultipleTimes() {
    let holder = Holder<any Comparable>()
    holder.register = 5
    holder.register = 6
    XCTAssertEqual(holder.resolve as! Int, 6)
    XCTAssertEqual(holder.resolveOptional as! Int, 6)
  }

  func testRemoveAll() {
    let holder = Holder<String>()
    holder.register = "some string"

    NiftyInject.removeAll()
    XCTAssertNil(holder.resolveOptional)
  }

}

private extension NiftyInjectTests {

  class Holder<Element> {
    @Register var register: Element
    @Resolve var resolve: Element
    @ResolveOptional var resolveOptional: Element?
  }

}
