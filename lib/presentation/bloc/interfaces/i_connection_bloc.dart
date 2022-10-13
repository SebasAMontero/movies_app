import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/bloc/i_bloc.dart';

abstract class IConnectionBloc implements Bloc {

  bool get isOnline;
  @override
  void initialize();
  @override
  void dispose();
  bool getStatus(ConnectivityResult result);
}
