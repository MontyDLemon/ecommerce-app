class Product {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<dynamic> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  static Product fromJson(Map<String, dynamic> data) {
    final newProduct = Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      discountPercentage: data['discountPercentage'].toDouble(),
      //in un solo campo rating è intero, in tutti gli altri è double -.-, quindi così funziona
      rating: data['rating'].toDouble(),
      stock: data['stock'],
      brand: data['brand'],
      category: data['category'],
      thumbnail: data['thumbnail'],
      images: data['images'],
    );
    return newProduct;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images,
      };

  @override
  String toString() => "id: $id, title: $title, rating: $rating";
}
