import 'package:ecommerce_app/pages/navbar_page.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedGender;
  String? selectedProvince;
  DateTime? selectedDate;
  bool isChecked = false;
  bool receiveNotification = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  /// [Fungsi untuk cek apakah semua field sudah terisi]
  bool _isFormValid() {
    return _nameController.text.isNotEmpty && selectedGender != null && selectedProvince != null && selectedDate != null && isChecked;
  }

  /// [Penggunaan Datetime pickers disini]
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  /// [Fungsi untuk menyimpan data ke SharedPreferences]
  Future<void> _saveDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text); // name adalah key, jadi nanti di page lain bisa get data key name yg udah di save
    await prefs.setString('gender', selectedGender ?? ''); // gender adalah key
    await prefs.setString('province', selectedProvince ?? '');
    if (selectedDate != null) {
      await prefs.setString('birthdate', "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}");
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavbarPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        /// [Penggunaan Layout = column kebawah, kalau row kesamping]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),

            /// [Penggunaan Text]
            const Text(
              'Register',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 30.0,
            ),

            /// [Penggunaan EditText (TextFormField/TextField)]
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap Anda',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(
              height: 20.0,
            ),

            const Text(
              'Jenis Kelamin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ListTile(
              title: const Text('Laki-laki'),

              /// [Penggunaan RadioButton = untuk memelih gender laki-laki]
              leading: Radio<String>(
                value: 'Laki-laki',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Perempuan'),

              /// [Penggunaan RadioButton = untuk memelih gender perempuan]
              leading: Radio<String>(
                value: 'Perempuan',
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),

            /// [Penggunaan Spinners/Dropdown = contohnya memilih provinsi]
            DropdownButtonFormField<String>(
              value: selectedProvince,
              decoration: const InputDecoration(
                labelText: 'Pilih Provinsi',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'DKI Jakarta',
                  child: Text('DKI Jakarta'),
                ),
                DropdownMenuItem(
                  value: 'Jawa Barat',
                  child: Text('Jawa Barat'),
                ),
                DropdownMenuItem(
                  value: 'Jawa Tengah',
                  child: Text('Jawa Tengah'),
                ),
                DropdownMenuItem(
                  value: 'Jawa Timur',
                  child: Text('Jawa Timur'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedProvince = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih jenis kelamin';
                }
                return null;
              },
            ),

            const SizedBox(
              height: 20.0,
            ),

            /// [Pickers (Date/Time) = Menggunakan showDatePicker dan showTimePicker untuk memunculkan dialog pemilihan tanggal]
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Tanggal Lahir',
                hintText: 'Pilih tanggal lahir',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDate(context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal lahir tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),

            /// [Penggunaan Switch = untuk mengaktifkan sesuatu yg tadinya off menjadi on, disini untuk aktifkan toggle notifikasi]
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aktifkan Notifikasi'),
                Switch(
                  value: receiveNotification,
                  onChanged: (value) {
                    setState(() {
                      receiveNotification = value;
                    });

                    /// [Snackbar untuk memberi tau user ada sesuai yg di aktifkan/non aktif]
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          receiveNotification ? 'Notifikasi diaktifkan!' : 'Notifikasi dinonaktifkan!',
                        ),
                        backgroundColor: receiveNotification ? Colors.green : Colors.red,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            /// [Penggunaan Layout Row]
            Row(
              children: [
                /// [Penggunaan Checkbox = biasanya user untuk check syarat dan ketentuan]
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                const Text('Saya setuju dengan syarat dan ketentuan.')
              ],
            ),
            const SizedBox(height: 30.0),

            /// [Penggunaan Event Input (onPressed) =  intinya ketika button di klik akan melakukan apa, itu namanya event]
            Button.filled(
              onPressed: _saveDataToSharedPreferences,
              disabled: !_isFormValid(),
              label: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
