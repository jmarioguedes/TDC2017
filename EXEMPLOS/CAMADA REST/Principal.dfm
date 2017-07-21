object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Servidor REST utilizando DataSnap'
  ClientHeight = 120
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 479
    Height = 113
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 193
      Height = 25
      Caption = '&1 - CONECTAR COM O REDIS'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 71
      Width = 193
      Height = 25
      Caption = '3 - ABRIR SERVIDOR REST'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 39
      Width = 193
      Height = 25
      Caption = '&2 - CONECTAR COM O MONGO'
      TabOrder = 2
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 207
      Top = 73
      Width = 145
      Height = 21
      ItemIndex = 0
      TabOrder = 3
      Text = '8000'
      Items.Strings = (
        '8000'
        '9000')
    end
  end
end
