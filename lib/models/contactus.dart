


class ContactusModel {
  ContactusModel({
    this.name,
    this.email,
    this.subject,
    this.message,
  });

  String name;
  String email;
  String subject;
  String message;

  factory ContactusModel.fromJson(Map<String, dynamic> json) {
    return ContactusModel(
      name: json["name"],
      email: json["email"],
      subject: json["subject"],
      message: json["message"],
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "subject": subject,
      "message": message,
    };
  }
}
