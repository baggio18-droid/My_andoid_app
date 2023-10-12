import 'package:flutter/material.dart';
import 'package:my_app/DetailCashFlowPage.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TambahPemasukanPage extends StatefulWidget {
  @override
  _TambahPemasukanPageState createState() => _TambahPemasukanPageState();
}

class _TambahPemasukanPageState extends State<TambahPemasukanPage> {
  DateTime selectedDate =
      DateTime(2021, 1, 1); // Initial date set to 01/01/2021
  TextEditingController nominalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pemasukan'),
        foregroundColor: Colors.green,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Tanggal:',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        currentTime: selectedDate,
                      );
                    },
                  ),
                ],
              ),
              TextField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nominal',
                  prefixText: 'Rp',
                ),
              ),
              TextField(
                controller: keteranganController,
                decoration:
                    InputDecoration(labelText: 'Keterangan', prefixText: ''),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Reset fields and date to 01/01/2021
                      setState(() {
                        nominalController.text = '';
                        keteranganController.text = '';
                        selectedDate = DateTime(2021, 1, 1);
                      });
                    },
                    child: Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 227, 53, 13), // Background color
                      foregroundColor:
                          Color.fromARGB(255, 18, 17, 17), // Text color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double amount = double.parse(nominalController.text);
                        String description = keteranganController.text;
                        DateTime date = selectedDate;
                        bool isExpense = false;

                        TransactionData newTransaction = TransactionData(
                          amount: amount, 
                          description: description, 
                          date: date, 
                          isExpense: isExpense);
                  
                       
                      Navigator.pushNamed(context, '/detail_cash_flow', arguments: newTransaction);
                      // Handle save logic and database SQLite here
                    },
                    child: Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 138, 222, 232), // Background color
                      foregroundColor:Color.fromARGB(255, 18, 17, 17), // Text color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('<< Kembali'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 25, 179, 172), // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
