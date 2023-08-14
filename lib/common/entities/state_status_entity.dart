enum StateStatus {
  loading,
  done,
  error,
  init,
}

extension StateStatusExtension on StateStatus {
  toName(){
    switch(this){
      case StateStatus.done:
        return "done";
      case StateStatus.loading:
        return "loading";
      case StateStatus.error:
        return "error";
      case StateStatus.init:
        return "init";
    }
  }
}
