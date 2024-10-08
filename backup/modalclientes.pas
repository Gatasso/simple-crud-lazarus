unit modalClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, rxmemds;

type

  { TfrmBuscaClientes }

  TfrmBuscaClientes = class(TForm)
    dsClientes: TDataSource;
    rxClientes: TRxMemoryData;
    rxClientesCodigo: TLongintField;
    rxClientesCPF: TStringField;
    DBGrid1: TDBGrid;
    rxClientesNome: TStringField;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  frmBuscaClientes: TfrmBuscaClientes;

implementation

uses unitDM,unitpedidos;

{$R *.lfm}

{ TfrmBuscaClientes }

procedure TfrmBuscaClientes.FormShow(Sender: TObject);
begin
  with DM.zqTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select codigo, nome, cpf from clientes order by codigo');
    Open;
    if rxClientes.Active = False then rxClientes.Active:= true;
    rxClientes.EmptyTable;
    while not EOF do
    begin
      rxClientes.Append;
      rxClientesCodigo.AsInteger:= Fields[0].AsInteger;
      rxClientesNome.AsString:= Fields[1].AsString;
      rxClientesCPF.AsString:= Fields[2].AsString;
      rxClientes.Post;
      Next;
    end;
  end;
end;

procedure TfrmBuscaClientes.DBGrid1DblClick(Sender: TObject);
begin
  frmPedidos.edtCodCliente.Text:= rxClientesCodigo.AsString;
  frmPedidos.edtNomeCliente.Text:= rxClientesNome.AsString;
  frmPedidos.edtCpfCliente.Text:= rxClientesCPF.AsString;
  Close;
end;

end.

