import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  final Map<DateTime, String> imageDates = {
    DateTime(2025, 6, 11): 'assets/img1.jpg',
    DateTime(2025, 6, 19): 'assets/after.png',
  };

  DateTime _selectedDay = DateTime(2025, 6, 21);
  DateTime _focusedDay = DateTime(2025, 6, 21);

  void _showPopup(BuildContext context, DateTime selectedDay) {
    final normalized = normalize(selectedDay);
    final imagePath = imageDates[normalized];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${selectedDay.year}-${selectedDay.month}-${selectedDay.day}'),
        content: imagePath != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 100),
            const SizedBox(height: 10),
            const Text('이 날의 특별한 기록입니다!'),
          ],
        )
            : const Text('이 날은 특별한 기록이 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('달력')),
      body: TableCalendar(
        firstDay: DateTime.utc(2025, 6, 1),
        lastDay: DateTime.utc(2025, 6, 30),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          _showPopup(context, selectedDay);
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final imagePath = imageDates[normalize(day)];
            if (imagePath != null) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    '${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('${day.day}'));
            }
          },
        ),
      ),
    );
  }
}