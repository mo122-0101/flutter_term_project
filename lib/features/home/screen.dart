import 'package:cloud_firestore/cloud_firestore.dart' as ff;
import 'package:flutter/material.dart';
import 'package:flutter_chat/core/constants.dart';
import 'package:flutter_chat/core/helper/helper.dart';
import 'package:flutter_chat/features/home/widgets/chart.dart';
import 'package:flutter_chat/features/home/widgets/new_transaction.dart';
import 'package:flutter_chat/features/home/widgets/transaction_list.dart';

import 'models/transaction.dart';

class MyHomePage extends StatefulWidget {
  static const rn = '/myHomePage';

  const MyHomePage({super.key});
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
          ? SizedBox(
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
      SizedBox(
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
        FutureBuilder(
          future:
              ff.FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Helper.showSnackBar(
                context,
                snapshot.error.toString(),
                Colors.red,
              );
            }

            if (snapshot.hasData) {
              var data = snapshot.data!.data();
              var username = data!['username'];
              var imageurl = data['imageurl'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          imageurl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );

    final txListWidget = SizedBox(
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => startAddingNewTransaction(context),
      ),
    );
  }
}
