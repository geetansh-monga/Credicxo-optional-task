import 'dart:async';
import 'package:connectivity/connectivity.dart';

// BLoC class for connectivity.
class ConnectivityBloc {
  bool _status; //flag for connection status.

  Connectivity _connectivity = Connectivity(); // Instance of Connectivity.

  StreamController<bool> statusController =
      StreamController.broadcast(); //Stream Controller for connection status.

  //Method for checking whether device is connected to internet or not.
  void isConnected() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _status = true;
      statusController.sink.add(_status);
    } else {
      _status = false;
      statusController.sink.add(_status);
    }
  }

  //Method to observe that internet connection of the device hasn't changed.
  void observeConnectivity() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _status = true;
        statusController.sink.add(_status);
      } else {
        _status = false;
        statusController.sink.add(_status);
      }
    });
  }

  //Method for disposing the Connectivity BLoC.
  void dispose() {
    statusController.close();
  }
} // BLoC class ends.

//Global Object for ConnectivityBLoC
ConnectivityBloc connectivityBLoC = ConnectivityBloc();
