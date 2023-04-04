import 'package:flutter/material.dart';
import 'package:micro_animations/one_football/showcase_screen.dart';
import 'package:micro_animations/one_football/team_pie/n_pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ShowcaseScreen(
                  title: 'OneFootball Team Win Pie',
                  child: NPieChart(),
                ),
              ),
            );
          },
          title: const Text('OneFootball Team Win Pie'),
        ),
      ],
    );
  }
}