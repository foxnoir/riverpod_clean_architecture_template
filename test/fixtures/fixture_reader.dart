import 'dart:io';

/// fixture: Reads a file synchronously and returns its content as a string.
/// jsonDecode: Decodes this string into a dart data structure
/// (e.g. a list or map).

String fixture(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
