import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function helperFunction;
  NewTransaction(this.helperFunction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();

}

class _NewTransactionState extends State<NewTransaction> {

  final userTitleController = TextEditingController();
  final userPriceController = TextEditingController();
  var _userChosenDate;

  void _submitedData() {
    if(userPriceController.text.isEmpty) return;
    final inputTitle = userTitleController.text;
    final inputPrice = double.parse(userPriceController.text);

    // this is a small validation to make sure the user 'll never submit empty values
    if (inputTitle.isEmpty || inputPrice <= 0 || _userChosenDate == null) return;
    // widget here help me to access the properties and methods inside NewTransaction widget class
    widget.helperFunction(inputTitle, inputPrice, _userChosenDate);
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime.now())
      .then((chosenDate) {
          if (chosenDate == null) {
            return;
          }
          setState(() {
            _userChosenDate = chosenDate;
          });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            //MediaQuery.of(context).viewInsets.bottom => tell me how much space my softTypeKey occupies from bottom
            padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: userTitleController,
                  // i get a String here in onSubmitted as an argument but i don't care about it
                  // so i have to accept it but i will not use it
                  onSubmitted: (_) => _submitedData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  controller: userPriceController,
                  onSubmitted: (_) => _submitedData(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_userChosenDate == null
                          ? 'No date chosen yet!'
                          : 'Date: ${DateFormat('MMMM d, y').format(_userChosenDate)}'),
                      TextButton(
                          onPressed: _displayDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                                color: Colors.teal[200],
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: _submitedData,
                    child: const Text(
                      'Add Transaction',
                      style: TextStyle(fontSize: 14),
                    ),)
              ],
            ),
          )),
    );
  }
}
