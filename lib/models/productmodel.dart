class ProductModel {
  final String? barcode;
  final String? nameproduct;
  final String? descproduct;
  final String? imageProduct;
  final String? idcategorie;
  final String? idtype;

  ProductModel(
      {this.barcode,
      this.nameproduct,
      this.descproduct,
      this.idcategorie,
      this.idtype,
      this.imageProduct});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      barcode: json["barCode"],
      nameproduct: json["nameProduct"],
      descproduct: json["descProduct"],
      imageProduct: json["pathimage"],
      idcategorie: json["categoryIdCategory"],
      idtype: json["typepeauIdTypePeau"],
    );
  }
}
