import 'package:flutter/material.dart';
import 'package:micro_animations/nightingale_chart/dataset.dart';
import 'package:micro_animations/nightingale_chart/nightingale_chart.dart';

class NightingaleChartScreen extends StatelessWidget {
  const NightingaleChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nightingale Chart Screen')),
      body: Center(
        child: NightingaleChart(
          radius: 180,
          dataset: dataset,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
