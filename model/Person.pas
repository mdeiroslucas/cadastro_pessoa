unit Person;

interface

uses
  SysUtils, Address, PersonType;

type TPerson = class
  constructor create;
  destructor destroy;

  private
    FbirthDate: TDate;
    Frg: string;
    Femail: string;
    Fcpf: string;
    Fphone: string;
    FfullName: string;
    Faddress: TAddress;
    FpersonType: TPersonType;
    Fid: integer;

    procedure Setaddress(const Value: TAddress);
    procedure SetbirthDate(const Value: TDate);
    procedure Setcpf(const Value: string);
    procedure Setemail(const Value: string);
    procedure SetfullName(const Value: string);
    procedure Setphone(const Value: string);
    procedure Setrg(const Value: string);
    procedure SetpersonType(const Value: TPersonType);
    procedure Setid(const Value: integer);

  published
    property fullName: string read FfullName write SetfullName;
    property birthDate: TDate read FbirthDate write SetbirthDate;
    property cpf: string read Fcpf write Setcpf;
    property rg: string read Frg write Setrg;
    property email: string read Femail write Setemail;
    property phone: string read Fphone write Setphone;
    property address: TAddress read Faddress write Setaddress;
    property personType: TPersonType read FpersonType write SetpersonType;
    property id: integer read Fid write Setid;

end;

implementation

{ TPerson }

constructor TPerson.create;
begin
  Address     := TAddress.Create;
  PersonType  :=  TPersonType.Create;
end;

destructor TPerson.destroy;
begin
  Address.Destroy;
  PersonType.Destroy;
end;

procedure TPerson.Setaddress(const Value: TAddress);
begin
  Faddress := Value;
end;

procedure TPerson.SetbirthDate(const Value: TDate);
begin
  FbirthDate := Value;
end;

procedure TPerson.Setcpf(const Value: string);
begin
  Fcpf := Value;
end;

procedure TPerson.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TPerson.SetfullName(const Value: string);
begin
  FfullName := Value;
end;

procedure TPerson.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TPerson.SetpersonType(const Value: TPersonType);
begin
  FpersonType := Value;
end;

procedure TPerson.Setphone(const Value: string);
begin
  Fphone := Value;
end;

procedure TPerson.Setrg(const Value: string);
begin
  Frg := Value;
end;

end.
