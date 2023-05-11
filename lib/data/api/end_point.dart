class Endpoint {
  Endpoint._();
  static String baseUrl = "http://localhost:5000";

  // auth endpoints

  static String auth = "/auth";
  static String signUp = "/$auth/signup";
  static String signIn = "/$auth/signin";
  static String logout = "/$auth/logout";

  // notes endpoints

  static String notes = "/notes";
  static String createNote = "$notes/createNote";
  static String deleteNote = "$notes/deleteNote";
  static String updateNote = "$notes/updateNote";

// subnotes endpoints

  static String subNote = "/subNote";
  static String addSubNote = "$subNote/add";
  static String updateSubNote = "$subNote/update";
  static String deleteSubNote = "$subNote/delete";

// percentage endpoints

  static String percentage = "/percentage";
  static String completedTasks = "$percentage/completedTask";
  static String dailyTask = "$percentage/dailyTask";


}
