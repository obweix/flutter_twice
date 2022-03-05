import 'package:flutter/material.dart';
import 'package:flutter_twice/diagram.dart';

class PageDiagram extends StatefulWidget {
  const PageDiagram({Key? key}) : super(key: key);

  @override
  _PageDiagramState createState() => _PageDiagramState();
}

class _PageDiagramState extends State<PageDiagram> {
  final _data = List.generate(10, (index) => DiagramPoint(index+1, (index+1)*10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageDiagram"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: Diagram(
            data: _data,
          ),
        ),
      ),
    );
  }
}
