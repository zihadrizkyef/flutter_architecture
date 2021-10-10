abstract class RepoException {
  String message;
  RepoException(this.message);
}

class NoInternetException extends RepoException {
  NoInternetException(message): super(message);
}

class NoServiceFoundException extends RepoException {
  NoServiceFoundException(message): super(message);
}

class InvalidFormatException extends RepoException {
  InvalidFormatException(message): super(message);
}

class UnknownException extends RepoException {
  UnknownException(message): super(message);
}