import 'package:flutter/material.dart';
import 'package:flutter_twice/flutter_twice.dart';

class PageNetworkStatusNotifier extends StatefulWidget {
  const PageNetworkStatusNotifier({Key? key}) : super(key: key);

  @override
  _PageNetworkStatusNotifierState createState() => _PageNetworkStatusNotifierState();
}

class _PageNetworkStatusNotifierState extends State<PageNetworkStatusNotifier> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("PageNetworkStatusNotifier")),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline3!,
          child: NetworkListener(
            builder: (_,status){
              var networkStatuds = "";
              if (status == ConnectivityResult.none) {
                networkStatuds = "网络不可用";
              }
              if (status == ConnectivityResult.has) {
                networkStatuds = "网络可用";
              }
              return  Text(networkStatuds);
            },
          ),
        ),

      ),
    );
  }
}
