enum DataConstants {
  commandValue(value: "command"),
  eventChannelPath(value: "com.gorman.archimed/events"),
  methodChannelPath(value: "com.gorman.archimed/methods");
  const DataConstants({
    required this.value
  });
  final String value;
}
