import 'package:flutter/material.dart';

class OfflineWidget extends StatefulWidget {
  const OfflineWidget({super.key});

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_connected_no_internet_4_rounded,
              size: 190,
              color: Colors.red,
            ),
            const Text("You'r Offline"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Try again'),
            )
          ],
        ),
      ),
    );
  }
}
