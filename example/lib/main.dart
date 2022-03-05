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
            ]),
          ),
        ]);
      }),
    ));
  }
}

class NavigateListTile extends StatelessWidget {
  const NavigateListTile({required this.onNavigate, required this.title, Key? key})
      : super(key: key);

  final String title;
  final Function() onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF222222), fontSize: 15),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return onNavigate.call();
        }));
      },
    );
  }
}
