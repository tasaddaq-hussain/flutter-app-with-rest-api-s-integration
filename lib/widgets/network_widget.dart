import 'package:flutter/material.dart';
import 'package:meta_melon_task_app/config/constant.dart';
import 'package:meta_melon_task_app/services/network/network_service.dart';
import 'package:meta_melon_task_app/widgets/offline_widget.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget childWidget;

  const NetworkAwareWidget({
    Key? key,
    required this.childWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(
      builder: (context, data, child) {
        if (data == NetworkStatus.Online) {
          Fluttertoast.showToast(msg: ONLINE_MSG);
        } else if (data == NetworkStatus.Offline) {
          Fluttertoast.showToast(msg: OFFLINE_MSG);
          return const OfflineWidget();
        }

        return childWidget;
      },
    );
  }
}
