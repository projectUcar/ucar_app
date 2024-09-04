class ProfileModel {
  String _id, firstName, lastName, email, carrer, phoneNumber, gender;
  List<String> roles;
  
  ProfileModel({required String id, required this.firstName, required this.lastName, required this.email, required this.carrer, required this.phoneNumber, required this.gender, required this.roles}) : _id = id;
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    carrer: json["carrer"],
    phoneNumber: json["phoneNumber"],
    gender: json["gender"],
    roles: List<String>.from(json["roles"].map((x) => x)),
  );

  String get id => _id;

  Map<String, dynamic> toJson() => {
    "_id": _id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "carrer": carrer,
    "phoneNumber": phoneNumber,
    "gender": gender,
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}