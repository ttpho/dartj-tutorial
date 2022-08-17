import 'package:app/dio/dio_request.dart';
import 'package:app/http/http_request.dart';
import 'package:app/user.dart';
import 'package:app/user_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DartJ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  UserRepository? _userRepository = DioRequest();

  void _refresh() {
    setState(() {
      _counter++;
      _userRepository = _counter.isEven ? DioRequest() : HttpRequest();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Use ${_userRepository?.runtimeType.toString()}"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _userRepository == null
          ? Container()
          : FutureBuilder<List<User>?>(
              future: _userRepository?.fetchUser(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<User>?> snapshot,
              ) {
                if (snapshot.hasData) {
                  final List<User> list = snapshot.data ?? [];
                  if (list.isEmpty) {
                    return const Text("Empty");
                  }

                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final User user = list[index];
                      return Card(
                        child: ListTile(
                          title: Text(user.name ?? ""),
                          subtitle: Text(user.email ?? ""),
                          trailing: Text(user.username ?? ""),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: list.length,
                  );
                }

                if (snapshot.hasError) {
                  return Text(
                      "Error ${_userRepository?.runtimeType.toString()} ${snapshot.error?.toString()}");
                }

                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
