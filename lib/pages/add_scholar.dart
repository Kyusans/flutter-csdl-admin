import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_dropdown.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';

class AddScholar extends StatefulWidget {
  const AddScholar({Key? key}) : super(key: key);

  @override
  _AddScholarState createState() => _AddScholarState();
}

class _AddScholarState extends State<AddScholar> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _selectedYearLevel = "1st Year";
  final List<String> yearLevel = [
    "1st Year",
    "2nd Year",
    "3rd Year",
    "4th Year",
  ];
  setYearLevel(String? selectedValue) {
    setState(() {
      _selectedYearLevel = selectedValue!;
      print("Selected year level: " + _selectedYearLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Scholar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    'Enroll the scholar by completing the registration form.',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fill the Form',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              'Fill out the form by the given below.',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: MyTextField(
                                      labelText: "First name",
                                      obscureText: false,
                                      controller: _firstNameController,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: MyTextField(
                                      labelText: "Last name",
                                      obscureText: false,
                                      controller: _lastNameController,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: MyDropdown(
                                      items: yearLevel,
                                      labelText: "Select Year Level",
                                      value: _selectedYearLevel,
                                      onChange: setYearLevel,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: MyDropdown(
                                      items: yearLevel,
                                      labelText: "Select Year Level",
                                      value: _selectedYearLevel,
                                      onChange: setYearLevel,
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
