import 'package:flutter/material.dart';

class Diagram extends StatefulWidget {
  const Diagram({Key? key, required this.data, this.itemInterval = 30})
      : super(key: key);

  final List<DiagramPoint> data;

  final int itemInterval;

  @override
  _DiagramState createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {
  int? _selectedIndex;

  int get maxCrossAxisPosition {
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
        builder: (_, constraints) {
          final double maxHeight = constraints.maxHeight - 20;
          print(constraints);
          final children  = CustomPaint(
            child: ListView.builder(
                itemCount: widget.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (itemContext, i) {
                  // print(widget.data[i].crossAxisPosition /
                  //     maxCrossAxisPosition *
                  //     maxHeight);
                  return  LayoutBuilder(
                    builder: (_, constraints){
                      print(constraints);
                      return Row(
                        children: [
                          SizedBox(
                            width: widget.itemInterval.toDouble(),
                          ),
                          _buildDiagramItem(i, maxHeight),
                        ],
                      );
                    },
                  );

                }),
            painter: _DiagramPainter(
                data: widget.data,
                selectedIndex: _selectedIndex,
                itemInterval: widget.itemInterval),
          );

          return children;
        },
      ),
    );
  }

  CustomPaint _buildDiagramItem(int i, double maxHeight) {
    return CustomPaint(
      foregroundPainter: _SelectedItemPainter(isSelected: i == _selectedIndex),
      child: Column(children: [
        Container(
          width: widget.itemInterval.toDouble(),
          height:
              (1 - widget.data[i].crossAxisPosition / maxCrossAxisPosition) *
                  maxHeight,
          color: Colors.transparent,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = i;
            });
          },
          child: Container(
            key: ValueKey(i),
            width: widget.itemInterval.toDouble(),
            height: widget.data[i].crossAxisPosition /
                    maxCrossAxisPosition *
                    maxHeight -
                1,
            color: i == _selectedIndex ? Colors.pink[200] : Colors.blue[200],
          ),
        ),
        Center(
            child: Container(
          height: 21,
          child: Text('示例：$i'),
        )),
      ]),
    );
  }
}

class DiagramPoint {
  final int mainAxisPosition;
  final int crossAxisPosition;

  DiagramPoint(this.mainAxisPosition, this.crossAxisPosition);
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter(
      {required this.itemInterval, required this.data, this.selectedIndex});

  final List<DiagramPoint> data;
  final int? selectedIndex;
  final int itemInterval;

  static final bottomPadding = 20;
  static final _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    canvas.drawLine(
        Offset.zero, Offset(0, size.height - bottomPadding), _paint);
    canvas.drawLine(Offset(0, size.height - bottomPadding),
        Offset(size.width, size.height - bottomPadding), _paint);


  }

  @override
  bool shouldRepaint(covariant _DiagramPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _SelectedItemPainter extends CustomPainter{
  _SelectedItemPainter({this.isSelected=false});

  final bool isSelected;

  final lineLength = 6;

  @override
  void paint(Canvas canvas, Size size) {
    if(isSelected){
      final Paint paint = Paint()
          ..color = Colors.green;
      final height = size.height;
      double hOffset = 0;
      while(hOffset < height-lineLength){
        canvas.drawLine(Offset(size.width/2,hOffset), Offset(size.width/2,hOffset+lineLength), paint);
        hOffset += lineLength*2;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
