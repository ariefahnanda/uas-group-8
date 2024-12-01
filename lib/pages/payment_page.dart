import 'package:ecommerce_app/core/int_ext.dart';
import 'package:ecommerce_app/models/payment_model.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:ecommerce_app/widgets/payment_card.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int?> selectPayment = ValueNotifier<int?>(null);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              return ValueListenableBuilder<int?>(
                valueListenable: selectPayment,
                builder: (context, activeIndex, child) {
                  final payment = payments[index];
                  return PaymentMethod(
                    isActive: activeIndex == index,
                    data: payment,
                    onTap: () {
                      selectPayment.value = index;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 36.0),
          const Divider(),
          const SizedBox(height: 8.0),
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          ValueListenableBuilder<int?>(
            valueListenable: selectPayment,
            builder: (context, selectedIndex, _) {
              return Column(
                children: [
                  _buildPaymentSummary(),
                  if (selectedIndex != null) // Menampilkan jika ada metode yang dipilih
                    Row(
                      children: [
                        const Text(
                          'Pembayaran Melalui',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          payments[selectedIndex].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 20.0),
          ValueListenableBuilder(
            valueListenable: selectPayment,
            builder: (context, value, _) => Button.filled(
              disabled: value == null,
              onPressed: () {
                _showPaymentDialog(context);
              },
              label: 'Bayar Sekarang',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Column(
      children: [
        _buildSummaryRow('Total Belanja', 350000),
        _buildSummaryRow('Biaya Layanan', 2000),
        const SizedBox(height: 8.0),
        const Divider(
          height: 1,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryRow('Total Tagihan', 352000),
      ],
    );
  }

  Widget _buildSummaryRow(String title, int amount) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          amount.currencyFormatRp,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pembayaran Berhasil'),
          content: const Text('Pembayaran Anda telah berhasil dilakukan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
