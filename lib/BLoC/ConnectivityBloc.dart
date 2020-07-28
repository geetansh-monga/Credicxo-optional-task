import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityClass {
  bool _status;

  Connectivity _connectivity = Connectivity();

  StreamController<bool> statusController = StreamController.broadcast();

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

  void dispose() {
    statusController.close();
  }
}

ConnectivityClass connectivityBloc = ConnectivityClass();
