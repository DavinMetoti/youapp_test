class ApiRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String users = '/users';
  static const String userById = '/users/{id}';

  static String userDetail(String id) => '/users/$id';
}
