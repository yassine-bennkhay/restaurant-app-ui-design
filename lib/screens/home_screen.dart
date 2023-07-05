import 'package:flutter/material.dart';
import 'package:foody/data/data.dart';
import 'package:foody/screens/restaurant_screen.dart';
import 'package:foody/utils/constants.dart';
import 'package:foody/widgets/recent_orders.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/admob_controller.dart';
import '../widgets/rating_stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements BannerAdListener {
  late BannerAd _firstBannerAd;
  late BannerAd _secondBannerAd;
  bool _isBannerAdLoaded = false;

  _buildRestaurants() {
    List<Widget> restaurantsList = [];

    for (var restaurant in restaurants) {
      restaurantsList.add(
        GestureDetector(
          onTap: () {
            AdManager.loadInterstitialAd(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantScreen(restaurant: restaurant),
                ),
              );
            });
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
  void initState() {
    super.initState();
    AdManager.loadBannerAd(this).then((ad) => setState(() {
          _firstBannerAd = ad;
          _isBannerAdLoaded = true;
        }));
    AdManager.loadBannerAd(this).then((ad) => setState(() {
          _secondBannerAd = ad;
          _isBannerAdLoaded = true;
        }));
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
        _isBannerAdLoaded
            ? Center(
                child: SizedBox(
                  height: _secondBannerAd.size.height.toDouble(),
                  width: _secondBannerAd.size.width.toDouble(),
                  child: AdWidget(ad: _secondBannerAd),
                ),
              )
            : const SizedBox(),
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
            _isBannerAdLoaded
  ? Center(
                    child: SizedBox(
                      height: _firstBannerAd.size.height.toDouble(),
                      width: _firstBannerAd.size.width.toDouble(),
                      child: AdWidget(ad: _firstBannerAd),
                    ),
                  )
                : const SizedBox(),
            _buildRestaurants(),
          ],
        )
      ]),
    );
  }

  @override
  // TODO: implement onAdClicked
  AdEventCallback? get onAdClicked => throw UnimplementedError();

  @override
  // TODO: implement onAdClosed
  AdEventCallback? get onAdClosed => throw UnimplementedError();

  @override
  // TODO: implement onAdFailedToLoad
  AdLoadErrorCallback? get onAdFailedToLoad => throw UnimplementedError();

  @override
  // TODO: implement onAdImpression
  AdEventCallback? get onAdImpression => throw UnimplementedError();

  @override
  // TODO: implement onAdLoaded
  AdEventCallback? get onAdLoaded => throw UnimplementedError();

  @override
  // TODO: implement onAdOpened
  AdEventCallback? get onAdOpened => throw UnimplementedError();

  @override
  // TODO: implement onAdWillDismissScreen
  AdEventCallback? get onAdWillDismissScreen => throw UnimplementedError();

  @override
  // TODO: implement onPaidEvent
  OnPaidEventCallback? get onPaidEvent => throw UnimplementedError();
}
