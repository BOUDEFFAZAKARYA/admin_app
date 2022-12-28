import 'package:admin_app/addproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Panel',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
        selectedRoute: ' /',
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
          height: 60,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Header',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        footer: Container(
          height: 60,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Footer',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(50),
            child: const Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Text('More details :'),
          const Text('The number of app visitors :'),
        ]),
      ),
    );
  }
}
