import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';

import '../../widgets/job_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.grey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColor.primary, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                "https://www.github.com/aaqyaar.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Hi, Abdi Zamed Mohamed",
                        style: GoogleFonts.inter(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                    width: 4,
                  ),
                  Text(
                    "Let's Find Your Dream Job!",
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Job list
                  FutureBuilder(
                      future: ApiService.getJobs(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final job = snapshot.data![index];
                            return Column(
                              children: [
                                JobCard(
                                  job: job,
                                  image: "https://www.github.com/aaqyaar.png",
                                  companyName: job.company.toString(),
                                  jobTitle: job.title.toString(),
                                  salary: job.salary.toString(),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, "/"); // Navigate to HomeScreen
            } else if (index == 1) {
              Navigator.pushNamed(context, "/dashboard/jobs");
            } else if (index == 2) {
              Navigator.pushNamed(
                  context, "/settings"); // Navigate to SettingsScreen
            }
          },
          selectedItemColor: AppColor.primary,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            // user['role'] != ADMIN don't show this

            BottomNavigationBarItem(
                icon: Icon(Icons.cases_outlined), label: "Jobs"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings",
            )
          ],
        ));
  }
}
