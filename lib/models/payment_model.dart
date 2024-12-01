class PaymentModel {
  final String name;
  final String code;
  final String image;

  PaymentModel({
    required this.name,
    required this.code,
    required this.image,
  });
}

List<PaymentModel> payments = [
  PaymentModel(
    name: "BCA Virtual Account",
    code: 'bca',
    image: "assets/images/logo_bca.png",
  ),
  PaymentModel(
    name: "Mandiri Virtual Account",
    code: 'mandiri',
    image: "assets/images/logo_mandiri.png",
  ),
  PaymentModel(
    name: "Gopay",
    code: 'gopay',
    image: "assets/images/logo_gopay.png",
  ),
  PaymentModel(
    name: "Dana",
    code: 'dana',
    image: "assets/images/logo_dana.png",
  ),
  PaymentModel(
    name: "Indomaret",
    code: 'indomaret',
    image: "assets/images/logo_indomaret.png",
  ),
];
