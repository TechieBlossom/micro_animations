import 'package:flutter/material.dart';
import 'package:micro_animations/gap_pie_chart/dataset.dart';
import 'package:micro_animations/gap_pie_chart/gap_pie_chart.dart';

class GapPieChartScreen extends StatelessWidget {
  const GapPieChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pie Chart with Gaps')),
      body: Center(
        child: GapPieChart(
          radius: 100,
          dataset: dataset,
          strokeWidth: 16,
          gapDegrees: 12,
        ),
      ),
    );
  }
}
