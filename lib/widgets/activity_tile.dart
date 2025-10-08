import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final String activity;
  final bool selected;
  final VoidCallback onTap;

  const ActivityTile({super.key, required this.activity, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(activity),
        trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.add_circle_outline),
        onTap: onTap,
      ),
    );
  }
}
