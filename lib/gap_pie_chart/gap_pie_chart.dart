import 'package:flutter/material.dart';
import 'package:micro_animations/gap_pie_chart/dataset.dart';
import 'package:vector_math/vector_math.dart' as math;

final pieColors = [
  Colors.black,
  Colors.black38,
  Colors.black26,
  Colors.black12,
];

class ArcData {
  final Color color;
  final Animation<double> sweepAngle;
  final double startAngle;

  ArcData({
    required this.color,
    required this.sweepAngle,
    required this.startAngle,
  });
}

class GapPieChart extends StatefulWidget {
  const GapPieChart({
    super.key,
    this.radius = 100,
    this.strokeWidth = 5,
    this.scale = 1,
    required this.dataset,
    required this.gapDegrees,
  });

  final double radius;
  final double strokeWidth;
  final double scale;
  final List<Data> dataset;
  final double gapDegrees;

  @override
  State<GapPieChart> createState() => _GapPieChartState();
}

class _GapPieChartState extends State<GapPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<ArcData> arcs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2 * widget.dataset.length),
    );

    final remainingDegrees = 360 - (widget.dataset.length * widget.gapDegrees);
    final total = widget.dataset.fold(0.0, (a, data) => a + data.value) /
        remainingDegrees;
    double currentSum = 0.0;
    final intervalGap = 1 / widget.dataset.length;
    arcs = widget.dataset.indexed.map((item) {
      final (index, data) = item;
      final startAngle = currentSum + (index * widget.gapDegrees);
      currentSum += data.value / total;
      return ArcData(
        color: pieColors[index],
        sweepAngle: Tween<double>(
          begin: 0,
          end: data.value / total,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * intervalGap,
              (index + 1) * intervalGap,
            ),
          ),
        ),
        startAngle: -90 + startAngle,
      );
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: SizedBox.fromSize(
        size: Size.fromRadius(widget.radius),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _ProgressPainter(
                strokeWidth: widget.strokeWidth,
                arcs: arcs,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  const _ProgressPainter({
    required this.strokeWidth,
    required this.arcs,
  });

  final double strokeWidth;
  final List<ArcData> arcs;

  List<Paint> get paints => arcs.map((arc) {
        return Paint()
          ..color = arc.color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
      }).toList();

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    arcs.indexed.map((item) {
      final (index, arc) = item;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(arc.startAngle),
        math.radians(arc.sweepAngle.value),
        false,
        paints[index],
      );
    }).toList();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
