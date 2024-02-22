import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_drawer.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_csdl_admin/pages/add_scholar.dart';
import 'package:flutter_csdl_admin/pages/master_files.dart';
import 'package:flutter_csdl_admin/pages/user_profile.dart';
import 'package:flutter_csdl_admin/responsive/responsive_layout.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
  // static GlobalKey<_DashboardState> dashboardKey = GlobalKey<_DashboardState>();
}

class _DashboardState extends State<Dashboard> {
  final LocalStorage _localStorage = LocalStorage();
  // eh change nig 0 paghuman
  int _selectedIndex = 0;
  int _selectedTileIndex = 0;
  bool _isMobile = false;
  String _secondText = "";
  String _firstText = "";
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });

    if (_isDarkMode) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  Future<void> initialize() async {
    await _localStorage.init();
    updateSelectedIndex(int.parse(_localStorage.getValue("selectedIndex")));
  }

  void updateSelectedIndex(int index) {
    setState(() {
      _selectedTileIndex = index;
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _firstText = "Kunwari Dashboard ni";
          _secondText = "Dashboard ko to";
          break;
        case 1:
          _firstText = "Add Scholar";
          _secondText =
              "Enroll the scholar by completing the registration form.";
          break;
        case 2:
          _firstText = "General Info";
          _secondText = "Setup your profile account and edit profile details.";
          break;
        case 6:
          _firstText = "Master Files";
          _secondText =
              "Maintain and reference masterfiles for centralized and accurate data management.";
          break;
        default:
          _firstText = "Wala pa ni";
          _secondText = "balik lang soon";
          break;
      }
      _localStorage.setValue("selectedIndex", index.toString());
    });
  }

  Widget selectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardMain();
      case 1:
        return const AddScholar();
      case 2:
        return const UserProfile();
      case 6:
        return const MasterFiles();
      default:
        return Container();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIsMobile();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void _checkIsMobile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxWidth = MediaQuery.of(context).size.width;
      setState(() {
        _isMobile = maxWidth <= 800;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: onDesktop(),
      mobileBody: onMobile(),
    );
  }

  Widget onDesktop() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Stack(
        children: [
          Row(
            children: [
              MyDrawer(
                updateSelectedIndex,
                isMobile: _isMobile,
                selectedTileIndex: _selectedTileIndex,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 128),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Card(
                          elevation: 4,
                          color: Theme.of(context).colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _firstText,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    fontSize: 36,
                                  ),
                                ),
                                Text(
                                  _secondText,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 40, bottom: 40),
                                  child: selectedWidget(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: IconButton(
                  icon: Icon(
                    _isDarkMode
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _toggleTheme();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget onMobile() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          _firstText,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(
        updateSelectedIndex,
        isMobile: _isMobile,
        selectedTileIndex: _selectedTileIndex,
      ),
      body: selectedWidget(),
    );
  }
}

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
