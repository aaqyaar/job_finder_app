import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:job_finder/models/user.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Result> users = [];

  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await ApiService.fetchUsers();
    setState(() {
      users = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage("https://www.github.com/aaqyaar.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Hi, Abdi Zamed Mohamed",
                    style: GoogleFonts.inter(fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                height: 20,
                width: 4,
              ),
              Text(
                "Let's Find Your Dream Job!",
                style: GoogleFonts.inter(
                    fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: AppColor.tertiary,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search jobs by company, location"),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 40,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                color: index == 0
                                    ? AppColor.primary
                                    : AppColor.secondary,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "All",
                                  style: GoogleFonts.inter(
                                      color: index == 0
                                          ? AppColor.white
                                          : AppColor.dark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                        ),
                        Text("product Designer")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(selectedItemColor: AppColor.primary, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.cases_outlined), label: "Jobs"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
      ]),
    );
  }
}
