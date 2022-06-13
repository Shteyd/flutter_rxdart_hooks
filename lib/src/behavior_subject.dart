part of 'hook.dart';

/// Creates a [BehaviorSubject] which is automatically disposed when necessary.
///
/// See also:
///   * [BehaviorSubject], the created object
BehaviorSubject<T> useBehaviorSubjectController<T>(
    {bool sync = false,
    VoidCallback? onListen,
    VoidCallback? onCancel,
    List<Object>? keys}) {
  return use(_BehaviorSubjectControllerHook(
    onCancel: onCancel,
    onListen: onListen,
    sync: sync,
    keys: keys,
  ));
}

class _BehaviorSubjectControllerHook<T> extends Hook<BehaviorSubject<T>> {
  const _BehaviorSubjectControllerHook({
    required this.sync,
    this.onListen,
    this.onCancel,
    List<Object>? keys,
  }) : super(keys: keys);

  final bool sync;
  final VoidCallback? onListen;
  final VoidCallback? onCancel;

  @override
  _BehaviorSubjectControllerHookState<T> createState() =>
      _BehaviorSubjectControllerHookState<T>();
}

class _BehaviorSubjectControllerHookState<T>
    extends HookState<BehaviorSubject<T>, _BehaviorSubjectControllerHook<T>> {
  late final BehaviorSubject<T> _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = BehaviorSubject<T>(
      sync: hook.sync,
      onCancel: hook.onCancel,
      onListen: hook.onListen,
    );
  }

  @override
  void didUpdateHook(_BehaviorSubjectControllerHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook.onListen != hook.onListen) {
      _controller.onListen = hook.onListen;
    }
    if (oldHook.onCancel != hook.onCancel) {
      _controller.onCancel = hook.onCancel;
    }
  }

  @override
  BehaviorSubject<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.close();

  @override
  String get debugLabel => 'useBehaviorSubjectController';
}
