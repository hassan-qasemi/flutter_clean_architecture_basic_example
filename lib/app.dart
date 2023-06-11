import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reportrecorder/ui/route/home/view/home_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.pink),
      ),
      home: FutureBuilder(
        future: Hive.initFlutter("./db"),
        builder: (ctx, snp) {
          if (snp.connectionState == ConnectionState.done) {
            return HomeView();
          }
          if (snp.hasError) {
            return Scaffold(
              body: Center(
                child: Row(children: [
                  Text(snp.error.toString()),
                  ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text("exit"),
                  ),
                ]),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
