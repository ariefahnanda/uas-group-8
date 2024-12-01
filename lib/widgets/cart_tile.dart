import 'package:ecommerce_app/core/colors.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartModel data;
  const CartTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.2),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(
                  data.product.image,
                  width: 68.0,
                  height: 68.0,
                ),
              ),
              const SizedBox(
                width: 14.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        data.product.priceFormat,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulBuilder(
            builder: (context, setState) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: () {
                      if (data.quantity > 1) {
                        data.quantity--;
                        setState(() {});
                      }
                    },
                    child: const ColoredBox(
                      color: AppColors.primary,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.remove,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${data.quantity}'),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: () {
                      data.quantity++;
                      setState(() {});
                    },
                    child: const ColoredBox(
                      color: AppColors.primary,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
