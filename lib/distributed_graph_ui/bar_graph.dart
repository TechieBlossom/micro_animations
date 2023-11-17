import 'package:flutter/material.dart';
import 'package:micro_animations/distributed_graph_ui/dataset.dart';
import 'package:micro_animations/distributed_graph_ui/label.dart';
import 'package:micro_animations/distributed_graph_ui/overlay_mixin.dart';
import 'package:micro_animations/overlay_ui.dart';

class BarGraph extends StatelessWidget {
  const BarGraph({
    super.key,
    required this.dataset,
    this.isBasic = true,
  });

  final List<Data> dataset;
  final bool isBasic;

  List<double> get amounts => dataset
      .map((data) => data.medical + data.food + data.travel + data.others)
      .toList();

  double get maxAmount => amounts.reduce((a, b) => a > b ? a : b);

  double get scale => maxAmount / 10;

  List<String> get horizontalLabels =>
      dataset.map((data) => data.monthName).toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Row(
        key: key,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            horizontalLabels.length,
            (index) {
              final foodHeight = (dataset[index].food / maxAmount) * 300;
              final medicalHeight = (dataset[index].medical / maxAmount) * 300;
              final travelHeight = (dataset[index].travel / maxAmount) * 300;
              final othersHeight = (dataset[index].others / maxAmount) * 300;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: [
                  Label(label: horizontalLabels[index]),
                  SizedBox(
                    height: 300,
                    child: _Bar(
                      isBasic: isBasic,
                      foodHeight: foodHeight,
                      medicalHeight: medicalHeight,
                      travelHeight: travelHeight,
                      othersHeight: othersHeight,
                      foodInfo: dataset[index].food.toString(),
                      medicalInfo: dataset[index].medical.toString(),
                      travelInfo: dataset[index].travel.toString(),
                      othersInfo: dataset[index].others.toString(),
                    ),
                  ),
                ],
              );
            },
          ).toList()
        ],
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
    required this.foodInfo,
    required this.medicalInfo,
    required this.travelInfo,
    required this.othersInfo,
    required this.isBasic,
  });

  final double foodHeight;
  final double medicalHeight;
  final double travelHeight;
  final double othersHeight;
  final String foodInfo;
  final String medicalInfo;
  final String travelInfo;
  final String othersInfo;
  final bool isBasic;

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
    final total = widget.foodHeight +
        widget.travelHeight +
        widget.medicalHeight +
        widget.othersHeight;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.isBasic) {
      _foodAnimation = Tween<double>(begin: 0, end: widget.foodHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, widget.foodHeight / total),
        ),
      );
      _medicalAnimation =
          Tween<double>(begin: 0, end: widget.medicalHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            widget.foodHeight / total,
            (widget.foodHeight + widget.medicalHeight) / total,
          ),
        ),
      );
      _travelAnimation =
          Tween<double>(begin: 0, end: widget.travelHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (widget.foodHeight + widget.medicalHeight) / total,
            (widget.foodHeight + widget.medicalHeight + widget.travelHeight) /
                total,
          ),
        ),
      );
      _othersAnimation =
          Tween<double>(begin: 0, end: widget.othersHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (widget.foodHeight + widget.medicalHeight + widget.travelHeight) /
                total,
            1.0,
          ),
        ),
      );
    } else {
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
          curve: const Interval(
            0.25,
            0.5,
          ),
        ),
      );
      _travelAnimation =
          Tween<double>(begin: 0, end: widget.travelHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.5,
            0.75,
          ),
        ),
      );
      _othersAnimation =
          Tween<double>(begin: 0, end: widget.othersHeight).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.75,
            1.0,
          ),
        ),
      );
    }

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
            _Stick(
              color: const Color(0xFFE2E2E3),
              info: widget.foodInfo,
              value: _foodAnimation.value,
            ),
            _Stick(
              color: const Color(0xFFC392DC),
              info: widget.medicalInfo,
              value: _medicalAnimation.value,
            ),
            _Stick(
              color: const Color(0xFFFEBA17),
              info: widget.travelInfo,
              value: _travelAnimation.value,
            ),
            _Stick(
              color: const Color(0xFFCB9D9D),
              info: widget.othersInfo,
              value: _othersAnimation.value,
            ),
          ],
        );
      },
    );
  }
}

class _Stick extends StatefulWidget {
  const _Stick({
    required this.value,
    required this.info,
    required this.color,
  });

  final double value;
  final Color color;
  final String info;

  @override
  State<_Stick> createState() => _StickState();
}

class _StickState extends State<_Stick> with OverlayStateMixin {
  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) => removeOverlay(),
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details, context),
        child: Container(
          height: widget.value,
          width: 16,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, BuildContext context) {
    late Offset offset;
    final width = MediaQuery.sizeOf(context).width;
    if (details.globalPosition > Offset(width - 60, 0)) {
      offset = details.globalPosition - const Offset(50, 0);
    } else {
      offset = details.globalPosition;
    }
    toggleOverlay(
      OverlayUI(
        info: widget.info,
        borderColor: widget.color,
      ),
      offset,
    );
  }
}
