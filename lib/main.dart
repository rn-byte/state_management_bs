import 'package:flutter/material.dart';
import 'package:state_mgmt_contacts_book/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/new-contact': (context) => NewContactView(),
      //   '/home': (context) => const Home(),
      // },

      // For navigating
      //Navigator.of(context).pushNamed('/home');
      home: const Home(),
    );
  }
}
