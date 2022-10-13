import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/util/constants.dart';
import 'package:movies_app/core/util/keys.dart';
import 'package:movies_app/presentation/widget/main_screen_widget.dart';

void main() {
  testWidgets(
      'Main screen widget should have 3 tabs and a content container for each tab, tapping and dragging should change the current tab',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: MainScreenWidget(),
      ),
    );
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(Tab), findsNWidgets(3));
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.byKey(Keys.nowPlayingKey), findsOneWidget);
    expect(find.byKey(Keys.topRatedKey), findsNothing);

    await widgetTester.tap(find.text(Constants.topRatedTabText));

    await widgetTester.pumpAndSettle();
    expect(find.byKey(Keys.nowPlayingKey), findsNothing);
    expect(find.byKey(Keys.topRatedKey), findsOneWidget);

    await widgetTester.drag(
      find.byKey(Keys.topRatedKey),
      const Offset(
        -500,
        0,
      ),
    );

    await widgetTester.pumpAndSettle();
    expect(find.byKey(Keys.topRatedKey), findsNothing);
    expect(find.byKey(Keys.upcomingKey), findsOneWidget);
  });
}
