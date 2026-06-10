import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/submission_model.dart';

class SubmissionDetailController extends GetxController {
  final SubmissionModel submission;
  final address = ''.obs;
  final isLoadingAddress = true.obs;

  SubmissionDetailController({required this.submission});

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    isLoadingAddress.value = true;
    address.value = '';

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse'
        '?format=json&lat=${submission.latitude}'
        '&lon=${submission.longitude}&addressdetails=1',
      );
      final response = await http
          .get(
            url,
            headers: {'User-Agent': 'QuestionnaireApp/1.0'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final displayName = data['display_name'] as String?;
        address.value = displayName ?? 'Unknown location';
      } else {
        address.value = 'Unable to fetch address';
      }
    } on TimeoutException {
      address.value = 'Request timed out. Check your connection.';
    } on SocketException {
      address.value = 'No internet connection.';
    } on http.ClientException {
      address.value = 'Unable to reach location service.';
    } on FormatException {
      address.value = 'Invalid response from location service.';
    } catch (e) {
      address.value = 'Unable to fetch address';
    } finally {
      isLoadingAddress.value = false;
    }
  }

  bool get hasAddressError {
    final addr = address.value;
    return addr.contains('Unable') ||
        addr.contains('timed out') ||
        addr.contains('internet') ||
        addr.contains('error');
  }
}