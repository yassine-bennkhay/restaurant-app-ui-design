import '../models/food.dart';

class Restaurant {
  final String? imageUrl;
  final String? name;
  final String? address;
  final int? rating;
  final List<Food>? menu;
  final String? farAway;
  Restaurant({
    this.imageUrl,
    this.name,
    this.address,
    this.rating,
    this.menu,
    this.farAway,
  });
}
