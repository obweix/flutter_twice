
import 'package:flutter/material.dart';


class Diagram extends StatefulWidget {
  const Diagram({Key? key,required this.data,this.itemInterval = 30}) : super(key: key);

  final List<DiagramPoint> data;

  final int itemInterval;

  @override
  _DiagramState createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {

  int get maxCrossAxisPosition{
    int max = 0;
    widget.data.forEach((element) {
      if (element.crossAxisPosition > max) {
        max = element.crossAxisPosition;
      }
    });
    return max;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder:(_,constraints) {
         final double maxHeight = constraints.maxHeight - 20;
          print(constraints);
          return CustomPaint(
            child: ListView.builder(
                itemCount: widget.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,i){
                  print(widget.data[i].crossAxisPosition /
                      maxCrossAxisPosition *
                      maxHeight);
                  return Row(
                    children: [
                      SizedBox(width: widget.itemInterval.toDouble(),),
                      Column(
                        children:[
                        Container(
                          width: widget.itemInterval.toDouble(),
                          height: (1 -
                                  widget.data[i].crossAxisPosition /
                                      maxCrossAxisPosition) *
                              maxHeight,
                          color: Colors.transparent,
                        ),
                        Container(
                          width: widget.itemInterval.toDouble(),
                          height: widget.data[i].crossAxisPosition /
                              maxCrossAxisPosition *
                              maxHeight,
                          color: Colors.blue[200],
                        ),
                          Center(child:  Container(height: 20,child: Text('示例：$i'),)),
                        ]
                      ),
                    ],
                  );
                }),
            painter: _DiagramPainter(widget.data),
          );
        },
      ),
    );
  }
}

class DiagramPoint {
  final int mainAxisPosition;
  final int crossAxisPosition;

  DiagramPoint(this.mainAxisPosition, this.crossAxisPosition);
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter(this.data);

  final List<DiagramPoint> data;

  static const bottomPadding = 20;


  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    canvas.drawLine(Offset.zero, Offset(0, size.height - bottomPadding),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 1);
    canvas.drawLine(Offset(0, size.height - bottomPadding), Offset(size.width, size.height -bottomPadding),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant _DiagramPainter oldDelegate) {
    return true;
  }

}
