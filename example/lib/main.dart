import 'dart:math';
import 'dart:async';

import 'package:flutter/services.dart';

import 'index.dart';
import 'package:flutter_twice/index.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
        home: Scaffold(
      appBar: AppBar(title: Text("Flutter Twice")),
      body: Builder(builder: (context) {
        return Column(children: [
          Expanded(
            child: ListView(children: [
              ListTile(
                title: Text("DragOpenDrawer"),
                onTap: () => Navigator.of(context).pushNamed(Routes.pageDragOpenDrawer),
              ),
              ListTile(
                title: Text("PageExpandedListTile"),
                onTap: () =>  Navigator.of(context).pushNamed(Routes.pageExpandedListTile),
              ),
              ListTile(
                title: Text("PageDiagram"),
                onTap: () =>  Navigator.of(context).pushNamed(Routes.pageDiagram),
              ),
              ListTile(
                title: Text("PageNetworkStatusNotifier"),
                onTap: () =>  Navigator.of(context).pushNamed(Routes.pageNetworkStatusNotifier),
              ),
              ListTile(
                title: Text(Routes.pageCustomText),
                onTap: () =>  Navigator.of(context).pushNamed(Routes.pageCustomText),
              ),
            ]),
          ),
        ]);
      }),
    ));
  }
}

