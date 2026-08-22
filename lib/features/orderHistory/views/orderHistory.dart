import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/utils/pref_helpers.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/orderHistory/data/order_model.dart';
import 'package:gap/gap.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({super.key});

  @override
  State<Orderhistory> createState() => _OrderhistoryState();
}

class _OrderhistoryState extends State<Orderhistory> {
  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = PrefHelpers.getPaidOrders();
  }

  Future<void> _deleteOrder(String orderId) async {
    await PrefHelpers.deletePaidOrder(orderId);
    if (!mounted) return;

    setState(() {
      _ordersFuture = PrefHelpers.getPaidOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 25),
          child: CustomText(
            text: 'Order History',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primary,
                    size: 60,
                  ),
                  Gap(10),
                  CustomText(
                    text: 'No paid orders yet..',
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
            itemCount: orders.length,
            itemBuilder: (context, index) => _OrderCard(
              order: orders[index],
              onDelete: () => _deleteOrder(orders[index].id),
            ),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onDelete;

  const _OrderCard({required this.order, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt.toLocal();
    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.receipt_long, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: order.id,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 6),
                    CustomText(text: 'Date: $formattedDate'),
                    const SizedBox(height: 4),
                    CustomText(text: 'Payment: ${order.paymentMethod}'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CustomText(
                          text: 'Total: L.E ${order.total.toStringAsFixed(2)}',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: onDelete,
                          icon: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.paleYellow,
                            ),
                            child: const Icon(
                              CupertinoIcons.delete,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
