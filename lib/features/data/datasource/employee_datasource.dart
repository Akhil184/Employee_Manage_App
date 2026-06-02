import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/employee_model.dart';


class EmployeeDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String collection = "employees";

  Stream<List<EmployeeModel>> getEmployees() {
    return firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => EmployeeModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> addEmployee(EmployeeModel employee) async {
    await firestore.collection(collection).add(employee.toMap());
  }

  Future<void> updateEmployee(String id, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(id).update(data);
  }

  Future<void> deleteEmployee(String id) async {
    await firestore.collection(collection).doc(id).delete();
  }
}