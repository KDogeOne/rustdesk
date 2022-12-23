import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/desktop/pages/remote_tab_page.dart';
import 'package:flutter_hbb/main.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:provider/provider.dart';

/// multi-tab desktop remote screen
class DesktopRemoteScreen extends StatelessWidget {
  final Map<String, dynamic> params;

  DesktopRemoteScreen({Key? key, required this.params}) : super(key: key) {
    if (Platform.isLinux) {
      WindowController.fromWindowId(windowId!).getXID().then((xid) async {
        if (xid != 0) {
          bind.mainSetGrabX11Window(xid: xid);
        }
        bind.mainStartGrabKeyboard();
      });
    } else {
      bind.mainStartGrabKeyboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: gFFI.ffiModel),
          ChangeNotifierProvider.value(value: gFFI.imageModel),
          ChangeNotifierProvider.value(value: gFFI.cursorModel),
          ChangeNotifierProvider.value(value: gFFI.canvasModel),
        ],
        child: Scaffold(
          body: ConnectionTabPage(
            params: params,
          ),
        ));
  }
}
