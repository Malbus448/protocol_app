import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _saving = false;

  Future<void> _completeWelcome(String userId) async {
    setState(() {
      _saving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'firstLogin': false}, SetOptions(merge: true));
    } catch (_) {
      // Ignore write errors and continue navigation.
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final name = args?['name']?.toString().trim();
    final userId = args?['userId']?.toString();
    final displayName = (name != null && name.isNotEmpty) ? name : 'there';

    final bodyColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello, $displayName!',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Welcome to My Flutter App. We're setting up your profile.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: bodyColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saving || userId == null
                          ? null
                          : () => _completeWelcome(userId),
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed:
                        userId == null ? null : () => _completeWelcome(userId),
                    child: const Text('Skip for now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
