import 'package:date_format/date_format.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final _Refresh refresh = _Refresh();

class _Refresh {
  RefreshController refreshController = RefreshController(initialRefresh: true);
}
