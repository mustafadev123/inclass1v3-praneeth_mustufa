import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'In-Class 1 v3',
      home: const TabsPage(),
    );
  }
}

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int tabIndex = 0;

  final List<String> tabs = [
    'Tab 1',
    'Tab 2',
    'Tab 3',
    'Tab 4',
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome'),
          content: const Text(
            'This is the AlertDialog for Tab 1.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBarMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Button pressed on Tab 3!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('In-Class 1 v3'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              for (final tab in tabs)
                Tab(text: tab),
            ],
          ),
        ),

        body: TabBarView(
          controller: _tabController,
          children: [
            // TAB 1
            Container(
              color: Colors.lightBlue.shade100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Tab 1',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: showWelcomeDialog,
                      child: const Text('Show Alert Dialog'),
                    ),
                  ],
                ),
              ),
            ),

            // TAB 2
            Container(
              color: Colors.lightGreen.shade100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your name',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // TAB 3
            Container(
              color: Colors.orange.shade100,
              child: Center(
                child: ElevatedButton(
                  onPressed: showSnackBarMessage,
                  child: const Text('Show SnackBar'),
                ),
              ),
            ),

            // TAB 4
            Container(
              color: Colors.purple.shade100,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: const Text('Flutter'),
                      subtitle: const Text(
                        'Building user interfaces with widgets.',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.code),
                      title: const Text('Dart'),
                      subtitle: const Text(
                        'Programming language used by Flutter.',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone_android),
                      title: const Text('Mobile Apps'),
                      subtitle: const Text(
                        'Flutter can be used to build mobile apps.',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Currently selected: ${tabs[tabIndex]}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}