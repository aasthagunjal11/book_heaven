class Product {
  final String title;
  final String image;
  final double price;
  final String description;

  Product({
    required this.title,
    required this.image,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parsedPrice = 0.0;
    if (json['price'] != null) {
      try {
        parsedPrice = double.tryParse(json['price'].replaceAll(RegExp(r'[\$,]'), '')) ?? 0.0;
      } catch (e) {
        parsedPrice = 0.0; 
      }
    }

    return Product(
      title: json['title'] ?? 'Unknown Title', 
      image: json['image'] ?? '', 
      price: parsedPrice,
      description: json['description'] ?? 'No description available', 
    );
  }
}
