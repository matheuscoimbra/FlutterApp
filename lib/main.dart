import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          builder: (context) => EventBus(),
          dispose: (context, bus) => bus.dispose(),
        )

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white
        ),
        home: LoginPage(),
      ),
    );
  }
}


