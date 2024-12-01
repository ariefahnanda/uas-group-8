import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/pages/navbar_page.dart';
import 'package:ecommerce_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkData();
  }

  /// [Fungsi untuk mengecek apakah ada data di SharedPreferences]
  Future<void> _checkData() async {
    // Menambahkan delay 3 detik
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name'); // Cek apakah nama ada

    if (mounted) {
      // Jika nama kosong, navigasi ke halaman Register
      if (name == null || name.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      } else {
        // Jika nama ada, navigasi ke halaman Navbar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavbarPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
            SizedBox(height: 20),
            Text('Memeriksa data...'),
          ],
        ),
      ),
    );
  }
}
