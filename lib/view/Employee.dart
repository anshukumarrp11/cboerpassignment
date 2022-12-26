import 'package:assignment/view/Home.dart';
import 'package:assignment/view/formview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/TodoModel.dart';

class EmployeePage extends StatelessWidget {
  EmployeePage({super.key});

  final _employeupdatekey = GlobalKey<FormState>();

  final Ref = FirebaseDatabase.instance.ref('EmployeDetail');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employee detail"),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:
              //  Column(
              //   children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Provider.of<TodoModel>(context).itemCount,
                  //      itemCount: controller.itemCount.value,
                  // Text(controller.names.value[index].name),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                Provider.of<TodoModel>(context)
                                    .model[index]
                                    .EmployeeCode,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(
                              Provider.of<TodoModel>(context)
                                  .model[index]
                                  .EmployeeName,
                            ),
                            Text(
                              Provider.of<TodoModel>(context)
                                  .model[index]
                                  .Address,
                            ),
                            Text(
                              Provider.of<TodoModel>(context)
                                  .model[index]
                                  .Mobile,
                            ),
                            Text(
                              Provider.of<TodoModel>(context).model[index].Dob,
                            ),
                            Text(
                              Provider.of<TodoModel>(context)
                                  .model[index]
                                  .Remarks,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    elevation: 10,
                                    child: Text(
                                      'Edit',
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Form(
                                                key: _employeupdatekey,
                                                child: MyFormview(
                                                    // EmployeeCode=
                                                    ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }),
                                MaterialButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    elevation: 10,
                                    child: Text(
                                      'Delete',
                                    ),
                                    onPressed: () {
                                      Provider.of<TodoModel>(context,
                                              listen: false)
                                          .removeEmployee(index);
                                      // Ref.child(snapshot
                                      //         .child('EmployeCode')
                                      //         .value
                                      //         .toString())
                                      //     .remove();
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ));
  }
}
