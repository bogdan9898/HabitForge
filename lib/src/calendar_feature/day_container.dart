import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  const DayContainer({
    super.key,
    required this.dayIndex,
  });

  final int dayIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[900],
      child: Center(
        child: dayIndex < 10 ? Text("0$dayIndex") : Text("$dayIndex"),
      ),
    );
  }
}
