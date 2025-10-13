//-------------custom raidr painter-----------------------
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class CustomRadarChart extends StatelessWidget {
  final List<String> features;
  final List<double> actualData;
  final List<double> goalData;
  final int levels;
  final double maxValue;
  final Size? size;

  const CustomRadarChart({
    super.key,
    required this.features,
    required this.actualData,
    required this.goalData,
    this.levels = 6,
    this.maxValue = 100,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomPaint(
      size:
          size ??
          Size(width * 0.360, height * 0.200), 
      painter: RadarChartPainter(
        features: features,
        actualData: actualData,
        goalData: goalData,
        levels: levels,
        maxValue: maxValue,
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<String> features;
  final List<double> actualData;
  final List<double> goalData;
  final int levels;
  final double maxValue;

  RadarChartPainter({
    required this.features,
    required this.actualData,
    required this.goalData,
    required this.levels,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final int sides = features.length;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 * 0.8;
    final angle = (2 * pi) / sides;

    //  Grid ring color pattern
    final List<Color> gridColors = [
      Colors.grey,
      Colors.red,
      Colors.red,
      Colors.orange.withOpacity(0.6),
      Colors.orange.withOpacity(0.6),
    ];

    final Paint axisPaint = Paint()
      ..color = AppColor.textGreyColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    final Paint actualPaint = Paint()
      ..color = Color(0xffCC7A2A).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final Paint goalPaint = Paint()
      ..color = Color(0xff6BA03A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // 1. Draw background grid (polygons) with custom colors
    for (int i = 1; i <= levels; i++) {
      final r = radius * (i / levels);
      final path = Path();

      for (int j = 0; j < sides; j++) {
        final x = center.dx + r * cos(angle * j - pi / 2);
        final y = center.dy + r * sin(angle * j - pi / 2);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();

      // Use color from gridColors list (wrap around if needed)
      final color = gridColors[(i - 1) % gridColors.length];

      final Paint gridPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.4;

      canvas.drawPath(path, gridPaint);
    }

    // 2. Draw axis lines
    for (int i = 0; i < sides; i++) {
      final x = center.dx + radius * cos(angle * i - pi / 2);
      final y = center.dy + radius * sin(angle * i - pi / 2);
      canvas.drawLine(center, Offset(x, y), axisPaint);
    }

    // 3. Draw actualData shape (filled orange)
    final Path actualPath = Path();
    for (int i = 0; i < sides; i++) {
      final value = actualData[i] / maxValue;
      final r = value * radius;
      final x = center.dx + r * cos(angle * i - pi / 2);
      final y = center.dy + r * sin(angle * i - pi / 2);
      if (i == 0) {
        actualPath.moveTo(x, y);
      } else {
        actualPath.lineTo(x, y);
      }
    }
    actualPath.close();
    canvas.drawPath(actualPath, actualPaint);

    // 4. Draw goalData shape (dotted orange)
    final Path goalPath = Path();
    for (int i = 0; i < sides; i++) {
      final value = goalData[i] / maxValue;
      final r = value * radius;
      final x = center.dx + r * cos(angle * i - pi / 2);
      final y = center.dy + r * sin(angle * i - pi / 2);
      if (i == 0) {
        goalPath.moveTo(x, y);
      } else {
        goalPath.lineTo(x, y);
      }
    }
    goalPath.close();

    // Dotted/dashed path
    const dashWidth = 3.0;
    const dashSpace = 2.0;
    final Path dashedPath = Path();
    for (final metric in goalPath.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashedPath, goalPaint);

    // 5. Draw dots on vertices
    final Paint dotPaint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < sides; i++) {
      final rActual = actualData[i] / maxValue * radius;
      final xActual = center.dx + rActual * cos(angle * i - pi / 2);
      final yActual = center.dy + rActual * sin(angle * i - pi / 2);
      dotPaint.color = Color(0xffCC7A2A);
      canvas.drawCircle(Offset(xActual, yActual), 2, dotPaint);

      final rGoal = goalData[i] / maxValue * radius;
      final xGoal = center.dx + rGoal * cos(angle * i - pi / 2);
      final yGoal = center.dy + rGoal * sin(angle * i - pi / 2);
      dotPaint.color = Color(0xff6BA03A);
      canvas.drawCircle(Offset(xGoal, yGoal), 2, dotPaint);
    }

    // 6. Draw feature labels
    final textStyle = const TextStyle(color: Colors.black, fontSize: 14);
    for (int i = 0; i < sides; i++) {
      final label = features[i];
      final textPainter = TextPainter(
        text: TextSpan(text: label, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 100);

      final r = radius + 30;
      final x = center.dx + r * cos(angle * i - pi / 2);
      final y = center.dy + r * sin(angle * i - pi / 2);

      canvas.save();
      canvas.translate(x - textPainter.width / 2, y - textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
