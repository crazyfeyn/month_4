import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/cart_controller.dart';
import 'package:flutter_application/controllers/product_controller.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/views/screens/home_screen.dart';
import 'package:flutter_application/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return CartController();
          }),
          ChangeNotifierProvider(create: (context) {
            return ProductController();
          })
        ],
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }

                  return snapshot.hasData ? const HomeScreen() : const SignInScreen();
                },
              ),
            ));
  }
}
