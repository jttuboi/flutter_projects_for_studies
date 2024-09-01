// import 'dart:developer';

// import '../entities/contact.dart';
// import '../entities/meta.dart';
// import '../services/result/result.dart';
// import '../utils/constants.dart';
// import 'i_contact_offline_datasource.dart';

// class FakeContactOfflineDataSource implements IContactOfflineDataSource {
//   FakeContactOfflineDataSource._();
//   static final instance = FakeContactOfflineDataSource._();

//   @override
//   Future<({List<Contact> contacts, Meta meta})> getAll({int page = 0}) async {
//     await Future.delayed(const Duration(seconds: 3));

//     final start = page * qtyContactsPerPage;
//     var end = (page + 1) * qtyContactsPerPage;

//     if (end > _contacts.length) {
//       end = _contacts.length;
//     }

//     final record = (
//       contacts: _contacts.getRange(start, end).toList(),
//       meta: _createMeta(page),
//     );

//     return record;
//   }

//   @override
//   Future<Result<Contact>> get(String id) async {
//     final contact = _contacts.firstWhere((contact) => contact.id == id, orElse: () {
//       return const Contact.noData();
//     });
//     return Success(contact);
//   }

//   @override
//   Future<Result<void>> deleteAll() async {
//     _contacts.clear();

//     return const Success(null);
//   }

//   @override
//   Future<Result<Contact>> create(Contact contactToAdd) async {
//     final newContact = contactToAdd.copyWith(id: _nextId.toString());
//     _contacts.add(newContact);

//     _nextId++;

//     return Success(newContact);
//   }

//   @override
//   Future<Result<Contact>> update(Contact contactToUpdate) async {
//     final index = _contacts.indexWhere((contact) => contact.id == contactToUpdate.id);
//     _contacts[index] = contactToUpdate;

//     return Success(contactToUpdate);
//   }

//   @override
//   Future<Result<Contact>> delete(Contact contactToRemove) async {
//     return Success(contactToRemove);
//   }

//   @override
//   Future<void> desynchronizeList() async {}

//   void print() {
//     log('[');
//     for (final contact in _contacts) {
//       log(contact.toString());
//     }
//     log(']');
//   }

//   Meta _createMeta(int page) {
//     final totalPages = (_contacts.length / qtyContactsPerPage).ceil();
//     final isLastPage = (page + 1) == totalPages;

//     return Meta(
//       previousPage: page - 1, // -1 se (page == 0)
//       currentPage: page,
//       nextPage: isLastPage ? -1 : page + 1, // -1 se ()
//       totalPages: totalPages,
//       totalEntries: _contacts.length,
//     );
//   }

//   int _nextId = 4;

//   final _contacts = <Contact>[
//     // contato "normal"
//     const Contact(
//       id: '1',
//       name: 'Jão (arq normal)',
//       avatarUrl: 'https://archives.bulbagarden.net/media/upload/5/54/0007Squirtle.png',
//       documentUrl: 'https://www.orimi.com/pdf-test.pdf',
//     ),
//     // contato com arquivos grandes
//     const Contact(
//       id: '2',
//       name: 'Zé (arq grandes)',
//       avatarUrl: 'https://freetestdata.com/wp-content/uploads/2021/09/png-5mb-1.png',
//       documentUrl: 'https://freetestdata.com/wp-content/uploads/2022/11/Free_Test_Data_10.5MB_PDF.pdf',
//     ),
//     // contato sem arquivos
//     const Contact(
//       id: '3',
//       name: 'Maria (sem arq)',
//       avatarUrl: '',
//       documentUrl: '',
//     ),
//     // contato com arquivos inválidos
//     const Contact(
//       id: '4',
//       name: 'Maria (arq bugados)',
//       avatarUrl: 'https://pixabay.com/get/gf62d964c9db4324cbaee_640.png',
//       documentUrl: 'https://google.com/asd.png',
//     ),
//     const Contact(id: '5', name: '5', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '6', name: '6', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '7', name: '7', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '8', name: '8', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '9', name: '9', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '10', name: '10', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '11', name: '11', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '12', name: '12', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '13', name: '13', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '14', name: '14', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '15', name: '15', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '16', name: '16', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '17', name: '17', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '18', name: '18', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '19', name: '19', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '20', name: '20', avatarUrl: '', documentUrl: ''),
//     const Contact(id: '21', name: '21', avatarUrl: '', documentUrl: ''),
//   ];

//   @override
//   Future<bool> isListSynchronized() {
//     // TODO: implement isListSynchronized
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> synchronizeList() {
//     // TODO: implement synchronizeList
//     throw UnimplementedError();
//   }
// }
