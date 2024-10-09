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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Move over the pads',
      ),
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
  final List<String> imageUrls = List.generate(
    10,
    (index) => 'https://picsum.photos/seed/${index + 1}/200/200',
  );

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
        child: TouchInterceptor(
          child: Wrap(
            children: List.generate(
              10,
              (index) => _ColorfulPad(imageUrl: imageUrls[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorfulPad extends StatefulWidget {
  const _ColorfulPad({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<_ColorfulPad> createState() => _ColorfulPadState();
}

class _ColorfulPadState extends State<_ColorfulPad> {
  bool _highlighted = false;

  void _in() {
    if (_highlighted) return;
    setState(() => _highlighted = true);
  }

  void _out() {
    if (!_highlighted) return;
    setState(() => _highlighted = false);
  }

  @override
  Widget build(BuildContext context) {
    return TouchConsumer(
      onTouchDown: _in,
      onTouchUp: _out,
      onTouchEnter: _in,
      onTouchExit: _out,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: _highlighted ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ),
        width: _highlighted ? 200 : 70,
        height: _highlighted ? 200 : 70,
        child: ClipOval(
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                  Icons.error); // Placeholder for failed image load
            },
          ),
        ),
      ),
    );
  }
}
