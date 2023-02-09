enum UserRole {
  clientReceivables,
  clientNotReceivables,
}

enum UserAccess {
  image,
  claim,
  catalog,
  offers,
  receivable,
}

extension UserAccessString on UserAccess {
  static UserAccess? fromString(String name) {
    switch (name) {
      case 'image':
        return UserAccess.image;
      case 'claim':
        return UserAccess.claim;
      case 'catalog':
        return UserAccess.catalog;
      case 'offers':
        return UserAccess.offers;
      case 'receivable':
        return UserAccess.receivable;
      default:
        return null;
    }
  }
}

extension UserListRole on List<UserRole> {
  bool get isClientReceivables => contains(UserRole.clientReceivables);
}

extension UserListAccess on List<UserAccess> {
  bool get isImage => contains(UserAccess.image);
  bool get isClaim => contains(UserAccess.claim);
  bool get isCatalog => contains(UserAccess.catalog);
  bool get isOffers => contains(UserAccess.offers);
  bool get isReceivable => contains(UserAccess.receivable);
}
