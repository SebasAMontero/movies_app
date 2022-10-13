import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/usecases/i_usecase.dart';
import 'data/datasource/local/DAOs/database.dart';
import 'data/datasource/remote/api_service.dart';
import 'data/repository/movies_repository_impl.dart';
import 'domain/repository/i_movies_repository.dart';
import 'domain/usecase/get_movies_usecase.dart';
import 'presentation/bloc/connection_bloc.dart';
import 'presentation/bloc/interfaces/i_connection_bloc.dart';
import 'presentation/bloc/interfaces/i_movies_bloc.dart';
import 'presentation/bloc/movies_bloc_impl.dart';
import 'presentation/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database _db;
  late http.Client _client;
  late ApiService _service;
  late IMoviesRepository _moviesRepository;
  late Usecase _getMoviesUsecase;
  late IMoviesBloc _moviesBloc;
  late IConnectionBloc _connectionBloc;

  @override
  void initState() {
    _client = http.Client();
    _db = Database();
    _service = ApiService(client: _client);
    _connectionBloc = ConnectionBloc()..initialize();
    _moviesRepository = MoviesRepository(
      _service,
      _db,
      _connectionBloc,
    );
    _getMoviesUsecase = GetMoviesUsecase(_moviesRepository);
    _moviesBloc = MoviesBloc(_getMoviesUsecase);
    super.initState();
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMoviesBloc>.value(value: _moviesBloc),
      ],
      child: MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff4C3A51),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
