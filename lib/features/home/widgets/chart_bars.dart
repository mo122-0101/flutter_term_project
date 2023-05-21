import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final double spendingAmmount;
  final double spendingPctOfTotal; // it's a value from 0 to 1

  const ChartBars(
      {required this.label,
      required this.spendingAmmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${spendingAmmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 8,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(220, 220, 220, 1),
                          width: 1.2),
                      color: const Color.fromRGBO(244, 241, 241, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  FractionallySizedBox(
                    // heightFactor accept a value from 0 to 1 => 0 is 0% of the surrounding container &
                    // 1 is 1% of the surrounding container
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(height: constraints.maxHeight * 0.15,child: Text(label)),
          ],
        );
    },);

  }
}
