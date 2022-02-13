import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_twice/flutter_twice.dart';
import 'package:flutter_twice/drag_open_drawer.dart';

void main() {
  runApp(const MyApp());
}

final List<DiagramPoint> data =
    List.generate(10, (index) => DiagramPoint(index, (10 + index) * 30));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("drag open drawer"),
        ),
        body: Column(
          children:  [
            Expanded(
              child: DragOpenDrawer(
                openDuration: Duration(microseconds: 900),
                closeDuration: Duration(milliseconds: 300),
                onOpen: (){
                  print("onOpen");
                },
               child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: 40,
                            itemBuilder: (context,index){
                          return ListTile(title: Text("$index"),);
                        }),
                      ),
                    ]
                  ),
                backgroundBuilder: (context){
                  return Container(child: FlutterLogo(style: FlutterLogoStyle.stacked,),color: Colors.blue[200],);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


