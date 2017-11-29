unit DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TAnswer=(yes,no,dunno);

  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    fContinuous: string;
    f3Samples: string;
    fParametric: string;
    fIndepSamples: string;
    fCovariate: string;
    fSelect: string;
    fTestList: TStringList;
  public
    { Public declarations }
    procedure ThreeSamples(answer:TAnswer);
    procedure ContinuousData(answer:TAnswer);
    procedure IndependentSamples(answer:TAnswer);
    procedure Parametric(answer:TAnswer);
    procedure Covariates(answer:TAnswer);
    function updateSQL: string;
    function GetDescription(aParameter:string): string;

  end;

var
  TestHandler: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.ContinuousData(answer: TAnswer);
begin
  if answer=yes then
  fContinuous := ' where continuous=1'
  else if answer=no then
  fContinuous := ' where continuous=0'
  else if answer=dunno then
  fContinuous := ' where (continuous=1 or continuous=0)' ;
end;

procedure TDataModule1.Covariates(answer: TAnswer);
begin
  if answer=yes then
  fCovariate := ' and covariate=1'
  else if answer=no then
  fCovariate := ' and covariate=0'
  else if answer=dunno then
  fCovariate := '';


end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
    fTestList:=TStringList.Create;

   fSelect := 'SELECT * FROM tests';
  // need something with a 'where'
  // or else an error will be thrown
  // until user clicks the Continuous group, none of
  // the other variables contain a 'where'
  fContinuous := ' where (continuous=1 or continuous=0)';
end;

procedure TDataModule1.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IF DEFINED(iOS) OR DEFINED(Android)}
  FDConnection1.Params.Values['Database']:=TPath.Combine(TPath.GetDocumentsPath,'Stats.db');
  {$ENDIF}
end;

function TDataModule1.GetDescription(aParameter: string): string;
begin

    FDQuery1.SQL.Text :=
      'SELECT description FROM Tests WHERE "test-name"=:aParameter';
    FDQuery1.ParamByName('aParameter').AsString := aParameter;
    FDQuery1.Open();
    result := FDQuery1.FieldByName('description').AsString;
end;

procedure TDataModule1.IndependentSamples(answer: TAnswer);
begin
   if answer=yes then
   fIndepSamples := ' and `indep-samples`=1'
  else if answer=no then
  fIndepSamples := ' and `indep-samples`=0'
  else if answer=dunno then
  fIndepSamples := '';
end;

procedure TDataModule1.Parametric(answer: TAnswer);
begin
   if answer=yes then
   fParametric := ' and parametric=1'
  else if answer=no then
  fParametric := ' and parametric=0'
  else if answer=dunno then
  fParametric := '';
end;

procedure TDataModule1.ThreeSamples(answer: TAnswer);
begin
  if answer=yes then
  f3Samples := ' and `3-samples`=1'
  else if answer=no then
  f3Samples := ' and `3-samples`=0'
  else if answer=dunno then
  f3Samples := '';

end;

function TDataModule1.updateSQL: string;
begin
  fTestList.Clear;

  FDQuery1.SQL.Text := fSelect + fContinuous + f3Samples + fParametric +
    fIndepSamples + fCovariate;
  FDQuery1.Active := true;

  FDQuery1.First;
  while not FDQuery1.Eof do
  begin
    fTestList.Add(FDQuery1.FieldByName('test-name').AsString);
    FDQuery1.Next;
  end;
  result:=fTestList.text;
end;

end.
