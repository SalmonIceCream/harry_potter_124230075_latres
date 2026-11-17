import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/character_page.dart';
import 'pages/login_page.dart';
import 'repositories/auth_repository.dart';
import 'repositories/favorite_repository.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FavoriteRepository.init();
  await NotificationService.init();

  final loggedIn = await AuthRepository().isLoggedIn();
  runApp(MyApp(home: loggedIn ? const CharacterPage() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harry Potter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: home,
    );
  }
}