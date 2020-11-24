object Form_Loading: TForm_Loading
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form_Loading'
  ClientHeight = 39
  ClientWidth = 42
  Color = 13093870
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 0
    Top = 96
    Width = 345
    Height = 27
    Color = 9864393
    ForeColor = 9864393
    ParentColor = False
    Progress = 0
    Visible = False
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 8
    Top = 8
    FrameDelay = 30
    IndicatorSize = aisSmall
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 200
    Top = 8
  end
end
