import 'package:ecommerce_app/pages/register_page.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? gender;
  String? province;
  String? birthdate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// [Fungsi untuk memuat data dari SharedPreferences]
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      gender = prefs.getString('gender');
      province = prefs.getString('province');
      birthdate = prefs.getString('birthdate');
    });
  }

  /// [Fungsi untuk logout (menghapus semua data di SharedPreferences)]
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data dari SharedPreferences

    /// [Menggunakan removeUntil untuk menghapus semua halaman dan navigasi ke halaman Register]
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda berhasil logout!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// [Menampilkan data yang disimpan di SharedPreferences]
            ///
            ProfileTile(
              label: 'Nama',
              title: name!,
            ),
            ProfileTile(
              label: 'Jenis Kelamin',
              title: gender!,
            ),
            ProfileTile(
              label: 'Tanggal Lahir',
              title: birthdate!,
            ),
            ProfileTile(
              label: 'Provinsi',
              title: province!,
            ),

            const SizedBox(
              height: 20.0,
            ),

            /// [Tombol Logout untuk menghapus data di SharedPreferences]
            Button.filled(
              onPressed: () {
                _logout(context);
              },
              label: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String label;
  final String title;
  const ProfileTile({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
