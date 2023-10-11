import 'package:flutter/material.dart';
import 'package:flutter_app/PengaturanPage.dart';
import 'package:flutter_app/tambah_pemasukan_page.dart';
import 'package:flutter_app/tambah_pengeluaran.dart';
import 'package:flutter_app/DetailCashFlowPage.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<TransactionData> initialData = []; // Initialize with empty data

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New App',
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/tambah_pemasukan': (context) => TambahPemasukanPage(),
        '/tambah_pengeluaran': (context) => TambahPengeluaranPage(),
        '/detail_cash_flow': (context) => DetailCashFlowPage(initialData),
        '/pengaturan': (context) => PengaturanPage(),
        // Updated route definition
        // Add routes for other pages here as needed
      },
    );
  }
}
