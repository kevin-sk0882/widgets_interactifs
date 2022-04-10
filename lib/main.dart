import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:widgets_interactifs/widgets/datepickerviews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Interactifs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Widgets Interactifs'),
      debugShowCheckedModeBanner: false,
      locale: const Locale('fr', 'FR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TextField
  String change = "";
  String submitted = "";

  //CheckPoint
  Map check = {
    "Carottes": false,
    "Bananes": false,
    "Yaourt": false,
    "Pain": false
  };
  List<Widget> checkList() {
    List<Widget> l = [];
    check.forEach((key, value) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(color: (value) ? Colors.green : Colors.red),
          ),
          Checkbox(
            value: value,
            onChanged: (bool? b) {
              setState(() {
                check[key] = b;
              });
            },
          )
        ],
      );
      l.add(row);
    });
    return l;
  }

  //Radio
  int? itemSelected;
  List<Widget> radioList() {
    List<Widget> l = [];
    for (var i = 0; i < 4; i++) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Choix numero ${i + 1}"),
          Radio(
            value: i,
            groupValue: itemSelected,
            onChanged: (int? value) {
              setState(() {
                itemSelected = value ?? 0;
              });
            },
          ),
        ],
      );
      l.add(row);
    }
    return l;
  }

  //Switch
  bool? interrupteur;

  //Slider
  double sliderDouble = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(25),
                ),
                Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (String string) {
                          setState(() {
                            change = string;
                          });
                        },
                        onSubmitted: (String string) {
                          setState(() {
                            submitted = string;
                          });
                        },
                        onEditingComplete: () {},
                        decoration: const InputDecoration(
                          labelText: "Entrer votre nom",
                        ),
                      ),
                      Text(change),
                      Text(submitted),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: checkList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: radioList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.emoji_emotions,
                            color: Colors.yellow,
                          ),
                          Text(
                              "${((interrupteur) ?? false) ? "Eteint" : "Allume à ${sliderDouble.toInt()}"} la lumiere ..."),
                          Switch(
                            value: interrupteur ?? false,
                            onChanged: (bool b) {
                              setState(() {
                                interrupteur = b;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: Slider(
                        value: sliderDouble,
                        min: 0,
                        max: 20,
                        onChanged: (value) {
                          setState(() {
                            sliderDouble = value;
                          });
                        },
                        divisions: 5,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext builder) => const AfficheDate(),
                      ),
                    );
                  },
                  child: const Text("Page suivante pour les DatePicker"),
                  style: ButtonStyle(
                    elevation:
                        MaterialStateProperty.resolveWith((states) => 10),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
