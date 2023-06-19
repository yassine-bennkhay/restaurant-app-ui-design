import 'package:flutter/material.dart';
import 'package:foody/data/data.dart';
import 'package:foody/utils/constants.dart';

import '../models/order.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});
  _buildRecentOrder(BuildContext context, Order? order) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 320,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.grey.shade200)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  height: 100,
                  width: 100,
                  image: AssetImage(order!.food!.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.food!.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        order.restaurant!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        order.date!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: 48,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Recent Orders",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: currentUser.orders!.length,
              itemBuilder: (BuildContext context, index) {
                Order? order = currentUser.orders?[index];
                return _buildRecentOrder(context, order);
              }),
        )
      ],
    );
  }
}
