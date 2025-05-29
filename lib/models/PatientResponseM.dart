/// message : "success"
/// patients : [{"_id":"680e46afa94ae296cbf6d8d3","name":"patient2","password":"$2b$08$ci1eOsZ/IDEHnFn4tWcNHevuXNpZmAOspBuLskXHeiPqRY0t.njDG","role":"patient","doctorId":"680e4606f8dafd5edaa6bbd5","age":50,"code":"5099f","createdAt":"2025-04-27T15:01:03.273Z","scan":[{"_id":"680e4d5d8c66969b28900505","filePath":"https://res.cloudinary.com/dkyodvnxd/image/upload/v1745767772/aiPhoto/or5bnxzpjhfehn6o7tkd.jpg","uploadedTo":"680e46afa94ae296cbf6d8d3","analyzed":true,"uploadDate":"2025-04-27T15:29:33.919Z","createdAt":"2025-04-27T15:29:33.926Z","analysisResult":"Very Mild Dementia"},null],"medicines":[{"_id":"680e49c84fd6d023c98125a8","name":"Panado4","dosage":"500mg","schedule":"evert 8 hour","type":"tablet","startDate":"2025-04-14T00:00:00.000Z","endDate":"2025-04-21T00:00:00.000Z","prescribedTo":"680e46afa94ae296cbf6d8d3","confirm":true,"__v":0}]},null]

class PatientResponseM {
  PatientResponseM({
    this.message,
    this.patients,
  });

  PatientResponseM.fromJson(dynamic json) {
    message = json['message'];
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients?.add(Patients.fromJson(v));
      });
    }
  }

  String? message;
  List<Patients>? patients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (patients != null) {
      map['patients'] = patients?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "680e46afa94ae296cbf6d8d3"
/// name : "patient2"
/// password : "$2b$08$ci1eOsZ/IDEHnFn4tWcNHevuXNpZmAOspBuLskXHeiPqRY0t.njDG"
/// role : "patient"
/// doctorId : "680e4606f8dafd5edaa6bbd5"
/// age : 50
/// code : "5099f"
/// createdAt : "2025-04-27T15:01:03.273Z"
/// scan : [{"_id":"680e4d5d8c66969b28900505","filePath":"https://res.cloudinary.com/dkyodvnxd/image/upload/v1745767772/aiPhoto/or5bnxzpjhfehn6o7tkd.jpg","uploadedTo":"680e46afa94ae296cbf6d8d3","analyzed":true,"uploadDate":"2025-04-27T15:29:33.919Z","createdAt":"2025-04-27T15:29:33.926Z","analysisResult":"Very Mild Dementia"},null]
/// medicines : [{"_id":"680e49c84fd6d023c98125a8","name":"Panado4","dosage":"500mg","schedule":"evert 8 hour","type":"tablet","startDate":"2025-04-14T00:00:00.000Z","endDate":"2025-04-21T00:00:00.000Z","prescribedTo":"680e46afa94ae296cbf6d8d3","confirm":true,"__v":0}]

class Patients {
  Patients({
    this.id,
    this.name,
    this.password,
    this.role,
    this.doctorId,
    this.age,
    this.code,
    this.createdAt,
    this.scan,
    this.medicines,
  });

  Patients.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    doctorId = json['doctorId'];
    age = json['age'];
    code = json['code'];
    createdAt = json['createdAt'];
    if (json['scan'] != null) {
      scan = [];
      json['scan'].forEach((v) {
        if (v != null) {
          scan?.add(Scan.fromJson(v));
        }
      });
    }

    if (json['medicines'] != null) {
      medicines = [];
      json['medicines'].forEach((v) {
        if (v != null) {
          medicines?.add(Medicines.fromJson(v));
        }
      });
    }
  }

  String? id;
  String? name;
  String? password;
  String? role;
  String? doctorId;
  int? age;
  String? code;
  String? createdAt;
  List<Scan>? scan;
  List<Medicines>? medicines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['password'] = password;
    map['role'] = role;
    map['doctorId'] = doctorId;
    map['age'] = age;
    map['code'] = code;
    map['createdAt'] = createdAt;
    if (scan != null) {
      map['scan'] = scan?.map((v) => v.toJson()).toList();
    }
    if (medicines != null) {
      map['medicines'] = medicines?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Map<String, dynamic> toJsonForPost() {
    return {
      'name': name,
      'password': password,
      'age': age,
      'code': code,
    };
  }
}

/// _id : "680e49c84fd6d023c98125a8"
/// name : "Panado4"
/// dosage : "500mg"
/// schedule : "evert 8 hour"
/// type : "tablet"
/// startDate : "2025-04-14T00:00:00.000Z"
/// endDate : "2025-04-21T00:00:00.000Z"
/// code : "680e46afa94ae296cbf6d8d3"
/// confirm : true
/// __v : 0

class Medicines {
  Medicines({
    this.id,
    this.name,
    this.dosage,
    this.schedule,
    this.type,
    this.startDate,
    this.endDate,
    this.code,
    this.confirm,
    this.v,
  });

  Medicines.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    dosage = json['dosage'];
    schedule = json['schedule'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    code = json['code'];
    confirm = json['confirm'];
    v = json['__v'];
  }

  String? id;
  String? name;
  String? dosage;
  String? schedule;
  String? type;
  String? startDate;
  String? endDate;
  String? code;
  bool? confirm;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['dosage'] = dosage;
    map['schedule'] = schedule;
    map['type'] = type;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['code'] = code;
    map['confirm'] = confirm;
    return map;
  }
}

/// _id : "680e4d5d8c66969b28900505"
/// filePath : "https://res.cloudinary.com/dkyodvnxd/image/upload/v1745767772/aiPhoto/or5bnxzpjhfehn6o7tkd.jpg"
/// uploadedTo : "680e46afa94ae296cbf6d8d3"
/// analyzed : true
/// uploadDate : "2025-04-27T15:29:33.919Z"
/// createdAt : "2025-04-27T15:29:33.926Z"
/// analysisResult : "Very Mild Dementia"

class Scan {
  Scan({
    this.id,
    this.filePath,
    this.uploadedTo,
    this.analyzed,
    this.uploadDate,
    this.createdAt,
    this.analysisResult,
  });

  Scan.fromJson(dynamic json) {
    id = json['_id'];
    filePath = json['filePath'];
    uploadedTo = json['uploadedTo'];
    analyzed = json['analyzed'];
    uploadDate = json['uploadDate'];
    createdAt = json['createdAt'];
    analysisResult = json['analysisResult'];
  }

  String? id;
  String? filePath;
  String? uploadedTo;
  bool? analyzed;
  String? uploadDate;
  String? createdAt;
  String? analysisResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['filePath'] = filePath;
    map['uploadedTo'] = uploadedTo;
    map['analyzed'] = analyzed;
    map['uploadDate'] = uploadDate;
    map['createdAt'] = createdAt;
    map['analysisResult'] = analysisResult;
    return map;
  }
}
