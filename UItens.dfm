object FrmItensPedido: TFrmItensPedido
  Left = 0
  Top = 0
  Caption = 'Itens do pedido'
  ClientHeight = 207
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object Panel_confirmacao: TPanel
    Left = 0
    Top = 166
    Width = 628
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 168
    ExplicitTop = 152
    ExplicitWidth = 185
    object Btn_Confirmar: TButton
      Left = 448
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = Btn_ConfirmarClick
    end
    object Btn_Fechar: TButton
      Left = 536
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      DisabledImageName = 'Btn_Fechar'
      TabOrder = 1
      OnClick = Btn_FecharClick
    end
  end
  object Panel_Itens: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 166
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 145
    object Label_Produto: TLabel
      Left = 19
      Top = 7
      Width = 71
      Height = 15
      Caption = 'C'#243'd. Produto'
    end
    object Label_Quantidade: TLabel
      Left = 22
      Top = 55
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object Label_VrUnitario: TLabel
      Left = 109
      Top = 55
      Width = 56
      Height = 15
      Caption = 'Vr Unit'#225'rio'
    end
    object Label_Desconto: TLabel
      Left = 196
      Top = 55
      Width = 50
      Height = 15
      Caption = 'Desconto'
    end
    object Label_Descricao: TLabel
      Left = 106
      Top = 7
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object Label_VrTotal: TLabel
      Left = 283
      Top = 55
      Width = 42
      Height = 15
      Caption = 'Vr Total '
    end
    object Label7: TLabel
      Left = 19
      Top = 111
      Width = 62
      Height = 15
      Caption = 'Observa'#231#227'o'
    end
    object Edit_Produto: TEdit
      Left = 16
      Top = 24
      Width = 81
      Height = 23
      ImeName = 'Edit_Produto'
      TabOrder = 0
      OnExit = Edit_ProdutoExit
    end
    object Edit_Quantidade: TEdit
      Left = 19
      Top = 76
      Width = 81
      Height = 23
      ImeName = 'Edit_Produto'
      TabOrder = 1
      OnExit = Edit_QuantidadeExit
    end
    object Edit_VrUnitario: TEdit
      Left = 106
      Top = 76
      Width = 81
      Height = 23
      ImeName = 'Edit_Produto'
      TabOrder = 2
      OnExit = Edit_QuantidadeExit
    end
    object Edit_Desconto: TEdit
      Left = 193
      Top = 76
      Width = 81
      Height = 23
      ImeName = 'Edit_Produto'
      TabOrder = 3
      OnExit = Edit_QuantidadeExit
    end
    object Edit_Descricao: TEdit
      Left = 103
      Top = 24
      Width = 508
      Height = 23
      ImeName = 'Edit_Produto'
      ReadOnly = True
      TabOrder = 4
    end
    object Edit_VrTotal: TEdit
      Left = 280
      Top = 76
      Width = 137
      Height = 23
      ImeName = 'Edit_Produto'
      ReadOnly = True
      TabOrder = 5
    end
    object Edit_Observacao: TEdit
      Left = 16
      Top = 128
      Width = 595
      Height = 23
      TabOrder = 6
    end
  end
end
