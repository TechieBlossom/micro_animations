import 'package:flutter/material.dart';
import 'package:micro_animations/distributed_graph_ui/bar_graph.dart';
import 'package:micro_animations/distributed_graph_ui/dataset.dart';

class DistributedGraphScreen extends StatelessWidget {
  const DistributedGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final iOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distributed Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarGraph(dataset: dataset),
      ),
    );
  }
}
