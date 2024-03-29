// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<RespostaLogin> autenticar(login) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(login.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaLogin>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/usuarios/autenticar',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaLogin.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespostaRegistrar> registrar(registrar) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(registrar.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaRegistrar>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/usuarios/registrar',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaRegistrar.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespostaRecuperarSenha> recuperarSenha(recuperarSenha) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(recuperarSenha.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaRecuperarSenha>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/usuarios/recuperarSenha',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaRecuperarSenha.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespostaPerfil> obterPerfil(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaPerfil>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/usuarios/perfil',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaPerfil.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespostaAlterarSenha> atualizarSenha(
      authorization, atualizarSenha) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(atualizarSenha.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaAlterarSenha>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/usuarios/atualizarSenha',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaAlterarSenha.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Estabelecimento>> obterEstabelecimentos(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Estabelecimento>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/estabelecimentos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Estabelecimento.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Agendamento>> obterAgendamentos(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Agendamento>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/agendamentos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Agendamento.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<HorariosDisponiveisAgendamento>> obterHorariosDisponiveis(
      authorization, idEstabelecimento) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<HorariosDisponiveisAgendamento>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/agendamentos/horarios/${idEstabelecimento}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            HorariosDisponiveisAgendamento.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RespostaCriarAgendamento> criarAgendamento(
      authorization, criarAgendamento) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(criarAgendamento.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespostaCriarAgendamento>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/agendamentos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespostaCriarAgendamento.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
