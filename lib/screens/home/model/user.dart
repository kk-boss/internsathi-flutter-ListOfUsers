class User {
  final num id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final Company company;

  User(this.id, this.name, this.username, this.email, this.phone, this.company);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] ?? 0,
      map['name'] ?? '',
      map['username'] ?? '',
      map['email'] ?? '',
      map['phone'] ?? '',
      Company.fromMap(map['company'] ?? ''),
    );
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase, this.bs);

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      map['name'] ?? '',
      map['catchPhrase'] ?? '',
      map['bs'] ?? '',
    );
  }
}
