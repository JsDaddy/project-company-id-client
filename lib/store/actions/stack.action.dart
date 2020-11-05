import 'package:company_id_new/store/models/stack.model.dart';

class GetStackPending {}

class GetStackSuccess {
  GetStackSuccess(this.stack);
  List<StackModel> stack;
}

class GetStackError {}
