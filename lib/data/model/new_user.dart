class NewUser {
  String? email;
  String? password;
  String? name;
  int? age;
  String? address;
  DateTime? dateOfBirth;

  NewUser({
    this.email,
    this.password,
    this.name,
    this.age,
    this.address,
    this.dateOfBirth,
  });

  static List<NewUser> users = [
    NewUser(
      email: 'a@a.a',
      password: '123123',
      name: 'User 1',
      age: 25,
      address: 'Address 1',
      dateOfBirth: DateTime(1996, 10, 15),
    ),
  ];
}
