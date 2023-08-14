import 'package:flutter/material.dart';
import 'package:micro_animations/distributed_graph_ui/dataset.dart';

const levels = 8;

class BarGraph extends StatelessWidget {
  const BarGraph({super.key, required this.dataset});

  final List<Data> dataset;

  List<double> get amounts => dataset
      .map((data) => data.medical + data.food + data.travel + data.others)
      .toList();

  @override
  Widget build(BuildContext context) {
    final sortedAmounts = amounts;
    sortedAmounts.sort((a, b) => b.compareTo(a));

    final maxAmount = sortedAmounts.first;
    const scale = 200;
    final maxLevelAmount = maxAmount + scale;

    final horizontalLabels = dataset.map((data) => data.monthName).toList();

    return SizedBox(
      height: 300,
      child: Row(
        key: key,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          horizontalLabels.length,
          (index) {
            final foodHeight = (dataset[index].food / maxLevelAmount) * scale;
            final medicalHeight =
                (dataset[index].medical / maxLevelAmount) * scale;
            final travelHeight =
                (dataset[index].travel / maxLevelAmount) * scale;
            final othersHeight =
                (dataset[index].others / maxLevelAmount) * scale;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.up,
              children: [
                _Label(label: horizontalLabels[index]),
                _Bar(
                  foodHeight: foodHeight,
                  medicalHeight: medicalHeight,
                  travelHeight: travelHeight,
                  othersHeight: othersHeight,
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class _Bar extends StatefulWidget {
  const _Bar({
    required this.foodHeight,
    required this.medicalHeight,
    required this.travelHeight,
    required this.othersHeight,
  });

  final double foodHeight;
  final double medicalHeight;
  final double travelHeight;
  final double othersHeight;

  @override
  State<_Bar> createState() => _BarState();
}

class _BarState extends State<_Bar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _foodAnimation;
  late Animation<double> _medicalAnimation;
  late Animation<double> _travelAnimation;
  late Animation<double> _othersAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _foodAnimation = Tween<double>(begin: 0, end: widget.foodHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25),
      ),
    );
    _medicalAnimation =
        Tween<double>(begin: 0, end: widget.medicalHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5),
      ),
    );
    _travelAnimation =
        Tween<double>(begin: 0, end: widget.travelHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75),
      ),
    );
    _othersAnimation =
        Tween<double>(begin: 0, end: widget.othersHeight).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          verticalDirection: VerticalDirection.up,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              width: 10,
              height: _foodAnimation.value,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange,
              ),
              width: 10,
              height: _medicalAnimation.value,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo,
              ),
              width: 10,
              height: _travelAnimation.value,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyanAccent,
              ),
              width: 10,
              height: _othersAnimation.value,
            ),
          ],
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontFamily: 'din-pro',
        );
    return Text(
      label,
      style: style,
      textAlign: TextAlign.right,
    );
  }
}
