class User {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String password;
  final bool verified;
  final bool owner;
  final int cardnumber;
  final String sheba;
  final String city;
  final String province;
  final String address;
  final int postalcode;
  final List<dynamic> imgs;
  final dynamic token;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.password,
    required this.verified,
    required this.owner,
    required this.cardnumber,
    required this.sheba,
    required this.city,
    required this.province,
    required this.address,
    required this.postalcode,
    required this.token,
    required this.imgs,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      verified: json['verified'],
      owner: json['owner'],
      cardnumber: json['cardnumber'],
      sheba: json['sheba'],
      city: json['city'],
      province: json['province'],
      address: json['address'],
      postalcode: json['postalcode'],
      imgs: json['imgs'],
      token: json['token'],
    );
  }
}
