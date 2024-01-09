import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_drawer.dart';
import 'package:flutter_csdl_admin/pages/add_scholar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // eh change nig 0 paghuman
  int _selectedIndex = 1;
  int _selectedTileIndex = 0;
  bool _isMobile = false;
  String _secondText = "";
  String _firstText = "";

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
        default:
          _firstText = "Wala pa ni";
          _secondText = "balik lang soon";
          break;
      }
    });
  }

  Widget selectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return DashboardMain();
      case 1:
        return AddScholar();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _firstText = "Kunwari Dashboard ni";
      _secondText = "Dashboard ko to";
    });
    _checkIsMobile();
  }

  void _checkIsMobile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxWidth = MediaQuery.of(context).size.width;
      setState(() {
        _isMobile = maxWidth <= 1300;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: _isMobile
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                _firstText,
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            )
          : null,
      drawer: _isMobile
          ? MyDrawer(
              updateSelectedIndex,
              selectedTileIndex: _selectedTileIndex,
            )
          : null,
      body: _isMobile ? selectedWidget() : _buildNonMobileLayout(),
    );
  }

  Widget _buildNonMobileLayout() {
    return Row(
      children: [
        MyDrawer(
          updateSelectedIndex,
          selectedTileIndex: _selectedTileIndex,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  elevation: 4,
                  color: Theme.of(context).colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _firstText,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: 36,
                          ),
                        ),
                        Text(
                          _secondText,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(64, 20, 104, 0),
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
      ],
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
