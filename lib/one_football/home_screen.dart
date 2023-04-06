import 'package:flutter/material.dart';
import 'package:micro_animations/one_football/showcase_screen.dart';
import 'package:micro_animations/one_football/team_pie/n_pie_chart.dart';

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
                  builder: (_) => const ShowcaseScreen(
                    title: 'OneFootball Team Win Pie',
                    child: NPieChart(
                      win: 10,
                      draw: 5,
                      loss: 5,
                    ),
                  ),
                ),
              );
            },
            title: const Text('OneFootball Team Win Pie'),
          ),
        ],
      ),
    );
  }
}
