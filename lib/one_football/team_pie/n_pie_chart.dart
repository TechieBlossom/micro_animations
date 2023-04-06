import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class NPieChart extends StatefulWidget {
  const NPieChart({
    super.key,
    this.radius = 100,
    this.win = 18,
    this.draw = 3,
    this.loss = 2,
  });

  final double radius;
  final int win;
  final int draw;
  final int loss;

  @override
  State<NPieChart> createState() => _NPieChartState();
}

class _NPieChartState extends State<NPieChart> {
  @override
  Widget build(BuildContext context) {
    double total = (widget.win + widget.draw + widget.loss) * (1 / 360);
    return SizedBox.fromSize(
      size: Size.fromRadius(widget.radius),
      child: CustomPaint(
        painter: _ProgressPainter(
          winProgress: widget.win / total,
          drawProgress: (widget.win + widget.draw) / total,
          lossProgress: (widget.win + widget.draw + widget.loss) / total,
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  double winProgress;
  double drawProgress;
  double lossProgress;

  _ProgressPainter({
    required this.winProgress,
    required this.drawProgress,
    required this.lossProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint winPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Paint drawPaint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Paint lossPaint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(winProgress),
      false,
      winPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(drawProgress),
      false,
      drawPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(lossProgress),
      false,
      lossPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
