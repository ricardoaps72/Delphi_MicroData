program PedidoMD;

uses
  Vcl.Forms,
  UPedido in 'UPedido.pas' {FrmPedido},
  UItens in 'UItens.pas' {FrmItensPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(TFrmItensPedido, FrmItensPedido);
  Application.Run;
end.
