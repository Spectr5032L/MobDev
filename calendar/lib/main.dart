import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru_RU', null);
  runApp(CalendarApp());
}


class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate = DateTime( // новый объект для смены
        _selectedDate.year,
        _selectedDate.month + delta,
      );
    });
  }

  void _changeYear(int delta) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year + delta,
        _selectedDate.month,
      );
    });
  }

  void _resetToToday() {
    setState(() {
      _selectedDate = _currentDate;
    });
  }

List<Widget> _buildCalendar() {
    List<String> weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    List<Widget> calendarDays = [];

    calendarDays.addAll(
      weekDays.map(
        (day) => Center(
          child: Text(
            day,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ),
    );

    int daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    int firstWeekday = DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;

    // смещения
    firstWeekday = (firstWeekday - 1) % 7;
    for (int i = 0; i < firstWeekday; i++) {
      calendarDays.add(SizedBox());
    }

    // дни месяца
    for (int day = 1; day <= daysInMonth; day++) {
      bool isToday = _selectedDate.year == _currentDate.year && _selectedDate.month == _currentDate.month && day == _currentDate.day;

      calendarDays.add(
        Container(
          decoration: BoxDecoration(
            color: isToday ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(4),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return calendarDays;
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMMM yyyy', 'ru_RU').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Календарь'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () => _changeMonth(-1),
                ),
                Column(
                  children: [
                    Text(
                      formattedMonth,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () => _changeYear(-1),
                        ),
                        Text(
                          '${_selectedDate.year}',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () => _changeYear(1),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          Expanded( // сетка
            child: GridView.count(
              crossAxisCount: 7,
              children: _buildCalendar(),
            ),
          ),
          if (!(_currentDate.year == _selectedDate.year && _currentDate.month == _selectedDate.month))
            ElevatedButton(
              onPressed: _resetToToday,
              child: Text('Сегодня'),
            ),
        ],
      ),
    );
  }
}
