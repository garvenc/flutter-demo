import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _sliderValue = 77;
  double _progressIndicatorValue = 0.3;
  var _expansionPanelListIndex = -1;
  int _bottomNavigatorBarIndex = 1;
  var _floatingActionButtonStr = "Time";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: createBody(),
      bottomNavigationBar: createBottomNavigatorBar(),
      drawer: createDrawer(),
      floatingActionButton: createFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar createAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.cloud),
            iconSize: 40,
            color: Colors.purple,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Share to your friends"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ));
          },
        ),
        PopupMenuButton(
          child: const Icon(Icons.more),
          itemBuilder: (context) {
            return const [
              PopupMenuItem(value: "help", child: Text("帮助")),
              PopupMenuItem(value: "delete", child: Text("删除"),)
            ];
          },
          onSelected: (value) {
            switch (value) {
              case "help":
                showDialog(
                  context: context,
                  builder:(context) {
                    return SimpleDialog(
                      title: const Text("帮助"),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                          },
                          child: const Text("帮助A"),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                          },
                          child: const Text("帮助B"),
                        )
                      ],
                    );
                  },
                );
                break;
              case "delete":
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("确定删除？"),
                      content: const Text("删除后将无法恢复！"),
                      actions: [
                        TextButton(
                          onPressed: () {
                          },
                          child: const Text("取消"),
                        ),
                        TextButton(
                          onPressed: () {
                          },
                          child: const Text("确定"),
                        )
                      ],
                    );
                  },
                );
                break;
            }
          },
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 5,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const[
          Tab(text: "TabA"),
          Tab(text: "TabB"),
          Tab(text: "TabC"),
        ],
      ),
    );
  }

  Widget createBody() {
    return Column(
      children: [
        createTabBarContent(),
        createBottomNavigatorBarContent(_bottomNavigatorBarIndex),
      ],
    );
  }

  Widget createTabBarContent() {
    return SizedBox(
      height: 50,
      child: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.pink,
          ),
          Container(
            color: Colors.lightBlue,
            child: Row(
              children: [
                const Chip(label: Text("读书")),
                const Chip(label: Text("电影")),
                Chip(
                  label: const Text("音乐"),
                  deleteIcon: const Icon(Icons.delete),
                  deleteIconColor: Colors.red,
                  deleteButtonTooltipMessage: "删除",
                  onDeleted: () {
                  },
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            child: Slider(
              max: 100,
              min: 0,
              value: _sliderValue,
              inactiveColor: Colors.black,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ),
        ],
      )
    );
  }

  Widget createBottomNavigatorBarContent(int bottomNavigatorBarIndex) {
    switch (bottomNavigatorBarIndex) {
      case 0:
        return Card(
          color: Colors.blue[50],
          child: Column(
            children: [
              const LinearProgressIndicator(),
              const CircularProgressIndicator(),
              LinearProgressIndicator(value: _progressIndicatorValue),
              CircularProgressIndicator(value: _progressIndicatorValue),
              const Divider(),
              ElevatedButton(
                child: const Text("进度+1"),
                onPressed:() {
                  setState(() {
                    _progressIndicatorValue += 0.1;
                    if (_progressIndicatorValue > 1) {
                      _progressIndicatorValue = 1;
                    }
                  });
                },
              ),
              TextButton(
                child: const Text("进度-1"),
                onPressed: () {
                  setState(() {
                    _progressIndicatorValue -= 0.1;
                    if (_progressIndicatorValue < 0) {
                      _progressIndicatorValue = 0;
                    }
                  });
                },
              ),
            ],
          ),
        );
      case 1:
        return Expanded(
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expansionPanelListIndex = (_expansionPanelListIndex == panelIndex) ? -1 : panelIndex;
                });
              },
              children: List.generate(10, (index) {
                return ExpansionPanel(
                  isExpanded: _expansionPanelListIndex == index,
                  headerBuilder: (context, isExpanded) {
                    return Text("第${index+1}个");
                  },
                  body: const Text("这是内容")
                );
              })
            ),
          ),
        );
      default:
        // Should not run into here.
        return const Text("unexpected situation...");
    }
  }

  Widget createBottomNavigatorBar() {
    return BottomNavigationBar(
      items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
      ],
      currentIndex: _bottomNavigatorBarIndex,
      onTap: (index) {
        setState(() {
          _bottomNavigatorBarIndex = index;
        });
      },
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: Icon(Icons.person),
            accountName: Text("zoe"),
            accountEmail: Text("address@example.com"),
          ),
          const AboutListTile(
            icon: Icon(Icons.info),
            child: Text("About this App"),
          ),
        ]
        +
        ["Alice", "Bob", "Clark", "David", "Edy", "Freud", "Griffin", "Helen", "Illidan", "Jack", "Kitty", "Lowry", "Mary", "Niken"].map((name) {
          return ListTile(
            leading: CircleAvatar(child: Text(name[0])),
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
            subtitle: const Text("Click to start talk"),
          );
        }).toList()
      )
    );
  }

  Widget createFloatingActionButton() {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.access_time_filled, color: Colors.pink),
      label: Text(_floatingActionButtonStr),
      tooltip: "Select Time",
      onPressed: () {
        var now = DateTime.now();
        showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now.subtract(const Duration(days: 30)),
          lastDate: now.add(const Duration(days: 30))
        ).then((date) {
          if (date != null) {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now()
            ).then((time) {
              if (time != null) {
                setState(() {
                  _floatingActionButtonStr = "${date.year}-${date.month}-${date.day} ${time.hour}:${time.minute}";
                });
              }
            });
          }
        }).catchError((err) {
        });
      },
    );
  }
}
