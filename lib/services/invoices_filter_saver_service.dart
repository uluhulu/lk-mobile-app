class InvoiceFilterSaverService {
  InvoiceFilterSaverService._privateConstructor();
  static final InvoiceFilterSaverService _instance =
      InvoiceFilterSaverService._privateConstructor();
  static InvoiceFilterSaverService get instance => _instance;

  final Map<String, dynamic> _filters = {};

  void saveFilter(String key, dynamic value) {
    _filters[key] = value;
  }

  dynamic getFilter(String key) {
    return _filters[key];
  }

  void clearFilter(String key) {
    _filters.remove(key);
  }

  void clearAllFilters() {
    _filters.clear();
  }

  bool isFilterExist(String key) {
    return _filters.containsKey(key);
  }

  bool isFilterEmpty(String key) {
    return _filters[key] == null;
  }

  bool isFilterNotEmpty(String key) {
    return _filters[key] != null;
  }

  void init() {
    _filters.clear();
  }
}
