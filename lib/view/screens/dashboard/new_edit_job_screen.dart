import 'package:flutter/material.dart';
import 'package:job_finder/models/jobs.dart';
import 'package:job_finder/services/api.dart';
import 'package:job_finder/utils/colors.dart';
import 'package:job_finder/utils/storage.dart';

class NewEditJobScreen extends StatefulWidget {
  const NewEditJobScreen(
      {Key? key, this.isEdit = false, this.currentJob = null})
      : super(key: key);

  final bool? isEdit;
  final JobModel? currentJob;

  @override
  State<NewEditJobScreen> createState() => _NewEditJobScreenState();
}

class _NewEditJobScreenState extends State<NewEditJobScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();

    _titleController.text = widget.currentJob?.title ?? '';
    _descriptionController.text = widget.currentJob?.description ?? '';
    _salaryController.text = widget.currentJob?.salary ?? '';
    _addressController.text = widget.currentJob?.address ?? '';
    _tagsController.text = widget.currentJob?.tags ?? '';
    _companyController.text = widget.currentJob?.company ?? '';
    _addressController.text = widget.currentJob?.address ?? '';
    _cityController.text = widget.currentJob?.city ?? '';
    _stateController.text = widget.currentJob?.state ?? '';
    _phoneController.text = widget.currentJob?.phone ?? '';
    _emailController.text = widget.currentJob?.email ?? '';
    _requirementsController.text = widget.currentJob?.requirements ?? '';
    _benefitsController.text = widget.currentJob?.benefits ?? '';
  }

  // Edit job method
  void editJob() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String salary = _salaryController.text;
    String tags = _tagsController.text;
    String company = _companyController.text;
    String address = _addressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String requirements = _requirementsController.text;
    String benefits = _benefitsController.text;

    // Check if required fields are not empty
    if (title.isNotEmpty ||
        description.isNotEmpty ||
        salary.isNotEmpty ||
        tags.isNotEmpty ||
        company.isNotEmpty ||
        address.isNotEmpty ||
        city.isNotEmpty ||
        state.isNotEmpty ||
        phone.isNotEmpty ||
        email.isNotEmpty ||
        requirements.isNotEmpty ||
        benefits.isNotEmpty) {
      // Call the updaet job API
      final response = await ApiService.updateJob(
        widget.currentJob?.id ?? '',
        title,
        description,
        salary,
        tags,
        company,
        address,
        city,
        state,
        phone,
        email,
        requirements,
        benefits,
      );

      if (response != null) {
        if (response.id != null) {
          // Handle success, e.g., show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Job updated successfully")),
          );

          Navigator.pushNamed(context, '/dashboard/jobs');
        } else if (response.message != null) {
          // Handle error message from the API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message!.toString())),
          );
        } else {
          // Show a generic error message if response.data and message are both null
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred while updating the job")),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred while update the job")),
        );
      }
    } else {
      // Show error message for empty required fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in fields")),
      );
    }
  }

  // Create job method
  void createJob() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String salary = _salaryController.text;
    String tags = _tagsController.text;
    String company = _companyController.text;
    String address = _addressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String requirements = _requirementsController.text;
    String benefits = _benefitsController.text;

    // Check if required fields are not empty
    if (title.isNotEmpty &&
        description.isNotEmpty &&
        salary.isNotEmpty &&
        tags.isNotEmpty &&
        company.isNotEmpty &&
        address.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        requirements.isNotEmpty &&
        benefits.isNotEmpty) {
      // Call the create job API
      final response = await ApiService.createJob(
        title,
        description,
        salary,
        tags,
        company,
        address,
        city,
        state,
        phone,
        email,
        requirements,
        benefits,
      );

      if (response != null) {
        if (response.id != null) {
          // Handle success, e.g., show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Job created successfully")),
          );

          Navigator.pushNamed(context, '/dashboard/jobs');
        } else if (response.message != null) {
          // Handle error message from the API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message!.toString())),
          );
        } else {
          // Show a generic error message if response.data and message are both null
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred while creating the job")),
          );
        }
      } else {
        // Show a generic error message if response is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred while creating the job")),
        );
      }
    } else {
      // Show error message for empty required fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit! ? "Edit Job" : "Create New Job"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 4,
                ),
                Text(
                  widget.isEdit! ? "Edit Job" : "Create Job",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFields for job creation
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Job Title",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Job Description",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _salaryController,
                  decoration: InputDecoration(
                    hintText: "Salary",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _tagsController,
                  decoration: InputDecoration(
                    hintText: "Tags",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _companyController,
                  decoration: InputDecoration(
                    hintText: "Company",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: "City",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    hintText: "State",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _requirementsController,
                  decoration: InputDecoration(
                    hintText: "Requirements",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _benefitsController,
                  decoration: InputDecoration(
                    hintText: "Benefits",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.secondary,
                        width: 1,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Save button with GestureDetector
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      widget.isEdit! ? editJob() : createJob();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        !widget.isEdit! ? "Save" : "Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
