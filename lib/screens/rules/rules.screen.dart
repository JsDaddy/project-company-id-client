import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/store/actions/rules.action.dart';
import 'package:company_id_new/store/models/rules.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.rules});
  List<RulesModel> rules;
}

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key key}) : super(key: key);
  @override
  _RulesScreenState createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final Duration _kExpand = const Duration(milliseconds: 200);
  Animation<double> _iconTurns;
  final List<bool> _isExpanded = List<bool>.filled(10, false);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  @override
  void initState() {
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    if (store.state.rules != null && store.state.rules.isNotEmpty) {
      return;
    }
    store.dispatch(GetRulesPending());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) =>
            _ViewModel(rules: store.state.rules),
        builder: (BuildContext context, _ViewModel state) {
          return ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Internal rules',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              if (state.rules != null && state.rules.isNotEmpty)
                ...state.rules.map(
                  (RulesModel rule) => ExpansionTile(
                    onExpansionChanged: (bool exp) => setState(() {
                      _isExpanded[state.rules.indexWhere(
                          (RulesModel stateRule) =>
                              stateRule.title == rule.title)] = exp;
                    }),
                    trailing: RotationTransition(
                        turns: _iconTurns,
                        child: !_isExpanded[state.rules.indexWhere(
                                (RulesModel stateRule) =>
                                    stateRule.title == rule.title)]
                            ? const Icon(
                                Icons.expand_more,
                                color: AppColors.red,
                              )
                            : const Icon(
                                Icons.expand_less,
                                color: AppColors.red,
                              )),
                    key: PageStorageKey<int>(state.rules.indexWhere(
                        (RulesModel stateRule) =>
                            stateRule.title == rule.title)),
                    title: Text(
                      rule.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Text(
                              rule.desc,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        });
  }
}
