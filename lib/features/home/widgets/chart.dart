import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions, {super.key});

  List<Map<String, dynamic>> get chartTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalPriceSum = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalPriceSum += transactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'price': totalPriceSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return chartTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: chartTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBars(
                  label: e['day'],
                  spendingAmmount: e['price'],
                  spendingPctOfTotal:
                      totalSpending == 0.0 ? 0.0 : e['price'] / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
