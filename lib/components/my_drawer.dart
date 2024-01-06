import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // header
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "*image*",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SAMS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "School Attendance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Monitoring System",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            // 0 dashboard
            ListTile(
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),

            // 1 add scholar
            ListTile(
              leading: const Icon(
                Icons.person_add_alt,
                color: Colors.white,
              ),
              title: const Text(
                "Add Scholar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/addScholar');
              },
            ),

            // 2 account
            ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              title: const Text(
                "Account",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),

            // 3 notification
            ListTile(
              leading: const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              title: const Text(
                "Notification",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),

            // 4 messages
            ListTile(
              leading: const Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Messages",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),

            // 5 qr code
            ListTile(
              leading: const Icon(
                Icons.qr_code_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "QR Code",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),

            // 6 history
            ListTile(
              leading: const Icon(
                Icons.history_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "History",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
