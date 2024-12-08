import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const _HomePage();
              case 1:
                return const _SettingPage();
              default:
                // Should not run into here.
                return const Text("unexpected case...");
            }
          },
        );
      },
      tabBar: CupertinoTabBar(
        items: const[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "setting"),
        ],
        currentIndex: 1,
        onTap: (index) {
        },
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<_HomePage> {
  var _sliderValue = 40.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("首页")
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoSlider(
            min: 0,
            max: 100,
            value: _sliderValue,
            activeColor: CupertinoColors.activeBlue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          CupertinoButton(
            child: const Text("设置"),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return const _SettingPage();
              }));
            },
          ),
          CupertinoButton(
            color: CupertinoColors.systemYellow,
            child: const Text("帮助"),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("查看帮助"),
                    content: const Text("请选择帮助内容"),
                    actions: [
                      CupertinoButton(
                        child: const Text("帮助一"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: const Text("帮助二"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: const Text("帮助三"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          CupertinoButton(
            color: CupertinoColors.systemOrange,
            child: const Text("删除"),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("确定删除？"),
                    content: const Text("删除后将无法恢复！"),
                    actions: [
                      CupertinoButton(
                        child: const Text("取消"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: const Text("确定"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class _SettingPage extends StatelessWidget {
  const _SettingPage();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "返回",
        middle: const Text("设置"),
        trailing: CupertinoButton(
          color: CupertinoColors.systemGreen,
          padding: const EdgeInsets.all(10),
          child: const Text("保存"),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      child: const Text("是"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text("否"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: const Text("取消"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              use24hFormat: true,
              onDateTimeChanged: (value) {
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: CupertinoTimerPicker(
              initialTimerDuration: const Duration(minutes: 5, seconds: 10),
              mode: CupertinoTimerPickerMode.hms,
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              onTimerDurationChanged: (value) {
              },
            ),
          ),
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 30,
              children: List.generate(5, (index) => Text("我是第${index+1}个项目")),
              onSelectedItemChanged: (index) {
              },
            ),
          )
        ],
      ),
    );
  }
}
