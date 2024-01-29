import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/models/jobs.dart';
import 'package:job_finder/view/screens/job_screen.dart';
import 'package:job_finder/widgets/reusable_card.dart';

import '../utils/colors.dart';

class JobCard extends StatelessWidget {
  JobCard({
    required this.image,
    required this.salary,
    required this.companyName,
    required this.jobTitle,
    required this.job,
    Key? key,
  }) : super(key: key);

  final String image;
  final String salary;
  final String companyName;
  final String jobTitle;
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  '/Users/abdizamed/StudioProjects/job_finder/assets/job.png',
                  width: 60,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    companyName,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.bookmark_border,
                size: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "${salary}K".toString(),
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${job.city}, ${job.state}'),
              ReUsableCard(
                isTapped: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return JobDetailsScreen(job: job);
                  }));
                },
                jobType: "Apply",
                color: AppColor.secondary,
                bgColor: AppColor.primary,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
