import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/submission_model.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._();
  factory LocalStorageService() => _instance;
  LocalStorageService._();

  static const String _userBoxName = 'userBox';
  static const String _submissionsBoxName = 'submissionsBox';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBoxName);
    await Hive.openBox(_submissionsBoxName);
  }

  Box get _userBox => Hive.box(_userBoxName);
  Box get _submissionsBox => Hive.box(_submissionsBoxName);

  Map<String, dynamic> _allUsers() {
    final data = _userBox.get('users');
    if (data == null) return {};
    return jsonDecode(data);
  }

  Future<void> _saveAllUsers(Map<String, dynamic> users) async {
    await _userBox.put('users', jsonEncode(users));
  }

  Future<void> saveUser(UserModel user) async {
    final users = _allUsers();
    users[user.phone] = user.toMap();
    await _saveAllUsers(users);
    await _userBox.put('loggedInPhone', user.phone);
  }

  UserModel? getUserByPhone(String phone) {
    final users = _allUsers();
    final data = users[phone];
    if (data == null) return null;
    return UserModel.fromMap(data);
  }

  UserModel? getLoggedInUser() {
    final phone = _userBox.get('loggedInPhone');
    if (phone == null) return null;
    return getUserByPhone(phone);
  }

  Future<void> setLoggedInPhone(String phone) async {
    await _userBox.put('loggedInPhone', phone);
  }

  Future<void> clearSession() async {
    await _userBox.delete('loggedInPhone');
  }

  Future<void> saveSubmission(SubmissionModel submission) async {
    final allSubmissions = _getAllSubmissions();
    allSubmissions.add(submission);
    final encoded = allSubmissions.map((s) => s.toMap()).toList();
    await _submissionsBox.put('submissions', jsonEncode(encoded));
  }

  List<SubmissionModel> _getAllSubmissions() {
    final data = _submissionsBox.get('submissions');
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((s) => SubmissionModel.fromMap(s)).toList();
  }

  List<SubmissionModel> getSubmissions(String userId) {
    return _getAllSubmissions().where((s) => s.userId == userId).toList();
  }

  int getSubmissionCount(String userId) {
    return getSubmissions(userId).length;
  }
}
