import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/restaurant.dart';
import '../utils/constants.dart';
import '../widgets/rating_stars.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant? restaurant;
  const RestaurantScreen({super.key, this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  _buildMenuItem(Food menuItem) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 175.0,
            height: 175.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    menuItem.imageUrl!,
                  )),
            ),
          ),
          Container(
            width: 175.0,
            height: 175.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black87.withOpacity(0.3),
                    Colors.black54.withOpacity(0.3),
                    Colors.black38.withOpacity(0.3),
                  ]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  menuItem.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  "${menuItem.price!.toString()}\$",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ],
            )),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              width: 48,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Hero(
              tag: widget.restaurant!.imageUrl!,
              child: Image(
                  fit: BoxFit.cover,
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage(widget.restaurant!.imageUrl!)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.red,
                    iconSize: 30.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    iconSize: 30.0,
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.restaurant!.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.restaurant!.farAway!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w200, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              RatingStars(
                rating: widget.restaurant!.rating!,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.restaurant!.address!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Reviews"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Contact"),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Menu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(10.0),
            crossAxisCount: 2,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 0.1,
            children: List.generate(widget.restaurant!.menu!.length, (index) {
              Food food = widget.restaurant!.menu![index];
              return _buildMenuItem(food);
            }),
          ),
        ),
      ]),
    );
  }
}
