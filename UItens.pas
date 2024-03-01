unit UItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmItensPedido = class(TForm)
    Panel_confirmacao: TPanel;
    Btn_Confirmar: TButton;
    Btn_Fechar: TButton;
    Panel_Itens: TPanel;
    Label_Produto: TLabel;
    Label_Quantidade: TLabel;
    Edit_Produto: TEdit;
    Edit_Quantidade: TEdit;
    Edit_VrUnitario: TEdit;
    Label_VrUnitario: TLabel;
    Edit_Desconto: TEdit;
    Label_Desconto: TLabel;
    Edit_Descricao: TEdit;
    Label_Descricao: TLabel;
    Edit_VrTotal: TEdit;
    Label_VrTotal: TLabel;
    Label7: TLabel;
    Edit_Observacao: TEdit;
    procedure Btn_FecharClick(Sender: TObject);
    procedure Edit_ProdutoExit(Sender: TObject);
    procedure Edit_QuantidadeExit(Sender: TObject);
    procedure Btn_ConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure calculaTotal;
    procedure LimparEdits(Form: TForm);
    function retornaNewId(): integer;
    function produtoExiste(ProdutoID: integer): boolean;

  public
    { Public declarations }
    procedure calculaTotalPedido;

  end;

var
  FrmItensPedido: TFrmItensPedido;

implementation

{$R *.dfm}

uses UPedido;

procedure TFrmItensPedido.Btn_ConfirmarClick(Sender: TObject);
var
  ID, Pedido : integer;
  msg, msgErro : string;

begin

  if FrmPedido.Pub_lIncluindo then
  begin

    ID := retornaNewId();
    Pedido := strtoint(FrmPedido.Edit_ID.Text);

  end
  else
  begin

    ID := FrmPedido.QryItensID.AsInteger;
    Pedido := strtoint(FrmPedido.Edit_ID.Text);

  end;

  try

    FrmPedido.Qry.Close;
    FrmPedido.Qry.SQL.Clear;

    if FrmPedido.Pub_lIncluindo then
    begin
      FrmPedido.Qry.SQL.Add(' insert into tbPedidoItem ');
      FrmPedido.Qry.SQL.Add(' ( tbPedidoItem.ID , tbPedidoItem.PedidoID, tbPedidoItem.ProdutoID, tbPedidoItem.Quantidade ');
      FrmPedido.Qry.SQL.Add(', tbPedidoItem.VrUnitario, tbPedidoItem.DescontoItem, tbPedidoItem.VrTotalItem, tbPedidoItem.Observacao) ');
      FrmPedido.Qry.SQL.Add(' values( :ID, :PedidoID, :ProdutoID,');
      FrmPedido.Qry.SQL.Add(':Quantidade, :VrUnitario, :DescontoItem, :VrTotalItem, :Observacao)');

      FrmPedido.Qry.Parameters.ParamByName('ID').Value           := ID;
      FrmPedido.Qry.Parameters.ParamByName('PedidoID').Value     := Pedido;
      FrmPedido.Qry.Parameters.ParamByName('ProdutoID').Value    := strtoint(Edit_Produto.Text);
      FrmPedido.Qry.Parameters.ParamByName('Quantidade').Value   := strtofloat(Edit_Quantidade.Text);
      FrmPedido.Qry.Parameters.ParamByName('VrUnitario').Value   := strtofloat(Edit_VrUnitario.Text);
      FrmPedido.Qry.Parameters.ParamByName('DescontoItem').Value := strtofloat(Edit_Desconto.Text);
      FrmPedido.Qry.Parameters.ParamByName('VrTotalItem').Value  := strtofloat(Edit_VrTotal.Text);
      FrmPedido.Qry.Parameters.ParamByName('Observacao').Value   := Edit_Observacao.Text;
      msg := ' Item incluido ';
      msgErro := ' Falha ao incluir Item ';
    end
    else
    begin
      FrmPedido.Qry.SQL.Add(' update tbPedidoItem ');
      FrmPedido.Qry.SQL.Add(' set tbPedidoItem.ProdutoID = :ProdutoID, tbPedidoItem.Quantidade = :Quantidade ');
      FrmPedido.Qry.SQL.Add(', tbPedidoItem.VrUnitario = :VrUnitario, tbPedidoItem.DescontoItem = :DescontoItem ');
      FrmPedido.Qry.SQL.Add(', tbPedidoItem.VrTotalItem = :VrTotalItem, tbPedidoItem.Observacao = :Observacao  ');
      FrmPedido.Qry.SQL.Add(' where tbPedidoItem.ID = :ID ');

      FrmPedido.Qry.Parameters.ParamByName('ID').Value           := ID;
      FrmPedido.Qry.Parameters.ParamByName('ProdutoID').Value    := strtoint(Edit_Produto.Text);
      FrmPedido.Qry.Parameters.ParamByName('Quantidade').Value   := strtofloat(Edit_Quantidade.Text);
      FrmPedido.Qry.Parameters.ParamByName('VrUnitario').Value   := strtofloat(Edit_VrUnitario.Text);
      FrmPedido.Qry.Parameters.ParamByName('DescontoItem').Value := strtofloat(Edit_Desconto.Text);
      FrmPedido.Qry.Parameters.ParamByName('VrTotalItem').Value  := strtofloat(Edit_VrTotal.Text);
      FrmPedido.Qry.Parameters.ParamByName('Observacao').Value   := Edit_Observacao.Text;

      msg := ' Item alterado ';
      msgErro := ' Falha ao alterar Item ';

    end;
    FrmPedido.Qry.ExecSQL;
    MessageDlg(msg , mtInformation, [mbOk], 0);

  except
    MessageDlg(msgErro, mtError, [mbOk], 0);
  end;

  calculaTotalPedido;

  close;

end;

procedure TFrmItensPedido.Btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmItensPedido.Edit_ProdutoExit(Sender: TObject);
begin
  if Edit_Produto.Text <> '' then
  begin
    if FrmPedido.Pub_lIncluindo then
    begin
      if not produtoExiste(strtoint(Edit_Produto.Text)) then
      begin
        with FrmPedido.Qry do
        begin
          close;
          sql.Clear;
          sql.Add('select ID, Descricao from tbProduto where ID = :ID');
          Parameters.ParamByName('ID').Value :=  strToInt(Edit_Produto.Text);
          open;
          Edit_Descricao.Text := FieldByName('Descricao').AsString;
        end;

        if Edit_Descricao.Text = '' then
          MessageDlg(' Produto não encontrado ', mtError, [mbOk], 0);
      end
      else
      begin
        MessageDlg(' Produto já foi inserido ', mtError, [mbOk], 0);
        abort;
      end;
    end
    else
    begin
      with FrmPedido.Qry do
      begin
        close;
        sql.Clear;
        sql.Add('select ID, Descricao from tbProduto where ID = :ID');
        Parameters.ParamByName('ID').Value :=  strToInt(Edit_Produto.Text);
        open;
        Edit_Descricao.Text := FieldByName('Descricao').AsString;
      end;

      if Edit_Descricao.Text = '' then
        MessageDlg(' Produto não encontrado ', mtError, [mbOk], 0);
    end;
  end;
end;


procedure TFrmItensPedido.Edit_QuantidadeExit(Sender: TObject);
begin
  calculaTotal;
end;

procedure TFrmItensPedido.FormActivate(Sender: TObject);
begin
  if FrmPedido.Pub_lIncluindo then
    LimparEdits(Self) // Limpa todos os edits do próprio formulário
  else
  begin
    Edit_Produto.Text    := FrmPedido.QryItensProdutoID.AsString;
    Edit_Descricao.Text  := FrmPedido.QryItensDescricao.AsString;
    Edit_Quantidade.Text := FrmPedido.QryItensQuantidade.AsString;
    Edit_VrUnitario.Text := FormatFloat('##0.00', FrmPedido.QryItensVrUnitario.AsFloat);
    Edit_VrTotal.Text    := FormatFloat('##0.00', FrmPedido.QryItensVrTotalItem.AsFloat);
    Edit_Desconto.Text   := FormatFloat('##0.00', FrmPedido.QryItensDescontoItem.AsFloat);
    Edit_Observacao.Text := FrmPedido.QryItensObservacao.AsString;
  end;
end;

procedure TFrmItensPedido.calculaTotal;
var
  quantidade : double;
  vrunitario : double;
  desconto : double;
  vrtotal : double;

begin

  quantidade := 0;
  vrunitario := 0;
  desconto   := 0;
  vrtotal    := 0;

  quantidade := StrToFloatDef(Edit_Quantidade.Text, 0);
  vrunitario := StrToFloatDef(Edit_VrUnitario.Text, 0);
  desconto   := StrToFloatDef(Edit_Desconto.Text, 0);

  vrtotal := (quantidade * vrunitario) - desconto;

  Edit_VrTotal.Text     := FormatFloat('##0.00', vrtotal);
  Edit_VrUnitario.Text  := FormatFloat('##0.00', vrunitario);
  Edit_Desconto.Text    := FormatFloat('##0.00', desconto);

  calculaTotalPedido;

end;

function TFrmItensPedido.retornaNewId(): integer;
var
  newId : integer;
begin
    with FrmPedido.Qry do
    begin

      Close;
      SQL.Clear;
      SQL.Add('select max(ID) + 1 as newID from tbPedidoItem');
      open;

      newId := Fields[0].AsInteger;
    end;

    result := newId;

end;

procedure TFrmItensPedido.LimparEdits(Form: TForm);
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

procedure TFrmItensPedido.calculaTotalPedido;
var
  vrTotalpedido : double;
begin
  with FrmPedido.Qry do
  begin
      Close;
      SQL.Clear;
      SQL.Add('select sum(VrTotalItem) from tbPedidoItem where tbPedidoItem.PedidoID = :PedidoID');
      Parameters.ParamByName('PedidoID').Value :=  strToInt(FrmPedido.Edit_ID.Text);
      open;
      vrTotalpedido := Fields[0].AsFloat;
  end;

  FrmPedido.Edit_VrTotalPedido.Text := FormatFloat('##0.00', vrTotalpedido);

end;

function TFrmItensPedido.produtoExiste(ProdutoID : integer) : boolean;
var
  PedidoID : integer;
begin
  PedidoID := strtoint(FrmPedido.Edit_ID.Text);
  with FrmPedido.Qry do
  begin
    close;
    sql.Clear;
    sql.Add('select tbPedidoItem.ProdutoID from tbPedidoItem where ');
    sql.Add(' tbPedidoItem.PedidoID = :PedidoID and tbPedidoItem.ProdutoID = :ProdutoID ');
    Parameters.ParamByName('ProdutoID').value := ProdutoID;
    Parameters.ParamByName('PedidoID').value := PedidoID;
    open;
    if Fields[0].AsString <> '' then
      result := true
    else
      result := false;
  end;
end;

end.
