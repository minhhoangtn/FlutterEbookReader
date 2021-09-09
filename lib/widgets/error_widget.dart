import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final VoidCallback onRefresh;

  const MyErrorWidget({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              child: Image.asset(
                'images/connection_error.png',
                fit: BoxFit.cover,
              ),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'May be some connection errors occurred',
                      style: TextStyle(fontSize: 20)),
                  TextSpan(text: ' 😴', style: TextStyle(fontSize: 25)),
                ])),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor),
              onPressed: onRefresh,
              child: const Text(
                'LOAD AGAIN',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
