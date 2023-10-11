import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCashFlowPage extends StatefulWidget {
  DetailCashFlowPage(List<TransactionData> initialData);

  @override
  _DetailCashFlowPageState createState() => _DetailCashFlowPageState();
}

class _DetailCashFlowPageState extends State<DetailCashFlowPage> {
  // Sample data for income and expense items
  List<TransactionData> transactionDatas = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getStringList('transactions');

    if (transactions != null) {
      setState(() {
        transactionDatas = transactions
            .map((transactionString) =>
                TransactionData.fromString(transactionString))
            .toList();
      });
    }
  }

  _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionStrings =
        transactionDatas.map((transaction) => transaction.toString()).toList();
    prefs.setStringList('transactions', transactionStrings);
  }

  @override
  Widget build(BuildContext context) {
    final TransactionData? newTransaction =
        ModalRoute.of(context)!.settings.arguments as TransactionData?;

    if (newTransaction != null) {
      // Add the new transaction to the list
      setState(() {
        transactionDatas.add(newTransaction);
      });

      // Save the updated list to shared preferences
      _saveTransactions();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cash Flow'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: transactionDatas.length,
              itemBuilder: (context, index) {
                final item = transactionDatas[index];

                return ListTile(
                  trailing: Icon(
                    item.isExpense
                        ? Icons.arrow_forward_rounded
                        : Icons.arrow_back_rounded,
                    color: item.isExpense ? Colors.red : Colors.green,
                  ),
                  title: Text('Rp ${item.amount.toStringAsFixed(2)}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description, style: TextStyle(fontSize: 14)),
                      Text(
                        '${item.date.day}/${item.date.month}/${item.date.year}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 25, 179, 172),
                  foregroundColor: Colors.white,
                ),
                child: Text('Kembali'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionData {
  late double amount;
  late String description;
  late DateTime date;
  late bool isExpense;

  TransactionData({
    required this.amount,
    required this.description,
    required this.date,
    required this.isExpense,
  });

  // Helper methods to convert to/from string
  String toString() {
    return '$amount|$description|${date.toIso8601String()}|$isExpense';
  }

  TransactionData.fromString(String data) {
    final parts = data.split('|');
    amount = double.parse(parts[0]);
    description = parts[1];
    date = DateTime.parse(parts[2]);
    isExpense = parts[3] == 'true';
  }
}
