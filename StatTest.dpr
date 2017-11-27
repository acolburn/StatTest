program StatTest;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainU in 'MainU.pas' {Form2},
  DM in 'DM.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, TestHandler);
  Application.Run;
end.
