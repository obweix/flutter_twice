import 'index.dart';

class ExpandedListTile extends StatefulWidget {
  const ExpandedListTile(
      {Key? key, required this.title, this.child, this.onTap})
      : super(key: key);

  final String title;
  final Widget? child;
  final Function()? onTap;

  @override
  _ExpandedListTileState createState() => _ExpandedListTileState();
}

class _ExpandedListTileState extends State<ExpandedListTile> {
  bool _isExpanded = false;
  static final Duration _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onTap?.call();
          },
          child: Container(
            color: Color(0xFFEEEEEE),
            padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Color(0xFF222222), fontSize: 15),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0 : -0.5,
                  duration: _animationDuration,
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: AnimatedAlign(
            heightFactor: _isExpanded ? 1.0 : 0.0,
            alignment: Alignment.center,
            duration: _animationDuration,
            child: widget.child),
          ),
      ],
    );
  }
}
