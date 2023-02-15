import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class Friend {
  String name;
  int color;

  Friend({required this.name, required this.color});
}

List<Friend> myFriends = [
  Friend(name: "Peter", color: 0Xff738f66),
  Friend(name: 'John', color: 0xff5e5e5e),
  Friend(name: 'Sara', color: 0xff9e9e9e),
  Friend(name: 'Max', color: 0xffff9190),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForEach() Method'),
        centerTitle: true,
      ),

      //Refactoring Body in another way

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Click on the button to change the background color',
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: ((context, index) => const Divider()),
              itemCount: myFriends.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(myFriends[index].color),
                    child: ListTile(
                      title: Text(myFriends[index].name),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myFriends.forEach((friend) {
            print("::::::::::::::::");
            print(friend);
            //change the color forEach Friend Container when Pressed
            friend.color = (Random().nextDouble() * 0xFFFFFFFF).toInt();
          });
          //OR
          // for (var friend in myFriends) {
          //   //change the color forEach Friend Container when Pressed
          //   friend.color = (Random().nextDouble() * 0xFFFFFFFF).toInt();
          // }
          setState(() {});
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
