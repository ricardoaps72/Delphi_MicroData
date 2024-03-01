object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedido'
  ClientHeight = 514
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object PageControl_Pedido: TPageControl
    Left = 0
    Top = 0
    Width = 712
    Height = 473
    ActivePage = TabSheet_Manutencao
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 708
    ExplicitHeight = 472
    object TabSheet_Pesquisa: TTabSheet
      Caption = 'Pesquisa'
      object Panel_Filtros: TPanel
        Left = 0
        Top = 0
        Width = 704
        Height = 81
        Align = alTop
        TabOrder = 0
        object Label_NumPedido: TLabel
          Left = 8
          Top = 33
          Width = 104
          Height = 15
          Caption = 'N'#250'mero do Pedido:'
        end
        object Label_CodProduto: TLabel
          Left = 296
          Top = 33
          Width = 105
          Height = 15
          Caption = 'C'#243'digo do Produto:'
        end
        object Edit_NumPedido: TEdit
          Left = 118
          Top = 30
          Width = 171
          Height = 23
          TabOrder = 0
        end
        object Edit_CodProduto: TEdit
          Left = 406
          Top = 30
          Width = 171
          Height = 23
          ImeName = 'Edit_CodProduto'
          TabOrder = 1
        end
        object Btn_Filtrar: TButton
          Left = 592
          Top = 29
          Width = 87
          Height = 25
          Cursor = crHandPoint
          Caption = 'Filtrar'
          DisabledImageName = 'Button_Filtrar'
          TabOrder = 2
          OnClick = Btn_FiltrarClick
        end
      end
      object Panel_GridPedidos: TPanel
        Left = 0
        Top = 81
        Width = 704
        Height = 120
        Align = alTop
        TabOrder = 1
        object DBGrid_Pedidos: TDBGrid
          Left = 1
          Top = 1
          Width = 702
          Height = 118
          Align = alClient
          DataSource = DSPedidos
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Cliente'
              Width = 256
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VrTotalPedido'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataPedido'
              Width = 79
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataDigitacao'
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Observacao'
              Width = 89
              Visible = True
            end>
        end
      end
      object Panel_GridItens: TPanel
        Left = 0
        Top = 201
        Width = 704
        Height = 242
        Align = alClient
        TabOrder = 2
        object DBGrid_Itens: TDBGrid
          Left = 1
          Top = 1
          Width = 702
          Height = 240
          Align = alClient
          DataSource = DSItens
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Width = 31
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PedidoID'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ProdutoID'
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Width = 178
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VrUnitario'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Quantidade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DescontoItem'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VrTotalItem'
              Visible = True
            end>
        end
      end
    end
    object TabSheet_Manutencao: TTabSheet
      Caption = 'Manuten'#231#227'o'
      ImageIndex = 1
      OnShow = TabSheet_ManutencaoShow
      object Panel_Pedido: TPanel
        Left = 0
        Top = 0
        Width = 704
        Height = 241
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 700
        object Label_ID: TLabel
          Left = 12
          Top = 8
          Width = 11
          Height = 15
          Caption = 'ID'
        end
        object Label_Cliente: TLabel
          Left = 12
          Top = 56
          Width = 37
          Height = 15
          Caption = 'Cliente'
        end
        object Label_vrTotalPedido: TLabel
          Left = 12
          Top = 104
          Width = 95
          Height = 15
          Caption = 'Vr Total Pedido R$'
        end
        object Label_DataDigitacao: TLabel
          Left = 172
          Top = 8
          Width = 74
          Height = 15
          Caption = 'DataDigitacao'
        end
        object Label_DataPedido: TLabel
          Left = 278
          Top = 8
          Width = 61
          Height = 15
          Caption = 'DataPedido'
        end
        object Label_Observacao: TLabel
          Left = 12
          Top = 152
          Width = 62
          Height = 15
          Caption = 'Observacao'
        end
        object Btn_Salvar: TSpeedButton
          Left = 601
          Top = 202
          Width = 88
          Height = 32
          Cursor = crHandPoint
          DisabledImageName = 'Btn_Incluir'
          Caption = 'Salvar Pedido'
          OnClick = Btn_SalvarClick
        end
        object Btn_Novo: TSpeedButton
          Left = 12
          Top = 202
          Width = 88
          Height = 32
          Cursor = crHandPoint
          DisabledImageName = 'Btn_Novo'
          Caption = 'Novo Pedido'
          OnClick = Btn_NovoClick
        end
        object Btn_Gravar: TSpeedButton
          Left = 106
          Top = 202
          Width = 76
          Height = 32
          Cursor = crHandPoint
          DisabledImageName = 'Btn_Gravar'
          Caption = 'Gravar'
          OnClick = Btn_GravarClick
        end
        object Btn_Excluir: TSpeedButton
          Left = 259
          Top = 202
          Width = 88
          Height = 32
          Cursor = crHandPoint
          DisabledImageName = 'Btn_Excluir'
          Caption = 'Excluir'
          OnClick = Btn_ExcluirClick
        end
        object Btn_Alterar: TSpeedButton
          Left = 188
          Top = 202
          Width = 65
          Height = 32
          Cursor = crHandPoint
          DisabledImageName = 'Btn_Alterar'
          Caption = 'Alterar'
          OnClick = Btn_AlterarClick
        end
        object Edit_ID: TEdit
          Left = 12
          Top = 29
          Width = 154
          Height = 23
          ImeName = 'Edit_ID'
          ReadOnly = True
          TabOrder = 0
        end
        object Edit_DataDigitacao: TEdit
          Left = 172
          Top = 29
          Width = 93
          Height = 23
          ImeName = 'Edit_DataDigitacao'
          ReadOnly = True
          TabOrder = 1
        end
        object Edit_DataPedido: TEdit
          Left = 278
          Top = 29
          Width = 93
          Height = 23
          ImeName = 'Edit_DataPedido'
          ReadOnly = True
          TabOrder = 2
        end
        object Edit_Cliente: TEdit
          Left = 12
          Top = 75
          Width = 677
          Height = 23
          ReadOnly = True
          TabOrder = 3
          Text = 'Edit_Cliente'
        end
        object Edit_VrTotalPedido: TEdit
          Left = 12
          Top = 123
          Width = 253
          Height = 23
          ImeName = 'Edit_VrTotalPedido'
          ReadOnly = True
          TabOrder = 4
        end
        object Edit_Observacao: TEdit
          Left = 12
          Top = 173
          Width = 677
          Height = 23
          ReadOnly = True
          TabOrder = 5
        end
      end
      object Panel_Itens: TPanel
        Left = 0
        Top = 241
        Width = 704
        Height = 202
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 700
        ExplicitHeight = 201
        object DBGrid_ItensPedido: TDBGrid
          Left = 1
          Top = 1
          Width = 702
          Height = 159
          Align = alClient
          DataSource = DSItens
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object Panel_BotoesItens: TPanel
          Left = 1
          Top = 160
          Width = 702
          Height = 41
          Align = alBottom
          TabOrder = 1
          ExplicitTop = 159
          ExplicitWidth = 698
          object Btn_IncluirItens: TButton
            Left = 11
            Top = 9
            Width = 75
            Height = 25
            Caption = 'Incluir Itens'
            DisabledImageName = 'Btn_IncluirItens'
            TabOrder = 0
            OnClick = Btn_IncluirItensClick
          end
          object Btn_ExcluirItens: TButton
            Left = 95
            Top = 9
            Width = 75
            Height = 25
            Caption = 'Excluir Itens'
            DisabledImageName = 'Btn_IncluirItens'
            TabOrder = 1
            OnClick = Btn_ExcluirItensClick
          end
          object Btn_AlterarItens: TButton
            Left = 177
            Top = 9
            Width = 75
            Height = 25
            Caption = 'Alterar Itens'
            DisabledImageName = 'Btn_IncluirItens'
            TabOrder = 2
            OnClick = Btn_AlterarItensClick
          end
        end
      end
    end
  end
  object Panel_Rodape: TPanel
    Left = 0
    Top = 473
    Width = 712
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 472
    ExplicitWidth = 708
  end
  object conexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=sa;Initial Catalog=bd;Data Source=DESKTOP-KDTGTQH'
    ConnectionTimeout = 30
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 432
  end
  object QryPedidos: TADOQuery
    Active = True
    Connection = conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      #9'tbPedido.ID,'
      #9'tbPedido.Cliente,'#9
      #9'tbPedido.VrTotalPedido,'
      
        '                format(getdate(), '#39'dd.MM.yyyy'#39') as [DataDigitaca' +
        'o],'
      #9'format(getdate(), '#39'dd.MM.yyyy'#39') as [DataPedido],'
      #9'tbPedido.Observacao'#9
      ''
      'from tbPedido ')
    Left = 527
    object QryPedidosID: TIntegerField
      FieldName = 'ID'
    end
    object QryPedidosCliente: TStringField
      FieldName = 'Cliente'
      Size = 60
    end
    object QryPedidosVrTotalPedido: TBCDField
      FieldName = 'VrTotalPedido'
      currency = True
      Precision = 18
      Size = 2
    end
    object QryPedidosDataDigitacao: TWideStringField
      FieldName = 'DataDigitacao'
      KeyFields = 'DataDigitacao'
      Size = 4000
    end
    object QryPedidosDataPedido: TWideStringField
      FieldName = 'DataPedido'
      KeyFields = 'DataPedido'
      Size = 4000
    end
    object QryPedidosObservacao: TStringField
      FieldName = 'Observacao'
      Size = 200
    end
  end
  object DSPedidos: TDataSource
    DataSet = QryPedidos
    OnStateChange = DSPedidosStateChange
    OnDataChange = DSPedidosDataChange
    Left = 596
  end
  object QryItens: TADOQuery
    Active = True
    Connection = conexao
    CursorType = ctStatic
    DataSource = DSPedidos
    Parameters = <
      item
        Name = 'PedidoID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 1
      end>
    SQL.Strings = (
      'select  '
      #9'tbPedidoItem.ID,'
      #9'tbPedidoItem.PedidoID,'
      #9'tbPedidoItem.ProdutoID,'
      #9'tbProduto.Descricao,'
      #9'tbPedidoItem.VrUnitario,'
      #9'tbPedidoItem.Quantidade,'
      #9'tbPedidoItem.DescontoItem,'
      #9'tbPedidoItem.VrTotalItem,'
      '                tbPedidoItem.Observacao'
      
        'from tbPedidoItem inner join tbProduto on (tbProduto.id = tbPedi' +
        'doItem.ProdutoID) '
      
        '                                          inner join tbPedido on' +
        ' (tbPedido.id = tbPedidoItem.PedidoID) '
      'where tbPedidoItem.PedidoID = :PedidoID;')
    Left = 556
    Top = 315
    object QryItensID: TIntegerField
      DisplayWidth = 4
      FieldName = 'ID'
    end
    object QryItensPedidoID: TIntegerField
      DisplayWidth = 8
      FieldName = 'PedidoID'
    end
    object QryItensProdutoID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProdutoID'
    end
    object QryItensDescricao: TStringField
      DisplayWidth = 37
      FieldName = 'Descricao'
      Size = 100
    end
    object QryItensVrUnitario: TBCDField
      DisplayWidth = 9
      FieldName = 'VrUnitario'
      currency = True
      Precision = 18
      Size = 2
    end
    object QryItensQuantidade: TIntegerField
      DisplayWidth = 10
      FieldName = 'Quantidade'
    end
    object QryItensDescontoItem: TBCDField
      DisplayWidth = 12
      FieldName = 'DescontoItem'
      currency = True
      Precision = 18
      Size = 2
    end
    object QryItensVrTotalItem: TBCDField
      DisplayWidth = 11
      FieldName = 'VrTotalItem'
      currency = True
      Precision = 18
      Size = 2
    end
    object QryItensObservacao: TStringField
      FieldName = 'Observacao'
      Size = 200
    end
  end
  object DSItens: TDataSource
    DataSet = QryItens
    Left = 628
    Top = 315
  end
  object Qry: TADOQuery
    Connection = conexao
    Parameters = <>
    Left = 612
    Top = 138
  end
end
