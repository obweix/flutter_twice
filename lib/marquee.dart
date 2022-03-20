import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final Widget child;

  const Marquee({
    required this.child,
    Key? key}) : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarqueeTransition(
        child: widget.child,
        offset: _controller,
        onScroll: (double childWidth) {
          // 无需滚动时终止动画
          if(0 == childWidth){
            _controller.animateTo(0,duration: Duration(seconds:1));
            return;
          }
          // 优化，防止重复调用repeat函数
          if(_controller.duration == Duration(seconds: childWidth~/50)){
            return;
          }
          _controller.repeat(period: Duration(seconds: childWidth~/50));
        });
  }
}

class MarqueeTransition extends AnimatedWidget{
  final int _childId = 0;

  final Widget child;

  Animation<double> get offset => listenable as Animation<double>;


  /// 获取到[child]的大小后，回调给父类，根据[child]的长度调整滚动速度
  final Function(double width) onScroll;

  const MarqueeTransition({
    Key? key,
    required this.child,
    required Animation<double> offset,
    required this.onScroll,
  }) : assert(offset != null),
        super(key: key, listenable: offset);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomMultiChildLayout(
        delegate: CustomLayout(childId: _childId,scrollOffset:offset.value,onScroll: onScroll),
        children: [
          LayoutId(
            id: _childId,
            child: Row(
              children: [
                child
              ],
            ),
          ),
          LayoutId(
            id: _childId + 1,
            child: Row(
              children: [
                child
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLayout extends MultiChildLayoutDelegate{
  final int childId;
  final double scrollOffset;
  static const internal = 30;

  /// 获取到[child]的大小后，回调给父类，根据[child]的长度调整滚动速度
  final Function(double width) onScroll;

  CustomLayout(
      {required this.childId,
        required this.scrollOffset,
        required this.onScroll,
      });

  @override
  void performLayout(Size size) {
    if(hasChild(childId)){
      final childSize =  layoutChild(childId, BoxConstraints.loose(Size(double.infinity,size.height)));
      layoutChild(childId + 1, BoxConstraints.loose(Size(double.infinity,size.height)));

      // 文字未溢出，无需滚动
      if(childSize.width < size.width){
        positionChild(childId, Offset.zero);
        onScroll.call(0);
        return;
      }

      // 文字溢出，滚动
      positionChild(childId, Offset(-(childSize.width + internal)*scrollOffset,0));
      positionChild(childId + 1, Offset(-(childSize.width + internal)*scrollOffset + (childSize.width + internal),0));

      // 开启滚动
      onScroll.call(childSize.width);
    }
  }

  @override
  bool shouldRelayout(covariant CustomLayout oldCustomLayout) {
    return oldCustomLayout.scrollOffset != scrollOffset;
  }

}