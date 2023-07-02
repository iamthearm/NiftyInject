import Swinject

/// Holds a Swinject container to use for the property wrappers.
public class NiftyInject {

  public static let container = Container()

  public static func removeAll() {
    container.removeAll()
  }

}

private extension NiftyInject {

  static func getOptional<T>() -> T? {
    container.resolve(T.self)
  }

  static func get<T>() -> T {
    self.getOptional()!
  }

  static func set<T>(_ value: T) {
    container.register(T.self) { _ in value }
  }

}

/// Allows setting a value in the container for the declared type.
/// Also fetches a value from the container.
/// Fetching prior to registration a value is a programmer error.
@propertyWrapper
public struct Register<Component> {

  public init() {}

  public var wrappedValue: Component {
    get { NiftyInject.get() }
    set { NiftyInject.set(newValue) }
  }

}

/// Fetches a value from the container.
/// Fetching prior to registration a value is a programmer error.
@propertyWrapper
public struct Resolve<Component> {

  public init() {}

  public var wrappedValue: Component {
    get { NiftyInject.get() }
  }

}

/// Fetches an optional value from the container.
@propertyWrapper
public struct ResolveOptional<Component> {

  public init() {}

  public var wrappedValue: Component? {
    get { NiftyInject.getOptional() }
  }

}
