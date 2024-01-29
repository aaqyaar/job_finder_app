import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/controllers/auth_provider.dart';
import 'package:job_finder/models/jobs.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';
import 'package:job_finder/view/screens/dashboard/new_edit_job_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  List<JobModel> jobs = [];

  @override
  void initState() {
    super.initState();

    fetchJobs();
  }

  Future<void> fetchJobs() async {
    final response = await ApiService.getJobs();
    setState(() {
      jobs = response;
    });
  }

  // deleteJob method
  void deleteJob(String id) async {
    // Check if id is not empty
    if (id.isNotEmpty) {
      // Call the deleteJob API
      final response = await ApiService.deleteJob(id);
      if (response != null) {
        if (response.status == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Job deleted successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          // fetchJobs while job deleted
          fetchJobs();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message.toString())),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred during deleting job")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Id cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: FutureBuilder(
          future: Storage.getValue('user'),
          builder: (context, snapshot) {
            var user = json.decode(snapshot.data);
            return ListView(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/dashboard/jobs/new");
                    },
                    // if user['role'] == 'admin' then show the button

                    child: user['role'] == 'ADMIN'
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Create New +",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container(),
                  ),
                ),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Jobs'),
                    ),
                    DataColumn(
                      label: Text('Actions'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    jobs.length,
                    (int index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          // All rows will have the same selected color.
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08);
                          }
                          // Even rows will have a grey color.
                          if (index.isEven) {
                            return Colors.grey.withOpacity(0.3);
                          }
                          return null; // Use default value for other states and odd rows.
                        },
                      ),
                      cells: <DataCell>[
                        DataCell(Text(jobs[index].title ?? '')),
                        DataCell(Row(
                          children: [
                            user['role'] == 'ADMIN'
                                ? IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.green.shade600,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewEditJobScreen(
                                                      currentJob: jobs[index],
                                                      isEdit: true)));
                                    },
                                  )
                                : Container(),
                            user['role'] == 'ADMIN'
                                ? IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      deleteJob(jobs[index].id ?? '');
                                    },
                                  )
                                : Container()
                          ],
                        )),
                      ],
                      selected: selected[index],
                      onSelectChanged: (bool? value) {
                        setState(() {
                          selected[index] = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
