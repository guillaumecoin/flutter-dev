class User {
  final int idUser;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;
  final String streetName;
  final int streetNumber;
  final String pwdHash;
  final int zipCode;
  final String city;
  final String photoUrl;
  final String siret;
  final String companyName;

  User(
      {required this.idUser,
      required this.lastName,
      required this.dateOfBirth,
      required this.email,
      required this.streetName,
      required this.streetNumber,
      required this.pwdHash,
      required this.zipCode,
      required this.city,
      required this.photoUrl,
      required this.siret,
      required this.companyName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        idUser: json['idUser'],
        lastName: json['lastName'],
        dateOfBirth: json['dateOfBirth'],
        email: json['email'],
        streetName: json['streetName'],
        streetNumber: json['streetNumber'],
        pwdHash: json['pwdHash'],
        zipCode: json['zipCode'],
        city: json['city'],
        photoUrl: json['photoUrl'],
        siret: json['siret'],
        companyName: json['companyName']);
  }
}
