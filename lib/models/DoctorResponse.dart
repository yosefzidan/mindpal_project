/// message : "doctor created successfully"
/// doctor : {"name":"doctor16","password":"...","role":"doctor","_id":"682499f50a72d43696110174","code":"A84de","createdAt":"2025-05-14T13:26:13.537Z"}

class DoctorResponse {
  DoctorResponse({
    this.message,
    this.doctor,
    this.doctors,
  });

  String? message;
  Doctor? doctor;
  List<Doctor>? doctors;

  DoctorResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['doctor'] != null) {
      doctor = Doctor.fromJson(json['doctor']);
    } else if (json['doctors'] != null) {
      doctors =
          List<Doctor>.from(json['doctors'].map((x) => Doctor.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (doctor != null) {
      map['doctor'] = doctor!.toJson();
    }
    if (doctors != null) {
      map['doctors'] = doctors!.map((x) => x.toJson()).toList();
    }
    return map;
  }
}

/// name : "doctor16"
/// password : "..."
/// role : "doctor"
/// _id : "682499f50a72d43696110174"
/// code : "A84de"
/// createdAt : "2025-05-14T13:26:13.537Z"

class Doctor {
  Doctor({
    this.name,
    this.password,
    this.role,
    this.id,
    this.code,
    this.createdAt,
    this.deviceTokens,
  });

  String? name;
  String? password;
  String? role;
  String? id;
  String? code;
  String? createdAt;
  String? deviceTokens; // ممكن يكون null أو List<String>

  Doctor.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    role = json['role'];
    id = json['_id'];
    code = json['code'];
    createdAt = json['createdAt'];
    deviceTokens = json['deviceTokens'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['role'] = role;
    map['_id'] = id;
    map['code'] = code;
    map['createdAt'] = createdAt;
    map['deviceTokens'] = deviceTokens;
    return map;
  }

  Map<String, dynamic> toJsonForPost() {
    return {
      'name': name,
      'password': password,
    };
  }
}
