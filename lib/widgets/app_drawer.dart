import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  final String userRole; // Expected values: 'user', 'editor', 'admin', 'super_admin'

  const AppDrawer({
    super.key,
    required this.onLogout,
    required this.userRole,
  });

  bool get isAdmin => userRole == 'admin' || userRole == 'super_admin';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          right: BorderSide(color: Color(0xFFB21232), width: 2),
          top: BorderSide(color: Color(0xFFB21232), width: 2),
          bottom: BorderSide(color: Color(0xFFB21232), width: 2),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const Divider(),
              if (isAdmin)
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('Admin'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/admin_page');
                  },
                ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Schedule'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/schedule_page');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/profile_page');
                },
              ),

              // THIS IS THE ORIGIN STORY SECTION START
             ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About the app'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer first
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(16),
                    content: Stack(
  children: [
    Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
        child: const SingleChildScrollView(
          child: Text(
            '''The Origin of the App
It all started during a SARMED course in Banff, Alberta — in a firehall training room packed with more Macs than an Apple keynote. So many, in fact, that nicknames had to be assigned just to keep order. One of them, known henceforth as Mullet Mac, sat quietly absorbing the chaos.

At some point, between scenario drills and caffeine refills, Mullet Mac turned to the room and asked a simple question:
"How have you all been reading the TEAAM protocols?"

A chorus of shrugs and muttered complaints followed — everyone was using the PDF, and navigating it was about as smooth as a gurney ride over gravel.

That’s when Mullet Mac, in a rare moment of upright posture and mild confidence, posed a second question — this time to Miles:
"Have you ever thought about turning the protocols into an app?"

Miles replied with something like, "Yeah, we've talked about it... but nothing really came from those discussions."

And that was that. Mullet Mac said something modest like, "Well, I kinda dabble in app stuff," and within days, the first prototype was alive. Born in Banff, forged in a sea of Macs, and powered by sheer protocol-fueled spite.

And here we are.

This app is dedicated to everyone involved with TEAAM — the individuals offering their time, skills, and heart to help others in emergency situations across BC’s remote and austere environments.
You are expanding access to advanced medical care where it’s needed most — because geography should never determine the quality of care someone receives.''',
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ),
  ],
),
                  ),
                );
              },
            ),
 // THIS IS THE ORIGIN STORY SECTION END
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: onLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
