import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class TokenDataMapper extends BaseDataMapper<DataResponse<TokenData>, Token> {
  @override
  Token mapToEntity(DataResponse<TokenData>? data) {
    return Token(
      accessToken: data?.data?.accessToken ?? '',
      typeToken: data?.data?.typeToken ?? '',
      message: data?.message ?? '',
      statusCode: data?.status_code ?? 0,
    );
  }
}
