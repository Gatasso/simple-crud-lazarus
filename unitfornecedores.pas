unit unitFornecedores;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TfrmFornecedor }

  TfrmFornecedor = class(TForm)
    btAlterar: TButton;
    btCancelar: TButton;
    btConsultar: TButton;
    btExcluir: TButton;
    btIncluir: TButton;
    btSalvar: TButton;
    edtCEP: TEdit;
    edtCod: TEdit;
    edtCNPJ: TEdit;
    edtEndereco: TEdit;
    edtNome: TEdit;
    edtFantasia: TEdit;
    edtTelefone: TEdit;
    lblCEP: TLabel;
    lblCNPJ: TLabel;
    lblEndereco: TLabel;
    lblNome: TLabel;
    lblFantasia: TLabel;
    lblTelefone: TLabel;
    pnlHeader: TPanel;
    pnlCod: TPanel;
    pnlOp: TPanel;
    pnlBody: TPanel;
    procedure btAlterarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmFornecedor: TfrmFornecedor;
  opc: integer;

implementation

{$R *.lfm}

uses unitDM;

{ TfrmFornecedor }

  procedure TfrmFornecedor.FormClose(Sender: TObject;
    var CloseAction: TCloseAction);
  begin
    frmFornecedor:= nil;
  end;

  procedure TfrmFornecedor.btIncluirClick(Sender: TObject);
  begin
    btIncluir.Enabled:= false;
    btAlterar.Enabled:= false;
    btConsultar.Enabled:= false;
    btExcluir.Enabled:= false;
    btCancelar.Enabled:= true;
    btSalvar.Enabled:= true;
    opc:= 1;
    edtNome.Enabled:=true;
    edtFantasia.Enabled:=true;
    edtCNPJ.Enabled:=true;
    edtCEP.Enabled:=true;
    edtEndereco.Enabled:=true;
    edtTelefone.Enabled:=true;
    edtCod.Enabled:= false;
    edtNome.SetFocus;
  end;

  procedure TfrmFornecedor.btSalvarClick(Sender: TObject);
  begin
    if opc = 1 then
    begin
      with DM.zqFornecedores do
        begin
          close;
          sql.Clear;
          SQL.Add('insert into fornecedores(nome, fantasia, cnpj, cep, endereco, telefone)');
          SQL.Add('values(:nome, :fantasia, :cnpj, :cep, :endereco, :telefone)');
          ParamByName('nome').AsString:= edtNome.Text;
          ParamByName('fantasia').AsString:= edtFantasia.Text;
          ParamByName('cnpj').AsString:= edtCNPJ.Text;
          ParamByName('cep').AsString:= edtCEP.Text;
          ParamByName('endereco').AsString:= edtEndereco.Text;
          ParamByName('telefone').AsString:= edtTelefone.Text;
          ExecSQL;
        end

    end
    else if opc = 2 then
    begin
      with DM.zqFornecedores do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update fornecedores set nome=:nome, fantasia=:fantasia, cnpj=:cnpj, cep=:cep, endereco=:endereco, telefone=:telefone');
          SQL.Add('where codigo=:codigo');
          ParamByName('codigo').AsInteger:= StrToInt(edtCod.text);
          ParamByName('nome').AsString:= edtNome.Text;
          ParamByName('fantasia').AsString:= edtFantasia.Text;
          ParamByName('cnpj').AsString:= edtCNPJ.Text;
          ParamByName('cep').AsString:= edtCEP.Text;
          ParamByName('endereco').AsString:= edtEndereco.Text;
          ParamByName('telefone').AsString:= edtTelefone.Text;
          ExecSQL;
        end;
    end;
      opc:= 3;
      btIncluir.Enabled:= true;
      btAlterar.Enabled:= true;
      btConsultar.Enabled:= true;
      btExcluir.Enabled:= true;
      btCancelar.Enabled:= false;
      btSalvar.Enabled:= false;
      edtCod.Clear;
      edtNome.Clear;
      edtFantasia.Clear;
      edtCNPJ.Clear;
      edtCEP.Clear;
      edtEndereco.Clear;
      edtTelefone.Clear;
      edtNome.Enabled:=false;
      edtFantasia.Enabled:=false;
      edtCNPJ.Enabled:=false;
      edtCEP.Enabled:=false;
      edtEndereco.Enabled:=false;
      edtTelefone.Enabled:=false;
      edtCod.Enabled:= true;
      edtCod.SetFocus;
  end;

  procedure TfrmFornecedor.btCancelarClick(Sender: TObject);
  begin
    btIncluir.Enabled:= true;
    btAlterar.Enabled:= true;
    btConsultar.Enabled:= true;
    btExcluir.Enabled:= true;
    btCancelar.Enabled:= false;
    btSalvar.Enabled:= false;
    edtCod.Enabled:= true;
    edtNome.Enabled:=false;
    edtFantasia.Enabled:=false;
    edtCNPJ.Enabled:=false;
    edtCEP.Enabled:=false;
    edtEndereco.Enabled:=false;
    edtTelefone.Enabled:=false;
    opc:= 0;
  end;

procedure TfrmFornecedor.btAlterarClick(Sender: TObject);
begin
  if edtNome.Text = '' then
  begin
    ShowMessage('É necessário Consultar um registro antes de alterá-lo');
    edtCod.SetFocus;
    exit;
  end
  else
  begin
     btIncluir.Enabled:= false;
     btAlterar.Enabled:= false;
     btConsultar.Enabled:= false;
     btExcluir.Enabled:= false;
     btSalvar.Enabled:= true;
     btCancelar.Enabled:= true;
     edtNome.Enabled:=true;
     edtFantasia.Enabled:=true;
     edtCNPJ.Enabled:=true;
     edtCEP.Enabled:=true;
     edtEndereco.Enabled:=true;
     edtTelefone.Enabled:=true;
     edtCod.Enabled:= false;
     opc:= 2;
     edtNome.SetFocus;
  end;
end;

procedure TfrmFornecedor.btConsultarClick(Sender: TObject);
begin
  if edtCod.Text = '' then
  begin
    showMessage('Precisa informar um código para consultar');
    edtCod.SetFocus;
    exit;
  end
  else
  begin
    with DM.zqFornecedores do
      begin
        close;
        SQL.Clear;
        SQL.Add('select * from fornecedores where codigo=:codigo');
        ParamByName('codigo').AsInteger:= StrToInt(edtCod.text);
        open;
        if IsEmpty then
        begin
          ShowMessage('Código não cadastrado no banco');
          edtCod.Clear;
          edtNome.Clear;
          edtFantasia.Clear;
          edtCNPJ.Clear;
          edtCEP.Clear;
          edtEndereco.Clear;
          edtTelefone.Clear;
          edtCod.SetFocus;
        end
        else
        begin
          edtNome.Text:= FieldByName('nome').AsString;
          edtFantasia.Text:= FieldByName('fantasia').AsString;
          edtCNPJ.Text:= FieldByName('cnpj').AsString;
          edtCEP.Text:= FieldByName('cep').AsString;
          edtEndereco.Text:= FieldByName('endereco').AsString;
          edtTelefone.Text:= FieldByName('telefone').AsString;
        end;
      end;
  end;
end;

procedure TfrmFornecedor.btExcluirClick(Sender: TObject);
begin
  if edtNome.Text = '' then
  begin
    showMessage('É necessário realizar uma consulta antes de Excluir o registro');
    edtCod.SetFocus;
    exit;
  end
  else
  begin
    if MessageDlg('Confirma a exclusão? Uma vez exluído não há como recuperar', mtConfirmation, [mbYes, mbNo], 0)= mrYes then;
    begin
      with DM.zqFornecedores do
        begin
          Close;
          SQL.Clear;
          SQL.Add('delete from fornecedores where codigo=:codigo');
          ParamByName('codigo').AsInteger:= StrToInt(edtCod.text);
          ExecSQL;
          edtCod.Clear;
          edtNome.Clear;
          edtFantasia.Clear;
          edtCNPJ.Clear;
          edtCEP.Clear;
          edtEndereco.Clear;
          edtTelefone.Clear;
          edtCod.Enabled:= true;
          edtNome.Enabled:=false;
          edtFantasia.Enabled:=false;
          edtCNPJ.Enabled:=false;
          edtCEP.Enabled:=false;
          edtEndereco.Enabled:=false;
          edtTelefone.Enabled:=false;
          edtCod.SetFocus;
        end;
    end;
  end;
end;

end.

