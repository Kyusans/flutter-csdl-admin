import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final Function(int) onItemTapped;
  final int selectedTileIndex;
  const MyDrawer(this.onItemTapped, {required this.selectedTileIndex, Key? key})
      : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState(selectedTileIndex);
  // static GlobalKey<_MyDrawerState> drawerKey = GlobalKey<_MyDrawerState>();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedTileIndex;

  _MyDrawerState(this._selectedTileIndex);

  void updateSelectedIndex(index) {
    setState(() {
      _selectedTileIndex = index;
      widget.onItemTapped(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            // 0 dashboard
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 0
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 3.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 0,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                onTap: () {
                  updateSelectedIndex(0);
                },
              ),
            ),

            // 1 add scholar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 1
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 1,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                  updateSelectedIndex(1);
                },
              ),
            ),

            // 2 account
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 2
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 2,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                onTap: () {
                  updateSelectedIndex(2);
                },
              ),
            ),

            // 3 notification
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 3
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 3,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                onTap: () {
                  updateSelectedIndex(3);
                },
              ),
            ),

            // 4 messages
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 4
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 4,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                onTap: () {
                  updateSelectedIndex(4);
                },
              ),
            ),

            // 5 qr code
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 5
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 5,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
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
                onTap: () {
                  updateSelectedIndex(5);
                },
              ),
            ),

            // 6 Master files
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _selectedTileIndex == 6
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.transparent,
                  width: 6.0,
                ),
              ),
              child: ListTile(
                selected: _selectedTileIndex == 6,
                selectedTileColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                leading: const Icon(
                  Icons.folder_copy_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Master Files",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  updateSelectedIndex(6);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
