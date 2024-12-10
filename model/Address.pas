unit Address;

interface

type TAddress = class
  private
    Fid: integer;
    Fcity: string;
    Fdistrict: string;
    Fstate: string;
    Fstreet: string;
    Fcep: string;

    procedure Setcity(const Value: string);
    procedure Setdistrict(const Value: string);
    procedure Setstate(const Value: string);
    procedure Setstreet(const Value: string);
    procedure Setid(const Value: integer);
    procedure Setcep(const Value: string);

  published
    property city: string read Fcity write Setcity;
    property district: string read Fdistrict write Setdistrict;
    property state: string read Fstate write Setstate;
    property street: string read Fstreet write Setstreet;
    property id: integer read Fid write Setid;
    property cep: string read Fcep write Setcep;
  end;

implementation

{ TAddress }

procedure TAddress.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TAddress.Setcity(const Value: string);
begin
  Fcity := Value;
end;

procedure TAddress.Setdistrict(const Value: string);
begin
  Fdistrict := Value;
end;

procedure TAddress.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TAddress.Setstate(const Value: string);
begin
  Fstate := Value;
end;

procedure TAddress.Setstreet(const Value: string);
begin
  Fstreet := Value;
end;

end.
