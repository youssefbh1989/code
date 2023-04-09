class Busniss {

  final String type;
  final String name;
  final String arabicName;
  final String email;
  final String cr_number;
  final String phone;
  final String image;
  final String coverImage;
  final String cr_copy;
  final String password;
  final String passwordConfirmation;

  Busniss({
    this.type,
    this.name,
    this.arabicName,
    this.email,
    this.phone,
    this.image,
    this.coverImage,
    this.cr_copy,
    this.password,
    this.passwordConfirmation,
    this.cr_number
  });

  factory Busniss.fromJson(Map<String, dynamic> json) {
    return Busniss(
      type: json['type'],
      cr_number: json['cr_number'],
      name: json['name'],
      arabicName: json['name_ar'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      coverImage: json['cover'],
      cr_copy: json['cr_copy'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'cr_number': cr_number,
      'email': email,
      'phone': phone,
      'image': image,
      'cover_image': coverImage,
      'cr_copy': cr_copy,
      'password': password,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }
}