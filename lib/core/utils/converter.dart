
class Converter{

  static List<String> splitAndFormatPhoneNumber(String phoneNumber) {
    // Split the phone number into three-character segments
    List<String> segments = [];
    for (int i = 0; i < phoneNumber.length; i += 3) {
      segments.add(phoneNumber.substring(i, i + 3));
    }

    // Format the segments according to the desired pattern
    String formattedNumber = '+20 ';
    for (int i = 0; i < segments.length; i++) {
      formattedNumber += segments[i];
      if (i!= segments.length - 1) {
        formattedNumber += '-';
      }
    }

    return [formattedNumber]; // Return as a list since the output is a single formatted number
  }

}