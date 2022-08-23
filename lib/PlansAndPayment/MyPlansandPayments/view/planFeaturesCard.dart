import 'package:flutter/material.dart';

class PlanDetailsCard extends StatelessWidget {
  final List<Widget> planDetails;
  final Color color;

  PlanDetailsCard({required this.planDetails, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: planDetails),
        ),
      ),
    );
  }
}
