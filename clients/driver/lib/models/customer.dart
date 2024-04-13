class Customer {
  final String avatar;
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String default_payment_method;
  final String rank;

  Customer(
      {required this.default_payment_method,
      required this.firstname,
      required this.lastname,
      required this.phonenumber,
      required this.avatar,
      required this.rank});

  bool hasValue() {
    return firstname != "" && lastname != "" && phonenumber != "";
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        firstname: json['firstname'],
        lastname: json['lastname'],
        phonenumber: json['phonenumber'],
        avatar: json['avatar'],
        rank: json['rank'],
        default_payment_method: json['default_payment_method']);
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'avatar': avatar,
        'rank': rank,
        'default_payment_method': default_payment_method,
      };
}
