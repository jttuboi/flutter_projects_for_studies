const String databaseName = "contacts.db";
const String tableName = "contacts";
const String createContactsTableScript =
    "CREATE TABLE contacts(id INTEGER PRIMARY KEY,name TEXT, email TEXT, phone TEXT,image TEXT, addressLine1 TEXT, addressLine2 TEXT, latLng TEXT)";
