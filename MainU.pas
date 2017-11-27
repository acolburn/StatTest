unit MainU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, System.Rtti, FMX.Grid.Style, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Controls,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts,
  FMX.Bind.Navigator, Data.Bind.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.StdCtrls, FMX.WebBrowser, FireDAC.Comp.UI,
  System.IOUtils, DM;

type
  TForm2 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    rdoContinuousYes: TRadioButton;
    rdoContinuousNo: TRadioButton;
    rdoIndependent: TRadioButton;
    rdoDependent: TRadioButton;
    rdo2Samples: TRadioButton;
    rdo3Samples: TRadioButton;
    rdoParametric: TRadioButton;
    rdoNonParametric: TRadioButton;
    rdoCovariatesYes: TRadioButton;
    rdoCovariatesNo: TRadioButton;
    rdoContinuousDontKnow: TRadioButton;
    rdoIndependentDontKnow: TRadioButton;
    rdo2SamplesDontKnow: TRadioButton;
    rdoParametricDontKnow: TRadioButton;
    rdoCovariatesDontKnow: TRadioButton;
    WebBrowser1: TWebBrowser;
    StringGrid1: TStringGrid;
    FDQueryDisplayDescription: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    StringColumn1: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure ContinuousYes(Sender: TObject);
    procedure ContinuousNo(Sender: TObject);
    procedure IndependentSamples(Sender: TObject);
    procedure DependentSamples(Sender: TObject);
    procedure TwoSamples(Sender: TObject);
    procedure ThreeOrMoreSamples(Sender: TObject);
    procedure ParametricYes(Sender: TObject);
    procedure ParametricNo(Sender: TObject);
    procedure CovariatesYes(Sender: TObject);
    procedure CovariatesNo(Sender: TObject);
    procedure ContinuousDontKnow(Sender: TObject);
    procedure IndependentDontKnow(Sender: TObject);
    procedure TwoSamplesDontKnow(Sender: TObject);
    procedure ParametricDontKnow(Sender: TObject);
    procedure CovariatesDontKnow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    // procedure GridBindSourceDB1SelectCell(Sender: TObject; const ACol,
    // ARow: Integer; var CanSelect: Boolean);
  private
    procedure UpdateDisplay;
    { Private declarations }
    // fContinuous: string;
    // f3Samples: string;
    // fParametric: string;
    // fIndepSamples: string;
    // fCovariate: string;
    // fSelect: string;
    // procedure updateSQL;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm2.TwoSamples(Sender: TObject);
begin
  // f3Samples := ' and `3-samples`=0';
  // updateSQL;
  TestHandler.ThreeSamples(no);
  UpdateDisplay;

end;

procedure TForm2.ThreeOrMoreSamples(Sender: TObject);
begin
  // f3Samples := ' and `3-samples`=1';
  // updateSQL;
  TestHandler.ThreeSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.ContinuousNo(Sender: TObject);
begin
  // fContinuous := ' where continuous=0';
  TestHandler.ContinuousData(no);
  UpdateDisplay;
end;

procedure TForm2.ContinuousYes(Sender: TObject);
begin
  // fContinuous := ' where continuous=1';
  TestHandler.ContinuousData(yes);
  UpdateDisplay;
end;

procedure TForm2.CovariatesNo(Sender: TObject);
begin
  // fCovariate := ' and covariate=0';
  TestHandler.Covariates(no);
  UpdateDisplay;
end;

procedure TForm2.CovariatesYes(Sender: TObject);
begin
  // fCovariate := ' and covariate=1';
  TestHandler.Covariates(yes);
  UpdateDisplay;
end;

procedure TForm2.DependentSamples(Sender: TObject);
begin
  // fIndepSamples := ' and `indep-samples`=0';
  TestHandler.IndependentSamples(no);
  UpdateDisplay;
end;

procedure TForm2.IndependentSamples(Sender: TObject);
begin
  // fIndepSamples := ' and `indep-samples`=1';
  TestHandler.IndependentSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.ParametricNo(Sender: TObject);
begin
  // fParametric := ' and parametric=0';
  TestHandler.Parametric(no);
  UpdateDisplay;
end;

procedure TForm2.ParametricYes(Sender: TObject);
begin
  // fParametric := ' and parametric=1';
  TestHandler.Parametric(yes);
  UpdateDisplay;
end;

procedure TForm2.StringGrid1SelectCell(Sender: TObject;
  const ACol, ARow: Integer; var CanSelect: Boolean);
var
  sParameter: string;
  s: string;
begin
  if ARow > -1 then
  begin
    sParameter := StringGrid1.Cells[ACol, ARow];
    FDQueryDisplayDescription.SQL.Text :=
      'SELECT description FROM Tests WHERE "test-name"=:aParameter';
    FDQueryDisplayDescription.ParamByName('aParameter').AsString := sParameter;
    FDQueryDisplayDescription.Open();
    s := FDQueryDisplayDescription.FieldByName('description').AsString;
    WebBrowser1.LoadFromStrings(s, '');
  end;
end;

procedure TForm2.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IF DEFINED(iOS) OR DEFINED(Android)}
  FDConnection1.Params.Values['Database'] :=
    TPath.Combine(TPath.GetDocumentsPath, 'Stats.db');
{$ENDIF}
end;

procedure TForm2.UpdateDisplay;
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    sl.Text := TestHandler.updateSQL;
    for i := 0 to sl.Count - 1 do
      StringGrid1.Cells[0, i] := sl[i];
  finally
    sl.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  // fSelect := 'SELECT * FROM tests';
  // need something with a 'where'
  // or else an error will be thrown
  // until user clicks the Continuous group, none of
  // the other variables contain a 'where'
  // fContinuous := ' where (continuous=1 or continuous=0)';
  StringColumn1.Width := StringGrid1.Width;
end;

// procedure TForm2.GridBindSourceDB1SelectCell(Sender: TObject; const ACol,
// ARow: Integer; var CanSelect: Boolean);
// begin
// showmessage('OnSelectCell. Col='+IntToStr(ACol)+',Row='+IntToStr(ARow));
// end;

procedure TForm2.TwoSamplesDontKnow(Sender: TObject);
begin
  // f3Samples := '';
  // updateSQL;
  TestHandler.ThreeSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.ContinuousDontKnow(Sender: TObject);
begin
  // fContinuous := ' where (continuous=1 or continuous=0)';
  TestHandler.ContinuousData(dunno);
  UpdateDisplay;
end;

procedure TForm2.CovariatesDontKnow(Sender: TObject);
begin
  // fCovariate := '';
  TestHandler.Covariates(dunno);
  UpdateDisplay;
end;

procedure TForm2.IndependentDontKnow(Sender: TObject);
begin
  // fIndepSamples := '';
  TestHandler.IndependentSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.ParametricDontKnow(Sender: TObject);
begin
  // fParametric := '';
  TestHandler.Parametric(dunno);
  UpdateDisplay;
end;

// procedure TForm2.updateSQL;
// var
// sl:TStringList;
// begin
// FDQuery1.SQL.Text := fSelect + fContinuous + f3Samples + fParametric +
// fIndepSamples + fCovariate;
// FDQuery1.Active := true;
//
// sl:=TStringList.Create;
// FDQuery1.First;
// while not FDQuery1.Eof do
// begin
// sl.Add(FDQuery1.FieldByName('test-name').AsString);
// FDQuery1.Next;
// end;
// showmessage(sl.Text);
// sl.Free;
//
//
// end;

end.
