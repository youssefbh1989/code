class Product {
  final String productName;
  final String productImageUrl;
  final double currentPrice;
  final String oldPrice;
  final bool isLiked;

  const Product({
     this.productName,
     this.productImageUrl,
     this.currentPrice,
     this.oldPrice,
     this.isLiked,
  });
}

class Category {
  final String categoryName;
  final String productCount;
  final String thumbnailImage;

  const Category({
     this.categoryName,
     this.productCount,
     this.thumbnailImage,
  });
}

// list of categories
final categories = [
  const Category(
    categoryName: "T-SHIRT",
    productCount: "240",
    thumbnailImage:
        "https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  ),
  const Category(
    categoryName: "SHOES",
    productCount: "120",
    thumbnailImage:
        "https://images.unsplash.com/photo-1595341888016-a392ef81b7de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1179&q=80",
  ),
  const Category(
    categoryName: "HODDIE",
    productCount: "200",
    thumbnailImage:
        "https://images.unsplash.com/photo-1647771746277-eac927afab2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  ),
  const Category(
    categoryName: "JEANS",
    productCount: "240",
    thumbnailImage:
        "https://images.unsplash.com/photo-1576995853123-5a10305d93c0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  ),
];

// list of products
final products = [
  const Product(
    productName: "MNML - Oversized Tshirt",
    productImageUrl: "assets/onbording/image1.jpeg",
    currentPrice: 500,
    oldPrice: "700",
    isLiked: true,
  ),
  const Product(
    productName: "Crop Top Hoddie",
    productImageUrl: "assets/onbording/image2.jpeg",
    currentPrice: 392,
    oldPrice: "400",
    isLiked: false,
  ),
  const Product(
    productName: "Half Tshirt",
    productImageUrl:
        "assets/onbording/image3.jpeg",
    currentPrice: 204,
    oldPrice: "350",
    isLiked: true,
  ),
  const Product(
    productName: "Best Fit Women Outfit",
    productImageUrl:
        "assets/onbording/image4.jpeg",
    currentPrice: 540,
    oldPrice: "890",
    isLiked: true,
  ),
  const Product(
    productName: "Strip Tourser",
    productImageUrl:
        "assets/onbording/image5.jpeg",
    currentPrice: 230,
    oldPrice: "750",
    isLiked: false,
  ),
  const Product(
    productName: "MNML - Jeans",
    productImageUrl:
        "assets/onbording/image1.jpeg",
    currentPrice: 240,
    oldPrice: "489",
    isLiked: false,
  ),
  const Product(
    productName: "MNML - Jeans",
    productImageUrl:
        "assets/onbording/image2.jpeg",
    currentPrice: 240,
    oldPrice: "489",
    isLiked: false,
  ),
  const Product(
    productName: "Half Tshirt",
    productImageUrl:
        "assets/onbording/image3.jpeg",
    currentPrice: 204,
    oldPrice: "350",
    isLiked: true,
  ),
];

List<String> tShirts = ['T-Shirt 1', 'T-Shirt 2', 'T-Shirt 3'];
List<String> shoes = ['Shoes 1', 'Shoes 2', 'Shoes 3'];
List<String> hoodies = ['Hoodie 1', 'Hoodie 2', 'Hoodie 3'];
List<String> jeans = ['Jeans 1', 'Jeans 2', 'Jeans 3'];

