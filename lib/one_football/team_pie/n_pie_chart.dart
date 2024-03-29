import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

import 'dataset.dart';

final pieColors = [
  Colors.black,
  Colors.black45,
  Colors.black38,
  Colors.black26,
  Colors.black12,
];

class ArcData {
  final Color color;
  final Animation<double> sweepAngle;

  ArcData({
    required this.color,
    required this.sweepAngle,
  });
}

class NPieChart extends StatefulWidget {
  const NPieChart({
    super.key,
    this.radius = 100,
    this.textSize = 20,
    this.strokeWidth = 5,
    this.scale = 1,
    required this.dataset,
  });

  final double radius;
  final double textSize;
  final double strokeWidth;
  final double scale;
  final List<Data> dataset;

  @override
  State<NPieChart> createState() => _NPieChartState();
}

class _NPieChartState extends State<NPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<ArcData> arcs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    final curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    final total = widget.dataset.fold(0.0, (a, data) => a + data.value) / 360;
    double currentSum = 0.0;
    arcs = widget.dataset.indexed.map((item) {
      final (index, data) = item;
      currentSum += data.value;
      return ArcData(
        color: pieColors[index],
        sweepAngle: Tween<double>(
          begin: 0,
          end: currentSum / total,
        ).animate(curvedAnimation),
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
          ..strokeCap = StrokeCap.butt
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
        math.radians(-90),
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

class VerticalStat extends StatelessWidget {
  const VerticalStat(
    this.label,
    this.value, {
    super.key,
    required this.textSize,
  });

  final String label;
  final String value;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    final labelStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: textSize);
    final valueStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: textSize);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}
