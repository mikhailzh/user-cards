import 'dart:math';

import 'package:flutter/material.dart';

const double _defaultWidth = 3;

class GradientProgressIndicator extends StatelessWidget {
  final Gradient gradient;
  final double progress;
  final double width;
  final double? radius;

  const GradientProgressIndicator({
    Key? key,
    required this.gradient,
    required this.progress,
    this.width = _defaultWidth,
    this.radius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (radius == null) {
      return LayoutBuilder(
        builder: (context, constraints) => _buildWithRadius(
          min(
            constraints.maxHeight,
            constraints.maxWidth,
          ),
        ),
      );
    } else {
      return _buildWithRadius(radius!);
    }
  }

  Widget _buildWithRadius(double radius) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: _ProgressPainter(
          gradient: gradient,
          width: width,
          progress: progress,
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final Gradient gradient;
  final double progress;
  final double width;

  _ProgressPainter({
    required this.gradient,
    required this.progress,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(0.0, 0.0) & size;
    final paint = _getPaint(rect);
    final radius = (rect.shortestSide - width) / 2.0;
    // canvas.drawCircle(rect.center, radius, paint);

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -pi / 2,
      2 * progress * pi,
      false,
      paint,
    );
  }

  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) {
    return true;
  }
}
