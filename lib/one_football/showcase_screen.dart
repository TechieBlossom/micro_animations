import 'package:flutter/material.dart';
import 'package:micro_animations/one_football/team_pie/dataset.dart';
import 'package:micro_animations/one_football/team_pie/n_pie_chart.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OneFootball Team Win Pie')),
      body: Center(
        child: NPieChart(
          radius: 100,
          textSize: 20,
          dataset: dataset,
          strokeWidth: 8,
        ),
      ),
    );
  }
}
