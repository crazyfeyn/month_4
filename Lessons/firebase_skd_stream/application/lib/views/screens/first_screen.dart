import 'package:application/views/screens/create_quizes.dart';
import 'package:application/views/screens/edit_quizes_screen.dart';
import 'package:application/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: const Text(
                    'Solve quizes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateQuizesScreen()));
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: const Text(
                    'Create quizes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditQuizesScreen()));
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade800,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)),
                  child: const Text(
                    'Delete quizes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
