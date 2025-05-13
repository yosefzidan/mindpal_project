/// message : "Patient created successfully"
/// patient : {"name":"patient2","password":"$2b$08$.hjXLmSicgXlxNrGTjqfkeVQ77A73ZBbXevU0f5.V0sDQ9yNl5PcC","role":"patient","doctorId":"68207753fb560432549cc905","age":50,"_id":"6823ab81c3be7442e49339fa","code":"5e114","createdAt":"2025-05-13T20:28:49.390Z"}

class PatientResponse {
  PatientResponse({
    this.message,
    this.patient,
  });

  PatientResponse.fromJson(dynamic json) {
    message = json['message'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
  }

  String? message;
  Patient? patient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    return map;
  }
}

/// name : "patient2"
/// password : "$2b$08$.hjXLmSicgXlxNrGTjqfkeVQ77A73ZBbXevU0f5.V0sDQ9yNl5PcC"
/// role : "patient"
/// doctorId : "68207753fb560432549cc905"
/// age : 50
/// _id : "6823ab81c3be7442e49339fa"
/// code : "5e114"
/// createdAt : "2025-05-13T20:28:49.390Z"

class Patient {
  Patient({
    this.name,
    this.password,
    this.role,
    this.doctorId,
    this.age,
    this.id,
    this.code,
    this.createdAt,
  });

  Patient.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    role = json['role'];
    doctorId = json['doctorId'];
    age = json['age'];
    id = json['_id'];
    code = json['code'];
    createdAt = json['createdAt'];
  }

  String? name;
  String? password;
  String? role;
  String? doctorId;
  int? age;
  String? id;
  String? code;
  String? createdAt;

  Map<String, dynamic> toJsonForPost() {
    return {
      'name': name,
      'password': password,
      'age': age,
      'code': code,
    };
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['role'] = role;
    map['doctorId'] = doctorId;
    map['age'] = age;
    map['_id'] = id;
    map['code'] = code;
    map['createdAt'] = createdAt;
    return map;
  }
}
