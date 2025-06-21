import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const int myScore = 3820;
    final List<int> allScores = [5000, 4200, myScore, 3000, 2800];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapRush'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My page', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: const [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 32)),
                SizedBox(width: 10),
                Text('포리프', style: TextStyle(fontSize: 20)),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Score', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final sorted = [...allScores]..sort((b, a) => a.compareTo(b));
                    final rank = sorted.indexOf(myScore) + 1;

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('🏆 랭킹 결과'),
                        content: Text('$myScore점은 현재 $rank등입니다!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Ranking'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('포리프 님의 점수는..', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Row(
              children: const [
                Text('3820점', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('+150', style: TextStyle(color: Colors.red, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Food', style: TextStyle(fontSize: 16)),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Dessert'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/foods.png',
                  width: 320,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          // 필요한 경우 탭 전환 처리
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '기록'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
        ],
      ),
    );
  }
}