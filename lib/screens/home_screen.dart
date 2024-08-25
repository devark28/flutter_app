import 'package:flutter/material.dart';
import 'package:flutter_app/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DetailsScreen()));
              },
              child: const Text("Next Screen"))),
    );
  }
}
