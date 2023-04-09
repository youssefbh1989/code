class FilterCategories {
  int id;
  String name;
  String nameAr;
  String description;
  String descriptionAr;
  String price;
  String duration;
  String status;
  String slug;
  String ordered;
  String categoryId;
  String salonId;
  String createdAt;
  String updatedAt;
  List<Images> images;
  Salon salon;
  Category category;

  FilterCategories(
      {this.id,
        this.name,
        this.nameAr,
        this.description,
        this.descriptionAr,
        this.price,
        this.duration,
        this.status,
        this.slug,
        this.ordered,
        this.categoryId,
        this.salonId,
        this.createdAt,
        this.updatedAt,
        this.images,
        this.salon,
        this.category});

  FilterCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
    slug = json['slug'];
    ordered = json['ordered'];
    categoryId = json['category_id'];
    salonId = json['salon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['ordered'] = this.ordered;
    data['category_id'] = this.categoryId;
    data['salon_id'] = this.salonId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.salon != null) {
      data['salon'] = this.salon.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Images {
  String image;
  String serviceId;

  Images({this.image, this.serviceId});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class Salon {
  int id;
  String name;
  String nameAr;
  String type;
  String image;
  String address;
  String addressAr;

  Salon(
      {this.id,
        this.name,
        this.nameAr,
        this.type,
        this.image,
        this.address,
        this.addressAr});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    type = json['type'];
    image = json['image'];
    address = json['address'];
    addressAr = json['address_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['type'] = this.type;
    data['image'] = this.image;
    data['address'] = this.address;
    data['address_ar'] = this.addressAr;
    return data;
  }
}

class Category {
  int id;
  String name;
  String nameAr;
  String image;

  Category({this.id, this.name, this.nameAr, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    return data;
  }
}