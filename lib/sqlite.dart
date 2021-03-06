// import 'dart:async';
//
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// final String databaseName = 'devices';
//
// void connectDatabase(String databaseName) async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   final Future<Database> database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//       join(await getDatabasesPath(), databaseName+'.db'),
//   );
//  }
//
// Future<void> initDatabase(Device device) async {
//   // Get a reference to the database.
//   final Database db = await database;
//
//
// }
//
// void sqliteTest() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final Future<Database> database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'devices.db'),
//     // When the database is first created, create a table to store dogs.
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE devices(id INTEGER PRIMARY KEY, deviceId INTEGER, deviceName TEXT)",
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
//
//   Future<void> insertDevice(Device device) async {
//     // Get a reference to the database.
//     final Database db = await database;
//
//     // Insert the Dog into the correct table. Also specify the
//     // `conflictAlgorithm`. In this case, if the same dog is inserted
//     // multiple times, it replaces the previous data.
//     await db.insert(
//       'devices',
//       devices.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<Device>> devices() async {
//     // Get a reference to the database.
//     final Database db = await database;
//
//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('devices');
//
//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return Device(
//         id: maps[i]['id'],
//         deviceId: maps[i]['deviceId'],
//         deviceName: maps[i]['deviceName'],
//       );
//     });
//   }
//
//   Future<void> updateDevice(Device device) async {
//     // Get a reference to the database.
//     final db = await database;
//
//     // Update the given Dog.
//     await db.update(
//       'devices',
//       device.toMap(),
//       // Ensure that the Dog has a matching id.
//       where: "id = ?",
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [dog.id],
//     );
//   }
//
//   Future<void> deleteDog(int id) async {
//     // Get a reference to the database.
//     final db = await database;
//
//     // Remove the Dog from the database.
//     await db.delete(
//       'dogs',
//       // Use a `where` clause to delete a specific dog.
//       where: "id = ?",
//       // Pass the Dog's id as a whereArg to prevent SQL injection.
//       whereArgs: [id],
//     );
//   }
//
//   var fido = Dog(
//     id: 0,
//     name: 'Fido',
//     age: 35,
//   );
//
//   // Insert a dog into the database.
//   await insertDog(fido);
//
//   // Print the list of dogs (only Fido for now).
//   print(await dogs());
//
//   // Update Fido's age and save it to the database.
//   fido = Dog(
//     id: fido.id,
//     name: fido.name,
//     age: fido.age + 7,
//   );
//   await updateDog(fido);
//
//   // Print Fido's updated information.
//   print(await dogs());
//
//   // Delete Fido from the database.
//   //await deleteDog(fido.id);
//
//   // Print the list of dogs (empty).
//   print(await dogs());
// }
//
// class Device {
//   final int id;
//   final int deviceId;
//   final String deviceName;
//
//
//   Device({this.id, this.deviceId, this.deviceName});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'deviceId': deviceId,
//       'deviceName': deviceName,
//     };
//   }
//
//   // Implement toString to make it easier to see information about
//   // each dog when using the print statement.
//   @override
//   String toString() {
//     return 'Dog{id: $id, name: $deviceName, age: $deviceId}';
//   }
// }
