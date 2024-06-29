import 'package:application/views/widgets/variant_widget.dart';
import 'package:flutter/material.dart';
import 'package:application/controllers/quizes_controller.dart';
import 'package:application/models/quizes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuizesController quizesController = QuizesController();
  PageController pageController = PageController();
  int selectedAnswer = -1;
  int currentPageIndex = 0;

  void nextPage() {
    // setState(() {
    currentPageIndex++;
    // });
    pageController.nextPage(
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final quizesController = Provider.of<QuizesController>(context);

    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: StreamBuilder(
          stream: quizesController.list,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            return Stack(children: [
              Positioned(
                child: 
                     Image.asset('assets/images/duolingo.gif',
                        height: 100, width: 100)
              ),
              PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length + 1,
                itemBuilder: (context, index) {
                  if (!(currentPageIndex == snapshot.data.docs.length)) {
                    Quize quize = Quize.fromJson(snapshot.data.docs[index]);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            quize.question,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 40),
                          VariantWidget(
                            quize: quize,
                            selectedAnswer: selectedAnswer,
                            nextPage: nextPage,
                            quizesController: quizesController,
                          )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox(
                        child: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 54, 154, 57),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: Text(
                            "correct answers: ${quizesController.correctResponses.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: Text(
                            "correct answers: ${quizesController.incorrectResponses.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        quizesController.correctResponses.length >=
                                quizesController.incorrectResponses.length
                            ? Image.asset('assets/images/strong.gif', height: 300)
                            : Image.asset('assets/images/sad.gif', height: 400),
                      ],
                    )));
                  }
                },
              ),
            ]);
          },
        ),
      ),
    );
  }
}
