import 'package:flutter/material.dart';
import 'package:foody/data/data.dart';
import 'package:foody/screens/restaurant_screen.dart';
import 'package:foody/utils/constants.dart';
import 'package:foody/widgets/recent_orders.dart';

import '../widgets/rating_stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildRestaurants() {
    List<Widget> restaurantsList = [];

    for (var restaurant in restaurants) {
      restaurantsList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: restaurant.imageUrl!,
                  child: Image(
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    image: AssetImage(restaurant.imageUrl!),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RatingStars(
                        rating: restaurant.rating!,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        restaurant.address!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        restaurant.farAway!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    }
    return Column(
      children: restaurantsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
              hintText: "Search Food or Restaurants",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: const BorderSide(width: 0.5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: const BorderSide(
                      width: 0.5, color: AppColors.primaryColor)),
            ),
          ),
        ),
        const RecentOrders(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "NearBy Restaurants",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'view All',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 15),
                      )),
                )
              ],
            ),
            _buildRestaurants(),
          ],
        )
      ]),
    );
  }
}
