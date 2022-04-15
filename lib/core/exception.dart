class NoInternetException implements Exception{
  NoInternetException({message});
  @override
  String toString() {
    return "No internet connection!";
  }
}

class GenericException implements Exception{
  @override
  String toString() {
    return "Something went wrong!";
  }
}