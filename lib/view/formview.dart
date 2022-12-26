import 'package:assignment/login/Login.dart';
import 'package:assignment/view/Employee.dart';
import 'package:assignment/model/TodoModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFormview extends StatelessWidget {
  MyFormview({super.key});
  final TextEditingController _CodeController = TextEditingController();

  final TextEditingController _NameController = TextEditingController();

  final TextEditingController _NumberController = TextEditingController();

  final TextEditingController _RemarksController = TextEditingController();

  final TextEditingController _DateController = TextEditingController();

  final TextEditingController _AdressController = TextEditingController();

  final _employekey = GlobalKey<FormState>();

  final Ref = FirebaseDatabase.instance.ref('EmployeDetail');

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              formview(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 10,
                      child: Text(
                        'Save',
                      ),
                      onPressed: () {
                        if (_employekey.currentState!.validate()) {
                          Ref.child(_CodeController.text.toString()).set({
                            'EmployeCode': _CodeController.text.toString(),
                            'EmployeeName': _NameController.text.toString(),
                            'Address': _AdressController.text.toString(),
                            'Mobile': _NumberController.text.toString(),
                            'Dob': _DateController.text.toString(),
                            'Remarks': _RemarksController.text.toString(),
                          }).then((value) {
                            Provider.of<TodoModel>(context, listen: false)
                                .addEmployee(
                              _CodeController.text,
                              _NameController.text,
                              _NumberController.text,
                              _RemarksController.text,
                              _DateController.text,
                              _AdressController.text,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeePage()));
                          });
                        }
                      }),
                ],
              )
            ]),
      ),
    );
  }

  Widget formview() => Form(
        key: _employekey,
        child: Column(
          children: [
            TextFormField(
              maxLines: 1,
              // onChanged: onChangeCode,
              controller: _CodeController,
              decoration: InputDecoration(
                hintText: 'Employee Code',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Employee Code';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 1,
              controller: _NameController,
              decoration: InputDecoration(
                hintText: 'Employee Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Employee Code';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 1,
              controller: _AdressController,
              decoration: InputDecoration(
                hintText: 'Address 1',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address 1';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 1,
              controller: _NumberController,
              decoration: InputDecoration(
                hintText: 'Mobile No.',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mobile No.';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 1,
              controller: _DateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Date of Birth',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Date of Birth';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              maxLines: 3,
              controller: _RemarksController,
              decoration: InputDecoration(
                hintText: 'Remarks',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Remarks';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      );
}
