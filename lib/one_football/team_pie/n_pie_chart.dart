import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class NPieChart extends StatefulWidget {
  const NPieChart({
    super.key,
    this.radius = 100,
    this.win = 18,
    this.draw = 3,
    this.loss = 2,
    this.textSize = 20,
    this.strokeWidth = 5,
    this.scale = 1,
  });

  final double radius;
  final int win;
  final int draw;
  final int loss;
  final double textSize;
  final double strokeWidth;
  final double scale;

  @override
  State<NPieChart> createState() => _NPieChartState();
}

class _NPieChartState extends State<NPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _win;
  late Animation<double> _draw;
  late Animation<double> _loss;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    final curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    final total = (widget.win + widget.draw + widget.loss) / 360;
    _win = Tween<double>(
      begin: 0,
      end: widget.win / total,
    ).animate(curvedAnimation);
    _draw = Tween<double>(
      begin: 0,
      end: (widget.win + widget.draw) / total,
    ).animate(curvedAnimation);
    _loss = Tween<double>(
      begin: 0,
      end: (widget.win + widget.draw + widget.loss) / total,
    ).animate(curvedAnimation);

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
                winProgress: _win.value,
                drawProgress: _draw.value,
                lossProgress: _loss.value,
              ),
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              VerticalStat(
                'W',
                widget.win.toString(),
                textSize: widget.textSize,
              ),
              VerticalStat(
                'D',
                widget.draw.toString(),
                textSize: widget.textSize,
              ),
              VerticalStat(
                'L',
                widget.loss.toString(),
                textSize: widget.textSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  const _ProgressPainter({
    required this.strokeWidth,
    required this.winProgress,
    required this.drawProgress,
    required this.lossProgress,
  });

  final double strokeWidth;
  final double winProgress;
  final double drawProgress;
  final double lossProgress;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint winPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint drawPaint = Paint()
      ..color = Colors.black38
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint lossPaint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

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
