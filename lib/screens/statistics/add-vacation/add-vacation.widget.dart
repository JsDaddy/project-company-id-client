import 'package:company_id_new/common/helpers/app-colors.dart';
import 'package:company_id_new/common/helpers/app-converting.dart';
import 'package:company_id_new/common/helpers/app-dropdowns.dart';
import 'package:company_id_new/common/services/validators.service.dart';
import 'package:company_id_new/common/widgets/app-button/app-button.widget.dart';
import 'package:company_id_new/common/widgets/app-dropdown-wrapper/app-dropdown-wrapper.widget.dart';
import 'package:company_id_new/common/widgets/app-input/app-input.widget.dart';
import 'package:company_id_new/store/actions/logs.action.dart';
import 'package:company_id_new/store/actions/ui.action.dart';
import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/log.model.dart';
import 'package:company_id_new/store/models/user.model.dart';
import 'package:company_id_new/store/reducers/reducer.dart';
import 'package:company_id_new/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  _ViewModel({this.isLoading, this.user});
  bool isLoading;
  UserModel user;
}

class AddVacationDialogWidget extends StatefulWidget {
  const AddVacationDialogWidget({this.choosedDate, Key key}) : super(key: key);
  final DateTime choosedDate;

  @override
  _AddVacationDialogWidgetState createState() =>
      _AddVacationDialogWidgetState();
}

class _AddVacationDialogWidgetState extends State<AddVacationDialogWidget> {
  VacationType selectedReason;
  List<VacationType> reasons = <VacationType>[
    VacationType.VacNonPaid,
    VacationType.VacPaid,
    VacationType.SickNonPaid,
    VacationType.SickPaid
  ];
  final TextEditingController _descController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel(
            isLoading: store.state.isLoading, user: store.state.user),
        builder: (BuildContext context, _ViewModel state) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Builder(builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AppDropDownWrapperWidget(
                                    child:
                                        DropdownButtonFormField<VacationType>(
                                  decoration: AppDropDownStyles.decoration,
                                  style: AppDropDownStyles.style,
                                  icon: AppDropDownStyles.icon,
                                  autovalidate: true,
                                  isExpanded: AppDropDownStyles.isExpanded,
                                  hint: const Text('Select reason',
                                      style: AppDropDownStyles.hintStyle),
                                  value: selectedReason,
                                  onChanged: (VacationType value) {
                                    setState(() {
                                      selectedReason = value;
                                    });
                                  },
                                  items: reasons.map((VacationType reason) {
                                    return DropdownMenuItem<VacationType>(
                                        value: reason,
                                        child: Text(
                                            AppConverting.getVacationTypeString(
                                                reason)));
                                  }).toList(),
                                )),
                                const SizedBox(height: 16),
                                AppInput(
                                  maxLines: 4,
                                  myController: _descController,
                                  validator: (String value) =>
                                      validators.validateIsEmpty(
                                          value, 'Please enter description'),
                                  labelText: 'Description',
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButtonWidget(
                            color: AppColors.green,
                            onClick: () => _request(state),
                            title: 'Request'),
                        const SizedBox(width: 12),
                        AppButtonWidget(
                          title: 'Cancel',
                          onClick: () => Navigator.pop(context),
                        )
                      ])
                ])),
          );
        });
  }

  void _request(_ViewModel state) {
    store.dispatch(SetTitle('Statistics'));
    if (!_formKey.currentState.validate()) {
      return;
    }

    store.dispatch(RequestVacationPending(LogModel(
        desc: _descController.text,
        date: widget.choosedDate,
        type: LogType.Vacation,
        user: state.user,
        status: RequestStatus.Pending,
        vacationType: selectedReason)));
  }
}
