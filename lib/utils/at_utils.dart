class ATUtils {

  // Ensures a safe date string is returned for methods like DateTime.parse
  static String ensureSafeDateString(String maybeUnsafeDate) {
    return maybeUnsafeDate.substring(0, 19);
  }
}