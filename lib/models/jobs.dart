class BaseResponse<T> {
  int? numberOfPages;
  int? currentPage;
  int? total;
  List<T>? data;

  BaseResponse({
    this.numberOfPages,
    this.currentPage,
    this.total,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        numberOfPages: json["numberOfPages"],
        currentPage: json["currentPage"],
        total: json["total"],
        data: List<T>.from(json["data"].map((x) => x)),
      );
}

class JobModel {
  String? id;
  String? user;
  String? title;
  String? description;
  String? salary;
  String? tags;
  String? company;
  String? address;
  String? city;
  String? state;
  String? phone;
  String? email;
  String? requirements;
  String? benefits;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? message;

  JobModel(
      {this.id,
      this.user,
      this.title,
      this.description,
      this.salary,
      this.tags,
      this.company,
      this.address,
      this.city,
      this.state,
      this.phone,
      this.email,
      this.requirements,
      this.benefits,
      this.v,
      this.createdAt,
      this.updatedAt,
      this.message});

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
      id: json["_id"],
      user: json["user"],
      title: json["title"],
      description: json["description"],
      salary: json["salary"],
      tags: json["tags"],
      company: json["company"],
      address: json["address"],
      city: json["city"],
      state: json["state"],
      phone: json["phone"],
      email: json["email"],
      requirements: json["requirements"],
      benefits: json["benefits"],
      v: json["__v"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      message: json['message']);
}
