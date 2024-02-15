import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectivityNow() async {
  ConnectivityResult connectivityResult =
  await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
   // return toast
    return false;
  }
}