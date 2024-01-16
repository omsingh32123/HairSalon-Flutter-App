import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String phonenumber;
  HomePage({super.key,  required this.phonenumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(backgroundColor: const Color.fromARGB(0, 0, 0, 0) , child: Image.asset("assets/images/logo.png", height: 35, width: 35,)),
        title: const Column(
          mainAxisAlignment : MainAxisAlignment.start,
          children: [
            Text(
              "Good Morning",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Shushma Shukla",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 10, 15),
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: const Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(children: [
              Icon(
                Icons.search,
                size: 30,
                color:  Color.fromARGB(255, 108, 108, 108),
              ),
              SizedBox(width: 13,),
              Flexible(
                child: TextField(
                  decoration:
                      InputDecoration(border: InputBorder.none),
                ),
              ),
            ]),
          ),
          const Expanded(
            child:  SingleChildScrollView(
              child: Column(children: [
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
                SizedBox( height: 80, ),
                Text("data"),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
