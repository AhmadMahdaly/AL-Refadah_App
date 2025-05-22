/// This file contains all the constants variables used in the app
// for easy access and modification.

library;

///  This is the ID of the company used in the app.
const int companyId = 2;

///
const Map<String, String> arabicToLatinNumberMap = {
  '1': '١',
  '2': '٢',
  '3': '٣',
  '4': '٤',
  '5': '٥',
  '6': '٦',
  '7': '٧',
  '8': '٨',
  '9': '٩',
  '0': '٠',
};
String convertArabicToLatin(String input) {
  var result = input.toLowerCase();
  arabicToLatinNumberMap.forEach((latin, arabic) {
    result = result.replaceAll(arabic, latin);
  });
  return result;
}

const String appTitle = 'Al-Rifadah';
const String welcomeToCompany = 'اهلا بك في شركة الرفادة';
