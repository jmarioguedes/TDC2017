object dmRegras: TdmRegras
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 507
  Width = 703
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=Mongo')
    Connected = True
    LoginPrompt = False
    Left = 80
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 136
  end
  object FDPhysMongoDriverLink1: TFDPhysMongoDriverLink
    Left = 80
    Top = 216
  end
  object DSServer1: TDSServer
    AutoStart = False
    Left = 360
    Top = 64
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 352
    Top = 224
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8000
    OnHTTPTrace = DSHTTPService1HTTPTrace
    Server = DSServer1
    Filters = <>
    Left = 352
    Top = 144
  end
end
