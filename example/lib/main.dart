import 'dart:math';
import 'dart:async';

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
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("Flutter Twice")),
      body: Builder(builder: (context) {
        return Column(children: [
          Expanded(
            child: ListView(children: [
              NavigateListTile(
                title: "DragOpenDrawer",
                builder: () => PageDragOpenDrawer(),
              ),
              NavigateListTile(
                title: "PageExpandedListTile",
                builder: () => PageExpandedListTile(),
              ),
            ]),
          ),
        ]);
      }),
    ));
  }
}

class NavigateListTile extends StatelessWidget {
  const NavigateListTile({required this.builder, required this.title, Key? key})
      : super(key: key);

  final String title;
  final Function()? builder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF222222), fontSize: 15),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return builder?.call();
        }));
      },
    );
  }
}
