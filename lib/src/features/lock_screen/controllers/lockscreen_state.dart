class LockScreenState {
  final bool enableLock;
  final bool isSuccess;
  final bool isError;
  final bool isNewUser;
  final String passCode;
  LockScreenState({
    required this.enableLock,
    required this.isSuccess,
    required this.isError,
    required this.isNewUser,
    required this.passCode,
  });

  LockScreenState copyWith({
    bool? enableLock,
    bool? isSuccess,
    bool? isError,
    bool? isNewUser,
    String? passCode,
  }) {
    return LockScreenState(
      enableLock: enableLock ?? this.enableLock,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isNewUser: isNewUser ?? this.isNewUser,
      passCode: passCode ?? this.passCode,
    );
  }
}
