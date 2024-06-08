String getRoutes(List<String> routeNames) {
  final StringBuffer stringBuffer = StringBuffer();
  routeNames.map((e) {
    stringBuffer.write(e);
    if (routeNames.last != e) {
      stringBuffer.write(' - ');
    }
  }).toList();
  return stringBuffer.toString();
}
