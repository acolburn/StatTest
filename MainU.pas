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
  private
    procedure UpdateDisplay;
  public
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
  TestHandler.ThreeSamples(no);
  UpdateDisplay;

end;

procedure TForm2.ThreeOrMoreSamples(Sender: TObject);
begin
  TestHandler.ThreeSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.ContinuousNo(Sender: TObject);
begin
  TestHandler.ContinuousData(no);
  UpdateDisplay;
end;

procedure TForm2.ContinuousYes(Sender: TObject);
begin
  TestHandler.ContinuousData(yes);
  UpdateDisplay;
end;

procedure TForm2.CovariatesNo(Sender: TObject);
begin
  TestHandler.Covariates(no);
  UpdateDisplay;
end;

procedure TForm2.CovariatesYes(Sender: TObject);
begin
  TestHandler.Covariates(yes);
  UpdateDisplay;
end;

procedure TForm2.DependentSamples(Sender: TObject);
begin
  TestHandler.IndependentSamples(no);
  UpdateDisplay;
end;

procedure TForm2.IndependentSamples(Sender: TObject);
begin
  TestHandler.IndependentSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.ParametricNo(Sender: TObject);
begin
  TestHandler.Parametric(no);
  UpdateDisplay;
end;

procedure TForm2.ParametricYes(Sender: TObject);
begin
  TestHandler.Parametric(yes);
  UpdateDisplay;
end;

procedure TForm2.StringGrid1SelectCell(Sender: TObject;
  const ACol, ARow: Integer; var CanSelect: Boolean);
var
  s: string;
begin
  if ARow > -1 then
  begin
      s:=TestHandler.GetDescription(StringGrid1.Cells[ACol,ARow]);
      WebBrowser1.LoadFromStrings(s,'');
  end;
end;

procedure TForm2.UpdateDisplay;
var
  sl: TStringList;
  i: Integer;
begin
  //clear rows
  for I := 0 to StringGrid1.RowCount-1 do
    StringGrid1.Cells[0,i]:='';

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
  StringColumn1.Width := StringGrid1.Width;
  UpdateDisplay;
end;


procedure TForm2.TwoSamplesDontKnow(Sender: TObject);
begin
  TestHandler.ThreeSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.ContinuousDontKnow(Sender: TObject);
begin
  TestHandler.ContinuousData(dunno);
  UpdateDisplay;
end;

procedure TForm2.CovariatesDontKnow(Sender: TObject);
begin
  TestHandler.Covariates(dunno);
  UpdateDisplay;
end;

procedure TForm2.IndependentDontKnow(Sender: TObject);
begin
  TestHandler.IndependentSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.ParametricDontKnow(Sender: TObject);
begin
  TestHandler.Parametric(dunno);
  UpdateDisplay;
end;

end.
