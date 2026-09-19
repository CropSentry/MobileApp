import 'package:crop_sentry/server/sensor_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'home_page.dart';
import '../User Authentication/login.dart';
import '../usedWidgets/theme.dart';
import '../server/firebase_sensor_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SensorRepository currentBackend = FirebaseSensorRepository();
  runApp(MyApp(repository: currentBackend));
}

class MyApp extends StatelessWidget {
  final SensorRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Sentry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Apply the custom theme globally here
      home: AuthGate(repository: repository),
    );
  }
}

class AuthGate extends StatelessWidget {
  final SensorRepository repository;
  const AuthGate({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return snapshot.hasData
            ? HomePage(repository: repository)
            : LoginPage(repository: repository);
      },
    );
  }
}
