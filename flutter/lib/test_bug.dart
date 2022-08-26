import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hbb/desktop/widgets/tabbar_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common.dart';
import 'consts.dart';
import 'main.dart';

/// -t lib/test_bug.dart
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // await windowManager.setSize(Size(400, 600));
  // await windowManager.setAlignment(Alignment.topRight);
  await initEnv(kAppTypeMain);

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getCurrentTheme(),
      home: TabTest()));
}

class TabTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabTestState();
  }
}

const initData = ["0", "1", "2", "3", "4", "5"];
var addCount = 0;

final tabController = DesktopTabController();

class TabTestState extends State<TabTest> {
  @override
  void initState() {
    initData.forEach((e) {
      tabController.state.value.tabs.add(TabInfo(
          key: e,
          label: "Tab " + e,
          closable: true,
          page: Page(
            e,
            key: ValueKey(e),
          )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDarkTheme() ? TarBarTheme.dark() : TarBarTheme.light();
    return Scaffold(
      body: DesktopTab(
          controller: tabController,
          isMainWindow: true,
          theme: theme,
          tail: ActionIcon(
            theme: theme,
            onTap: () {
              final newTab = "Add" + addCount.toString();
              tabController.add(TabInfo(
                  key: newTab,
                  label: newTab,
                  page: Page(
                    newTab,
                    key: ValueKey(newTab),
                  )));
            },
            is_close: false,
            icon: IconFont.add,
            message: '',
          ).paddingOnly(left: 10)),
    );
  }
}

class Page extends StatefulWidget {
  final String text;
  final Key? key;

  Page(this.text, {this.key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    debugPrint("+++initState ${widget.text}");
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("---dispose ${widget.text}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(child: Text(widget.text, style: TextStyle(fontSize: 30)));
  }

  @override
  bool get wantKeepAlive {
    final res = tabController.state.value.tabs
            .indexWhere((tab) => tab.key == widget.text) >=
        0;
    debugPrint("${widget.text} wantKeepAlive: $res");
    return res;
  }
}
