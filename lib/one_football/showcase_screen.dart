import 'package:flutter/material.dart';
import 'package:micro_animations/one_football/team_pie/n_pie_chart.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OneFootball Team Win Pie')),
      body: const Center(
        child: NPieChart(
          radius: 100,
          win: 10,
          draw: 5,
          loss: 5,
          textSize: 20,
          strokeWidth: 8,
        ),
      ),
    );
  }
}
