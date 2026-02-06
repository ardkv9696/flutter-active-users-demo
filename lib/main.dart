import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final int age;
  final bool isActive;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      isActive: json['isActive'] as bool,
    );
  }
}


final List<Map<String, dynamic>> usersJson = [
  {'id': 1, 'name': 'Alex', 'age': 25, 'isActive': true},
  {'id': 2, 'name': 'John', 'age': 19, 'isActive': false},
  {'id': 3, 'name': 'Kate', 'age': 27, 'isActive': true},
  {'id': 4, 'name': 'Maria', 'age': 30, 'isActive': true},
];


List<User> getActiveUsers() {
  final users = usersJson
      .map(User.fromJson)
      .where((user) => user.isActive)
      .toList()
    ..sort((a, b) => a.age.compareTo(b.age));

  return users;
}

class ActiveUsersScreen extends StatefulWidget {
  const ActiveUsersScreen({Key? key}) : super(key: key);

  @override
  State<ActiveUsersScreen> createState() => _ActiveUsersScreenState();
}

class _ActiveUsersScreenState extends State<ActiveUsersScreen> {
  late List<User> activeUsers;

  @override
  void initState() {
    super.initState();
    activeUsers = getActiveUsers();
  }

  void refreshUsers() {
    setState(() {
      activeUsers = getActiveUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshUsers,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: activeUsers.length,
        itemBuilder: (context, index) {
          final user = activeUsers[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green,
                child: Text(
                  user.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('${user.age} years'),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: const ActiveUsersScreen(),
    );
  }
}
