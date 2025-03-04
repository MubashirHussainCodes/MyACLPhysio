import 'dart:async';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  final List<String> exercises;
  final int initialIndex;

  ExerciseScreen({required this.exercises, required this.initialIndex});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.exercises.length,
        physics: NeverScrollableScrollPhysics(), // so user doesn't swipe manually
        itemBuilder: (context, index) {
          return ExercisePage(
            exercise: widget.exercises[index],
            index: index,
            total: widget.exercises.length,
            pageController: _pageController,
          );
        },
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  final String exercise;
  final int index;
  final int total;
  final PageController pageController;

  ExercisePage({
    required this.exercise,
    required this.index,
    required this.total,
    required this.pageController,
  });

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _secondsElapsed = 0;
  Timer? _timer;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    // By default, the timer is not started automatically.
    // The user will press the "Start Timer" button to begin.
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Start or stop the timer based on its current state.
  void _toggleTimer() {
    if (_isTimerRunning) {
      // Stop the timer
      _timer?.cancel();
      setState(() {
        _isTimerRunning = false;
      });
    } else {
      // Start the timer
      setState(() {
        _isTimerRunning = true;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_secondsElapsed < 60) {
            _secondsElapsed++;
            if (_secondsElapsed == 60) {
              // If it reaches 60, auto-navigate to next page
              _autoNavigateNext();
            }
          } else {
            _timer?.cancel();
            _isTimerRunning = false;
          }
        });
      });
    }
  }

  /// Navigate to the next page or return to the start if we're at the end.
  void _autoNavigateNext() {
    if (widget.index < widget.total - 1) {
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // If it's the last page, just pop until the first route (or do something else).
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  /// Navigate to the previous page if we aren't on the first page.
  void _autoNavigatePrevious() {
    if (widget.index > 0) {
      widget.pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // If it's the first page, maybe pop or do nothing.
      Navigator.pop(context);
    }
  }

  /// Manually go to next page on button press, ignoring the timer.
  void _goNextManually() {
    _autoNavigateNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a separate Scaffold if you want an AppBar or
      // any extra scaffolding for each page. Otherwise, you can
      // just return a Container or Column.
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
    

          SizedBox(height: 20),
            // The name of the exercise
            Text(
              widget.exercise,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),

            Spacer(),

            // "Start Timer" button in the middle
            ElevatedButton(
              onPressed: _toggleTimer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor:
                    _isTimerRunning ? Colors.red.shade600 : Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _isTimerRunning ? 'STOP TIMER' : 'START TIMER',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20),
            // A simple display of the elapsed time
            Text(
              '$_secondsElapsed / 60 seconds',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),

            Spacer(),

            // Bottom row for Previous and Next buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous button on the left
                ElevatedButton(
                  onPressed: _autoNavigatePrevious,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'PREVIOUS',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Next button on the right
                ElevatedButton(
                  onPressed: _goNextManually,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
