import QtQuick 6.2

Item {
    id: root

    property double lineWidth: 3
    property color strokeColor: "#BFCBD9"
    property color fillColor: Qt.rgba(242 / 255, 244 / 255, 255 / 255, 0.0)
    property string lineCap: "round"

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            ctx.setLineDash([4/1.3, 3.8/1.3]);
            ctx.lineWidth = root.lineWidth;
            ctx.strokeStyle = root.strokeColor;
            ctx.lineCap = root.lineCap;

            function drawRoundedRect(x, y, width, height, x_radius, y_radius) {
                const kappa = 0.5522847498;
                let rx = Math.min(x_radius, width * 0.5);
                let ry = Math.min(y_radius, height * 0.5);
                let ox = rx * kappa;
                let oy = ry * kappa;

                ctx.beginPath();

                // Top-left corner
                ctx.moveTo(x, y + ry);
                ctx.bezierCurveTo(x, y + ry - oy, x + rx - ox, y, x + rx, y);

                // Top-right corner
                ctx.lineTo(x + width - rx, y);
                ctx.bezierCurveTo(x + width - rx + ox, y, x + width, y + ry - oy, x + width, y + ry);

                // Bottom-right corner
                ctx.lineTo(x + width, y + height - ry);
                ctx.bezierCurveTo(x + width, y + height - ry + oy, x + width - rx + ox, y + height, x + width - rx, y + height);

                // Bottom-left corner
                ctx.lineTo(x + rx, y + height);
                ctx.bezierCurveTo(x + rx - ox, y + height, x, y + height - ry + oy, x, y + height - ry);

                ctx.closePath();
                ctx.fillStyle = root.fillColor;
                ctx.fill();
                ctx.stroke();
            }

            drawRoundedRect(ctx.lineWidth/2, ctx.lineWidth/2, width-ctx.lineWidth, height-ctx.lineWidth, 10, 10); // (x, y, width, height, x_radius, y_radius)
        }
    }
    onWidthChanged: update()
    onHeightChanged: update()
    onStrokeColorChanged: update()
    onFillColorChanged: canvas.requestPaint()
    onLineWidthChanged: update()
    onLineCapChanged: update()
}
