/// message : "doctor created successfully"
/// doctor : {"name":"doctor16","password":"...","role":"doctor","_id":"682499f50a72d43696110174","code":"A84de","createdAt":"2025-05-14T13:26:13.537Z"}

class DoctorResponse {
  DoctorResponse({
    this.message,
    this.doctor,
  });

  DoctorResponse.fromJson(dynamic json) {
    message = json['message'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  String? message;
  Doctor? doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
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
  });

  Doctor.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    role = json['role'];
    id = json['_id'];
    code = json['code'];
    createdAt = json['createdAt'];
  }

  String? name;
  String? password;
  String? role;
  String? id;
  String? code;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['role'] = role;
    map['_id'] = id;
    map['code'] = code;
    map['createdAt'] = createdAt;
    return map;
  }

  Map<String, dynamic> toJsonForPost() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    return map;
  }
}
