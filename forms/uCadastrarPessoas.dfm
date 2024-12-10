object frmCadastroPessoas: TfrmCadastroPessoas
  Left = 0
  Top = 0
  Caption = 'Cadastrar Pessoas'
  ClientHeight = 783
  ClientWidth = 1037
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 1037
    Height = 73
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = -6
    ExplicitWidth = 975
    object btnEditar: TButton
      Left = 76
      Top = 1
      Width = 75
      Height = 71
      Align = alLeft
      Caption = 'Editar'
      TabOrder = 0
    end
    object btnExcluir: TButton
      Left = 151
      Top = 1
      Width = 75
      Height = 71
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 1
    end
    object btnSalvar: TButton
      Left = 1
      Top = 1
      Width = 75
      Height = 71
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 2
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 73
    Width = 1037
    Height = 669
    Align = alClient
    Caption = 'Cadastrar Pessoas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 975
    ExplicitHeight = 513
    object lblNome: TLabel
      Left = 8
      Top = 17
      Width = 30
      Height = 13
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblSobrenome: TLabel
      Left = 144
      Top = 17
      Width = 59
      Height = 13
      Caption = 'Sobrenome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtSobrenome: TEdit
      Left = 144
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 394
      Width = 1035
      Height = 274
      Align = alBottom
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 742
    Width = 1037
    Height = 41
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 586
    ExplicitWidth = 975
    object pnlRegistro: TPanel
      Left = 1
      Top = 1
      Width = 96
      Height = 39
      Align = alLeft
      TabOrder = 0
      object lblQuantidade: TLabel
        Left = 1
        Top = 23
        Width = 94
        Height = 15
        Align = alBottom
        Alignment = taCenter
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 6
      end
      object lblRegistro: TLabel
        Left = 1
        Top = 1
        Width = 94
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = 'Registros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 48
      end
    end
  end
end
