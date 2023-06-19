import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foody/utils/constants.dart';

import '../data/data.dart';
import '../widgets/bottom_item.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;

  final List _barItems = [
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": const HomeScreen(),
    },
    {
      "icon": "assets/icons/heart.svg",
      "active_icon": "assets/icons/heart.svg",
      "page": Container(
        child: const Center(child: Text("Second")),
      ),
    },
    {
      "icon": "assets/icons/bookmark.svg",
      "active_icon": "assets/icons/bookmark.svg",
      "page": Container()
    },
    {
      "icon": "assets/icons/profile.svg",
      "active_icon": "assets/icons/profile.svg",
      "page": Container(),
    },
  ];
  void onPageChanged(int index) {
    setState(() {
      _activeTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text("Food Delivery"),
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/profile.svg",
                width: 23,
                height: 23,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen())),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/cart.svg",
                        width: 23,
                        height: 23,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn)),
                    Text(
                      "(${currentUser.cart?.length})",
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ))
          ]),
      bottomNavigationBar: _buildBottomBar(),
      body: _buildPage(),
    );
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _barItems.length,
        (index) => _buildAnimatedPage(_barItems[index]["page"]),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _barItems.length,
            (index) => BottomBarItem(
              _barItems[index]["icon"],
              isActive: _activeTab == index,
              activeColor: AppColors.primaryColor,
              onTap: () {
                onPageChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
