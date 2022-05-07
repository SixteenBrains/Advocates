import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final String iconUrl;
  final String label;
  final int? count;

  const StatsWidget({
    Key? key,
    required this.iconUrl,
    required this.label,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          const Text('-0%'),
          const SizedBox(height: 5.0),
          Text(
            '${count ?? '000'}',
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(label),
          const SizedBox(height: 8.0),
          Image.asset(
            iconUrl,
            height: 40.0,
            width: 40.0,
          )
        ],
      ),
    );
  }
}
