class CartItemModel {
  String itemId, name, description, category, image;
  double rates, price, discountPrice;
  int likes, reviews, count;
  List specs;
  bool favorites;

  CartItemModel({
    required this.category,
    required this.description,
    required this.itemId,
    required this.name,
    required this.discountPrice,
    required this.image,
    required this.price,
    required this.likes,
    required this.reviews,
    required this.specs,
    required this.favorites,
    required this.rates,
    required this.count,
  });

  factory CartItemModel.fromJson(Map json) {
    return CartItemModel(
        category: json['category'],
        description: json['description'],
        itemId: json['itemId'],
        name: json['name'],
        image: json['image'],
        discountPrice: json['discountPrice'],
        price: json['price'],
        likes: json['likes'],
        count: json['count'] ?? 1,
        reviews: json['reviews'],
        specs: json['specs'],
        favorites: json['favorites'] ?? false,
        rates: json['rates']);
  }
  Map toJson() {
    return {
      'itemId': itemId,
      'category': category,
      'description': description,
      'name': name,
      'image': image,
      'discountPrice': discountPrice,
      'price': price,
      'likes': likes,
      'rates': rates,
      'reviews': reviews,
      'specs': specs,
      'count': count,
    };
  }
}
