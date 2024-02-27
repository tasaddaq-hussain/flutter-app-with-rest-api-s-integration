import 'package:flutter/material.dart';
import 'package:meta_melon_task_app/locator.dart';
import 'package:meta_melon_task_app/services/network/network_service.dart';
import 'package:meta_melon_task_app/ui/home_view.dart';
import 'package:meta_melon_task_app/widgets/network_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<NetworkStatus>(
      create: (context) =>
          NetworkStatusService().networkStatusController.stream,
      initialData: NetworkStatus.Online,
      child: MaterialApp(
        title: 'Meta Melon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NetworkAwareWidget(
          childWidget: HomeView(),
        ),
      ),
    );
  }
}