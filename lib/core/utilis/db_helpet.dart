import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String dbName = "history.db";
  final String tableName = "currency_history";
  final String colId = "id";
  final String colFrom = "fromCurrency";
  final String colTO = "toCurrency";
  final String colDate = "date";
  final String colAmount = "amount";
  final String colDifference = "difference";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colFrom TEXT,$colTO TEXT,$colDate TEXT,$colAmount TEXT,$colDifference TEXT)");
  }

  insertRecord(
      {required String from,
      required String to,
      required String date,
      required String amount,
      required String difference}) async {
    await initDB();
    String query =
        "INSERT INTO $tableName($colFrom, $colTO, $colAmount, $colDifference, $colDate) VALUES(?, ?, ?, ?, ?)";
    List args = [from, to, amount, difference, date];

    await db?.rawInsert(query, args);
  }

  Future fetchAllRecords() async {
    await initDB();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<CurrencyDB> historyList =
        data.map((e) => CurrencyDB.fromJSON(data: e)).toList();

    return historyList;
  }

  Future<void> clearRecords() async {
    await initDB();

    // Execute a SQL query to delete all records from the table
    await db!.delete(tableName);

    // Optionally, you can print a message or perform any other action after clearing the records
    print('All records cleared successfully');
  }
}
