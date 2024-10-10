unit unitpedidos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, ComCtrls, EditBtn, rxmemds;

type

  { TfrmPedidos }

  TfrmPedidos = class(TForm)
    btCriarPedido: TButton;
    btAlterarPedido: TButton;
    btSalvarPedido: TButton;
    btCancelar: TButton;
    btExcluirPedido: TButton;
    btConsultarPedido: TButton;
    btBuscarProd: TButton;
    btBuscarCliente: TButton;
    edtCodPedido: TEdit;
    edtCodProd: TEdit;
    edtCodCliente: TEdit;
    edtQntdProd: TEdit;
    edtNomeProd: TEdit;
    edtValorUnitProd: TEdit;
    edtDescontoPorcent: TEdit;
    edtNomeCliente: TEdit;
    edtCpfCliente: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btAddItem: TButton;
    btItemCancel: TButton;
    btClienteCancel: TButton;
    DBGrid1: TDBGrid;
    dsItensPedido: TDataSource;
    rxItensPedido: TRxMemoryData;
    rxItensPedidoCod: TLongintField;
    rxItensPedidoNome: TStringField;
    rxItensPedidoQntd: TLongintField;
    rxItensPedidoVlrUnd: TFloatField;
    rxItensPedidoVlrTotal: TFloatField;
    btUpDown: TUpDown;
    Label2: TLabel;
    edtDataPedido: TEdit;
    Label9: TLabel;
    cbxStatusPedido: TComboBox;
    edtHoraPedido: TEdit;
    Label10: TLabel;
    edtValorDesconto: TEdit;
    Label12: TLabel;
    edtSubTotal: TEdit;
    edtValorTotalPedido: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure limpaCampos();
    procedure btStatusInicial();
    procedure btStatusEditando();
    procedure statusInicialCampos();
    procedure statusEditandoCampos();
    procedure btCriarPedidoClick(Sender: TObject);
    procedure btAlterarPedidoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btBuscarProdClick(Sender: TObject);
    procedure btItemCancelClick(Sender: TObject);
    procedure btBuscarClienteClick(Sender: TObject);
    procedure btClienteCancelClick(Sender: TObject);
    procedure btAddItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSalvarPedidoClick(Sender: TObject);
    procedure calculaSubTotal();
    procedure calculaTotalPedido();
    procedure btExcluirPedidoClick(Sender: TObject);
    procedure btConsultarPedidoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtDescontoPorcentExit(Sender: TObject);
  private

  public

  end;

var
  frmPedidos: TfrmPedidos;
  opc: Integer;
  isEditable: Boolean;

const
  formatoData= 'dd/mm/yyyy';
  formatoHora= 'hh:nn';
implementation

uses UnitDM, modalProdutos, modalClientes;

{$R *.lfm}

{ TfrmPedidos }
//********************* Procedures Gerais de Auxílio *************************//
// Lógica de 'abertura' do formulário
   procedure TfrmPedidos.FormShow(Sender: TObject);
   begin
     if rxItensPedido.Active = false then rxItensPedido.Active:= true;
     rxItensPedido.EmptyTable;
   end;
// Lógica de fechamento de um formulário
  procedure TfrmPedidos.FormClose(Sender: TObject; var CloseAction: TCloseAction);
  begin
    frmPedidos:= nil;
  end;
//************************** Funções Auxiliares ******************************//
// Limpa todos os campos EDT do formulário
   procedure TfrmPedidos.limpaCampos();
   begin
    edtCodPedido.Clear;
    edtCodCliente.Clear;
    edtNomeCliente.Clear;
    edtCpfCliente.Clear;
    //if edtDescontoPorcent.Text = '0' then;
    edtDescontoPorcent.Text:= '0';
    edtCodProd.Clear;
    edtNomeProd.Clear;
    edtValorUnitProd.Clear;
    edtQntdProd.Text:= '0';
    edtDataPedido.Clear;
    edtHoraPedido.Clear;
    cbxStatusPedido.ItemIndex:= -1;
    edtSubTotal.Clear;
    edtValorDesconto.Clear;
    edtValorTotalPedido.Clear;
    rxItensPedido.EmptyTable;
   end;
// Status Inicial dos Campos Input
   procedure TfrmPedidos.statusInicialCampos();
   begin
     edtCodPedido.Enabled:= true;
     cbxStatusPedido.Enabled:= false;
     edtCodProd.Enabled:= false;
     edtNomeProd.Enabled:= false;
     edtValorUnitProd.Enabled:= false;
     edtQntdProd.Enabled:= false;
     edtCodCliente.Enabled:= false;
     edtNomeCliente.Enabled:= false;
     edtCpfCliente.Enabled:= false;
     edtDescontoPorcent.Enabled:= false;
     edtSubTotal.Enabled:= false;
     edtValorDesconto.Enabled:= false;
     edtValorTotalPedido.Enabled:= false;
     DBGrid1.Enabled:= false;
   end;
// Ativação dos Campos para Input
   procedure TfrmPedidos.statusEditandoCampos();
   begin
     edtCodPedido.Enabled:= false;
     cbxStatusPedido.Enabled:= true;
     edtCodCliente.Enabled:= true;
     edtNomeCliente.Enabled:= true;
     edtCpfCliente.Enabled:= true;
     edtDescontoPorcent.Enabled:= true;
     //edtDescontoPorcent.Text:= '0';
     edtCodProd.Enabled:= true;
     edtNomeProd.Enabled:= true;
     edtValorUnitProd.Enabled:= true;
     edtQntdProd.Enabled:= true;
     edtQntdProd.Text:= '0';
     DBGrid1.Enabled:= True;
   end;
// Ativação dos Botões no estado Inicial
   procedure TfrmPedidos.btStatusInicial();
   begin
     btCriarPedido.Enabled:= true;
     btAlterarPedido.Enabled:= true;
     btExcluirPedido.Enabled:= true;
     btConsultarPedido.Enabled:= true;
     btSalvarPedido.Enabled:= false;
     btCancelar.Enabled:= false;
     btBuscarProd.Enabled:= false;
     btBuscarCliente.Enabled:= false;
     btClienteCancel.Enabled:= false;
     btAddItem.Enabled:= false;
     btItemCancel.Enabled:= false;
     btUpDown.Enabled:= false;
   end;
// Ativação dos Botões no modo de Edição
   procedure TfrmPedidos.btStatusEditando();
   begin
     btCriarPedido.Enabled:= false;
     btAlterarPedido.Enabled:= false;
     btExcluirPedido.Enabled:= false;
     btConsultarPedido.Enabled:= false;
     btSalvarPedido.Enabled:= true;
     btCancelar.Enabled:= true;
     btBuscarProd.Enabled:= true;
     btBuscarCliente.Enabled:= true;
     btClienteCancel.Enabled:= true;
     btAddItem.Enabled:= true;
     btItemCancel.Enabled:= true;
     btUpDown.Enabled:= true;
   end;

//********************************* CRUD *************************************//
// Operação Criar Pedido
   procedure TfrmPedidos.btCriarPedidoClick(Sender: TObject);
   var dataHora: TDateTime;
   begin
     limpaCampos();
     btStatusEditando();
     statusEditandoCampos();
     opc:= 1;
     dataHora:= now;
     edtDataPedido.Text:= FormatDateTime(formatoData, dataHora);
     edtHoraPedido.Text:= FormatDateTime(formatoHora, dataHora);
     cbxStatusPedido.ItemIndex:= 0;
   end;
// Operação Alterar Pedido
   procedure TfrmPedidos.btAlterarPedidoClick(Sender: TObject);
   begin
     if (edtCodPedido.Text = '') or (rxItensPedido.RecordCount = 0) then
     begin
       ShowMessage('É necessário consultar um pedido antes de Alterá-lo');
       edtCodPedido.SetFocus;
       exit;
     end
     else
     begin
       btStatusEditando();
       statusEditandoCampos();
       opc:= 2;
     end;
   end;
// Cancela Operação
   procedure TfrmPedidos.btCancelarClick(Sender: TObject);
   begin
     btStatusInicial();
     statusInicialCampos();
     limpaCampos();
     opc:= 0;
     cbxStatusPedido.ItemIndex:= -1;
   end;
// Operação Salvar Pedido
   procedure TfrmPedidos.btSalvarPedidoClick(Sender: TObject);
   var maxIdPedido: Integer;
   begin
     if rxItensPedido.RecordCount = 0 then
     begin
       MessageDlg('Insira um produto antes de salvar', mtWarning,[mbOK], 0);
       edtCodProd.SetFocus;
       exit;
     end
     else if edtCodCliente.Text = '' then
     begin
       MessageDlg('Informe o cliente antes de salvar', mtWarning,[mbOK], 0);
       btBuscarCliente.SetFocus;
       exit;
     end
     else
     begin
       if opc = 1 then
       begin
         with DM.zqPedidos do
         begin
           Close;
           SQL.Clear;
           SQL.Add('insert into pedidosm (data_pedido, hora_pedido, cod_cliente, subtotal_pedido, total_desconto, total_pedido, status_pedido,pcent_desconto)');
           SQL.Add('values (:data_pedido, :hora_pedido, :cod_cliente, :subtotal_pedido, :total_desconto, :total_pedido, :status_pedido, :pcent_desconto)');
           ParamByName('data_pedido').AsDateTime:= StrToDateTime(edtDataPedido.Text);
           ParamByName('hora_pedido').AsTime:= StrToTime(edtHoraPedido.Text);
           ParamByName('status_pedido').AsString:= cbxStatusPedido.Text;
           ParamByName('cod_cliente').AsInteger:= StrToInt(edtCodCliente.Text);
           ParamByName('pcent_desconto').AsInteger:= StrToInt(edtDescontoPorcent.Text);
           ParamByName('subtotal_pedido').AsFloat:= StrToFloat(edtSubTotal.Text);
           ParamByName('total_desconto').AsFloat:= StrToFloat(edtValorDesconto.Text);
           ParamByName('total_pedido').AsFloat:= StrToFloat(edtValorTotalPedido.Text);
           ExecSQL;

           Close;
           SQL.Clear;
           SQL.Add('select MAX(id_pedido) as maxId from pedidosm');
           Open;
           maxIdPedido:= FieldByName('maxId').AsInteger;

           rxItensPedido.First;
           while not rxItensPedido.EOF do
           begin
             with DM.zqTemp do
             begin
               Close;
               SQL.Clear;
               SQL.Add('insert into pedidosi (id_pedido, cod_produto, quantidade, valor_unit, valor_total)');
               SQL.Add('values (:id_pedido, :cod_produto, :quantidade, :valor_unit, :valor_total)');
               ParamByName('id_pedido').AsInteger:= maxIdPedido;
               ParamByName('cod_produto').AsInteger:= rxItensPedidoCod.AsInteger;
               ParamByName('quantidade').AsInteger:= rxItensPedidoQntd.AsInteger;
               ParamByName('valor_unit').AsFloat:= rxItensPedidoVlrUnd.AsFloat;
               ParamByName('valor_total').AsFloat:= rxItensPedidoVlrTotal.AsFloat;
               ExecSQL;
             end;
             rxItensPedido.Next;
           end;
         end;
       end
       else if opc = 2 then
       begin
         with DM.zqPedidos do
         begin
           Close;
           SQL.Clear;
           SQL.Add('update pedidosm set cod_cliente=:cod_cliente, pcent_desconto=:pcent_desconto, total_desconto=:total_desconto, subtotal_pedido=:subtotal_pedido, total_pedido=:total_pedido');
           SQL.Add('where id_pedido=:id_pedido');
           ParamByName('id_pedido').AsInteger:= StrToInt(edtCodPedido.Text);
           ParamByName('cod_cliente').AsInteger := StrToInt(edtCodCliente.Text);
           ParamByName('pcent_desconto').AsInteger := StrToInt(edtDescontoPorcent.Text);
           ParamByName('total_desconto').AsFloat := StrToFloat(edtValorDesconto.Text);
           ParamByName('subtotal_pedido').AsFloat := StrToFloat(edtSubTotal.Text);
           ParamByName('total_pedido').AsFloat := StrToFloat(edtValorTotalPedido.Text);
           ExecSQL;
         end;
         with DM.zqTemp do
         begin
           Close;
           SQL.Clear;
           SQL.Add('delete from pedidosi where id_pedido=:id_pedido');
           ParamByName('id_pedido').asInteger:= StrToInt(edtCodPedido.Text);
           ExecSQL;

           rxItensPedido.First;
           while not rxItensPedido.EOF do
           begin
             Close;
             SQL.Clear;
             SQL.Add('insert into pedidosi (id_pedido, cod_produto, quantidade, valor_unit, valor_total)');
             SQL.Add('values (:id_pedido, :cod_produto, :quantidade, :valor_unit, :valor_total)');
             ParamByName('id_pedido').AsInteger:= maxIdPedido;
             ParamByName('cod_produto').AsInteger:= rxItensPedidoCod.AsInteger;
             ParamByName('quantidade').AsInteger:= rxItensPedidoQntd.AsInteger;
             ParamByName('valor_unit').AsFloat:= rxItensPedidoVlrUnd.AsFloat;
             ParamByName('valor_total').AsFloat:= rxItensPedidoVlrTotal.AsFloat;
             ExecSQL;
           end;
           rxItensPedido.Next;
         end;
       end;
     end;
     limpaCampos();
     statusInicialCampos();
     btStatusInicial();
   end;
// Operação Exluir Pedido
   procedure TfrmPedidos.btExcluirPedidoClick(Sender: TObject);
   begin
     if (edtCodPedido.Text = '') or (rxItensPedido.RecordCount = 0) then
     begin
       MessageDlg('Consulte um produto', mtWarning, [mbOK], 0);
       edtCodPedido.SetFocus;
       exit;
     end
     else if MessageDlg('Deseja excluir o produto? Uma vez excluído, não há como voltar', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       with DM.zqPedidos do
       begin
         Close;
         SQL.Clear;
         SQL.Add('delete from pedidosm where id_pedido=:id_pedido');
         ParamByName('id_pedido').AsInteger:= StrToInt(edtCodPedido.Text);
         ExecSQL;
         MessageDlg('Pedido excluido com sucesso', mtWarning, [mbOK], 0);
       end;
       limpaCampos();
       statusInicialCampos();
       btStatusInicial();
     end;
   end;
// Operação Consultar Pedido
   procedure TfrmPedidos.btConsultarPedidoClick(Sender: TObject);
   begin
     if edtCodPedido.Text = '' then  // posteriormente, abrir tela de consulta de pedidos
     begin
       MessageDlg('Informe o código do pedido', mtWarning, [mbOK], 0);
       edtCodPedido.SetFocus;
       Exit;
     end
     else
     begin
       with DM.zqPedidos do
       begin
         Close;
         SQL.Clear;
         SQL.Add('select pedidosm.*, cliente.nome, cliente.cpf from pedidosm');
         SQL.Add('inner join clientes cliente on pedidosm.cod_cliente = cliente.codigo');
         SQL.Add('where pedidosm.id_pedido=:id_pedido');
         ParamByName('id_pedido').AsInteger:= StrToInt(edtCodPedido.Text);
         Open;

         if IsEmpty then
         begin
           MessageDlg('Nenhum Pedido foi encontrado', mtError,[mbOK],0);
           btStatusInicial();
           statusInicialCampos();
           limpaCampos();
         end
         else
         begin
           edtDataPedido.Text:= FieldByName('data_pedido').AsString;
           edtHoraPedido.Text:= FieldByName('hora_pedido').AsString;
           cbxStatusPedido.Text:= FieldByName('status_pedido').AsString;
           edtDescontoPorcent.Text:= FieldByName('pcent_desconto').AsString;
           edtValorTotalPedido.Text:= FieldByName('total_pedido').AsString;
           edtValorDesconto.Text:= FieldByName('total_desconto').AsString;
           edtSubTotal.Text:= FieldByName('subtotal_pedido').AsString;
           edtCodCliente.Text:= FieldByName('cod_cliente').AsString;
           edtNomeCliente.Text:= FieldByName('nome').AsString;
           edtCpfCliente.Text:= FieldByName('cpf').AsString;
         end;
       end;

         with DM.zqTemp do
         begin
           Close;
           SQL.Clear;
           SQL.Add('select itens.*, prod.nome from pedidosi as itens');
           SQL.Add('inner join produtos prod');
           SQL.Add('on itens.cod_produto = prod.codigo');
           SQL.Add('where itens.id_pedido=:id_pedido');
           ParamByName('id_pedido').AsString:= edtCodPedido.Text;
           Open;

           rxItensPedido.EmptyTable;
           if rxItensPedido.Active = false then rxItensPedido.Active:= true;
           rxItensPedido.DisableControls;
           while not EOF do
           begin
             rxItensPedido.Append;
             rxItensPedidoCod.AsInteger:= FieldByName('cod_produto').AsInteger;
             rxItensPedidoNome.AsString:= FieldByName('nome').AsString;
             rxItensPedidoQntd.AsInteger:= FieldByName('quantidade').AsInteger;
             rxItensPedidoVlrUnd.AsFloat:= FieldByName('valor_unit').AsFloat;
             rxItensPedidoVlrTotal.AsFloat:= FieldByName('valor_total').AsFloat;
             rxItensPedido.Post;
             Next;
           end;
           rxItensPedido.EnableControls;
         end;
       end;
       btAlterarPedido.SetFocus;
   end;
//********************************* Itens ************************************//
// Consulta de Produtos
   procedure TfrmPedidos.btBuscarProdClick(Sender: TObject);
   begin
     btItemCancel.Enabled:= true;
     btAddItem.Enabled:= true;
     try
        if frmBuscaProdutos = nil then frmBuscaProdutos:= TfrmBuscaProdutos.Create(nil);
        frmBuscaProdutos.ShowModal;
     finally
        FreeAndNil(frmBuscaProdutos);
        statusEditandoCampos();
     end;
   end;
// Cancela inserção de Itens
    procedure TfrmPedidos.btItemCancelClick(Sender: TObject);
    begin
      //btItemCancel.Enabled:= false;
      btAddItem.Enabled:= false;
      edtCodProd.Clear;
      edtNomeProd.Clear;
      edtValorUnitProd.Clear;
      edtQntdProd.Clear;
    end;
// Adiciona os itens ao pedido
   procedure TfrmPedidos.btAddItemClick(Sender: TObject);
   begin
     if edtCodProd.Text = '' then
      begin
        ShowMessage('Produto não identificado');
        edtCodProd.SetFocus;
        exit;
      end
      else if edtQntdProd.Text = '' then
      begin
        ShowMessage('É necessário informar a quantidade de itens antes de adicioná-lo');
        edtQntdProd.SetFocus;
        exit;
      end;
      try
         if rxItensPedido.Locate('cod', edtCodProd.Text, []) then
         begin
           rxItensPedido.Edit;
           rxItensPedidoQntd.AsInteger:= rxItensPedidoQntd.AsInteger + StrToInt(edtQntdProd.Text);
         end
         else
         begin
           rxItensPedido.Append;
           rxItensPedidoCod.AsString:= edtCodProd.Text;
           rxItensPedidoNome.AsString:= edtNomeProd.Text;
           rxItensPedidoQntd.AsString:= edtQntdProd.Text;
           rxItensPedidoVlrUnd.AsString:= edtValorUnitProd.Text;
         end;
         rxItensPedidoVlrTotal.AsString:= FloatToStr(
                                            rxItensPedidoQntd.AsInteger * rxItensPedidoVlrUnd.AsFloat
                                          );
         rxItensPedido.post;
      finally
         calculaSubTotal();
         edtDescontoPorcentExit(self);
         calculaTotalPedido();
         edtCodProd.Clear;
         edtNomeProd.Clear;
         edtValorUnitProd.Clear;
         edtQntdProd.Text:= '0';
      end;
   end;

//******************************* Clientes ************************************//
// Consulta de Clientes
   procedure TfrmPedidos.btBuscarClienteClick(Sender: TObject);
   begin
     try
        if frmBuscaClientes = nil then frmBuscaClientes:= TfrmBuscaClientes.Create(nil);
        frmBuscaClientes.ShowModal;
     finally
        FreeAndNil(frmBuscaClientes);
        statusEditandoCampos();
     end;
   end;
// Cancela inserção de dados do Cliente
   procedure TfrmPedidos.btClienteCancelClick(Sender: TObject);
   begin
     //btClienteCancel.Enabled:= false;
     statusEditandoCampos();
     edtCodCliente.Clear;
     edtNomeCliente.Clear;
     edtCpfCliente.Clear;
     edtDescontoPorcent.Text:= '0';
   end;
//*************************** Calcula Valores ********************************//
// Cálculo SubTotal
   procedure TfrmPedidos.calculaSubTotal();
   var soma: Double;
   begin
     soma:= 0;
     with rxItensPedido do
     begin
       First;
       while not EOF do
       begin
         soma:= soma + rxItensPedidoVlrTotal.AsFloat;
         Next;
       end;
       edtSubTotal.Text:= FloatToStr(soma);
     end;
     calculaTotalPedido();
   end;
// Cálculo Valor do Desconto
   procedure TfrmPedidos.edtDescontoPorcentExit(Sender: TObject);
   begin
     if isEditable then
     begin
       isEditable:= False;
       exit;
     end;

     if (rxItensPedido.RecordCount = 0) then
     begin
       isEditable:= true;
       MessageDlg('Adicione Produtos', mtWarning, [mbOK], 0);
       edtDescontoPorcent.Text:= '0';
       edtCodProd.SetFocus;
       Exit;
     end
     else
     begin
       if (StrToFloat(edtDescontoPorcent.Text) < 0) or (StrToFloat(edtDescontoPorcent.Text) >= 100) then
       begin
         isEditable:= true;
         MessageDlg('Insira um valor válido para desconto', mtWarning, [mbOK], 0 );
         edtDescontoPorcent.Text:= '0';
         edtDescontoPorcent.SetFocus;
         Exit;
       end
       else
       begin
         edtValorDesconto.Text:= FloatToStr(
                                 (StrToFloat(edtDescontoPorcent.Text)/100) *
                                  StrToFloat(edtSubTotal.Text)
                                  );
         isEditable:= false;
       end;
     end;
     isEditable:= false;
     calculaTotalPedido();
   end;
// Cálculo Valor Total do Pedido
   procedure TfrmPedidos.calculaTotalPedido();
   begin
        if edtValorDesconto.Text = '' then edtValorDesconto.Text:= '0';
        edtValorTotalPedido.Text:= FloatToStr(
                                   StrToFloat(edtSubTotal.Text) -
                                   StrToFloat(edtValorDesconto.Text));
   end;
procedure TfrmPedidos.DBGrid1DblClick(Sender: TObject);
begin
  if MessageDlg('Você deseja mesmo remover o item do pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    rxItensPedido.Delete;
    calculaSubTotal();
    edtDescontoPorcentExit(self);
    calculaTotalPedido();
  end;
end;


end.

