import QtQuick 6.2

Behavior {
    id: fadeOutBehavior

    // Property to specify the target item for the fade-out effect
    property Item fadeTarget

    // Sequential animation to fade out and then delete the item
    SequentialAnimation {
        id: fadeOutAnimation

        // Fade-out effect
        NumberAnimation {
            target: fadeOutBehavior.fadeTarget
            property: "opacity"
            to: 0
            duration: 300
            easing.type: Easing.InOutQuad
        }

        // Signal handler to delete the item after fade-out
        onStopped: {
            if (fadeOutBehavior.fadeTarget) {
                fadeOutBehavior.fadeTarget.destroy();
            }
        }
    }

    // Start the animation whenever the behavior is triggered
    onFadeTargetChanged: {
        if (fadeTarget) {
            fadeOutAnimation.start();
        }
    }
}
