import 'package:connectivity/connectivity.dart';

class ConnectivityCheck {
  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    return connectivityResult == ConnectivityResult.none ? false : true;
  }
}
