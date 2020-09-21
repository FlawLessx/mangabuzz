import 'dart:io';

String fixture(String name) =>
    File('test/unit_test/fixtures/$name.json').readAsStringSync();
