import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<FlSpot> pengeluaranData = [
      FlSpot(0, 500000),
      FlSpot(1, 480000),
      FlSpot(2, 300000),
      FlSpot(3, 200000),
      FlSpot(4, 750000),
      FlSpot(5, 390000),
      // Add more data points as needed
    ];

    final List<FlSpot> pemasukanData = [
      FlSpot(0, 1500000),
      FlSpot(1, 750000),
      FlSpot(2, 450000),
      FlSpot(3, 600000),
      FlSpot(4, 390000),
      FlSpot(5, 157000),
      // Add more data points as needed
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Rangkuman Bulan
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Rangkuman Bulan',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Pengeluaran label (Green color)
                  Text(
                    'Pengeluaran: Rp 500.000',
                    style: TextStyle(
                      color: Colors.green, // Set text color to green
                    ),
                  ),
                  // Pemasukan label (Red color)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0), // Adjust the value as needed
                    child: Text(
                      'Pemasukan: Rp 1.500.000',
                      style: TextStyle(
                        color: Colors.red, // Set text color to red
                      ),
                    ),
                  ),
                  // Line Chart
                  Container(
                    width: 350,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom:
                                BorderSide(color: const Color(0xff37434d), width: 1),
                            left:
                                BorderSide(color: const Color(0xff37434d), width: 1),
                            right:
                                BorderSide(color: const Color(0xff37434d), width: 1),
                            top:
                                BorderSide(color: const Color(0xff37434d), width: 1),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: pengeluaranData,
                            isCurved: true,
                            colors: [Color.fromARGB(255, 2, 88, 7)],
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: pemasukanData,
                            isCurved: true,
                            colors: [Color.fromARGB(255, 193, 10, 10)],
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildIconButton(context, Icons.add, 'Tambah Pemasukan'),
                      SizedBox(width: 33.0),
                      buildIconButton(context, Icons.remove, 'Tambah Pengeluaran'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 62.0),
                        child:
                            buildIconButton(context, Icons.list, 'Detail Cash Flow'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: buildIconButton(context, Icons.settings, 'Pengaturan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the icon buttons with text below
  Widget buildIconButton(BuildContext context, IconData icon, String text) {
    return Column(
      children: <Widget>[
        
        IconButton(
          icon: Icon(icon),
          iconSize: 100,
          onPressed: () {
             if (text == 'Tambah Pemasukan') {
                Navigator.pushNamed(context, '/tambah_pemasukan');
              } else if (text == 'Tambah Pengeluaran') {
                Navigator.pushNamed(context, '/tambah_pengeluaran');
              } else if (text == 'Detail Cash Flow') {
                Navigator.pushNamed(context, '/detail_cash_flow');
              } else if (text == 'Pengaturan') {
                Navigator.pushNamed(context, '/pengaturan');
              }
          },
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0), // Adjust text size
          ),
        ),
      ],
    );
  }
}
