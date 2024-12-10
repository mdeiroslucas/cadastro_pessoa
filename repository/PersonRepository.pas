unit PersonRepository;

interface

uses
  //firedac
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  //classes
  DBConnection, Person;

type TPersonRepository = class
  constructor create;
  destructor destroy;

  private
    Connection: TDBConnection;
  public
    procedure savePerson(const Person: TPerson);

    function getPersonType: TDataSource;
end;

implementation

{ TPersonTypeRepository }

constructor TPersonRepository.create;
begin
  self.Connection:= TDBConnection.create;
end;

destructor TPersonRepository.destroy;
begin
  self.Connection.destroy;
end;

function TPersonRepository.getPersonType: TDataSource;
var
  fQuery: TFDQuery;
  dataSource: TDataSource;
  sSqL: string;
begin
  fQuery              := TFDQuery.Create(nil);
  dataSource          := TDataSource.Create(nil);

  dataSource          := fQuery.DataSource;

  fQuery.Connection   := self.Connection.FDConnection;

  sSql:=
  'SELECT             '+
  '   id, descricao   '+
  'FROM               '+
  '   tipo_pessoa;    ';

  fQuery.Open(sSQL);

  fQuery.RecordCount;

  Result:= dataSource;
end;

procedure TPersonRepository.savePerson(const Person: TPerson);
var
  fQuery: TFDQuery;
  sSql: string;
begin
  fQuery:= TFDQuery.Create(nil);

  try
    fQuery.Connection :=  self.Connection.FDConnection;

    sSql:=
    'INSERT INTO pessoas (                                                                              '+
    '   nome_completo, data_nascimento, cpf, rg, email, telefone, tipo_pessoa_id, endereco_id           '+
    ')  VALUES (                                                                                        '+
    '   :nome_completo, :data_nascimento, :cpf, :rg, :email, :telefone, :tipo_pessoa_id, :endereco_id  )';

    fQuery.SQL.Text:= sSQL;

    fQuery.ParamByName('nome_completo').AsString    :=  Person.fullName;
    fQuery.ParamByName('data_nascimento').AsDate    :=  Person.birthDate;
    fQuery.ParamByName('cpf').AsString              :=  Person.cpf;
    fQuery.ParamByName('rg').AsString               :=  Person.rg;
    fQuery.ParamByName('email').AsString            :=  Person.email;
    fQuery.ParamByName('telefone').AsString         :=  Person.phone;
    fQuery.ParamByName('tipo_pessoa_id').AsInteger  :=  Person.personType.id;
    fQuery.ParamByName('endereco_id').AsInteger     :=  Person.address.id;

    fQuery.ExecSQL;
  finally
    fQuery.Close;
    fQuery.Free;
  end;
end;

end.