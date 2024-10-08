unit unitClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmClientes }

  TfrmClientes = class(TForm)
    btIncluir: TButton;
    btAlterar: TButton;
    btCancelar: TButton;
    btSalvar: TButton;
    btExcluir: TButton;
    btConsultar: TButton;
    edtCod: TEdit;
    edtCEP: TEdit;
    edtTelefone: TEdit;
    edtEndereco: TEdit;
    edtRG: TEdit;
    edtNome: TEdit;
    edtCPF: TEdit;
    lblCEP: TLabel;
    lblTelefone: TLabel;
    lblEndereco: TLabel;
    lblRG: TLabel;
    lblNome: TLabel;
    lblCPF: TLabel;
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
  frmClientes: TfrmClientes;
  opc: integer;

implementation

{$R *.lfm}

uses unitDM;

{ TfrmClientes }

procedure TfrmClientes.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
     frmClientes:= nil;
end;

procedure TfrmClientes.btIncluirClick(Sender: TObject);
begin
  btIncluir.Enabled:= false;
  btAlterar.Enabled:= false;
  btConsultar.Enabled:= false;
  btExcluir.Enabled:= false;
  btSalvar.Enabled:= true;
  btCancelar.Enabled:= true;
  opc:= 1;
  edtNome.setFocus;
end;

procedure TfrmClientes.btSalvarClick(Sender: TObject);
begin
    if opc = 1 then
    begin
       with DM do
         begin
           zqClientes.close;
           zqClientes.sql.clear;
           zqClientes.sql.add('insert into clientes (nome, cpf, rg, cep, endereco, telefone)');
           zqClientes.sql.add('values(:nome,:cpf, :rg, :cep, :endereco, :telefone)');
           zqClientes.ParamByName('nome').asString:= edtNome.Text;
           zqClientes.ParamByName('cpf').asString:= edtCPF.Text;
           zqClientes.ParamByName('rg').AsString:= edtRG.Text;
           zqClientes.ParamByName('cep').asString:= edtCEP.Text;
           zqClientes.ParamByName('endereco').AsString:= edtEndereco.Text;
           zqClientes.ParamByName('telefone').AsString:= edtTelefone.Text;
           zqClientes.execsql;
         end;
    end
    else if opc = 2 then
    begin
       with DM do
         begin
           zqClientes.close;
           zqClientes.sql.clear;
           zqClientes.sql.add('update clientes set nome=:nome, cpf=:cpf, rg=:rg, cep=:cep, endereco=:endereco, telefone=:telefone');
           zqClientes.sql.add('where codigo=:codigo');
           zqClientes.ParamByName('nome').asString:= edtNome.Text;
           zqClientes.ParamByName('cpf').asString:= edtCPF.Text;
           zqClientes.ParamByName('rg').AsString:= edtRG.Text;
           zqClientes.ParamByName('cep').asString:= edtCEP.Text;
           zqClientes.ParamByName('endereco').AsString:= edtEndereco.Text;
           zqClientes.ParamByName('telefone').AsString:= edtTelefone.Text;
           zqClientes.ParamByName('codigo').AsInteger:= StrToInt(edtCod.text);
           zqClientes.ExecSQL;
         end;
    end;
    opc:= 3;
       btIncluir.Enabled:= true;
       btAlterar.Enabled:= true;
       btConsultar.Enabled:= true;
       btExcluir.Enabled:= true;
       btSalvar.Enabled:= false;
       btCancelar.Enabled:= false;
       edtNome.Clear;
       edtCPF.Clear;
       edtRG.Clear;
       edtCEP.Clear;
       edtEndereco.Clear;
       edtTelefone.Clear;
end;

procedure TfrmClientes.btCancelarClick(Sender: TObject);
begin
  btIncluir.Enabled:= true;
  btAlterar.Enabled:= true;
  btConsultar.Enabled:= true;
  btExcluir.Enabled:= true;
  btSalvar.Enabled:= false;
  btCancelar.Enabled:= false;
end;

procedure TfrmClientes.btConsultarClick(Sender: TObject);
begin
   if edtCod.Text = '' then
   begin
      ShowMessage('Necessario informar Codigo para realizar consulta');
      edtCod.SetFocus;
      exit;
   end;
   with DM do
     begin
       zqClientes.close;
       zqClientes.SQL.clear;
       zqClientes.SQL.Add('select * from clientes where codigo = :codigo');
       zqClientes.ParamByName('codigo').AsInteger:= StrToInt(edtCod.Text);
       zqClientes.Open;
       if zqClientes.isEmpty then
       begin
         showMessage('Codigo não cadastrado');
         edtNome.Clear;
         edtCPF.Clear;
         edtRG.Clear;
         edtCEP.Clear;
         edtEndereco.Clear;
         edtTelefone.Clear;
         edtCod.SetFocus;
       end
       else
       begin
         edtNome.text:= zqClientes.fieldByName('nome').AsString;
         edtCPF.text:= zqClientes.fieldByName('cpf').AsString;
         edtRG.text:= zqClientes.FieldByName('rg').AsString;
         edtCEP.text:= zqClientes.FieldByName('cep').AsString;
         edtEndereco.text:= zqClientes.FieldByName('endereco').AsString;
         edtTelefone.text:= zqClientes.FieldByName('telefone').asString;

       end;
     end;
end;

procedure TfrmClientes.btExcluirClick(Sender: TObject);
begin
  if edtNome.text = '' then
  begin
    ShowMessage('É necessário realizar consulta de cliente antes de excluir');
    edtCod.SetFocus;
    exit;
  end
  else
    begin
    if messageDlG('Deseja Excluir Cliente selecionado', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
    begin
      with DM do
        begin
          zqClientes.close;
          zqClientes.sql.clear;
          zqClientes.sql.Add('delete from clientes where codigo=:codigo');
          zqClientes.ParamByName('codigo').AsInteger:= StrToint(edtCod.text);
          zqClientes.ExecSQL;
          edtNome.Clear;
          edtCPF.Clear;
          edtRG.Clear;
          edtCEP.Clear;
          edtEndereco.Clear;
          edtTelefone.Clear;
        end;
    end;
  end;
end;

procedure TfrmClientes.btAlterarClick(Sender: TObject);
begin
  if edtNome.text = '' then
  begin
    ShowMessage('É necessário realizar consulta de cliente antes de alterar');
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
     opc:= 2;
     edtNome.SetFocus;
  end;
end;

end.

