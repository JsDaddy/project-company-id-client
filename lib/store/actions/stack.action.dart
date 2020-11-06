import 'package:company_id_new/common/helpers/app-enums.dart';
import 'package:company_id_new/store/models/stack.model.dart';

class GetStackPending {
  GetStackPending({this.stackTypes = StackTypes.Default});
  StackTypes stackTypes;
}

class GetStackSuccess {
  GetStackSuccess(this.stack);
  List<StackModel> stack;
}

class GetStackError {}
