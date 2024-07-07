import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn/utils/constants.dart';
import 'package:learn/utils/route/route_constant.dart';

class Quiz extends StatefulWidget {
  static const routeName = "/quiz";
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class Questions {
  String question;
  List<String> options;
  String? image;
  int answer;

  Questions({
    required this.question,
    required this.options,
    required this.answer,
    this.image,
  });
}

class _QuizState extends State<Quiz> {
  int _score = 0;
  int _selectedIndex = -1;
  bool _isTappable = true;
  int _questionNumber = 0;
  final TextEditingController _fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: topPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Question ${_questionNumber + 1}/${AppConstants.ques.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: width * 0.90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  AppConstants.ques[_questionNumber].image != null
                      ? Container(
                          height: 200,
                          width: 200,
                          color: Colors.white,
                          child: Image.asset(
                            AppConstants.ques[_questionNumber].image!,
                          ),
                        )
                      : const SizedBox(
                          height: 10,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppConstants.ques[_questionNumber].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => options(
                    width: width,
                    option: AppConstants.ques[_questionNumber].options[index],
                    currentIndex: index,
                    selectedIndex: _selectedIndex),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: AppConstants.ques[_questionNumber].options.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedIndex == -1) {
                  return;
                }
                if (_questionNumber < AppConstants.ques.length - 1) {
                  setState(() {
                    _questionNumber++;
                    _selectedIndex = -1;
                    _isTappable = true;
                  });
                } else {
                  print("Quiz Completed");
                  saveQuizResult(_score);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: SizedBox(
                              height: height * 0.4,
                              width: width * 0.8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Congratulations !!!",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "You Have Scored $_score out of ${AppConstants.ques.length}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextField(
                                    controller: _fileNameController,
                                    decoration: const InputDecoration(
                                      labelText: "Enter file name",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 20),
                                        maximumSize: Size(width * 0.7, 60),
                                        minimumSize: Size(width * 0.7, 60),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AllRoutesConstant.mainhomeRoute);
                                      },
                                      child: const Text(
                                        "Save and Go Back",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ),
                          ));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                maximumSize: Size(width * 0.7, 60),
                minimumSize: Size(width * 0.7, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget options({
    required double width,
    required String option,
    required int currentIndex,
    required int selectedIndex,
  }) {
    return InkWell(
      onTap: () {
        if (_isTappable) {
          setState(() {
            _selectedIndex = currentIndex;
            if (currentIndex == AppConstants.ques[_questionNumber].answer) {
              _score++;
            }
            _isTappable = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: width * 0.9,
        decoration: BoxDecoration(
          color: selectedIndex == currentIndex
              ? currentIndex == AppConstants.ques[_questionNumber].answer
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3)
              : Colors.white,
          border: Border.all(
            color: selectedIndex == currentIndex
                ? currentIndex == AppConstants.ques[_questionNumber].answer
                    ? Colors.green
                    : Colors.red
                : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedIndex == currentIndex
                      ? currentIndex == AppConstants.ques[_questionNumber].answer
                          ? Colors.green
                          : Colors.red
                      : Colors.black,
                  width: selectedIndex == currentIndex ? 5 : 1,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              option,
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void saveQuizResult(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_score', score);
    print("Score saved: $score");
  }
}