import 'package:flutter/material.dart';

class OverlayUI extends StatelessWidget {
  const OverlayUI({super.key, required this.borderColor, required this.info});

  final Color borderColor;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 4),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        info,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
