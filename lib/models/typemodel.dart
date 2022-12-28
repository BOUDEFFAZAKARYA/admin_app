class TypeModel {
  final String? idType;
  final String? nameType;

  TypeModel({this.nameType, this.idType});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      nameType: json["nameTypePeau"],
      idType: json["idTypePeau"],
    );
  }
}
