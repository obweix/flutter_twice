import '../index.dart';
import 'package:flutter_twice/drag_open_drawer.dart';

class PageDragOpenDrawer extends StatefulWidget {
  const PageDragOpenDrawer({Key? key}) : super(key: key);

  @override
  _PageDragOpenDrawerState createState() => _PageDragOpenDrawerState();
}

class _PageDragOpenDrawerState extends State<PageDragOpenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
