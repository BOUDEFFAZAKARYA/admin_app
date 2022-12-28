class CategoryModel {
  final String? namecategory;
  final String? idcategory;
  CategoryModel({this.namecategory, this.idcategory});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      namecategory: json["nameCategory"],
      idcategory: json["idCategory"],
    );
  }
}
