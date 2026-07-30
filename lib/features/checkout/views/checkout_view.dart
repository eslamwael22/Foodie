import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/buttom_sheet.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/checkout/widgets/custom_order_summary.dart';
import 'package:foodie/features/checkout/widgets/payment_methods.dart';
import 'package:foodie/features/checkout/widgets/sucsess_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  bool isChecked = false;
  String selectedPayment = "Cash on Delivery";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomText(
                text: 'Order Summary',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomOrderSummary(
              text: 'Order',
              price: '\$18.19',
              fontWeight: FontWeight.w300,
            ),
            CustomOrderSummary(
              text: 'Taxes',
              price: '\$0.5',
              fontWeight: FontWeight.w300,
            ),
            CustomOrderSummary(
              text: 'Delivery Fees',
              price: '\$5',
              fontWeight: FontWeight.w300,
            ),
            Gap(30),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.5,
              indent: 20,
              endIndent: 40,
            ),
            Gap(10),
            CustomOrderSummary(
              text: 'Total',
              price: '\$23.74',
              fontWeight: FontWeight.bold,
            ),
            Gap(10),
            CustomOrderSummary(
              text: 'Estimated Delivery Time',
              price: '15-30 min',
              fontWeight: FontWeight.w400,
            ),
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomText(
                text: 'Payment Methods',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            PaymentMethods(
              onTap: () {
                setState(() {
                  selectedPayment = 'Cash on Delivery';
                });
              },
              image: 'assets/images/dollar Background Removed 1.png',
              title: 'Cash on Delivery',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              tilecolor: AppColors.secondary,
              value: 'Cash on Delivery',
              textcolor: Colors.white,
            ),
            Gap(10),
            PaymentMethods(
              onTap: () {
                setState(() {
                  selectedPayment = 'Debit Card';
                });
              },
              image: 'assets/images/image 13.png',
              title: 'Debit Card',
              subtitle: '**** **** **** 1234',
              value: 'Debit Card',
              tilecolor: Color(0xffF3F4F6),
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              groupValue: selectedPayment,
              textcolor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const CustomText(
                    text: 'Save card details for future payments',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: SafeArea(
          top: false,
          child: ButtomSheet(
            onTap: () {
              showDialog(
                barrierDismissible: true,
                barrierColor: Colors.grey.shade400,
                context: context,
                builder: (_) => SuccessDialog(
                  title: "Payment Successful",
                  message:
                      "Your order has been placed successfully and will be delivered soon",
                  buttonText: "Done",
                  onPressed: () {
                    context.go('/'); // إغلاق الـ Dialog
                    // أي أكشن تاني
                  },
                  color: AppColors.primary,
                ),
              );
            },
            price: '23.74',

            pricetext: 'Total Price',
            text: 'Pay Now',
          ),
        ),
      ),
    );
  }
}
