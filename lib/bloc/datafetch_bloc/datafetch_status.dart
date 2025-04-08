abstract class DataFetchStatus {
  const DataFetchStatus();
}

class InitialFetchStatus extends DataFetchStatus {
  const InitialFetchStatus();
}

class FetchingData extends DataFetchStatus {
  const FetchingData();
}

class RefreshingData extends DataFetchStatus {
  const RefreshingData();
}

class FetchSuccess extends DataFetchStatus {
  const FetchSuccess();
}

class FetchFailure extends DataFetchStatus {
  final Object exception;

  FetchFailure(this.exception);

  String get error => exception.toString();
}

