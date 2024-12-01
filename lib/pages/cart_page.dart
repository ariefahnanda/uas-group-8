import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/core/int_ext.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/pages/payment_page.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:ecommerce_app/widgets/cart_tile.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge.count(
              count: 2,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: carts.length,
            itemBuilder: (context, index) => CartTile(
              data: CartModel(
                product: carts[index],
                quantity: 1,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16.0,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                350000.currencyFormatRp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Button.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentPage(),
                ),
              );
            },
            label: 'Checkout (${carts.length})',
          ),
        ],
      ),
    );
  }
}
