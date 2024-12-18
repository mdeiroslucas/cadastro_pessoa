unit PersonRepository;

interface

uses
  //firedac
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.SysUtils,

  //classes
  DBConnection, Person;

type TPersonRepository = class
  constructor create;
  destructor destroy;

  private
    Connection: TDBConnection;
  public
    procedure savePerson(const Person: TPerson);
    procedure updatePerson(const Person: TPerson);
    procedure deletePerson(const id: integer);

    function getPersonType: TDataSource;
    function getPeople: TDataSource;
    function isCPFRegisted(const sCPF: string): Boolean;
end;

implementation

{ TPersonTypeRepository }

constructor TPersonRepository.create;
begin
  self.Connection:= TDBConnection.create;
end;

procedure TPersonRepository.deletePerson(const id: integer);
var
  fQuery: TFDQuery;
  sSqL: string;
  idade: integer;
begin
  fQuery     := TFDQuery.Create(nil);

  try
    fQuery.Connection := self.Connection.FDConnection;

    sSQL:= 'DELETE FROM person WHERE id = ' + id.ToString;

    fQuery.SQL.Text:= sSQL;

    fQuery.ExecSQL;

  finally
    fQuery.Close;
    fQuery.Free;
  end;
end;

destructor TPersonRepository.destroy;
begin
  self.Connection.destroy;
end;

function TPersonRepository.getPeople: TDataSource;
var
  fQuery: TFDQuery;
  ds: TDataSource;
  sSqL: string;
begin
  fQuery     := TFDQuery.Create(nil);
  ds         := TDataSource.Create(nil);

  ds.DataSet := fQuery;

  fQuery.Connection := self.Connection.FDConnection;

  sSql:=
  'SELECT                                             '+
  '   id,                                             '+
  '   CAST(full_name AS VARCHAR(80)) AS full_name,    '+
  '   birth_date,                                     '+
  '   CAST(cpf AS VARCHAR(20)) AS cpf,                '+
  '   CAST(rg AS VARCHAR(15)) AS rg,                  '+
  '   CAST(email AS VARCHAR(15)) AS email,            '+
  '   CAST(phone AS VARCHAR(20)) AS phone,            '+
  '   CAST(city AS VARCHAR(20)) AS city,              '+
  '   CAST(state AS VARCHAR(20)) AS state,            '+
  '   CAST(street AS VARCHAR(20)) AS street,          '+
  '   CAST(district AS VARCHAR(20)) AS district,      '+
  '   CAST(cep AS VARCHAR(20)) AS cep,                '+
  '   person_type_id                                  '+
  'FROM                                               '+
  '   person;                                         ';

  fQuery.Open(sSQL);

  fQuery.RecordCount;

  Result:= ds;
end;

function TPersonRepository.getPersonType: TDataSource;
var
  fQuery: TFDQuery;
  ds: TDataSource;
  sSqL: string;
begin
  fQuery     := TFDQuery.Create(nil);
  ds         := TDataSource.Create(nil);

  ds.DataSet := fQuery;

  fQuery.Connection   := self.Connection.FDConnection;

  sSql:=
  'SELECT                                              '+
  '   id,                                              '+
  '   CAST(description AS VARCHAR(80)) AS description  '+
  'FROM                                                '+
  '   person_type;                                     ';

  fQuery.Open(sSQL);

  Result:= ds;
end;

function TPersonRepository.isCPFRegisted(const sCPF: string): Boolean;
var
  fQuery: TFDQuery;
  sSqL: string;
  bIsCPFRegisted: boolean;
begin
  fQuery     := TFDQuery.Create(nil);

  try
    fQuery.Connection   := self.Connection.FDConnection;

    sSql:=
    'SELECT                     '+
    '   id                      '+
    'FROM                       '+
    '   person                  '+
    'WHERE                      '+
    '   cpf = ' + QuotedStr(sCpf);

    fQuery.Open(sSql);

    Result:= (not fQuery.IsEmpty);
  finally
    fQuery.Close;
    fQuery.Free;
  end;
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
    'INSERT INTO person (                                                       '+
    '   full_name, birth_date, cpf, rg, email, phone, person_type_id,           '+
    '   street, district, city, state, cep                                      '+
    ')  VALUES (                                                                '+
    '   :full_name, :birth_date, :cpf, :rg, :email, :phone, :person_type_id,    '+
    '   :street, :district, :city, :state, :cep)                                ';

    fQuery.SQL.Text:= sSQL;

    fQuery.ParamByName('full_name').AsString        :=  Person.fullName;
    fQuery.ParamByName('birth_date').AsDate         :=  Person.birthDate;
    fQuery.ParamByName('cpf').AsString              :=  Person.cpf;
    fQuery.ParamByName('rg').AsString               :=  Person.rg;
    fQuery.ParamByName('email').AsString            :=  Person.email;
    fQuery.ParamByName('phone').AsString            :=  Person.phone;
    fQuery.ParamByName('person_type_id').AsInteger  :=  Person.personType.id;
    fQuery.ParamByName('street').AsString           :=  Person.Address.street;
    fQuery.ParamByName('district').AsString         :=  Person.Address.district;
    fQuery.ParamByName('city').AsString             :=  Person.Address.city;
    fQuery.ParamByName('state').AsString            :=  Person.Address.state;
    fQuery.ParamByName('cep').AsString              :=  Person.Address.cep;

    fQuery.ExecSQL;
  finally
    fQuery.Close;
    fQuery.Free;
  end;
end;

procedure TPersonRepository.updatePerson(const Person: TPerson);
var
  fQuery: TFDQuery;
  sSql: string;
begin
  fQuery:= TFDQuery.Create(nil);

  try
    fQuery.Connection :=  self.Connection.FDConnection;

    sSql:=
    'UPDATE person SET                              '+
    '   full_name = :full_name,                     '+
    '   birth_date = :birth_date,                   '+
    '   cpf = :cpf,                                 '+
    '   rg = :rg,                                   '+
    '   email= :email,                              '+
    '   phone = :phone,                             '+
    '   person_type_id = :person_type_id,           '+
    '   street = :street,                           '+
    '   district = :district,                       '+
    '   city = :city,                               '+
    '   state = :state,                             '+
    '   cep = :cep                                  '+
    'WHERE                                          '+
    '   person.id = :id                             ';

    fQuery.SQL.Text:= sSQL;

    fQuery.ParamByName('full_name').AsString        :=  Person.fullName;
    fQuery.ParamByName('birth_date').AsDate         :=  Person.birthDate;
    fQuery.ParamByName('cpf').AsString              :=  Person.cpf;
    fQuery.ParamByName('rg').AsString               :=  Person.rg;
    fQuery.ParamByName('email').AsString            :=  Person.email;
    fQuery.ParamByName('phone').AsString            :=  Person.phone;
    fQuery.ParamByName('person_type_id').AsInteger  :=  Person.personType.id;
    fQuery.ParamByName('street').AsString           :=  Person.Address.street;
    fQuery.ParamByName('district').AsString         :=  Person.Address.district;
    fQuery.ParamByName('city').AsString             :=  Person.Address.city;
    fQuery.ParamByName('state').AsString            :=  Person.Address.state;
    fQuery.ParamByName('cep').AsString              :=  Person.Address.cep;
    fQuery.ParamByName('id').AsInteger              :=  Person.id;

    fQuery.ExecSQL;
  finally
    fQuery.Close;
    fQuery.Free;
  end;
end;

end.
