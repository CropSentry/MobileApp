import 'package:flutter/material.dart';
import 'User Authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'display_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final emailPrefix = (user != null && user.email != null)
        ? user.email!.split('@').first
        : 'Farmer'; // Fallback text
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService().signOut(),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Welcome $emailPrefix!',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          //test cards start
          SentryCard(
            title: "Test Card 1",
            status: "OK",
            moisture: 9.0,
            temperature: 75.0,
            isOnline: true,
          ),
          SentryCard(
            title: "Test Card 2",
            status: "Alert",
            moisture: 10.5,
            temperature: 60.0,
            isOnline: false,
          ),
          SentryCard(
            title: "Test Card 3",
            status: "Danger",
            moisture: 2.1,
            temperature: 90.0,
            isOnline: true,
          ),
          //test cards end
          //This will have all the Cards
        ],
      ),
    );
  }
}
