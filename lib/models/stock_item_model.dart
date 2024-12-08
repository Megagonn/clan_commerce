class StockItemModel {
  String itemId, name, description, category, image;
  double rates, price, discountPrice;
  int likes, reviews;
  List specs;
  // bool favorites;

  StockItemModel({
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
    // required this.favorites,
    required this.rates,
  });

  factory StockItemModel.fromJson(Map json) {
    return StockItemModel(
        category: json['category'],
        description: json['description'],
        itemId: json['itemId'],
        name: json['name'],
        image: json['imagePath'],
        discountPrice: json['discountPrice'],
        price: json['price'],
        likes: json['likes'],
        reviews: json['reviews'],
        specs: json['specs'],
        // favorites: json['favorites'],
        rates: json['rates']);
  }
  Map toJson(){
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
      
    };
  }
}
