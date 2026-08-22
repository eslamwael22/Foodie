import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/buttom_sheet.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/payment_methods.dart';
import 'package:foodie/features/checkout/widgets/checkout_section_title.dart';
import 'package:foodie/features/checkout/widgets/order_summary_card.dart';
import 'package:foodie/features/checkout/widgets/sucsess_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CheckoutView extends StatefulWidget {
  final double cartTotal;

  const CheckoutView({super.key, this.cartTotal = 0});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  static const double taxes = 0.50;
  static const double deliveryFees = 5.00;
  bool isChecked = false;
  String selectedPayment = "Cash on Delivery";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(70),

            const CheckoutSectionTitle(
              title: 'Order Summary',
              icon: CupertinoIcons.doc_text,
            ),
            OrderSummaryCard(
              orderTotal: widget.cartTotal,
              taxes: taxes,
              deliveryFees: deliveryFees,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(color: AppColors.borderGrey),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Estimated Delivery Time',
                    fontSize: 15,
                    color: AppColors.textGrey,
                  ),
                  CustomText(
                    text: '15 - 30 min',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
            Gap(30),
            const CheckoutSectionTitle(
              title: 'Payment Method',
              icon: CupertinoIcons.creditcard,
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
              tilecolor: AppColors.primary,
              value: 'Cash on Delivery',
              textcolor: AppColors.white,
            ),
            const SizedBox(height: 8),
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
              tilecolor: AppColors.lightGray,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              groupValue: selectedPayment,
              textcolor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
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
                  const Expanded(
                    child: CustomText(
                      text: 'Save card details for future payments',
                      fontSize: 14,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.background,
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
                    context.go('/Roots');
                  },
                  color: AppColors.primary,
                ),
              );
            },
            price: (widget.cartTotal + taxes + deliveryFees).toStringAsFixed(2),
            pricetext: 'Total Price',
            text: 'Pay Now',
          ),
        ),
      ),
    );
  }
}
