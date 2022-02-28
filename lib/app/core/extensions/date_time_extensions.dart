extension GetDateTime on DateTime {
  String getDateTime() {
    final String localDateTime = toLocal().toString();
    final List<String> splittedDateTime = localDateTime.split('.');
    return splittedDateTime[0];
  }
}
