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
  System.IOUtils, DM, FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.TabControl, FMX.Gestures;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    WebBrowser1: TWebBrowser;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    ListView1: TListView;
    VertScrollBox1: TVertScrollBox;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
<<<<<<< HEAD
=======
    GestureManager1: TGestureManager;
    btnContinuousYes: TSpeedButton;
    btnContinuousNo: TSpeedButton;
    btnContinuousDontKnow: TSpeedButton;
    btnIndependent: TSpeedButton;
    btnDependent: TSpeedButton;
    btnIndependentDontKnow: TSpeedButton;
    btn2SamplesYes: TSpeedButton;
    btn2SamplesNo: TSpeedButton;
    btn2SamplesDontKnow: TSpeedButton;
    btnParametricYes: TSpeedButton;
    btnParametricNo: TSpeedButton;
    btnParametricDontKnow: TSpeedButton;
    btnCovariatesYes: TSpeedButton;
    btnCovariatesNo: TSpeedButton;
    btnCovariatesDontKnow: TSpeedButton;
>>>>>>> main
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
    procedure ListView1Change(Sender: TObject);
    procedure WebBrowser1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
<<<<<<< HEAD
=======
    procedure btnContinuousYesClick(Sender: TObject);
    procedure btnContinuousNoClick(Sender: TObject);
    procedure btnContinuousDontKnowClick(Sender: TObject);
    procedure btnIndependentClick(Sender: TObject);
    procedure btnDependentClick(Sender: TObject);
    procedure btnIndependentDontKnowClick(Sender: TObject);
    procedure btn3SamplesNoClick(Sender: TObject);
    procedure btn3SamplesYesClick(Sender: TObject);
    procedure btn3SamplesDontKnowClick(Sender: TObject);
    procedure btnParametricYesClick(Sender: TObject);
    procedure btnParametricNoClick(Sender: TObject);
    procedure btnParametricDontKnowClick(Sender: TObject);
    procedure btnCovariatesYesClick(Sender: TObject);
    procedure btnCovariatesNoClick(Sender: TObject);
    procedure btnCovariatesDontKnowClick(Sender: TObject);
>>>>>>> main
//    procedure StringGrid1SelectCell(Sender: TObject; const ACol, ARow: Integer;
//      var CanSelect: Boolean);
//    procedure ListBox1Change(Sender: TObject);
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
{$R *.Windows.fmx MSWINDOWS}

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

procedure TForm2.ListView1Change(Sender: TObject);
var
  s:string;
begin
   if ListView1.ItemIndex>-1 then
   begin
     s:='<head> '+
     '<meta name="viewport" id="viewport" content="width=device-width, user-scalable=no, minimum-scale=1, maximum-scale=1" /> '+
     '</head>';
     s:=s+'<body>'+TestHandler.GetDescription(ListView1.Items[ListView1.ItemIndex].Text)+'</body>';
     WebBrowser1.LoadFromStrings(s,'');
     TabControl1.ActiveTab:=TabItem2;
   end;

end;

//procedure TForm2.ListBox1Change(Sender: TObject);
//var
//  s:string;
//begin
//if ListBox1.ItemIndex>-1 then
//  begin
//      s:=TestHandler.GetDescription(ListBox1.Items[ListBox1.ItemIndex]);
//      WebBrowser1.LoadFromStrings(s,'');
//  end;
//end;

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

//procedure TForm2.StringGrid1SelectCell(Sender: TObject;
//  const ACol, ARow: Integer; var CanSelect: Boolean);
//var
//  s: string;
//begin
//  if ARow > -1 then
//  begin
//      s:=TestHandler.GetDescription(StringGrid1.Cells[ACol,ARow]);
//      WebBrowser1.LoadFromStrings(s,'');
//  end;
//end;

procedure TForm2.UpdateDisplay;
var
  sl: TStringList;
  i: Integer;
  item:TListViewItem;
begin
  //clear rows
//  for I := 0 to StringGrid1.RowCount-1 do
//    StringGrid1.Cells[0,i]:='';
  ListView1.Items.Clear;

  sl := TStringList.Create;
  try
    sl.Text := TestHandler.updateSQL;
    for i := 0 to sl.Count - 1 do
    begin
      item:=ListView1.Items.Add;
      item.text := sl[i];
    end;
  finally
    sl.Free;
  end;


end;

procedure TForm2.WebBrowser1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  TabControl1.ActiveTab:=TabItem1;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//  StringColumn1.Width := StringGrid1.Width;
  TabControl1.ActiveTab:=TabItem1;
  UpdateDisplay;
end;


procedure TForm2.TwoSamplesDontKnow(Sender: TObject);
begin
  TestHandler.ThreeSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.btn3SamplesDontKnowClick(Sender: TObject);
begin
TestHandler.ThreeSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.btn3SamplesYesClick(Sender: TObject);
begin
TestHandler.ThreeSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.btn3SamplesNoClick(Sender: TObject);
begin
  TestHandler.ThreeSamples(no);
  UpdateDisplay;
end;

procedure TForm2.btnContinuousDontKnowClick(Sender: TObject);
begin
TestHandler.ContinuousData(dunno);
  UpdateDisplay;
end;

procedure TForm2.btnContinuousNoClick(Sender: TObject);
begin
TestHandler.ContinuousData(no);
  UpdateDisplay;
end;

procedure TForm2.btnContinuousYesClick(Sender: TObject);
begin
  TestHandler.ContinuousData(yes);
  UpdateDisplay;
end;

procedure TForm2.btnCovariatesDontKnowClick(Sender: TObject);
begin
TestHandler.Covariates(dunno);
  UpdateDisplay;
end;

procedure TForm2.btnCovariatesNoClick(Sender: TObject);
begin
TestHandler.Covariates(no);
  UpdateDisplay;
end;

procedure TForm2.btnCovariatesYesClick(Sender: TObject);
begin
  TestHandler.Covariates(yes);
  UpdateDisplay;
end;

procedure TForm2.btnDependentClick(Sender: TObject);
begin
TestHandler.IndependentSamples(no);
  UpdateDisplay;
end;

procedure TForm2.btnIndependentClick(Sender: TObject);
begin
  TestHandler.IndependentSamples(yes);
  UpdateDisplay;
end;

procedure TForm2.btnIndependentDontKnowClick(Sender: TObject);
begin
TestHandler.IndependentSamples(dunno);
  UpdateDisplay;
end;

procedure TForm2.btnParametricDontKnowClick(Sender: TObject);
begin
TestHandler.Parametric(dunno);
  UpdateDisplay;
end;

procedure TForm2.btnParametricNoClick(Sender: TObject);
begin
TestHandler.Parametric(no);
  UpdateDisplay;
end;

procedure TForm2.btnParametricYesClick(Sender: TObject);
begin
   TestHandler.Parametric(yes);
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
