class Product{
  int id;
  String title;
  String description;
  double price;
  String category;
  String image;
  Rating rating;

  Product.fromJson(Map<String, dynamic> json) :
    id = json['id'], 
    title = json['title'], 
    description = json['description'],
    price = json['price'].toDouble(), 
    category = json['category'], 
    image = json['image'], 
    rating = Rating.fromJson(json['rating']);
}

class Rating{
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count
  });

  factory Rating.fromJson(Map<String, dynamic> json){
    return Rating(
      rate: json['rate'].toDouble(), 
      count: json['count']
    );
  }
}
