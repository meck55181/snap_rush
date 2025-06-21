import 'dart:async';
import 'package:flutter/material.dart';
import 'calendar.dart';
import 'finish.dart';
import 'my_page.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({Key? key}) : super(key: key);

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  Duration remainingTime = const Duration(hours: 1);
  Timer? _timer;
  bool isRunning = false;
  bool isStarted = false;

  void _startTimer() {
    if (isRunning) return;
    isRunning = true;
    isStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds == 0) {
        timer.cancel();
        isRunning = false;
      } else {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      }
    });
    setState(() {});
  }

  void _stopTimer() {
    _timer?.cancel();
    isRunning = false;
    isStarted = false;
    setState(() {
      remainingTime = const Duration(hours: 1);
    });
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapRush'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'), // 필요시 변경
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '오늘의 미션',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text(
            '텀블러 사용하기',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '1시간 내로 미션을 시작하세요!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/tum.png', height: 200), // 이미지 경로 필요시 수정
          const SizedBox(height: 20),
          Text(
            formatDuration(remainingTime),
            style: const TextStyle(
              fontSize: 40,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _stopTimer,
                child: const Text('포기하기'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  if (!isStarted) {
                    _startTimer();
                  } else {
                    // 미션 완료 시 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MissionCompleteScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(isStarted ? '완료' : '시작하기'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '기록'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
          };
        },
      ),
    );
  }
}