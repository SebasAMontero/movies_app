import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import 'interfaces/i_connection_bloc.dart';

class ConnectionBloc implements IConnectionBloc {
  bool _isOnline = false;
  final Connectivity _connectivity = Connectivity();
  @override
  void dispose() {
  }

  @override
  bool getStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  void getConnectionStatus() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      getStatus(result);
    } catch(e) {
      debugPrint('$e');
    }
  }

  @override
  bool get isOnline => _isOnline;

  @override
  void initialize() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isOnline = getStatus(result);
    });
    getConnectionStatus();
  }
}
