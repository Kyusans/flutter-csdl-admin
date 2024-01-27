import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_masterfiles.dart';

class MasterFiles extends StatefulWidget {
  const MasterFiles({Key? key}) : super(key: key);

  @override
  _MasterFilesState createState() => _MasterFilesState();
}

class _MasterFilesState extends State<MasterFiles> {
  bool _isMobile = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIsMobile();
  }

  void _checkIsMobile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxWidth = MediaQuery.of(context).size.width;
      setState(() {
        _isMobile = maxWidth <= 1400;
      });
    });
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyMasterfiles(
              topText: "Admin",
              labelText: "Add Administrator",
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "Department",
              labelText: "Add Department",
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "School Year",
              labelText: "Add School Year",
              onPressed: () {},
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
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "Course",
              labelText: "Add Course",
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "Scholarship Type",
              labelText: "Add Scholarship Type",
              onPressed: () {},
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
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "Office",
              labelText: "Add Office",
              onPressed: () {},
            ),
            MyMasterfiles(
              topText: "Scholarship Sub Type",
              labelText: "Add Scholarship Sub Type",
              onPressed: () {},
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
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "Department",
          labelText: "Add Department",
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "School Year",
          labelText: "Add School Year",
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        MyMasterfiles(
          topText: "Supervisor",
          labelText: "Add Supervisor",
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "Course",
          labelText: "Add Course",
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "Scholarship Type",
          labelText: "Add Scholarship Type",
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        MyMasterfiles(
          topText: "Office Master",
          labelText: "Add Office Master",
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "Office",
          labelText: "Add Office",
          onPressed: () {},
        ),
        MyMasterfiles(
          topText: "Scholarship Sub Type",
          labelText: "Add Scholarship Sub Type",
          onPressed: () {},
        ),
      ],
    );
  }
}
