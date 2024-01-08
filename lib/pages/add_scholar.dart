import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
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
  String _selectedYearLevel = "Select year level";
  String _selectedCourse = "Select course";
  final List<String> yearLevel = [
    "Select year level",
    "1st Year",
    "2nd Year",
    "3rd Year",
    "4th Year",
  ];

  final List<String> course = [
    "Select course",
    "IT",
    "Course 1",
    "Course 2",
    "Course 3",
  ];

  void setYearLevel(String? selectedValue) {
    setState(() {
      _selectedYearLevel = selectedValue!;
      print("Selected year level: " + _selectedYearLevel);
    });
  }

  void setCourse(String? selectedValue) {
    setState(() {
      _selectedCourse = selectedValue!;
      print("Selected year level: " + _selectedCourse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 50, 64, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Add Scholar',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 36,
            ),
          ),
          Text(
            'Enroll the scholar by completing the registration form.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 4,
            color: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Fill the Form',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const Text(
                    'Fill out the form by the given below.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
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
                            willValidate: true,
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
                            willValidate: true,
                            controller: _lastNameController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: MyTextField(
                            labelText: "School id",
                            willValidate: true,
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
                            labelText: "Contact number",
                            willValidate: true,
                            obscureText: false,
                            controller: _lastNameController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: MyDropdown(
                            items: yearLevel,
                            value: _selectedYearLevel,
                            onChange: setYearLevel,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: MyDropdown(
                            items: course,
                            value: _selectedCourse,
                            onChange: setCourse,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MyButton(
                          buttonText: "Add Scholar",
                          buttonSize: 16,
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
