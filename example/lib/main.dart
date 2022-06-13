import 'package:flutter/material.dart';
import 'package:flutter_rxdart_hooks/flutter_rxdart_hooks.dart';

void main() {
  runApp(const MyApp());
}

/// {@template app}
/// A [StatelessWidget] that:
/// * uses [flutter_rxdart_hooks](https://pub.dev/packages/flutter_rxdart_hooks)
/// to manage the state of a counter and the app theme.
/// * reacts to state changes
/// and updates the theme of the [MaterialApp].
/// * renders the [HomePage].
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro app}
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

/// {@template counter_page}
/// A [HookWidget] that:
/// * use [useBehaviorSubjectController] hook,
/// {@endtemplate}
class HomePage extends HookWidget {
  /// {@macro home_page}
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useBehaviorSubjectController<int>()..add(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: controller.stream,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.add(controller.value + 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
