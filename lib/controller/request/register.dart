class RegisterRequest {
  late String email;
  late String name;
  late String? address;
  late String? phone;
  late String password;

  @override
  String toString() {
    return "$name, $email, $password, $phone, $address ";
  }
}
