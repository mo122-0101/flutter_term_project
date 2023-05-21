import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {

  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({required this.transaction, required this.deleteTx});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal[200],
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${transaction.price}', style: const TextStyle(color: Colors.white),),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.23),
        ),
        subtitle: Text(
            DateFormat('MMM d, y').format(transaction.date)),
        // DateFormat('MMM d, y') = DateFormat.yMMMd(),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
          onPressed: () =>
              deleteTx(transaction.id),
          label: const Text('Delete'),
          icon: const Icon(Icons.delete),
          style: TextButton.styleFrom(
              primary: Colors.red
          ),
        )
            : IconButton(
          onPressed: () =>
              deleteTx(transaction.id),
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
