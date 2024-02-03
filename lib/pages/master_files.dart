import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_masterfiles.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_masterfiles.dart';
import 'package:get/get.dart';

class MasterFiles extends StatefulWidget {
  const MasterFiles({Key? key}) : super(key: key);

  @override
  _MasterFilesState createState() => _MasterFilesState();
}

class _MasterFilesState extends State<MasterFiles> {
  bool _isMobile = false;
  bool _isLoading = true;

  void _checkIsMobile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxWidth = MediaQuery.of(context).size.width;
      setState(() {
        _isMobile = maxWidth <= 1400;
      });
    });
  }

  void _handleAddMasterfiles(int index) {
    Get.dialog(
      AlertDialog(
        content: AddMasterfiles(selectedIndex: index, isMobile: _isMobile),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void _initializeData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIsMobile();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: _isMobile ? onMobile() : onDesktop(),
        ),
      ),
    );
  }

  Widget onDesktop() {
    return _isLoading
        ? const LoadingSpinner()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMasterfiles(
                    topText: "Admin",
                    labelText: "Add Administrator",
                    onPressed: () {
                      _handleAddMasterfiles(0);
                    },
                  ),
                  MyMasterfiles(
                    topText: "Department",
                    labelText: "Add Department",
                    onPressed: () {
                      _handleAddMasterfiles(1);
                    },
                  ),
                  MyMasterfiles(
                    topText: "School Year",
                    labelText: "Add School Year",
                    onPressed: () {
                      _handleAddMasterfiles(2);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMasterfiles(
                    topText: "Supervisor",
                    labelText: "Add Supervisor",
                    onPressed: () {
                      _handleAddMasterfiles(3);
                    },
                  ),
                  MyMasterfiles(
                    topText: "Course",
                    labelText: "Add Course",
                    onPressed: () {
                      _handleAddMasterfiles(4);
                    },
                  ),
                  MyMasterfiles(
                    topText: "Scholarship Type",
                    labelText: "Add Scholarship Type",
                    onPressed: () {
                      _handleAddMasterfiles(5);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMasterfiles(
                    topText: "Office Master",
                    labelText: "Add Office Master",
                    onPressed: () {
                      _handleAddMasterfiles(6);
                    },
                  ),
                  MyMasterfiles(
                    topText: "Office",
                    labelText: "Add Office",
                    onPressed: () {
                      _handleAddMasterfiles(7);
                    },
                  ),
                  MyMasterfiles(
                    topText: "Scholarship Sub Type",
                    labelText: "Add Scholarship Sub Type",
                    onPressed: () {
                      _handleAddMasterfiles(8);
                    },
                  ),
                ],
              ),
            ],
          );
  }

  Widget onMobile() {
    return Column(
      children: [
        MyMasterfiles(
          topText: "Admin",
          labelText: "Add Administrator",
          onPressed: () {
            _handleAddMasterfiles(0);
          },
        ),
        MyMasterfiles(
          topText: "Department",
          labelText: "Add Department",
          onPressed: () {
            _handleAddMasterfiles(1);
          },
        ),
        MyMasterfiles(
          topText: "School Year",
          labelText: "Add School Year",
          onPressed: () {
            _handleAddMasterfiles(2);
          },
        ),
        const SizedBox(height: 16),
        MyMasterfiles(
          topText: "Supervisor",
          labelText: "Add Supervisor",
          onPressed: () {
            _handleAddMasterfiles(3);
          },
        ),
        MyMasterfiles(
          topText: "Course",
          labelText: "Add Course",
          onPressed: () {
            _handleAddMasterfiles(4);
          },
        ),
        MyMasterfiles(
          topText: "Scholarship Type",
          labelText: "Add Scholarship Type",
          onPressed: () {
            _handleAddMasterfiles(5);
          },
        ),
        const SizedBox(height: 16),
        MyMasterfiles(
          topText: "Office Master",
          labelText: "Add Office Master",
          onPressed: () {
            _handleAddMasterfiles(6);
          },
        ),
        MyMasterfiles(
          topText: "Office",
          labelText: "Add Office",
          onPressed: () {
            _handleAddMasterfiles(7);
          },
        ),
        MyMasterfiles(
          topText: "Scholarship Sub Type",
          labelText: "Add Scholarship Sub Type",
          onPressed: () {
            _handleAddMasterfiles(8);
          },
        ),
      ],
    );
  }
}
