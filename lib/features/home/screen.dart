
import 'package:flutter/material.dart';
import 'package:flutter_chat/features/home/widgets/chart.dart';
import 'package:flutter_chat/features/home/widgets/new_transaction.dart';
import 'package:flutter_chat/features/home/widgets/transaction_list.dart';

import 'models/transaction.dart';

class MyHomePage extends StatefulWidget {
  static const rn = '/myHomePage';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'shoes', price: 23.66, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'weekly groceries',
        price: 77.28,
        date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    /*
    The where function in Dart return you an Iterable<T> and not a List<T>.
    But since you have the return type of your function as List<Transaction>,
    you have to convert the Iterable<Transaction> that you are getting from the where function.
    For this use the, toList function on the Iterable
    */
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double price, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(), title: title, price: price, date: date);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void startAddingNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar,
      double fraction, Widget txListWidget) {
    return [
      Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          const Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (bool val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
          height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              fraction,
          child: Chart(_recentTransactions))
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar,
      double fraction, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              fraction,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // check if i in landscaped mode or not
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text(
        'Expense Planner',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () => startAddingNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _removeTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, 0.8, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, 0.3, txListWidget),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, to add it in center
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () => startAddingNewTransaction(context),
      ),
    );
  }
}