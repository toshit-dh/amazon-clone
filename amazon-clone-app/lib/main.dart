import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/common/widgets/bottom_bar_admin.dart';
import 'package:amazoncloneapp/common/widgets/bottom_bar_user.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/features/auth/screens/auth_screen.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';
import 'package:amazoncloneapp/routes/router.dart';
import 'package:amazoncloneapp/features/auth/services/auth_service.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getuserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'amazoncloneapp',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontSize: 60, fontFamily: 'Lato', color: Colors.pink),
          labelLarge: TextStyle(),
        ),
        colorScheme: const ColorScheme.light(primary: Globals.secondaryColor),
        scaffoldBackgroundColor: Globals.greyBackgroundCOlor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const BottomBarAdmin()
          : const AuthScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/amazon.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}
