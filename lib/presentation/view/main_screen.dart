import 'package:flutter/material.dart';

import '../widget/main_screen_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScreenWidget(),
    );
  }
}
