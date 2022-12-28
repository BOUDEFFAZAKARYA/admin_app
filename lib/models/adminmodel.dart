class AdminModel {
  final String? idAdmin;
  final String? emailAdmin;
  final String? passwordAdmin;

  AdminModel({this.emailAdmin, this.idAdmin, this.passwordAdmin});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      emailAdmin: json["emailAdmin"],
      idAdmin: json["idAdmin"],
      passwordAdmin: json["passwordAdmin"],
    );
  }
}
