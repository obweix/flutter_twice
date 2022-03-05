
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// Connection status check result.
enum ConnectivityResult {
  /// has network.
  has,
  /// None: Device not connected to any network
  none
}

class NetworkStatusNotifier {

  static const EventChannel _eventChannel = EventChannel("network_status_notifier_ec");

  static Stream<ConnectivityResult>? _networkStatus;

  static Stream<ConnectivityResult> getNetworkStatus(){
    _networkStatus ??= _eventChannel.receiveBroadcastStream().map((satues) => parseResult(satues));
    return _networkStatus!;
  }

  static ConnectivityResult parseResult(int i){
    switch(i){
      case 0:
        return ConnectivityResult.none;
      case 1:
        return ConnectivityResult.has;
      default:
        return ConnectivityResult.none;
    }
  }
}

class NetworkListener extends StatelessWidget {
  const NetworkListener({
    required this.builder,
    Key? key}) : super(key: key);

  final  Widget Function(BuildContext context, ConnectivityResult connectivityResult) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: NetworkStatusNotifier.getNetworkStatus(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.active && snapshot.hasData){
         return builder(context,snapshot.data);
        }

        return builder(context,ConnectivityResult.none);
      },
    );
  }
}
