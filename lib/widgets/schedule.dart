import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/screen_utils.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  late Map<DateTime, Map<String, dynamic>> _roleAssignments;
  DateTime _focusedDay = DateTime.now();
  bool _loading = true;
  String _scheduleTitle = '';

  @override
  void initState() {
    super.initState();
    _roleAssignments = {};
    _loadUserAndSchedule();
  }

  Future<void> _loadUserAndSchedule() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userTeam = userDoc['Teaam'] as String;

      final scheduleDoc = await FirebaseFirestore.instance.collection('schedules').doc(userTeam).get();

      if (!scheduleDoc.exists) {
        if (!mounted) return;
        setState(() {
          _scheduleTitle = '$userTeam Schedule (not found)';
          _loading = false;
        });
        return;
      }

      final data = scheduleDoc.data() as Map<String, dynamic>;
      final Map<DateTime, Map<String, dynamic>> loadedAssignments = {};
      for (var entry in data.entries) {
        final date = DateTime.tryParse(entry.key);
        if (date != null && entry.value is Map<String, dynamic>) {
          loadedAssignments[date] = Map<String, dynamic>.from(entry.value);
        }
      }

      if (!mounted) return;
      setState(() {
        _roleAssignments = loadedAssignments;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _scheduleTitle = 'Failed to load schedule';
        _loading = false;
      });
    }
  }

  void _onDayTap(DateTime day) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final name = userDoc['Name'];
    final position = userDoc['Position'];
    final team = userDoc['Teaam'];

    final dateKey = DateTime.utc(day.year, day.month, day.day);
    final existing = _roleAssignments[dateKey] ?? {};

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('Assign yourself ($position)')),
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Medic', 'Rescue Tech'].map((role) {
            final alreadyTaken = existing[role];
            final isTaken = alreadyTaken != null;
            final isYours = alreadyTaken == name;

            return ListTile(
              title: Text(role),
              subtitle: Text(isTaken ? alreadyTaken.toString() : 'Available'),
              trailing: isTaken
                  ? isYours
                      ? TextButton(
                          onPressed: () async {
                            final docRef = FirebaseFirestore.instance.collection('schedules').doc(team);
                            await docRef.update({
                              '${dateKey.toIso8601String()}.$role': FieldValue.delete()
                            });
                            if (!mounted) return;
                            Navigator.pop(context);
                            _loadUserAndSchedule();
                          },
                          child: const Text('Remove'),
                        )
                      : null
                  : TextButton(
                      onPressed: () async {
                        if (position != role) {
                          if (!mounted) return;
                          Navigator.pop(context);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('You can only sign up for $position shifts')),
                          );
                          return;
                        }

                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Confirm Shift Assignment'),
                            content: Text('Are you sure you want to assign yourself to this $role shift?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          final docRef = FirebaseFirestore.instance.collection('schedules').doc(team);
                          await docRef.set({
                            dateKey.toIso8601String(): {role: name}
                          }, SetOptions(merge: true));

                          if (!mounted) return;
                          Navigator.pop(context);
                          _loadUserAndSchedule();
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<dynamic> _getDisplayForDay(DateTime day) {
    final dateKey = DateTime.utc(day.year, day.month, day.day);
    final entry = _roleAssignments[dateKey];
    if (entry == null) return [];
    return entry.entries.map((e) => '${e.key}: ${e.value}').toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtils.height(context, 0.01)),
            child: Text(
              _scheduleTitle,
              style: TextStyle(
                fontSize: ScreenUtils.fontSize(context, 0.025),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2026, 12, 31),
            focusedDay: _focusedDay,
            eventLoader: _getDisplayForDay,
            calendarFormat: CalendarFormat.month,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              _onDayTap(selectedDay);
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) => const SizedBox.shrink(),
              defaultBuilder: (context, day, focusedDay) {
                final dateKey = DateTime.utc(day.year, day.month, day.day);
                final roles = _roleAssignments[dateKey] ?? {};

                return Container(
                  padding: EdgeInsets.all(ScreenUtils.height(context, 0.003)),
                  margin: EdgeInsets.all(ScreenUtils.height(context, 0.001)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: ScreenUtils.width(context, 0.01),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: ScreenUtils.fontSize(context, 0.015),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenUtils.height(context, 0.02),
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'M: ${roles['Medic'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'R: ${roles['Rescue Tech'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final dateKey = DateTime.utc(day.year, day.month, day.day);
                final roles = _roleAssignments[dateKey] ?? {};

                return Container(
                  padding: EdgeInsets.all(ScreenUtils.height(context, 0.003)),
                  margin: EdgeInsets.all(ScreenUtils.height(context, 0.001)),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: ScreenUtils.width(context, 0.01),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: ScreenUtils.fontSize(context, 0.015),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenUtils.height(context, 0.02),
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Medic: ${roles['Medic'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rescue Tech: ${roles['Rescue Tech'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                final dateKey = DateTime.utc(day.year, day.month, day.day);
                final roles = _roleAssignments[dateKey] ?? {};

                return Container(
                  padding: EdgeInsets.all(ScreenUtils.height(context, 0.003)),
                  margin: EdgeInsets.all(ScreenUtils.height(context, 0.001)),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    border: Border.all(color: Colors.blue.shade700, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: ScreenUtils.width(context, 0.01),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: ScreenUtils.fontSize(context, 0.015),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: ScreenUtils.height(context, 0.02),
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Medic: ${roles['Medic'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013), color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rescue Tech: ${roles['Rescue Tech'] ?? ''}',
                              style: TextStyle(fontSize: ScreenUtils.fontSize(context, 0.013), color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
