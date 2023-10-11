import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanPage extends StatefulWidget {
  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String? storedPassword;

  @override
  void initState() {
    super.initState();
    loadPassword();
  }

  void loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    storedPassword = prefs.getString('password');
  }

  void savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }

  void changePassword() {
    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;

    if (currentPassword == storedPassword) {
      savePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Current password is incorrect.'),
        ),
      );
    }
  }
void performMultipleActions() {
  // Action 1: Display a message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Password changed successfully'),
    ),
  );

  // Action 2: Clear the newPassword text field
  newPasswordController.clear();
  currentPasswordController.clear();


  // Add more actions here as needed
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Ganti Password',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Password saat Ini',
                ),
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password baru'),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  ElevatedButton(
                    onPressed: performMultipleActions,
                    child: Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 138, 222, 232),
                      foregroundColor: Color.fromARGB(255, 18, 17, 17),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('<< Kembali'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 25, 179, 172),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 300),
          // Additional elements at the bottom
         Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0,          // Border width
                ),
              ),
              child: SizedBox(
                width: 90,
                height: 90,
                child: Icon(
                  Icons.person,
                  size: 80, // Adjust the icon size as needed
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About this App..',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Aplikasi ini dibuat oleh'),
                Text('Nama: De Roger Baggio Bryant'),
                Text('NIM: 191720238'),
                Text('Tanggal: 12 Oktober 2023'),
              ],
            ),
          ],
        ),
         ),
        ],
      ),
    );
  }
}
