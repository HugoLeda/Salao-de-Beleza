object Form_AbrirCaixa: TForm_AbrirCaixa
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form_AbrirCaixa'
  ClientHeight = 150
  ClientWidth = 300
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
  object SpeedButton1: TSpeedButton
    Left = 216
    Top = 109
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 137
    Top = 109
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 25
    Top = 64
    Width = 49
    Height = 23
    Caption = 'Valor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 104
    Top = 15
    Width = 103
    Height = 25
    Caption = 'Abrir Caixa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edvalortotal: TEdit
    Left = 80
    Top = 64
    Width = 193
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    Text = 'edvalortotal'
    OnKeyUp = edvalortotalKeyUp
  end
  object ADOQueryAbrirCaixa: TADOQuery
    Connection = Form_Principal.ADOConnection1
    Parameters = <
      item
        Name = 'VALOR'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = 0c
      end
      item
        Name = 'VALOR2'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = 0c
      end
      item
        Name = 'USU'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end
      item
        Name = 'ULT'
        Attributes = [paSigned]
        DataType = ftInteger
        Direction = pdReturnValue
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    SQL.Strings = (
      'insert into TB_CAIXA'
      
        '(DATA_ABERTURA, HORA_ABERTURA, VALOR_ABERTURA, VALOR_CAIXA, USUA' +
        'RIO)'
      'values'
      '(GETDATE(), GETDATE(), :VALOR, :VALOR2, :USU)'
      ''
      'select :ULT = SCOPE_IDENTITY()')
    Left = 56
    Top = 96
  end
end
