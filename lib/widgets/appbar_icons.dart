import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  final IconData icon;
  final Function function;
  const AppBarIcons({
    super.key,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
