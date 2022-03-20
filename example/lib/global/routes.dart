
import 'package:flutter_twice_example/index.dart';

class Routes{
  static const String pageDragOpenDrawer = "PageDragOpenDrawer";
  static const String pageExpandedListTile = "PageExpandedListTile";
  static const String pageDiagram = "PageDiagram";
  static const String pageNetworkStatusNotifier = "PageNetworkStatusNotifier";
  static const String pageCustomText = "pageCustomText";

 static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case pageDragOpenDrawer:
        return MaterialPageRoute(builder: (_)=>PageDragOpenDrawer());
      case pageExpandedListTile:
        return MaterialPageRoute(builder: (_)=>PageExpandedListTile());
      case pageDiagram:
        return MaterialPageRoute(builder: (_)=>PageDiagram());
      case pageNetworkStatusNotifier:
        return MaterialPageRoute(builder: (_)=>PageNetworkStatusNotifier());
      case pageCustomText:
        return MaterialPageRoute(builder: (_)=>PageCustomText());

      default:
        return MaterialPageRoute(builder: (_)=>Center(child: Text("undefine route name."),),);
    }
  }

}