import 'package:flutter/material.dart';

import 'EmployeeModel.dart';

class TodoModel with ChangeNotifier {
  List<EmployeModel> model = [];

  final TextEditingController _CodeController = TextEditingController();
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _NumberController = TextEditingController();
  final TextEditingController _RemarksController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _AdressController = TextEditingController();
  late EmployeModel employeemodel;
    late int selectedIndex;

  var itemCount = 0;
  // @override
  // void initState() {
  //   super.initState();

  //   // _CodeController.addListener(() {});
  //   // _NameController.addListener(() {});
  //   // _NumberController.addListener(() {});
  //   // _RemarksController.addListener(() {});
  //   // _DateController.addListener(() {});
  //   // _AdressController.addListener(() {});
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _CodeController.dispose();
    _NameController.dispose();
    _NumberController.dispose();
    _RemarksController.dispose();
    _DateController.dispose();
    _AdressController.dispose();
  }

  void toggleSelected(int index) {
    selectedIndex = index;

    notifyListeners(); 
  }
  addEmployee(String EmployeeCode, String EmployeeName, String Address,
      String Remarks, String Mobile, String Dob) {
    model.add(EmployeModel(
        EmployeeCode, EmployeeName, Address, Mobile, Remarks, Dob));
    itemCount = model.length;
    _CodeController.clear();
    _NameController.clear();
    _NumberController.clear();
    _RemarksController.clear();
    _DateController.clear();
    _AdressController.clear();
    notifyListeners();
  }

  updateEmployee(String EmployeeCode, String EmployeeName, String Address,
      String Remarks, String Mobile, String Dob) {
    notifyListeners();
  }

  removeEmployee(int index) {
    model.removeAt(index);
    itemCount = model.length;
    notifyListeners();
  }
}
