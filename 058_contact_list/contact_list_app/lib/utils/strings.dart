class Strings {
  const Strings._();

  static const title = 'Contact List';

  static const contacts = 'Contacts';
  static const contactsDesynchronized = 'Os contatos podem estar desincronizados, para atualizar conecte na internet.';
  static String contactsName({required String name, required String syncStatus}) {
    return '$name ($syncStatus)';
  }

  static const contactsShowData = 'Show data';
  static String contactsOpenDocument(String path) {
    final paths = path.split('/');
    final fullName = paths.last;
    final partialName = (fullName.length > 15) ? '...${fullName.substring(fullName.length - 15)}' : fullName;

    return 'Open ${(partialName.isEmpty) ? 'document' : partialName}';
  }

  static const contactName = 'Name';
  static const contactNameError = 'Name must not be empty.';
  static const contactDocument = 'Document';
  static const contactDocumentHint = 'Attach pdf document';
  static const contactSave = 'Save';
  static const contactAddMessage = 'Contato foi adicionado.';
  static const contactEditMessage = 'Contato foi editado.';
  static const contactDeleteMessage = 'Contato foi removido.';

  static const cOutdatedDataInfoDefaultText = 'Os dados podem estar desatualizados, para atualizar conecte na internet.';
  static String cTextTileTitle(String title) {
    return '$title: ';
  }
}
