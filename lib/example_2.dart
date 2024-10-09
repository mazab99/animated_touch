import 'dart:ui';

import 'package:animated_touch/touch_interceptor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tap the button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Mahmoud Azab',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TouchInterceptor(
              child: Stack(
                children: [
                  Center(
                    child: TouchConsumer(
                      onTouchDown: () => setState(() {
                        _buttonColor = Colors.lightBlue;
                      }),
                      onTouchUp: () => setState(() {
                        _buttonColor = Colors.blue;
                      }),
                      onTouchExit: () => setState(() {
                        _buttonColor = Colors.blue;
                      }),
                      child: ElevatedButton(
                        onPressed: () {
                          // not reachable
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            _buttonColor,
                          ),
                        ),
                        child: const Text('Push me'),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
