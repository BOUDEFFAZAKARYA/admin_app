import 'dart:convert';

import 'package:admin_app/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
Future<bool> VerifyAdmin(String email, String password) async {
  var response = await http.post(
    Uri.parse("http://localhost:4000/api/getAdmin"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "emailAdmin": email,
      "passwordAdmin": password,
    }),
  );
  if (response.statusCode == 200) {
    final jsonresponse = jsonDecode(response.body);
    return jsonresponse;
  } else {
    throw Exception('Failed to get Admin');
  }
}

void main() {
  runApp(const MyApp());
}

final ScrollController controller = ScrollController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: FirstPage());
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var myController0 = TextEditingController();
  var myController1 = TextEditingController();

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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
                Text('Please Enter your informations '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OKAY '),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FirstPage()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Incorrect information entered'),
                Text('Please check your email, password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OKAY '),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FirstPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                margin: const EdgeInsets.all(60),
                child: const Center(
                    child: Text('Welcome to the admin interface',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none))),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: const Text('Email : ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none))),
              Container(
                margin: const EdgeInsets.fromLTRB(500, 0, 500, 20),
                child: TextField(
                  controller: myController0,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email ',
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
              Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: const Text('Password : ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none))),
              Container(
                margin: const EdgeInsets.fromLTRB(500, 0, 500, 20),
                child: TextField(
                  controller: myController1,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      suffixIcon: _obscureText
                          ? IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () => _toggle(),
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () => _toggle(),
                            ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'password',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(50),
                child: SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (kIsWeb) {
                            if ((myController0.text.isEmpty) ||
                                (myController1.text.isEmpty)) {
                              _showMyDialog();
                            } else {
                              if (await VerifyAdmin(
                                  myController0.text.toString(),
                                  myController1.text.toString())) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              } else {
                                _showMyDialog1();
                              }
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 25),
                        ))),
              ),
            ],
          ),
        ));
  }
}
