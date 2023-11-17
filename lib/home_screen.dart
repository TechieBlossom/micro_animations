import 'package:flutter/material.dart';
import 'package:micro_animations/distributed_graph_ui/distributed_graph_screen.dart';
import 'package:micro_animations/gap_pie_chart/gap_pie_chart_screen.dart';
import 'package:micro_animations/nightingale_chart/nightingale_chart_screen.dart';
import 'package:micro_animations/one_football/showcase_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro Animations'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShowcaseScreen(),
                ),
              );
            },
            title: const Text('OneFootball Team Win Pie'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GapPieChartScreen(),
                ),
              );
            },
            title: const Text('Pie Chart with Gaps'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NightingaleChartScreen(),
                ),
              );
            },
            title: const Text('Nightingale Chart'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DistributedGraphScreen(),
                ),
              );
            },
            title: const Text('Distributed Graph'),
          ),
        ],
      ),
    );
  }
}
