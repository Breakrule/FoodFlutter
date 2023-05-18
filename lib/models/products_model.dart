class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products => _products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products,
  }) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products!.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductsModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }
}

// class Product {
//   int? totalSize;
//   int? typeId;
//   int? offset;
//   late List<ProductsModel> products;

//   Product({
//     required this.totalSize,
//     required this.typeId,
//     required this.offset,
//     required this.products,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     try {
//       return Product(
//         totalSize: json['total_size'] ?? 0,
//         typeId: json['type_id'] ?? 0,
//         offset: json['offset'] ?? 0,
//         products: (json['products'] as List<dynamic>?)
//                 ?.map((x) => ProductsModel.fromJson(x))
//                 ?.toList() ??
//             [],
//       );
//     } catch (e) {
//       print('Error parsing product: $e');
//       return Product(totalSize: 0, typeId: 0, offset: 0, products: []);
//     }
//   }
// }

// class ProductsModel {
//   int? id;
//   String? name;
//   String? description;
//   int? price;
//   int? stars;
//   String? img;
//   String? location;
//   String? createdAt;
//   String? updatedAt;
//   int? typeId;

//   ProductsModel({
//     this.id,
//     this.name,
//     this.description,
//     this.price,
//     this.stars,
//     this.img,
//     this.location,
//     this.createdAt,
//     this.updatedAt,
//     this.typeId,
//   });

//   factory ProductsModel.fromJson(Map<String, dynamic> json) {
//     return ProductsModel(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       price: json['price'],
//       stars: json['stars'],
//       img: json['img'],
//       location: json['location'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       typeId: json['type_id'],
//     );
//   }
// }
