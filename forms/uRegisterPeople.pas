unit uRegisterPeople;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,

  //FireDac
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite, Vcl.Imaging.pngimage,

  //classes
  RESTRequest4D, IOUtils, Json, Person, PersonService;

type
  TfrmRegisterPeople = class(TForm)
    pnlHeader: TPanel;
    pnlMain: TPanel;
    pnlFooter: TPanel;
    btnDelete: TBitBtn;
    btnEdit: TBitBtn;
    btnSave: TBitBtn;
    dbPeople: TDBGrid;
    lvlFullName: TLabel;
    edtFullName: TEdit;
    lblCPF: TLabel;
    edtRg: TEdit;
    lblBirthDate: TLabel;
    medtBirthDate: TMaskEdit;
    lblRG: TLabel;
    meditCPF: TMaskEdit;
    edtEmail: TEdit;
    edtStreet: TEdit;
    edtDistrict: TEdit;
    lblEmail: TLabel;
    lblPhone: TLabel;
    medtPhone: TMaskEdit;
    lblStreet: TLabel;
    lblDistrict: TLabel;
    lblZipCode: TLabel;
    edtCity: TEdit;
    lblCity: TLabel;
    lblState: TLabel;
    edtState: TEdit;
    lblPersonType: TLabel;
    dcboxPersonType: TDBLookupComboBox;
    edtId: TEdit;
    lblId: TLabel;
    Image2: TImage;
    mEditCEP: TMaskEdit;
    pnlRecord: TPanel;
    lblQuantity: TLabel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbPeopleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnEditClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mEditCEPExit(Sender: TObject);
    procedure mEditCEPKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmailExit(Sender: TObject);

  private
    { Private declarations }

    PersonService: TPersonService;

    procedure searchCEP(const sCEP: string);
    procedure fillAddressFields(const jObject: TJsonObject);
    procedure savePerson;
    procedure setPersonData(var Person: TPerson);
    procedure unlockAddressfields;
    procedure clearFields;
    procedure loadDataToEdit;
    procedure deleteUser;
    procedure checkFieldsEmpty;
  public
    { Public declarations }

  end;

var
  frmRegisterPeople: TfrmRegisterPeople;

implementation

{$R *.dfm}

uses Address, PersonType;

{ TfrmRegisterPeople }

procedure TfrmRegisterPeople.edtEmailExit(Sender: TObject);
var
  sEmail: string;
begin
  sEmail:= edtEmail.Text;

  try
    if not (PersonService.isEmailValid(sEmail)) then
    begin
      MessageDlg('O email informado n�o � v�lido!', mtError, [mbOK], 0);
    end;
  finally
    sEmail:= '';
  end;
end;

procedure TfrmRegisterPeople.fillAddressFields(const jObject: TJsonObject);
begin
  edtStreet.Text    := jObject.GetValue('logradouro', '');
  edtCity.Text      := jObject.GetValue('localidade', '');
  edtState.Text     := jObject.GetValue('estado', '');
  edtDistrict.Text  := jObject.GetValue('bairro','');
end;

procedure TfrmRegisterPeople.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PersonService.destroy;

  Action := caFree;
  frmRegisterPeople := nil;
end;

procedure TfrmRegisterPeople.FormCreate(Sender: TObject);
var
  fQuery2: TFDQuery;
begin
  PersonService  := TPersonService.create;

  dcboxPersonType.ListSource  := PersonService.getPersonType;
  dbPeople.DataSource         := PersonService.getPeople;

  lblQuantity.Caption         :=  dbPeople.DataSource.DataSet.RecordCount.ToString;
end;

procedure TfrmRegisterPeople.loadDataToEdit;
begin
  edtId.Text                :=  dbPeople.DataSource.DataSet.FieldByName('id').AsInteger.ToString;
  edtFullName.Text          :=  dbPeople.DataSource.DataSet.FieldByName('full_name').AsString;
  medtBirthDate.Text        :=  FormatDateTime('dd/mm/yyyy', dbPeople.DataSource.DataSet.FieldByName('birth_date').AsDateTime);
  meditCPF.Text             :=  dbPeople.DataSource.DataSet.FieldByName('cpf').AsString;
  medtPhone.Text            :=  dbPeople.DataSource.DataSet.FieldByName('phone').AsString;
  edtRg.Text                :=  dbPeople.DataSource.DataSet.FieldByName('rg').AsString;
  edtEmail.Text             :=  dbPeople.DataSource.DataSet.FieldByName('email').AsString;
  edtCity.Text              :=  dbPeople.DataSource.DataSet.FieldByName('city').AsString;
  edtState.Text             :=  dbPeople.DataSource.DataSet.FieldByName('state').AsString;
  edtStreet.Text            :=  dbPeople.DataSource.DataSet.FieldByName('street').AsString;
  edtDistrict.Text          :=  dbPeople.DataSource.DataSet.FieldByName('district').AsString;
  mEditCEP.Text             :=  dbPeople.DataSource.DataSet.FieldByName('cep').AsString;

  dcboxPersonType.KeyValue  :=  dbPeople.DataSource.DataSet.FieldByName('person_type_id').AsInteger;
end;

procedure TfrmRegisterPeople.mEditCEPExit(Sender: TObject);
var
  sCEP: string;
begin
  sCEP:= mEditCEP.text;

  //Retira espa�os em branco do cep.
  sCEP := sCEP.Replace(' ', '').Replace('-', '');

  if PersonService.isCepValid(sCEP) then
  begin
    searchCEP(sCEP);

    unlockAddressfields;
  end else
    MessageDlg('O cep informado � inv�lido!', mtError, [mbOK], 0);
end;

procedure TfrmRegisterPeople.mEditCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ' ' then
    Key := #0;
end;

procedure TfrmRegisterPeople.btnSearchClick(Sender: TObject);
begin
  clearFields;
end;

procedure TfrmRegisterPeople.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja deletar este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    deleteUser;
end;

procedure TfrmRegisterPeople.btnEditClick(Sender: TObject);
begin
  loadDataToEdit;
end;

procedure TfrmRegisterPeople.btnSaveClick(Sender: TObject);
begin
  checkFieldsEmpty;

  savePerson;

  MessageDlg('Dados salvo com sucesso!', mtInformation, [mbOK], 0);
end;

procedure TfrmRegisterPeople.checkFieldsEmpty;
begin
  if edtFullName.Text = '' then
    raise Exception.Create('Campo nome est� vazio!');

  if edtRg.Text = '' then
    raise Exception.Create('Campo RG est� vazio!');

  if edtEmail.Text = '' then
    raise Exception.Create('O Campo email est� vazio!');

  if medtPhone.Text = '' then
    raise Exception.Create('O Campo telefone est� vazio!');

  if mEditCEP.Text = '     -   ' then
    raise Exception.Create('O Campo CEP est� vazio!');

  if edtCity.Text = '' then
    raise Exception.Create('O Campo Cidade est� vazio!');

  if edtState.Text = '' then
    raise Exception.Create('O Campo Estado est� vazio!');

  if edtStreet.Text = '' then
    raise Exception.Create('O Campo Logradouro est� vazio!');

  if edtDistrict.Text = '' then
    raise Exception.Create('O Campo Bairro est� vazio!');

  if dcboxPersonType.KeyValue = null then
    raise Exception.Create('Informe o tipo da Pessoa!');
end;

procedure TfrmRegisterPeople.clearFields;
var
  index: Integer;
  Edit: TEdit;
begin
  for index := 0 to pnlMain.ControlCount - 1 do
  begin
    // Verifica se o controle � um TEdit
    if pnlMain.Controls[index] is TEdit then
    begin
      Edit := TEdit(pnlMain.Controls[index]);

      // Limpa o texto do Edit.
      Edit.Text := '';
    end;
  end;

  medtPhone.Text            := '';
  meditCPF.Text             := '';
  medtBirthDate.Text        := '';
  mEditCEP.Text             := '';
  dcboxPersonType.KeyValue  := null;

  dbPeople.DataSource.DataSet.Refresh;
  lblQuantity.Caption  :=  dbPeople.DataSource.DataSet.RecordCount.ToString;
end;

procedure TfrmRegisterPeople.dbPeopleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with (Sender as TDBGrid) do
  begin
    if DataSource.DataSet.RecNo mod 2 = 0 then
      Canvas.Brush.Color := clWhite
    else
      Canvas.Brush.Color := clSilver;

    if gdSelected in State then
      Canvas.Brush.Color := clSkyBlue;

    dbPeople.Canvas.FillRect(Rect);

    dbPeople.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmRegisterPeople.deleteUser;
var
  id: integer;
begin
  if (dbPeople.SelectedIndex <> -1) then
  begin
    id := dbPeople.DataSource.DataSet.FieldByName('id').AsInteger;

    PersonService.deletePerson(id);

    dbPeople.DataSource.DataSet.Refresh;
  end else
    raise Exception.Create('Selecione um registro para deletar!');
end;

procedure TfrmRegisterPeople.savePerson;
var
  Person: TPerson;
begin
  Person:= TPerson.create;

  setPersonData(Person);

  try
    if Person.id = 0 then
    begin
      try
        PersonService.savePerson(Person)
      except on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end else
      PersonService.updatePerson(Person);

    clearFields;
  finally
    Person.destroy;
  end;
end;

procedure TfrmRegisterPeople.searchCEP(const sCEP: string);
var
  LResponse: IResponse;
  sUrl: string;
  jObject: TJsonObject;
begin
  sUrl := 'www.viacep.com.br/ws/'+sCEP+'/json/';

  jObject:= PersonService.getCEP(sUrl);

  fillAddressFields(jObject);
end;

procedure TfrmRegisterPeople.setPersonData(var Person: TPerson);
var
  sDate: string;
  lDate: TDateTime;
  FormatSettings: TFormatSettings;
begin
  sDate:= medtBirthDate.Text;

  Person.fullName :=  edtFullName.Text;

  FormatSettings                  := TFormatSettings.Create;
  FormatSettings.ShortDateFormat  := 'd/m/y';
  FormatSettings.DateSeparator    := '/';


  if not PersonService.isDateValid(sDate) then
  begin
    MessageDlg('A data informada n�o � v�lida!', mtError, [mbOK], 0);
    abort;
  end;

  if edtId.Text <> '' then
    Person.id := StrToInt(edtId.Text);

  Person.cpf              :=  meditCPF.Text;
  Person.rg               :=  edtRg.Text;
  Person.email            :=  edtEmail.Text;
  Person.phone            :=  medtPhone.Text;
  Person.address.city     :=  edtCity.Text;
  Person.address.state    :=  edtState.Text;
  Person.address.street   :=  edtStreet.Text;
  Person.address.district :=  edtDistrict.Text;
  Person.Address.cep      :=  mEditCEP.Text;
  Person.personType.id    :=  dcboxPersonType.KeyValue;
end;

procedure TfrmRegisterPeople.unlockAddressfields;
begin
  edtCity.Enabled     := true;
  edtState.Enabled    := true;
  edtDistrict.Enabled := true;
  edtStreet.Enabled   := true;
end;

end.
