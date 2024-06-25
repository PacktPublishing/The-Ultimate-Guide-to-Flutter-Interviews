class ServiceLocator {
  static Map<String, dynamic> _services = {};

  static void registerService(String key, dynamic service) {
    _services[key] = service;
  }

  static T getService<T>(String key) {
    if (_services.containsKey(key)) {
      return _services[key] as T;
    } else {
      throw Exception('Service not registered with key: $key');
    }
  }
}