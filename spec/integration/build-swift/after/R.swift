// generated by xcres
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// See https://github.com/mrackwitz/xcres for more info.
//

public class R {
    public enum Icons: String {
        /// tab_bar/tabbar_list.png
        case tabBarList = "tab_bar/tabbar_list.png"
        /// tab_bar/tabbar_map.png
        case tabBarMap = "tab_bar/tabbar_map.png"
    }
    public enum Images: String {
        /// doge.jpeg
        case doge = "doge.jpeg"
    }
    public enum ImagesAssets: String {
        /// AppIcon
        case app = "AppIcon"
        /// GrumpyCat
        case catsGrumpy = "GrumpyCat"
        /// Doge
        case doge = "Doge"
        /// LaunchImage
        case launch = "LaunchImage"
    }
    public enum Strings: String {
        /// Bar String
        case bar = "bar"
        /// Only in english
        case enExclusive = "en_exclusive"
        /// Lorem Ipsum
        case example = "example"
        /// Foo String
        case foo = "foo"
    }
}

public extension R.Strings {
    public var localizedValue: String {
        return NSLocalizedString(self.rawValue,
                                 bundle: NSBundle(forClass: R.self),
                                 comment: "")
    }
}

