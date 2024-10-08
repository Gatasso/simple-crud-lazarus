unit unitPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    btClientes: TButton;
    btFornecedores: TButton;
    btProdutos: TButton;
    btPedidos: TButton;
    Label1: TLabel;
    Label2: TLabel;
    pnlCadastros: TPanel;
    pnlVendas: TPanel;
    procedure btClientesClick(Sender: TObject);
    procedure btFornecedoresClick(Sender: TObject);
    procedure btPedidosClick(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

uses unitClientes, unitFornecedores, unitProdutos, unitPedidos;

{ TfrmPrincipal }

// Cria e exibe o formulário de Cadastro de CLIENTES
   procedure TfrmPrincipal.btClientesClick(Sender: TObject);
   begin
     if frmClientes = nil then frmClientes:= tfrmClientes.create(nil);
     frmClientes.show;
   end;

// Cria e exibe o formulário de Cadastro de FORNECEDORES
   procedure TfrmPrincipal.btFornecedoresClick(Sender: TObject);
   begin
     if frmFornecedor = nil then frmFornecedor:= TfrmFornecedor.create(nil);
     frmFornecedor.show;
   end;

// Cria e exibe o formulário de Cadastro de PRODUTOS
   procedure TfrmPrincipal.btProdutosClick(Sender: TObject);
   begin
     if frmProdutos = nil then frmProdutos:= TfrmProdutos.create(nil);
     frmProdutos.show;
   end;

// Cria e exibe o formulário de Geração de PEDIDOS
   procedure TfrmPrincipal.btPedidosClick(Sender: TObject);
   begin
     if frmPedidos = nil then frmPedidos:= TfrmPedidos.Create(nil);
     frmPedidos.show;
   end;
end.

