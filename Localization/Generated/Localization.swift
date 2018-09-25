// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Tooltips {

    internal enum Button {
      /// CLOSE
      internal static let close = L10n.tr("Localizable", "tooltips.button.close")
      /// GOT IT!
      internal static let gotIt = L10n.tr("Localizable", "tooltips.button.got_it")
      /// NEXT!
      internal static let next = L10n.tr("Localizable", "tooltips.button.next")
    }
  }

  internal enum Trainings {

    internal enum Label {
      /// Training %lu out of %lu completed
      internal static func numberOfCompleted(_ p1: Int, _ p2: Int) -> String {
        return L10n.tr("Localizable", "trainings.label.number_of_completed", p1, p2)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
