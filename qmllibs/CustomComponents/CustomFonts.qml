import QtQuick 6.2

pragma Singleton

Item {
    readonly property string lexendBlack: lexendBlackFont.status === FontLoader.Ready ? lexendBlackFont.name : ""
    readonly property string lexendBold: lexendBoldFont.status === FontLoader.Ready ? lexendBoldFont.name : ""
    readonly property string lexendExtraBold: lexendExtraBoldFont.status === FontLoader.Ready ? lexendExtraBoldFont.name : ""
    readonly property string lexendExtraLight: lexendExtraLightFont.status === FontLoader.Ready ? lexendExtraLightFont.name : ""
    readonly property string lexendLight: lexendLightFont.status === FontLoader.Ready ? lexendLightFont.name : ""
    readonly property string lexendMedium: lexendMediumFont.status === FontLoader.Ready ? lexendMediumFont.name : ""
    readonly property string lexendRegular: lexendRegularFont.status === FontLoader.Ready ? lexendRegularFont.name : ""
    readonly property string lexendSemiBold: lexendSemiBoldFont.status === FontLoader.Ready ? lexendSemiBoldFont.name : ""
    readonly property string lexendThin: lexendThinFont.status === FontLoader.Ready ? lexendThinFont.name : ""


    FontLoader {
        id: lexendBlackFont
        source: "resources/fonts/Lexend-Black.ttf"
    }

    FontLoader {
        id: lexendBoldFont
        source: "resources/fonts/Lexend-Bold.ttf"
    }

    FontLoader {
        id: lexendExtraBoldFont
        source: "resources/fonts/Lexend-ExtraBold.ttf"
    }

    FontLoader {
        id: lexendExtraLightFont
        source: "resources/fonts/Lexend-ExtraLight.ttf"
    }

    FontLoader {
        id: lexendLightFont
        source: "resources/fonts/Lexend-Light.ttf"
    }

    FontLoader {
        id: lexendMediumFont
        source: "resources/fonts/Lexend-Medium.ttf"
    }

    FontLoader {
        id: lexendRegularFont
        source: "resources/fonts/Lexend-Regular.ttf"
    }

    FontLoader {
        id: lexendSemiBoldFont
        source: "resources/fonts/Lexend-SemiBold.ttf"
    }

    FontLoader {
        id: lexendThinFont
        source: "resources/fonts/Lexend-Thin.ttf"
    }
}
