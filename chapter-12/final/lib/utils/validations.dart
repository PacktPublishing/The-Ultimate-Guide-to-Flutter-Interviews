class Validations{
 static bool  validateUpdateBook(int bookId, String newBookName){
    if (bookId > 0 && newBookName.isNotEmpty) {
      return true;
    }
      return false;
  }
}