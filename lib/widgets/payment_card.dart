import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/models/payment_model.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  final bool isActive;
  final PaymentModel data;
  final VoidCallback onTap;

  const PaymentMethod({
    super.key,
    required this.isActive,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// [Penggunaan GestureDetector = menambahkan event dari suatu widget, misalkan gambar kan tidak bisa di klik, ]
    /// [ketika di tambahkwan widget gesture detector maka gambar tersebut akan memiliki event atau aksi ontap, lalu di ontap kita bisa atur event nya]
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  data.image,
                  height: 24.0,
                  width: 48.0,
                ),
                const SizedBox(width: 16.0),
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.0,
                ),
              ),
              child: Icon(
                Icons.circle,
                color: isActive ? AppColors.primary : Colors.transparent,
                size: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
