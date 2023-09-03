import 'package:flutter/material.dart';
import 'package:micro_animations/distributed_graph_ui/bar_graph.dart';
import 'package:micro_animations/distributed_graph_ui/dataset.dart';

class DistributedGraphScreen extends StatelessWidget {
  const DistributedGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distributed Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BarGraph(dataset: dataset, isBasic: false),
      ),
    );
  }
}

// const Padding(
// padding: EdgeInsets.only(top: 24.0),
// child: Legends(),
// ),

class Legends extends StatelessWidget {
  const Legends({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Legend(label: 'FOOD', color: Colors.green),
        Legend(label: 'MEDICAL', color: Colors.redAccent),
        Legend(label: 'TRAVEL', color: Colors.indigoAccent),
        Legend(label: 'OTHERS', color: Colors.blueGrey),
      ],
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Text(label),
      ],
    );
  }
}
