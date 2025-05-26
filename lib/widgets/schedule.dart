import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatefulWidget {
  final String userName;
  final String userRole;

  const ScheduleWidget({
    required this.userName,
    required this.userRole,
    super.key,
  });

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  DateTime selectedMonth = DateTime.now();

  List<DateTime> get daysInMonth {
    final first = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final last = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    return List.generate(last.day, (i) => DateTime(first.year, first.month, i + 1));
  }

  final mockShifts = <String, Map<String, String?>>{
    '2025-05-26': {'A': 'John', 'B': null},
    '2025-05-27': {'A': null, 'B': 'Emily'},
    '2025-05-28': {'A': null, 'B': null},
  };

  void joinShift(DateTime date, String role) {
    final key = DateFormat('yyyy-MM-dd').format(date);
    setState(() {
      mockShifts[key] ??= {'A': null, 'B': null};
      mockShifts[key]![role] = widget.userName;
    });
  }

  void removeShift(DateTime date, String role) {
    final key = DateFormat('yyyy-MM-dd').format(date);
    setState(() {
      if (mockShifts.containsKey(key)) {
        mockShifts[key]![role] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (i) => DateTime(DateTime.now().year, i + 1));

    return Column(
      children: [
        DropdownButton<DateTime>(
          value: selectedMonth,
          items: months
              .map((month) => DropdownMenuItem(
                    value: month,
                    child: Text(DateFormat('MMMM').format(month)),
                  ))
              .toList(),
          onChanged: (val) {
            if (val != null) setState(() => selectedMonth = val);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              final day = daysInMonth[index];
              final key = DateFormat('yyyy-MM-dd').format(day);
              final shifts = mockShifts[key] ?? {'A': null, 'B': null};

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(DateFormat('EEE, MMM d').format(day)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final role in ['A', 'B'])
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Role $role:'),
                            shifts[role] == widget.userName
                                ? TextButton(
                                    onPressed: () => removeShift(day, role),
                                    child: const Text('Remove'),
                                  )
                                : shifts[role] == null && widget.userRole == role
                                    ? TextButton(
                                        onPressed: () => joinShift(day, role),
                                        child: const Text('Join'),
                                      )
                                    : Text(shifts[role] ?? '—'),
                          ],
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
