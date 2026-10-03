import 'package:flutter/material.dart';

/// Pure Flutter Canvas Painter for the official UAE Dirham symbol.
///
/// Enables zero-asset, high-performance rendering of the Dirham currency glyph.
class DirhamCustomPainter extends CustomPainter {
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;

  const DirhamCustomPainter({
    this.color = Colors.black,
    this.style = PaintingStyle.fill,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    // Scale from 1500x1500 viewBox to target size
    final scale = size.width / 1500.0;
    canvas.save();
    canvas.scale(scale, scale);

    final path = _getDirhamPath();
    canvas.drawPath(path, paint);

    canvas.restore();
  }

  Path _getDirhamPath() {
    final path = Path();
    // Path definition corresponding to official UAE Dirham geometry
    path.moveTo(474.94, 1272.7);
    path.lineTo(263.1, 1272.7);
    path.cubicTo(260.0, 1272.7, 258.0, 1272.5, 256.64, 1269.31);
    path.cubicTo(287.57, 1235.01, 297.13, 1192.54, 302.78, 1148.59);
    path.cubicTo(304.5, 1132.0, 305.5, 1115.0, 305.62, 1098.82);
    path.cubicTo(305.72, 1037.48, 305.62, 976.15, 305.83, 914.82);
    path.cubicTo(305.83, 908.57, 304.33, 906.69, 297.94, 906.82);
    path.cubicTo(280.36, 907.27, 262.75, 906.95, 245.16, 906.95);
    path.cubicTo(204.85, 906.95, 178.16, 885.95, 160.36, 851.61);
    path.cubicTo(148.36, 828.37, 148.36, 803.11, 148.66, 777.85);
    path.cubicTo(153.5, 782.0, 160.0, 788.0, 178.83, 798.49);
    path.cubicTo(190.0, 803.0, 201.0, 803.3, 203.83, 803.3);
    path.lineTo(293.7, 803.43);
    path.lineTo(293.7, 713.57);
    path.lineTo(238.79, 713.7);
    path.cubicTo(206.15, 713.7, 181.79, 698.47, 163.79, 672.2);
    path.cubicTo(150.4, 652.67, 144.42, 630.73, 144.29, 607.13);
    path.cubicTo(155.0, 615.0, 168.0, 627.0, 199.75, 630.64);
    path.lineTo(287.48, 630.64);
    path.cubicTo(286.77, 565.27, 287.36, 499.89, 286.32, 434.53);
    path.cubicTo(285.61, 389.88, 277.98, 346.3, 258.32, 305.53);
    path.cubicTo(250.0, 287.0, 242.0, 270.0, 230.0, 253.0);
    path.lineTo(260.0, 250.0);
    path.cubicTo(387.91, 250.0, 515.82, 249.7, 643.72, 250.28);
    path.cubicTo(712.09, 250.59, 779.37, 259.76, 845.13, 279.17);
    path.cubicTo(913.13, 299.25, 975.13, 330.8, 1028.88, 377.31);
    path.cubicTo(1069.23, 412.2, 1101.17, 453.93, 1125.88, 501.19);
    path.cubicTo(1142.0, 532.0, 1156.0, 570.0, 1166.5, 609.33);
    path.lineTo(1238.5, 609.33);
    path.cubicTo(1279.19, 609.42, 1305.58, 631.01, 1323.08, 665.79);
    path.cubicTo(1334.47, 688.42, 1334.78, 712.86, 1334.55, 737.37);
    path.cubicTo(1324.0, 727.0, 1310.0, 714.0, 1280.6, 712.38);
    path.lineTo(1188.6, 712.23);
    path.lineTo(1188.67, 801.98);
    path.lineTo(1240.01, 801.74);
    path.cubicTo(1286.2, 799.5, 1320.81, 832.45, 1333.44, 872.47);
    path.cubicTo(1339.44, 891.62, 1339.25, 911.24, 1339.08, 930.92);
    path.cubicTo(1328.0, 920.0, 1313.0, 907.0, 1285.95, 905.81);
    path.lineTo(1178.25, 905.65);
    path.cubicTo(1163.01, 967.84, 1137.9, 1025.54, 1099.11, 1076.91);
    path.cubicTo(1060.32, 1128.28, 1011.69, 1168.01, 954.67, 1197.52);
    path.cubicTo(884.94, 1233.6, 810.12, 1251.63, 732.47, 1259.66);
    path.cubicTo(697.47, 1263.28, 662.36, 1264.39, 627.19, 1264.34);
    path.lineTo(474.94, 1272.7);
    path.close();

    // Inner top counter hole
    path.moveTo(730.42, 593.1);
    path.lineTo(991.36, 593.24);
    path.cubicTo(981.14, 539.37, 965.51, 487.49, 937.21, 439.97);
    path.cubicTo(907.6, 390.24, 867.14, 352.29, 815.21, 326.81);
    path.cubicTo(768.42, 293.0, 711.22, 282.73, 652.46, 280.59);
    path.cubicTo(591.9, 278.37, 531.28, 280.2, 470.68, 279.59);
    path.lineTo(470.68, 576.87);
    path.close();

    // Inner bottom counter hole
    path.moveTo(730.62, 907.0);
    path.lineTo(470.32, 906.84);
    path.lineTo(470.54, 1192.84);
    path.cubicTo(530.88, 1191.94, 591.27, 1195.32, 651.54, 1190.57);
    path.cubicTo(703.54, 1186.47, 753.85, 1175.75, 801.32, 1153.57);
    path.cubicTo(851.72, 1129.98, 892.62, 1095.3, 923.53, 1048.86);
    path.cubicTo(956.53, 999.26, 974.32, 943.92, 985.59, 886.04);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant DirhamCustomPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.style != style ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// A zero-dependency vector icon widget for the official UAE Dirham currency symbol.
class DirhamVectorIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const DirhamVectorIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurface;

    return CustomPaint(
      size: Size(size, size),
      painter: DirhamCustomPainter(color: effectiveColor),
    );
  }
}
