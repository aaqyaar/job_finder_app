import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/models/jobs.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key, required this.job}) : super(key: key);

  final JobModel job;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        '/Users/abdizamed/StudioProjects/job_finder/assets/job.png',
                        width: 60,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.job.company.toString(),
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.job.title.toString(),
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.job.salary.toString(),
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.job.city.toString()} , ${widget.job.state.toString()}, ${widget.job.address.toString()}',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Job Description",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.job.description.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.2,
                            height: 50,
                          ),
                          Text(
                            "Requirements",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.job.requirements.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.2,
                            height: 50,
                          ),
                          Text(
                            "Benefits",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.job.benefits.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.2,
                            height: 50,
                          ),
                          Text(
                            "Tags",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.job.tags.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                final Uri url = Uri.parse('mailto:${widget.job.email}');
                launchUrl(url);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Apply Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
