import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'homepage.dart';
import 'models/categorymodel.dart';
import 'models/typemodel.dart';

Future<List<CategoryModel>> fetchData() async {
  var response =
      await http.get(Uri.parse("http://localhost:4000/api/getCategory/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelscategory) => CategoryModel.fromJson(modelscategory))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<TypeModel>> fetchData1() async {
  var response =
      await http.get(Uri.parse("http://localhost:4000/api/getType/"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body.toString());
    return jsonResponse
        .map((modelstypes) => TypeModel.fromJson(modelstypes))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

createImage(int id, String name, String desc, String path, int idcat, int idtyp,
    bytes) {
  final uri = Uri.parse('http://localhost:4000/api/postProduct/add-product');
  var request = http.MultipartRequest('POST', uri)
    ..fields['barCode'] = id.toString()
    ..fields['nameProduct'] = name
    ..fields['descProduct'] = desc
    ..fields['typepeauIdTypePeau'] = idtyp.toString()
    ..fields['categoryIdCategory'] = idcat.toString();
  final httpImage =
      http.MultipartFile.fromBytes('profile', bytes, filename: path);
  request.files.add(httpImage);

  // ignore: unused_local_variable
  final response = request.send();
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  //Uint8List webImage = Uint8List(8);
  late Future<List<CategoryModel>> futureData;
  final CategoryModel modelscategory = CategoryModel();
  late Future<List<TypeModel>> futureData1;
  final TypeModel modelstypes = TypeModel();

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    futureData1 = fetchData1();
  }

  var myController0 = TextEditingController();
  var myController1 = TextEditingController();
  var myController2 = TextEditingController();
  var myController3 = TextEditingController();

  int selectedRadio = 0;
  bool isSelected = false;
  setSlectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  int selectedRadio1 = 0;
  bool isSelected1 = false;
  setSlectedRadio1(val1) {
    setState(() {
      selectedRadio1 = val1;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Product added Succefully '),
                Icon(Icons.sentiment_satisfied_sharp),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OKAY '),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddProductPage()));
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: unused_element
  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Product already exist'),
                Icon(Icons.sentiment_dissatisfied_sharp),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OKAY '),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool valeur0 = false;
  bool valeur1 = false;
  bool valeur2 = false;
  bool valeur3 = false;
  bool valeur4 = false;
  bool valeur5 = false;
  // ignore: prefer_typing_uninitialized_variables
  var bytes;
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Panel',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        centerTitle: true,
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Product Management',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(
                  title: 'Category Management',
                  icon: Icons.category_outlined,
                  children: [
                    AdminMenuItem(
                      title: 'Add Catgory',
                      route: '/addcategory',
                    ),
                    AdminMenuItem(
                      title: 'Update Catgory',
                      route: '/updatecategory',
                    ),
                    AdminMenuItem(
                      title: 'Remove Catgory',
                      route: '/removecategory',
                    ),
                  ]),
              AdminMenuItem(
                  title: 'Type Management',
                  icon: Icons.category_outlined,
                  children: [
                    AdminMenuItem(
                      title: 'Add Type',
                      route: '/addtype',
                    ),
                    AdminMenuItem(
                      title: 'Update Type',
                      route: '/updatetype',
                    ),
                    AdminMenuItem(
                      title: 'Remove Type',
                      route: '/removetype',
                    ),
                  ]),
              AdminMenuItem(
                title: 'Add Product',
                route: '/addproduct',
              ),
              AdminMenuItem(
                title: 'Delete Product',
                route: '/deleteproduct',
              ),
              AdminMenuItem(
                title: 'Change Product',
                route: '/changeproduct',
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Account Management',
            icon: Icons.person,
            children: [
              AdminMenuItem(
                title: 'Delete Account',
                route: '/deleteaccount',
              ),
            ],
          ),
        ],
        selectedRoute: '/addproduct',
        onSelected: (item) {
          if (item.route == '/addproduct') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
          }
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
          if (item.route == '/') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('BarCode of Product : ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(30, 0, 500, 0),
              child: TextField(
                controller: myController0,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'BarCode ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Visibility(
              visible: valeur0,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'BarCode input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('Name of Product : ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(30, 0, 500, 0),
              child: TextField(
                controller: myController1,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Visibility(
              visible: valeur1,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'NameProduct input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('Description of Product : ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(30, 0, 500, 0),
              child: TextField(
                controller: myController2,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'desc ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Visibility(
              visible: valeur2,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'DescriptionProduct input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('Image of Product: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(30, 0, 500, 20),
              child: TextField(
                controller: myController3,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'path',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
              ),
            ),
            Visibility(
              visible: valeur3,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'ImageProduct input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: const Text('UPLOAD FILE'),
                onPressed: () async {
                  if (kIsWeb) {
                    if (kIsWeb) {
                      var file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        myController3.text = file.name;
                        var f = await file.readAsBytes();
                        bytes = f;
                      } else {
                        //print('no image selected');
                      }
                    }
                  }
                },
              ),
            ]),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('Categorie of Product: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            FutureBuilder(
                future: futureData,
                builder: ((context, snapshot) {
                  // print(snapshot.error);
                  if (snapshot.hasData) {
                    List<CategoryModel> categories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RadioListTile(
                                  title: Text(
                                    categories[index].namecategory.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  value: int.parse(
                                      categories[index].idcategory.toString()),
                                  groupValue: selectedRadio,
                                  activeColor: Colors.black87,
                                  onChanged: (val) {
                                    setState(() {
                                      setSlectedRadio(val);
                                      isSelected = true;
                                    });
                                  },
                                  // ignore: unrelated_type_equality_checks
                                  selected: selectedRadio ==
                                      int.parse(categories[index]
                                          .idcategory
                                          .toString())),
                            ],
                          );
                        });
                  } else {
                    return const Text('no categories');
                  }
                })),
            Visibility(
              visible: valeur4,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'CategorieProduct input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: const Text('Type Skin of Product: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none))),
            FutureBuilder(
                future: futureData1,
                builder: ((context, snapshot) {
                  // print(snapshot.error);
                  if (snapshot.hasData) {
                    List<TypeModel> types = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RadioListTile(
                                  title: Text(
                                    types[index].nameType.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  value:
                                      int.parse(types[index].idType.toString()),
                                  groupValue: selectedRadio1,
                                  activeColor: Colors.black87,
                                  onChanged: (val) {
                                    setState(() {
                                      setSlectedRadio1(val);
                                      isSelected1 = true;
                                    });
                                  },
                                  // ignore: unrelated_type_equality_checks
                                  selected: selectedRadio1 ==
                                      int.parse(
                                          types[index].idType.toString())),
                            ],
                          );
                        });
                  } else {
                    return const Text('no types');
                  }
                })),
            Visibility(
              visible: valeur5,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: const Text(
                    'TypeSkin input is required !',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 15),
                  )),
            ),
            Container(
              margin: const EdgeInsets.all(50),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          if (myController0.text.isEmpty) {
                            valeur0 = !valeur0;
                          }
                          if (myController1.text.isEmpty) {
                            valeur1 = !valeur1;
                          }
                          if (myController2.text.isEmpty) {
                            valeur2 = !valeur2;
                          }
                          if (myController3.text.isEmpty) {
                            valeur3 = !valeur3;
                          }
                          if (selectedRadio == 0) {
                            valeur4 = !valeur4;
                          }
                          if (selectedRadio1 == 0) {
                            valeur5 = !valeur5;
                          }
                        });
                        if ((myController0.text.isNotEmpty) &&
                            (myController1.text.isNotEmpty) &&
                            (myController2.text.isNotEmpty) &&
                            (myController3.text.isNotEmpty) &&
                            (selectedRadio != 0) &&
                            (selectedRadio1 != 0)) {
                          createImage(
                              int.parse(myController0.text.toString()),
                              myController1.text.toString(),
                              myController2.text.toString(),
                              myController3.text.toString(),
                              selectedRadio,
                              selectedRadio1,
                              bytes);
                          _showMyDialog();
                          /*if (await createImage(
                              int.parse(myController0.text.toString()),
                              myController1.text.toString(),
                              myController2.text.toString(),
                              myController3.text.toString(),
                              selectedRadio,
                              selectedRadio1)) {
                            _showMyDialog();
                          } else {
                            _showMyDialog1();
                          }*/
                        }
                      },
                      child: const Text(
                        ' +  Add  +',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
