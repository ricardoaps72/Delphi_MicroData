unit UPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons;

type
  TFrmPedido = class(TForm)
    PageControl_Pedido: TPageControl;
    Panel_Rodape: TPanel;
    TabSheet_Pesquisa: TTabSheet;
    TabSheet_Manutencao: TTabSheet;
    Panel_Filtros: TPanel;
    Edit_NumPedido: TEdit;
    Label_NumPedido: TLabel;
    Label_CodProduto: TLabel;
    Edit_CodProduto: TEdit;
    Btn_Filtrar: TButton;
    Panel_GridPedidos: TPanel;
    Panel_GridItens: TPanel;
    DBGrid_Pedidos: TDBGrid;
    DBGrid_Itens: TDBGrid;
    conexao: TADOConnection;
    QryPedidos: TADOQuery;
    DSPedidos: TDataSource;
    QryItens: TADOQuery;
    DSItens: TDataSource;
    Panel_Pedido: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label_vrTotalPedido: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel_Itens: TPanel;
    DBGrid_ItensPedido: TDBGrid;
    QryPedidosID: TIntegerField;
    QryPedidosCliente: TStringField;
    QryPedidosVrTotalPedido: TBCDField;
    QryPedidosDataDigitacao: TWideStringField;
    QryPedidosDataPedido: TWideStringField;
    QryPedidosObservacao: TStringField;
    Btn_Salvar: TSpeedButton;
    Edit_ID: TEdit;
    Edit_DataDigitacao: TEdit;
    Edit_DataPedido: TEdit;
    Edit_Cliente: TEdit;
    Edit_VrTotalPedido: TEdit;
    Edit_Observacao: TEdit;
    Btn_Novo: TSpeedButton;
    Qry: TADOQuery;
    Btn_Gravar: TSpeedButton;
    Btn_Excluir: TSpeedButton;
    Btn_Alterar: TSpeedButton;
    Panel_BotoesItens: TPanel;
    Btn_IncluirItens: TButton;
    Btn_ExcluirItens: TButton;
    Btn_AlterarItens: TButton;
    QryItensID: TIntegerField;
    QryItensPedidoID: TIntegerField;
    QryItensProdutoID: TIntegerField;
    QryItensDescricao: TStringField;
    QryItensVrUnitario: TBCDField;
    QryItensQuantidade: TIntegerField;
    QryItensDescontoItem: TBCDField;
    QryItensVrTotalItem: TBCDField;
    QryItensObservacao: TStringField;
    procedure DSPedidosDataChange(Sender: TObject; Field: TField);
    procedure Btn_FiltrarClick(Sender: TObject);
    procedure DSPedidosStateChange(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure TabSheet_ManutencaoShow(Sender: TObject);
    procedure Btn_NovoClick(Sender: TObject);
    procedure Btn_GravarClick(Sender: TObject);
    procedure Btn_ExcluirClick(Sender: TObject);
    procedure Btn_AlterarClick(Sender: TObject);
    procedure Btn_IncluirItensClick(Sender: TObject);
    procedure Btn_ExcluirItensClick(Sender: TObject);
    procedure Btn_AlterarItensClick(Sender: TObject);

  private
    { Private declarations }
    procedure LimparEdits(Form: TForm);

  public
    { Public declarations }
    Pub_lIncluindo, Pub_lIncluindoPedido : Boolean;

  end;

var
  FrmPedido: TFrmPedido;

implementation

{$R *.dfm}

uses UItens;

procedure TFrmPedido.Btn_GravarClick(Sender: TObject);
begin
  try
    QryPedidos.Close;
    QryPedidos.SQL.Clear;
    QryPedidos.SQL.Add('update tbPedido set tbPedido.Cliente = :Cliente, ');
    QryPedidos.SQL.Add('       tbPedido.VrTotalPedido = :VrTotalPedido,  ');
    QryPedidos.SQL.Add('       tbPedido.Observacao = :Observacao         ');
    QryPedidos.SQL.Add('       where tbPedido.ID = :ID                   ');
    QryPedidos.Parameters.ParamByName('ID').Value := strToInt(Edit_ID.Text);
    QryPedidos.Parameters.ParamByName('Cliente').Value := Edit_Cliente.Text;
    QryPedidos.Parameters.ParamByName('VrTotalPedido').Value := StrToFloat(Edit_VrTotalPedido.Text);
    QryPedidos.Parameters.ParamByName('Observacao').Value :=Edit_Observacao.Text;
    QryPedidos.ExecSQL;
    MessageDlg('Pedido alterado ', mtInformation, [mbOk], 0);
  except
    MessageDlg('Falha ao alterar pedido ', mtError, [mbOk], 0);
  end;

end;

procedure TFrmPedido.Btn_IncluirItensClick(Sender: TObject);
begin
  if Pub_lIncluindoPedido then
    Btn_Salvar.Click;
  Btn_Alterar.Click;
  FrmPedido.QryItens.active := false;
  Pub_lIncluindo := true;
  FrmItensPedido.ShowModal;
  FrmPedido.QryItens.active := true;
  Pub_lIncluindoPedido := false;
end;

procedure TFrmPedido.Btn_AlterarClick(Sender: TObject);
begin

  if not QryPedidos.Active then
    QryPedidos.Active := true;

  QryPedidos.Edit;
  Edit_Cliente.ReadOnly := false;
  Edit_VrTotalPedido.ReadOnly := false;
  Edit_Observacao.ReadOnly := false;
  Edit_Cliente.SetFocus;

end;

procedure TFrmPedido.Btn_AlterarItensClick(Sender: TObject);
begin
  Btn_Alterar.Click;
  Pub_lIncluindo := false;
  FrmItensPedido.ShowModal;
  FrmPedido.QryItens.active := false;
  FrmPedido.QryItens.active := true;
end;

procedure TFrmPedido.Btn_ExcluirClick(Sender: TObject);
begin
begin
  try
    if MessageDlg('Deseja realmente excluir o registro?', mtconfirmation,[mbyes,mbno],0)= mryes then
    begin

      QryItens.Active := false;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('delete from tbPedidoItem where tbPedidoItem.PedidoID = :ID');
      Qry.Parameters.ParamByName('ID').Value := StrToInt(Edit_ID.Text);
      Qry.ExecSQL;
      QryItens.Active := true;

      QryPedidos.Close;
      QryPedidos.SQL.Clear;
      QryPedidos.SQL.Add('delete from tbPedido where tbPedido.ID = :ID');
      QryPedidos.Parameters.ParamByName('ID').Value := StrToInt(Edit_ID.Text);
      QryPedidos.ExecSQL;
      MessageDlg('Pedido excluido ', mtInformation, [mbOk], 0);
    end;
  except
    MessageDlg('Falha ao excluir pedido ', mtError, [mbOk], 0);
  end;

  LimparEdits(Self);

end;

end;

procedure TFrmPedido.Btn_ExcluirItensClick(Sender: TObject);
var
  Item : integer;
begin
  Item := QryItens.FieldByName('ID').Value;
  try
    if MessageDlg('Deseja realmente excluir o Item ?', mtconfirmation,[mbyes,mbno],0)= mryes then
    begin
      QryItens.Active := false;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('delete from tbPedidoItem where tbPedidoItem.ID = :ID');
      Qry.Parameters.ParamByName('ID').Value := Item;
      Qry.ExecSQL;
      MessageDlg('Item excluido ', mtInformation, [mbOk], 0);
      QryItens.Active := true;

      FrmItensPedido.calculaTotalPedido;

    end;
  except
    MessageDlg('Falha ao excluir Item ', mtError, [mbOk], 0);
  end;

end;

procedure TFrmPedido.Btn_FiltrarClick(Sender: TObject);
  var
    Param : TParameter;
begin

  if (Edit_NumPedido.Text <> '') then
  begin
    with QryPedidos do
    begin

      close;
      sql.clear;
      sql.Add(' select ');
      sql.Add('   tbPedido.ID, ');
      sql.Add('   tbPedido.Cliente, ');
      sql.Add('   tbPedido.VrTotalPedido, ');
      sql.Add('   format(getdate(), ''dd.MM.yyyy'') as [DataDigitacao], ');
      sql.Add('   format(getdate(), ''dd.MM.yyyy'') as [DataPedido], ');
      sql.Add('   tbPedido.Observacao ');
      sql.Add(' from tbPedido where tbPedido.ID = :PedidoID ');

      Param := QryPedidos.Parameters.ParamByName('PedidoID');
      Param.DataType := ftInteger;
      Param.Value := strtoInt(Edit_NumPedido.Text);
      open;
    end;
  end
  else
  begin

    with QryPedidos do
    begin
      close;
      sql.clear;
      sql.Add(' select ');
      sql.Add('   tbPedido.ID, ');
      sql.Add('   tbPedido.Cliente, ');
      sql.Add('   tbPedido.VrTotalPedido, ');
      sql.Add('   format(getdate(), ''dd.MM.yyyy'') as [DataDigitacao], ');
      sql.Add('   format(getdate(), ''dd.MM.yyyy'') as [DataPedido], ');
      sql.Add('   tbPedido.Observacao ');
      sql.Add(' from tbPedido ');
      open;
    end;

    MessageDlg('Informe o número do pedido', mtInformation, [mbOk], 0);
    abort;

  end;

  if (Edit_CodProduto.Text <> '') then
  begin

    with QryItens do
    begin
      close;
      sql.clear;
      sql.Add('  select ');
      sql.Add('  tbPedidoItem.ID, ');
      sql.Add('  tbPedidoItem.PedidoID, ');
      sql.Add('  tbPedidoItem.ProdutoID, ');
      sql.Add('  tbProduto.Descricao, ');
      sql.Add('  tbPedidoItem.VrUnitario, ');
      sql.Add('  tbPedidoItem.Quantidade, ');
      sql.Add('  tbPedidoItem.DescontoItem, ');
      sql.Add('  tbPedidoItem.VrTotalItem, ');
      sql.Add('  tbPedidoItem.Observacao ');
      sql.Add(' from tbPedidoItem ');
      sql.Add(' inner join tbPedido on (tbPedido.id = tbPedidoItem.PedidoID) ');
      sql.Add(' inner join tbProduto on (tbProduto.id = tbPedidoItem.ProdutoID) ');
      sql.Add(' where tbPedidoItem.PedidoID = :PedidoID and tbPedidoItem.ProdutoID = :ProdutoID ');

      Param := QryItens.Parameters.ParamByName('PedidoID');
      Param.DataType := ftInteger;
      Param.Value := strtoInt(Edit_NumPedido.Text);

      Param := QryItens.Parameters.ParamByName('ProdutoID');
      Param.DataType := ftInteger;
      Param.Value := strtoInt(Edit_CodProduto.Text);

      open;
    end;

  end;

end;

procedure TFrmPedido.DSPedidosDataChange(Sender: TObject; Field: TField);
  var
    Param : TParameter;
begin
 with QryItens do
  begin
    close;

    sql.clear;
    sql.Add('  select ');
    sql.Add('  tbPedidoItem.ID, ');
    sql.Add('  tbPedidoItem.PedidoID, ');
    sql.Add('  tbPedidoItem.ProdutoID, ');
    sql.Add('  tbProduto.Descricao, ');
    sql.Add('  tbPedidoItem.VrUnitario, ');
    sql.Add('  tbPedidoItem.Quantidade, ');
    sql.Add('  tbPedidoItem.DescontoItem, ');
    sql.Add('  tbPedidoItem.VrTotalItem, ');
    sql.Add('  tbPedidoItem.Observacao ');
    sql.Add(' from tbPedidoItem ');
    sql.Add(' inner join tbPedido on (tbPedido.id = tbPedidoItem.PedidoID) ');
    sql.Add(' inner join tbProduto on (tbProduto.id = tbPedidoItem.ProdutoID) ');
    sql.Add(' where tbPedidoItem.PedidoID = :PedidoID ');

    Param := QryItens.Parameters.ParamByName('PedidoID');
    Param.DataType := ftInteger;
    Param.Value := QryPedidos.FieldByName('ID').AsInteger;
    open;
  end;

  Btn_Gravar.Enabled  := (DSPedidos.State in [dsEdit]);
  Btn_Alterar.Enabled := (DSPedidos.State in [dsBrowse]);
  Btn_Excluir.Enabled := (DSPedidos.State in [dsBrowse]);
  Btn_Novo.Enabled := (DSPedidos.State in [dsBrowse]);
  Btn_Salvar.Enabled := (DSPedidos.State in [dsInsert]);

end;

procedure TFrmPedido.DSPedidosStateChange(Sender: TObject);
var
  newId : string;

begin
  if DSPedidos.State in [dsEdit, dsInsert] then
  begin

    Edit_DataDigitacao.Text := DateToStr(Date);
    Edit_DataPedido.Text    := DateToStr(Date);

  end;

end;

procedure TFrmPedido.Btn_NovoClick(Sender: TObject);
var
  newId : string;
begin

  Pub_lIncluindoPedido := true;

  if not QryPedidos.Active then
    QryPedidos.Active := true;

  LimparEdits(Self); // Limpa todos os edits do próprio formulário

  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Add('select max(ID) + 1 as newID from tbPedido');
  Qry.open;

  newId := Qry.Fields[0].AsString;

  QryPedidos.Append;

  Edit_Cliente.ReadOnly := false;
  Edit_VrTotalPedido.ReadOnly := false;
  Edit_Observacao.ReadOnly := false;

  Edit_ID.Text := newId;
  Edit_Cliente.SetFocus;

end;

procedure TFrmPedido.Btn_SalvarClick(Sender: TObject);
begin
  try

    if Edit_VrTotalPedido.Text = '' then
      Edit_VrTotalPedido.Text := '0,001';

    if Edit_Observacao.Text = '' then
      Edit_Observacao.Text := '.';

    QryPedidos.Close;
    QryPedidos.SQL.Clear;
    QryPedidos.SQL.Add('insert into tbPedido values(:ID, :Cliente, :VrTotalPedido, :DataDigitacao, :DataPedido, :Observacao)');
    QryPedidos.Parameters.ParamByName('ID').Value := StrToInt(Edit_ID.Text);
    QryPedidos.Parameters.ParamByName('Cliente').Value :=Edit_Cliente.Text;
    QryPedidos.Parameters.ParamByName('VrTotalPedido').Value := StrToFloat(Edit_VrTotalPedido.Text);
    QryPedidos.Parameters.ParamByName('DataDigitacao').Value := Date;
    QryPedidos.Parameters.ParamByName('DataPedido').Value := Date;
    QryPedidos.Parameters.ParamByName('Observacao').Value := Edit_Observacao.Text;
    QryPedidos.ExecSQL;
    MessageDlg('Pedido incluido ', mtInformation, [mbOk], 0);
  except
    MessageDlg('Falha ao incluir pedido ', mtError, [mbOk], 0);
  end;

  //LimparEdits(Self);

  Edit_NumPedido.Text := Edit_ID.Text;
  Btn_Filtrar.Click;

end;

procedure TFrmPedido.TabSheet_ManutencaoShow(Sender: TObject);
begin

  Edit_ID.Text            := QryPedidosID.AsString;
  Edit_DataDigitacao.Text := QryPedidosDataDigitacao.AsString;
  Edit_DataPedido.Text    := QryPedidosDataPedido.AsString;
  Edit_Cliente.Text       := QryPedidosCliente.AsString;
  Edit_VrTotalPedido.Text := FormatFloat('##0.00', QryPedidosVrTotalPedido.AsFloat);
  Edit_Observacao.Text    := QryPedidosObservacao.AsString;

end;

procedure TFrmPedido.LimparEdits(Form: TForm);
var
  i: Integer;
begin
  // Percorre todos os componentes do formulário
  for i := 0 to Form.ComponentCount - 1 do
  begin
    // Verifica se o componente é um TEdit
    if Form.Components[i] is TEdit then
    begin
      // Limpa o texto do TEdit
      TEdit(Form.Components[i]).Text := '';
    end;
  end;
end;



end.
