object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 475
  Width = 539
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=.\Stats.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
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
