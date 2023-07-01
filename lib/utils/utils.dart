import 'package:saktan_app/globals.dart' as global;
import 'package:url_launcher/url_launcher.dart';

final baseUrl = global.urlApi;

String cleanPhoneNumber(String phoneNumber) {
  final RegExp nonDigitRegExp = RegExp(r'\D');
  return phoneNumber.replaceAll(nonDigitRegExp, '');
}

Future<void> launchInBrowser(Uri url) async {
  final RegExp phoneRegExp = RegExp(r'^\+?\d+$');
  final RegExp telRegExp = RegExp(r'^tel:\+?\d+$');
  final RegExp emailRegExp =
      RegExp(r'^(mailto:)?[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  final String urlString = url.toString();

  if (telRegExp.hasMatch(urlString)) {
    final phoneNumber = cleanPhoneNumber(urlString.substring(4));
    await makePhoneCall(phoneNumber);
  } else if (phoneRegExp.hasMatch(urlString)) {
    final phoneNumber = cleanPhoneNumber(urlString);
    await makePhoneCall(phoneNumber);
  } else if (emailRegExp.hasMatch(urlString)) {
    final email = urlString.replaceAll('mailto:', '');
    await makeEmail(email);
  } else {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> makeEmail(String email) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launchUrl(launchUri);
}

String getT(String currentLocale, String? ru, String? ky) {
  if (currentLocale == "ru") {
    return ru ?? "";
  } else {
    return ky ?? "";
  }
}
