unit unitprodutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfrmProdutos }

  TfrmProdutos = class(TForm)
    btAlterarProd: TButton;
    btCancelarProd: TButton;
    btConsultarProd: TButton;
    btExcluirProd: TButton;
    btIncluirProd: TButton;
    btSalvarProd: TButton;
    edtDescricaoProd: TEdit;
    edtCodProd: TEdit;
    edtCodBarrasProd: TEdit;
    edtQtdEstoqueProd: TEdit;
    edtNomeProd: TEdit;
    edtValorUntProd: TEdit;
    lblDescricaoProd: TLabel;
    lblCodBarrasProd: TLabel;
    lblQtdEstoqueProd: TLabel;
    lblNomeProd: TLabel;
    lblValorUntProd: TLabel;
    pnlHeader: TPanel;
    pnlCodProd: TPanel;
    pnlOp: TPanel;
    pnlBody: TPanel;
    pnlProd1: TPanel;
    pnlProd2: TPanel;
    procedure btAlterarProdClick(Sender: TObject);
    procedure btCancelarProdClick(Sender: TObject);
    procedure btConsultarProdClick(Sender: TObject);
    procedure btExcluirProdClick(Sender: TObject);
    procedure btIncluirProdClick(Sender: TObject);
    procedure btSalvarProdClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmProdutos: TfrmProdutos;
  opc: integer;

implementation

uses unitDM;

{$R *.lfm}

{ TfrmProdutos }

procedure TfrmProdutos.FormClose(Sender: TObject;
                                 var CloseAction: TCloseAction);
  begin
    frmProdutos:= nil;
  end;

//  Opção Incluir
procedure TfrmProdutos.btIncluirProdClick(Sender: TObject);
begin
  // Limpando Campos
    edtCodProd.Clear;
    edtNomeProd.Clear;
    edtDescricaoProd.Clear;
    edtCodBarrasProd.Clear;
    edtValorUntProd.Clear;
    edtQtdEstoqueProd.Clear;
  // Restrição de Botões
    btIncluirProd.Enabled:= false;
    btAlterarProd.Enabled:= false;
    btConsultarProd.Enabled:= false;
    btSalvarProd.Enabled:= true;
    btCancelarProd.Enabled:= true;
    btExcluirProd.Enabled:= false;
  // Restrição de Campos
    edtCodProd.Enabled:= false;
    edtNomeProd.Enabled:= true;
    edtCodBarrasProd.Enabled:= true;
    edtValorUntProd.Enabled:= true;
    edtDescricaoProd.Enabled:= true;
    edtQtdEstoqueProd.Enabled:= true;
    opc:= 1;
end;

// Salvar Novo, ou Alterações de Produto
procedure TfrmProdutos.btSalvarProdClick(Sender: TObject);
begin
  if opc = 1 then
  begin
    with DM.zqProdutos do
    begin
      Close;
      SQL.Clear;
      SQL.Add('insert into produtos(nome, descricao, codigo_barras, valor_unit, estoque)');
      SQL.Add('values(:nome, :descricao, :codigo_barras, :valor_unit, :estoque)');
      ParamByName('nome').AsString:= edtNomeProd.Text;
      ParamByName('descricao').AsString:= edtDescricaoProd.Text;
      ParamByName('codigo_barras').AsString:= edtCodBarrasProd.Text;
      ParamByName('valor_unit').AsDouble:= StrToFloat(edtValorUntProd.Text);
      ParamByName('estoque').AsDouble:= StrToFloat(edtQtdEstoqueProd.Text);
      ExecSQL;
    end;
  end
  else if opc = 2 then
  begin
    with DM.zqProdutos do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update produtos set nome=:nome, descricao=:descricao, codigo_barras=:codigo_barras, valor_unit=:valor_unit, estoque=:estoque');
      SQL.Add('where codigo=:codigo');
      ParamByName('codigo').AsInteger:= StrToInt(edtCodProd.Text);
      ParamByName('nome').AsString:= edtNomeProd.Text;
      ParamByName('descricao').AsString:= edtDescricaoProd.Text;
      ParamByName('codigo_barras').AsString:= edtCodBarrasProd.Text;
      ParamByName('valor_unit').AsDouble:= StrToFloat(edtValorUntProd.Text);
      ParamByName('estoque').AsDouble:= StrToFloat(edtQtdEstoqueProd.Text);
      ExecSQL;
    end;
  end;
  // Restrição de Botões
    btIncluirProd.Enabled:= true;
    btAlterarProd.Enabled:= true;
    btConsultarProd.Enabled:= true;
    btSalvarProd.Enabled:= false;
    btCancelarProd.Enabled:= false;
    btExcluirProd.Enabled:= true;
  // Restrição de Campos
    edtCodProd.Enabled:= true;
    edtNomeProd.Enabled:= false;
    edtCodBarrasProd.Enabled:= false;
    edtValorUntProd.Enabled:= false;
    edtDescricaoProd.Enabled:= false;
    edtQtdEstoqueProd.Enabled:= false;
    opc:= 0;
  // Limpando Campos
    edtCodProd.Clear;
    edtNomeProd.Clear;
    edtDescricaoProd.Clear;
    edtCodBarrasProd.Clear;
    edtValorUntProd.Clear;
    edtQtdEstoqueProd.Clear;
end;

//  Cancelar Opção
procedure TfrmProdutos.btCancelarProdClick(Sender: TObject);
begin
  // Restrição de Botões
     btIncluirProd.Enabled:= true;
     btAlterarProd.Enabled:= true;
     btConsultarProd.Enabled:= true;
     btSalvarProd.Enabled:= false;
     btCancelarProd.Enabled:= false;
     btExcluirProd.Enabled:= true;
  // Restrição de Campos
     edtCodProd.Enabled:= true;
     edtNomeProd.Enabled:= false;
     edtCodBarrasProd.Enabled:= false;
     edtValorUntProd.Enabled:= false;
     edtDescricaoProd.Enabled:= false;
     edtQtdEstoqueProd.Enabled:= false;
     opc:= 0;
  // Limpando Campos
     edtCodProd.Clear;
     edtNomeProd.Clear;
     edtDescricaoProd.Clear;
     edtCodBarrasProd.Clear;
     edtValorUntProd.Clear;
     edtQtdEstoqueProd.Clear;
end;

// Consultar Produto
procedure TfrmProdutos.btConsultarProdClick(Sender: TObject);
begin
  if edtCodProd.Text = '' then
  begin
    showMessage('O Código do produto precisa ser informado');
    edtCodProd.SetFocus;
    exit;
  end
  else
  begin
    with DM.zqProdutos do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from produtos where codigo=:codigo');
      ParamByName('codigo').AsInteger:= StrToInt(edtCodProd.Text);
      Open;
      if IsEmpty then
      begin
        ShowMessage('Produto não cadastrado. Nenhum registro foi encontrado');
        // Limpando Campos
           edtCodProd.Clear;
           edtNomeProd.Clear;
           edtDescricaoProd.Clear;
           edtCodBarrasProd.Clear;
           edtValorUntProd.Clear;
           edtQtdEstoqueProd.Clear;
        edtCodProd.SetFocus;
      end
      else
      begin
        edtNomeProd.Text:= FieldByName('nome').AsString;
        edtDescricaoProd.Text:= FieldByName('descricao').AsString;
        edtCodBarrasProd.Text:= FieldByName('codigo_barras').AsString;
        edtValorUntProd.Text:= FieldByName('valor_unit').AsString;
        edtQtdEstoqueProd.Text:= FieldByName('estoque').AsString;
      end;
    end;
  end;
end;

// Alterar Produto
procedure TfrmProdutos.btAlterarProdClick(Sender: TObject);
begin
  if edtNomeProd.Text = '' then
  begin
    ShowMessage('É necessário Consultar um produto antes de Alterá-lo');
    edtCodProd.SetFocus;
    exit;
  end
  else
  begin
  // Restrição de Botões
    btIncluirProd.Enabled:= false;
    btAlterarProd.Enabled:= false;
    btConsultarProd.Enabled:= false;
    btSalvarProd.Enabled:= true;
    btCancelarProd.Enabled:= true;
    btExcluirProd.Enabled:= false;
  // Restrição de Campos
    edtCodProd.Enabled:= false;
    edtNomeProd.Enabled:= true;
    edtCodBarrasProd.Enabled:= true;
    edtValorUntProd.Enabled:= true;
    edtDescricaoProd.Enabled:= true;
    edtQtdEstoqueProd.Enabled:= true;
  opc:= 2;
  edtNomeProd.SetFocus;
  end;
end;

// Exclusão de Produtos
procedure TfrmProdutos.btExcluirProdClick(Sender: TObject);
begin
  if edtNomeProd.Text = '' then
  begin
    showMessage('É necessário Consultar um produto antes de Excluí-lo');
    edtCodProd.SetFocus;
    exit;
  end
  else
  begin
    if MessageDlg('Deseja Excluir estre produto? Uma vez excluído, não é possível recuperá-lo mais', mtConfirmation, [mbYes,mbNo],0) = mrYes then
    begin
      with DM.zqProdutos do
      begin
        Close;
        SQL.Clear;
        SQL.Add('delete from produtos where codigo=:codigo');
        ParamByName('codigo').AsInteger:= StrToInt(edtCodProd.Text);
        ExecSQL;
      end;
      // Limpando Campos
         edtCodProd.Clear;
         edtNomeProd.Clear;
         edtDescricaoProd.Clear;
         edtCodBarrasProd.Clear;
         edtValorUntProd.Clear;
         edtQtdEstoqueProd.Clear;
      // Restrição de Botões
         btIncluirProd.Enabled:= true;
         btAlterarProd.Enabled:= true;
         btConsultarProd.Enabled:= true;
         btSalvarProd.Enabled:= false;
         btCancelarProd.Enabled:= false;
         btExcluirProd.Enabled:= true;
      // Restrição de Campos
         edtCodProd.Enabled:= true;
         edtNomeProd.Enabled:= false;
         edtCodBarrasProd.Enabled:= false;
         edtValorUntProd.Enabled:= false;
         edtDescricaoProd.Enabled:= false;
         edtQtdEstoqueProd.Enabled:= false;
       opc:= 0;
    end;
  end;
end;

end.

