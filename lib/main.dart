import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _mobileLayout(context);
        } else {
          return _tabletLayout(context);
        }
      },
    );
  }

  // ---------------- MOBILE LAYOUT ----------------

  Widget _mobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Week 3 Assignment"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildAvatar(),
            const SizedBox(height: 20),
            _buildList(),
            const SizedBox(height: 20),
            _buildButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------------- TABLET / DESKTOP LAYOUT ----------------

  Widget _tabletLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Week 3 Assignment"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            backgroundColor: Colors.deepPurple.shade50,
            selectedIconTheme: const IconThemeData(color: Colors.deepPurple),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text("Profile"),
              ),
            ],
            onDestinationSelected: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              }
            },
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildList()),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAvatar(),
                      const SizedBox(height: 30),
                      _buildButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DRAWER ----------------

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            accountName: Text("Flutter User"),
            accountEmail: Text("user@email.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.deepPurple),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------- LIST ----------------

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(
          4,
          (index) => Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.deepPurple),
              title: Text("List Item ${index + 1}"),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- AVATAR ----------------

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 70,
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.person, size: 70, color: Colors.white),
    );
  }

  // ---------------- BUTTON ----------------

  Widget _buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      onPressed: () {},
      child: const Text("VentureDive"),
    );
  }
}

// ---------------- SECOND SCREEN ----------------

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          "This is the Second Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
