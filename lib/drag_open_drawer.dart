import 'package:flutter/material.dart';

enum _DragOpenDrawerMode{
  // 正在拖动
  dragging,
  // 抽同打开事件已经触发
  done,
  // 抽屉处于关闭状态
  canceled,
  // 抽屉已经打开了
  opened,
}

class DragOpenDrawer extends StatefulWidget {
  const DragOpenDrawer({
    required this.child,
    required this.backgroundBuilder,
    this.onOpen,
    this.openDuration =  const Duration(seconds: 1),
    this.closeDuration = const Duration(seconds: 1),
    Key? key}) : super(key: key);

  final Widget Function(BuildContext context) backgroundBuilder;
  final Widget  child;

  /// 抽屉打开时的回调函数
  final void Function()? onOpen;

  final Duration openDuration;
  final Duration closeDuration;

  @override
  _DragOpenDrawerState createState() => _DragOpenDrawerState();
}

class _DragOpenDrawerState extends State<DragOpenDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _maxHeight;
  double _dragOffset = .0;
  bool _openTriggered = false;
  _DragOpenDrawerMode _dragOpenDrawerMode = _DragOpenDrawerMode.canceled;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _changeDragOpenDrawerMode(_DragOpenDrawerMode.canceled);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _maxHeight = constraints.maxHeight;
        return  WillPopScope(
          onWillPop: () async{
            if(_dragOpenDrawerMode == _DragOpenDrawerMode.opened){
              _changeDragOpenDrawerMode(_DragOpenDrawerMode.canceled);
              return false;
            }
            return true;
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ScaleTransition(
                    alignment: Alignment.topCenter,
                    scale: _controller,
                    child: widget.backgroundBuilder(context)),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return  Positioned(
                    top: Tween(begin: .0, end: _maxHeight).evaluate(_controller),
                    height: _maxHeight,
                    width: constraints.maxWidth,
                    child: NotificationListener(
                        onNotification: (notification){
                          if(notification is OverscrollNotification){
                            if(notification.overscroll >= 0){
                              return true;
                            }else{
                              _dragOffset -= notification.overscroll;

                              _changeDragOpenDrawerMode(_DragOpenDrawerMode.dragging);

                              if(_dragOffset >_maxHeight/4){
                                _changeDragOpenDrawerMode(_DragOpenDrawerMode.done);
                              }
                            }
                          }else if(notification is ScrollEndNotification && _dragOpenDrawerMode != _DragOpenDrawerMode.done){
                            _controller
                              ..duration = widget.closeDuration
                              ..reverse().then((value) => _dragOffset = .0);
                          }else if(notification is ScrollEndNotification && _dragOpenDrawerMode == _DragOpenDrawerMode.done){
                            _changeDragOpenDrawerMode(_DragOpenDrawerMode.opened);
                          }
                          return true;
                        },
                        child: child ?? SizedBox()),
                  );
                },
                child:Container(
                  color: Colors.white,
                  height: _maxHeight,
                  child: widget.child
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _changeDragOpenDrawerMode(_DragOpenDrawerMode newMode)async{
    _dragOpenDrawerMode = newMode;

    switch (newMode){
      case _DragOpenDrawerMode.canceled : {
        _controller.duration = widget.closeDuration;
        await _controller.reverse();
        _openTriggered = false;
        _dragOffset = .0;
        break;
      }

      case _DragOpenDrawerMode.dragging:
        _controller.duration = Duration(seconds: 0);
        await  _controller.animateTo(_dragOffset/_maxHeight);
        break;

      case _DragOpenDrawerMode.opened:
        _controller.duration = widget.openDuration;
        await _controller.forward();
        break;

      case _DragOpenDrawerMode.done:
        if(!_openTriggered){
          widget.onOpen!.call();
        }
        _openTriggered = true;
        break;
      default:
        //executeUnknown();
    }
  }
}