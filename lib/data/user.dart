class User {
  String? email;
  String? password;
  String? name;
  int? age;
  String? address;
  DateTime? dateOfBirth;
  String? userRole;

  User({
    this.email,
    this.password,
    this.name,
    this.age,
    this.address,
    this.dateOfBirth,
    this.userRole,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'userRole': userRole,
    };
  }
}
