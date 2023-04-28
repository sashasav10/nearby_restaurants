import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearby_restaurants/blocs/application_bloc.dart';
import 'package:nearby_restaurants/firebase_options.dart';
import 'package:nearby_restaurants/screens/home_screen.dart';
import 'package:nearby_restaurants/screens/login_email_password_screen.dart';
import 'package:nearby_restaurants/screens/login_screen.dart';
import 'package:nearby_restaurants/screens/signup_email_password_screen.dart';
import 'package:nearby_restaurants/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
        ),
        home: const AuthWrapper(),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return const LoginScreen();
  }
}
