object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 475
  Width = 539
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Alan\Documents\Embarcadero\Studio\Projects\Sta' +
        'tTest\Win32\Debug\Stats.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 432
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 440
    Top = 104
  end
end
