import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/coordinates.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  static Future<List<Coordinates>> fetchData() async {
    var url = Uri.parse("https://0b89-41-173-31-125.ngrok-free.app");
    var client = HttpClient();
    try {
      HttpClientRequest request = await client.getUrl(url);
      request.headers.set("ngrok-skip-browser-warning", "true");
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      final coordinates = Coordinates.parse(stringData);
      // print("Response: $coordinates");
      return coordinates;
    } finally {
      client.close();
    }
  }

  @override
  State<StatefulWidget> createState() {
    return DetailsState();
  }
}

class DetailsState extends State {
  List<Coordinates> coordinates = [];

  @override
  Widget build(BuildContext context) {
    DetailsScreen.fetchData().then((c) {
      sleep(const Duration(milliseconds: 500));
      setState(() {
        coordinates = c;
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                var url = Uri.parse("https://0b89-41-173-31-125.ngrok-free.app");
                var client = HttpClient();
                try {
                  HttpClientRequest request = await client.getUrl(url);
                  request.headers.set("ngrok-skip-browser-warning", "true");
                  HttpClientResponse response = await request.close();
                  final stringData = await response.transform(utf8.decoder).join();
                  // final data = jsonDecode(stringData);
                  setState(() {
                    coordinates = Coordinates.parse(stringData);
                  });
                  // print("Response: $coordinates");
                } finally {
                  client.close();
                }
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: coordinates.length,
          itemBuilder: (_, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  gradient: const LinearGradient(
                      colors: [Colors.green, Colors.lightGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.2, 0.6],
                      transform: GradientRotation(4 / 6)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green,
                        offset: Offset.fromDirection((5 / 6), 4.0),
                        blurRadius: 10.0,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: -3)
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coordinates[index].id),
                      Text(coordinates[index].x.toString()),
                      Text(coordinates[index].y.toString()),
                    ],
                  ),
                  Row(
                      // margin: const EdgeInsets.only(top: 10),
                      // child: ,
                      children: [Text(coordinates[index].direction)])
                ],
              ),
            );
          }),
    );
  }
}
