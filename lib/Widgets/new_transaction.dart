import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountVal = TextEditingController();
  var _selectedDate = DateTime.now();
  final titleVal = TextEditingController();

  void _submitData() {
    if (amountVal.text.isEmpty) {
      return;
    }
    final enteredTitle = titleVal.text;
    final enteredAmount = double.parse(amountVal.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 ) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount , _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        _selectedDate = DateTime.now();
      }
      setState(() {
        _selectedDate = pickedDate!;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleVal,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountVal,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                _selectedDate == null
                    ? Text('No Date Chosen')
                    : Text(
                        'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _submitData();
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
