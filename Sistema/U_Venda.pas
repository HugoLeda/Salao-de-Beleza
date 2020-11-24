unit U_Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TForm_Venda = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    BtnGVenda: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Button5: TButton;
    Button6: TButton;
    DBLFuncionario: TDBLookupComboBox;
    DBLCLiente: TDBLookupComboBox;
    ADOConnection1: TADOConnection;
    ADOQueryFuncionario: TADOQuery;
    ADOQueryCliente: TADOQuery;
    DataSourceFuncionario: TDataSource;
    DataSourceCliente: TDataSource;
    ADOQueryClienteCODIGO: TAutoIncField;
    ADOQueryClienteNOME: TStringField;
    Label4: TLabel;
    ADOQueryGerarVenda: TADOQuery;
    ADOQueryFuncionarioCODIGO: TAutoIncField;
    ADOQueryFuncionarioNOME: TStringField;
    ADOQueryAdicionarServicoItensVenda: TADOQuery;
    ADOQueryAdicionarProdutoItensVenda: TADOQuery;
    DBLServico: TDBLookupComboBox;
    ADOQueryServico: TADOQuery;
    ADOQueryServicoCODIGO: TAutoIncField;
    ADOQueryServicoNOME: TStringField;
    ADOQueryServicoPRECO: TBCDField;
    DataSourceServicos: TDataSource;
    BtnServico: TButton;
    BtnProduto: TButton;
    Label6: TLabel;
    EditProduto: TEdit;
    ADOQueryProduto: TADOQuery;
    ADOQueryProdutoCODIGO_DE_BARRAS: TLargeintField;
    EditProdutoQtd: TEdit;
    ADOQueryProdutoCODIGO: TAutoIncField;
    ADOQueryProdutoNOME: TStringField;
    ADOQueryProdutoDESCRICAO: TStringField;
    ADOQueryProdutoTIPO: TStringField;
    ADOQueryProdutoPRECO: TBCDField;
    ADOQueryProdutoMARCA: TStringField;
    ADOQueryProdutoFORNECEDOR: TIntegerField;
    ADOQueryProdutoIMAGEM: TStringField;
    ADOQueryProdutoDATA_CADASTRO: TWideStringField;
    ADOQueryProdutoDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryProdutoDISPONIVEL: TBooleanField;
    ADOQueryItensVenda: TADOQuery;
    DataSourceItensVenda: TDataSource;
    ADOQueryServicoDURACAO: TIntegerField;
    ADOQueryServicoDESCRICAO: TStringField;
    ADOQueryServicoDATA_CADASTRO: TWideStringField;
    ADOQueryServicoDATA_ULT_MODIFICACAO: TWideStringField;
    ADOQueryServicoDISPONIVEL: TBooleanField;
    ADOQueryMovimentacaoSaidaEstoque: TADOQuery;
    ADOQueryEstoque: TADOQuery;
    ADOQueryEstoqueCODIGO: TAutoIncField;
    ADOQueryEstoquePRODUTO: TIntegerField;
    ADOQueryEstoqueDATA_VALIDADE: TWideStringField;
    ADOQueryEstoqueQTD: TIntegerField;
    ADOQueryAtualizarValor: TADOQuery;
    ADOQueryAtualizarEstoque: TADOQuery;
    ADOQueryValor: TADOQuery;
    ADOQueryValorCODIGO: TAutoIncField;
    ADOQueryValorVENDEDOR: TIntegerField;
    ADOQueryValorCLIENTE: TIntegerField;
    ADOQueryValorVALOR: TBCDField;
    ADOQueryValorDATA: TDateTimeField;
    ADOQueryValorFORMA_PAGAMENTO: TStringField;
    ADOQueryValorSITUACAO: TStringField;
    ADOQueryItensVendaCHAVE: TAutoIncField;
    ADOQueryItensVendaNOME: TStringField;
    ADOQueryItensVendaPRECO: TBCDField;
    ADOQueryItensVendaQTD: TIntegerField;
    DBGrid1: TDBGrid;
    ADOQueryRemoverItemVenda: TADOQuery;
    ADOQueryCancelar: TADOQuery;
    ADOQueryItensVendaPRODUTO: TIntegerField;
    ADOQueryItensVendaCODIGO_VENDA: TIntegerField;
    ADOQueryItensVendaSERVICO: TIntegerField;
    ADOQueryRemoverServico: TADOQuery;
    ADOQueryAtualizaValorPraZero: TADOQuery;
    ADOQueryCancelarVenda: TADOQuery;
    PanelDireita: TPanel;
    PanelInferior: TPanel;
    PanelGrid: TPanel;
    LabelTextoValor: TLabel;
    LabelValor: TLabel;
    PanelValor: TPanel;
    PanelQtd: TPanel;
    LabelItens: TLabel;
    LabelQTD: TLabel;
    PanelEsquerda: TPanel;
    PanelBotoes: TPanel;
    ButtonCancelar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ButtonFinalizar: TSpeedButton;
    ButtonRemover: TSpeedButton;
    PanelBotoesEsquerda: TPanel;
    PanelBotoesDireita: TPanel;
    PanelBotaoInvisivel: TPanel;
    PanelGerarVenda: TPanel;
    PanelAdicionar: TPanel;
    ImgSelecionarFunc: TImage;
    ImgSelecionarCli: TImage;
    ButtonIniciarVenda: TSpeedButton;
    ImgSelecionarServ: TImage;
    ImgSelecionarProd: TImage;
    ButtonInserir: TSpeedButton;
    PanelItem: TPanel;
    LabelItem: TLabel;
    LabelItemSelecionado: TLabel;
    procedure BtnGVendaClick(Sender: TObject);
    procedure BtnServicoClick(Sender: TObject);
    procedure EditProdutoQtdClick(Sender: TObject);
    procedure BtnProdutoClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonIniciarVendaMouseEnter(Sender: TObject);
    procedure ButtonIniciarVendaMouseLeave(Sender: TObject);
    procedure ButtonIniciarVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgSelecionarFuncClick(Sender: TObject);
    procedure ImgSelecionarCliClick(Sender: TObject);
    procedure ButtonInserirMouseEnter(Sender: TObject);
    procedure ButtonInserirMouseLeave(Sender: TObject);
    procedure ButtonInserirClick(Sender: TObject);
    procedure ImgSelecionarProdClick(Sender: TObject);
    procedure ImgSelecionarServClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonRemoverClick(Sender: TObject);
    procedure ButtonFinalizarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonRemoverMouseEnter(Sender: TObject);
    procedure ButtonRemoverMouseLeave(Sender: TObject);
    procedure ButtonFinalizarMouseEnter(Sender: TObject);
    procedure ButtonFinalizarMouseLeave(Sender: TObject);
    procedure ButtonSairMouseEnter(Sender: TObject);
    procedure ButtonSairMouseLeave(Sender: TObject);
    procedure ButtonCancelarMouseEnter(Sender: TObject);
    procedure ButtonCancelarMouseLeave(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DataSourceItensVendaDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    CodUltVenda : Integer;
    CodUltMovimenacao : Integer;
    SelecionarFunc : Boolean;
    SelecionarCli : Boolean;
    SelecionarProd : Boolean;
    SelecionarServ : Boolean;
    CliPadrao : Boolean;
  end;

var
  Form_Venda: TForm_Venda;

implementation

{$R *.dfm}

uses U_Consu_Funcionarios, U_Consu_Clientes, U_Consu_Produto, U_Consu_Servicos,
  U_Pagamento;

//uses U_Pagamento, U_Principal;

procedure TForm_Venda.BtnProdutoClick(Sender: TObject);
Var
  Qtd, QTDNova: Integer;
begin
  Qtd := StrToInt(EditProdutoQtd.Text);

  if EditProduto.Text = '' then
  begin
    Application.MessageBox('Insira o Codigo de Barras!', 'Erro', MB_OK + MB_ICONERROR);
    EditProduto.SetFocus;
    Exit;
  end;

  if EditProduto.Text <> null then
  begin
      ADOQueryProduto.Close;
      ADOQueryProduto.Parameters.ParamByName('CODIGO_DE_BARRAS').Value := EditProduto.Text;
      ADOQueryProduto.Open;

      ADOQueryEstoque.Close;
      ADOQueryEstoque.Parameters.ParamByName('PRODUTO').Value := ADOQueryProdutoCODIGO.AsString;
      ADOQueryEstoque.Open;

      if ADOQueryEstoque.RecordCount = 0 then
      begin
        Application.MessageBox('Produto não encontrado!', 'Erro', MB_OK + MB_ICONERROR);
        EditProduto.SetFocus;
        Exit;
      end;

      //aqui vc verifica se tem a qtd desejada em estoque
      if Qtd > ADOQueryEstoqueQTD.AsInteger then
      begin
        Application.MessageBox('Quantidade informada não disponivel!', 'Erro', MB_OK + MB_ICONERROR);
        EditProduto.SetFocus;
        exit;
      end;


      ADOQueryAdicionarProdutoItensVenda.Close;
      ADOQueryAdicionarProdutoItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
      ADOQueryAdicionarProdutoItensVenda.Parameters.ParamByName('NOME').Value := ADOQueryProdutoNOME.AsString;
      ADOQueryAdicionarProdutoItensVenda.Parameters.ParamByName('PRECO').Value := ADOQueryProdutoPRECO.AsCurrency * StrToInt(EditProdutoQtd.Text);
      ADOQueryAdicionarProdutoItensVenda.Parameters.ParamByName('PRODUTO').Value := ADOQueryProdutoCODIGO.AsInteger;
      ADOQueryAdicionarProdutoItensVenda.Parameters.ParamByName('QTD').Value := EditProdutoQtd.Text;
      ADOQueryAdicionarProdutoItensVenda.ExecSQL;

      ADOQueryAtualizarValor.Close;
      ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
      ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
      ADOQueryAtualizarValor.ExecSQL;

      ADOQueryEstoque.Close;
      ADOQueryEstoque.Parameters.ParamByName('PRODUTO').Value := ADOQueryProdutoCODIGO.AsInteger;
      ADOQueryEstoque.Open;

      ADOQueryMovimentacaoSaidaEstoque.Close;
      ADOQueryMovimentacaoSaidaEstoque.Parameters.ParamByName('ESTOQUE').Value := ADOQueryEstoqueCODIGO.AsInteger;
      ADOQueryMovimentacaoSaidaEstoque.Parameters.ParamByName('QTD').Value := EditProdutoQtd.Text;
      ADOQueryMovimentacaoSaidaEstoque.ExecSQL;

      QTDNova := ADOQueryEstoqueQTD.AsInteger;
      QTDNova := QTDNova - Qtd;
      ADOQueryAtualizarEstoque.Close;
      ADOQueryAtualizarEstoque.Parameters.ParamByName('QTDNOVA').Value := QTDNova;
      ADOQueryAtualizarEstoque.Parameters.ParamByName('CODIGOESTOQUE').Value := ADOQueryEstoqueCODIGO.AsString;
      ADOQueryAtualizarEstoque.ExecSQL;

      ADOQueryItensVenda.Close;
      ADOQueryItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda ;
      ADOQueryItensVenda.Open;

      ADOQueryValor.Close;
      ADOQueryValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
      ADOQueryValor.Open;
      Edit1.Text := ADOQueryValorVALOR.AsString;
      ADOQueryItensVenda.Last;
  end;


end;

procedure TForm_Venda.BtnServicoClick(Sender: TObject);
begin
  if (DBLServico.KeyValue = 0) or (DBLServico.KeyValue = null) then
  begin
    Application.MessageBox('Selecione um Servico!', 'Erro', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if (DBLServico.KeyValue <> null) then
  begin
    ADOQueryAdicionarServicoItensVenda.Close;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('NOME').Value := ADOQueryServicoNOME.AsString;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('PRECO').Value := ADOQueryServicoPRECO.AsCurrency;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('SERVICO').Value := ADOQueryServicoCODIGO.AsInteger;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('QTD').Value := 1;
    ADOQueryAdicionarServicoItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
    ADOQueryAdicionarServicoItensVenda.ExecSQL;

    ADOQueryItensVenda.Close;
    ADOQueryItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda ;
    ADOQueryItensVenda.Open;

    ADOQueryAtualizarValor.Close;
    ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
    ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
    ADOQueryAtualizarValor.ExecSQL;

    ADOQueryValor.Close;
    ADOQueryValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
    ADOQueryValor.Open;
    Edit1.Text := CurrToStr(ADOQueryValorVALOR.AsCurrency);
  end;

end;

procedure TForm_Venda.Button4Click(Sender: TObject);
var
  QTDEstoque, QTD, Cod: Integer;
begin
  if ADOQueryItensVendaCHAVE.AsString = '' then
  begin
    Application.MessageBox('Selecione um item para ser removido!','Erro', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if ADOQueryItensVendaSERVICO.AsString <> '' then
    begin
      Cod := ADOQueryItensVendaCHAVE.AsInteger;
      ADOQueryRemoverServico.Close;
      ADOQueryRemoverServico.Parameters.ParamByName('CHAVE').Value := Cod;
      ADOQueryRemoverServico.ExecSQL;
    end
  else
    begin
      QTD := DBGrid1.Columns[2].Field.AsInteger;

      ADOQueryEstoque.Close;
      ADOQueryEstoque.Parameters.ParamByName('PRODUTO').Value :=  ADOQueryItensVendaPRODUTO.AsInteger;
      ADOQueryEstoque.Open;

      ADOQueryRemoverItemVenda.Close;
      ADOQueryRemoverItemVenda.Parameters.ParamByName('CHAVE').Value := ADOQueryItensVendaCHAVE.AsInteger;
      ADOQueryRemoverItemVenda.Parameters.ParamByName('QTDNOVA').Value := ADOQueryEstoqueQTD.AsInteger + QTD;
      ADOQueryRemoverItemVenda.Parameters.ParamByName('CODIGO').Value := ADOQueryEstoqueCODIGO.AsInteger;
      ADOQueryRemoverItemVenda.Parameters.ParamByName('ESTOQUE').Value := ADOQueryEstoqueCODIGO.AsInteger;
      ADOQueryRemoverItemVenda.Parameters.ParamByName('QTD').Value := QTD;
      ADOQueryRemoverItemVenda.ExecSQL;

      LabelQTD.Caption := IntToStr(ADOQueryItensVenda.RecordCount);
      ADOQueryItensVenda.Last;
      LabelValor.Caption := 'R$ ' + FormatFloat('###0.00', Abs(ADOQueryValorVALOR.AsFloat));

      {ADOQueryAtualizarEstoque.Close;
      QTDEstoque := ADOQueryEstoqueQTD.AsInteger;
      ADOQueryAtualizarEstoque.Parameters.ParamByName('QTDNOVA').Value := QTDEstoque + QTD;
      ADOQueryAtualizarEstoque.Parameters.ParamByName('CODIGOESTOQUE').Value := ADOQueryEstoqueCODIGO.AsInteger;
      ADOQueryAtualizarEstoque.ExecSQL;}
    end;

  ADOQueryItensVenda.Close;
  ADOQueryItensVenda.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda ;
  ADOQueryItensVenda.Open;

  if ADOQueryItensVenda.RecordCount > 0 then
    begin
      ADOQueryAtualizarValor.Close;
      ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
      ADOQueryAtualizarValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
      ADOQueryAtualizarValor.ExecSQL;
    end
  else
    begin
      ADOQueryAtualizaValorPraZero.Close;
      ADOQueryAtualizaValorPraZero.Parameters.ParamByName('CODULTVENDA').Value := CodUltVenda;
      ADOQueryAtualizaValorPraZero.ExecSQL;
    end;

  ADOQueryValor.Close;
  ADOQueryValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
  ADOQueryValor.Open;
  Edit1.Text := ADOQueryValorVALOR.AsString;

  ADOQueryItensVenda.Last;

end;

procedure TForm_Venda.Button5Click(Sender: TObject);
begin

  DBLFuncionario.KeyValue := 0;
  DBLCLiente.KeyValue := 0;

  if ADOQueryItensVenda.RecordCount = 0 then
    begin
      ADOQueryCancelarVenda.Close;
      ADOQueryCancelarVenda.Parameters.ParamByName('CODULTVENDA').Value := CodUltVenda;
      ADOQueryCancelarVenda.ExecSQL;
      LabelQTD.Caption := '0';
      LabelValor.Caption := 'R$ 0,00';
      LabelItem.Caption := '';
      Label3.Caption := 'Funcionário';
      Label2.Caption := 'Cliente';
      DBLFuncionario.Visible := True;
      DBLCLiente.Visible := True;
      ImgSelecionarFunc.Visible := True;
      ImgSelecionarCli.Visible := True;
      ButtonIniciarVenda.Visible := True;
      ButtonIniciarVenda.Enabled := True;
      Exit;
    end;

  if ADOQueryItensVenda.RecordCount = 1 then
    begin
      Button4Click(Sender);
      ADOQueryCancelarVenda.Close;
      ADOQueryCancelarVenda.Parameters.ParamByName('CODULTVENDA').Value := CodUltVenda;
      ADOQueryCancelarVenda.ExecSQL;
      LabelQTD.Caption := '0';
      LabelValor.Caption := 'R$ 0,00';
      LabelItem.Caption := '';
      Label3.Caption := 'Funcionário';
      Label2.Caption := 'Cliente';
      DBLFuncionario.Visible := True;
      DBLCLiente.Visible := True;
      ImgSelecionarFunc.Visible := True;
      ImgSelecionarCli.Visible := True;
      ButtonIniciarVenda.Visible := True;
      ButtonIniciarVenda.Enabled := True;
      Exit;
    end;

  ADOQueryItensVenda.First;

  while not ADOQueryItensVenda.Eof  do
    begin
      Button4Click(Sender);
      ADOQueryItensVenda.Next;
    end;
  Button4Click(Sender);

  ADOQueryCancelarVenda.Close;
  ADOQueryCancelarVenda.Parameters.ParamByName('CODULTVENDA').Value := CodUltVenda;
  ADOQueryCancelarVenda.ExecSQL;

  LabelQTD.Caption := '0';
  LabelValor.Caption := 'R$ 0,00';
  LabelItem.Caption := '';
  PanelAdicionar.Visible := False;
  Label3.Caption := 'Funcionário';
  Label2.Caption := 'Cliente';
  DBLFuncionario.Visible := True;
  DBLCLiente.Visible := True;
  ImgSelecionarFunc.Visible := True;
  ImgSelecionarCli.Visible := True;
  ButtonIniciarVenda.Visible := True;
  ButtonIniciarVenda.Enabled := True;
  {ADOQueryCancelar.Close;
  ADOQueryCancelar.Parameters.ParamByName('CODIGO_VENDA').Value := CodUltVenda;
  ADOQueryCancelar.Parameters.ParamByName('CODIGO_VENDA2').Value := CodUltVenda;
  ADOQueryCancelar.Parameters.ParamByName('CODIGO_VENDA3').Value := CodUltVenda;
  ADOQueryCancelar.ExecSQL;

  ADOQueryItensVenda.Close;
  ADOQueryItensVenda.Open;

  DBLFuncionario.KeyValue := 0;
  DBLCLiente.KeyValue := 0;
  DBLServico.KeyValue := 0;
  EditProduto.Text := '';
  BtnGVenda.Visible := True;

  ADOQueryValor.Close;
  ADOQueryValor.Parameters.ParamByName('CODIGO').Value := CodUltVenda;
  ADOQueryValor.Open;
  Edit1.Text := ADOQueryValorVALOR.AsString;

  LabelAviso.Caption := 'Venda Cancelada!';}
end;

procedure TForm_Venda.Button6Click(Sender: TObject);
begin
  Form_Venda.Hide;
  FormPagamento.ShowModal;

  if FormPagamento.Pagamento = True then
    begin
      Label3.Caption := 'Funcionário';
      Label2.Caption := 'Cliente';
      DBLFuncionario.Visible := True;
      DBLCLiente.Visible := True;
      ImgSelecionarFunc.Visible := True;
      ImgSelecionarCli.Visible := True;
      ButtonIniciarVenda.Visible := True;
      ButtonIniciarVenda.Enabled := True;
      CodUltVenda := 0;
      ADOQueryItensVenda.Close;
      LabelQTD.Caption := '0';
      LabelItem.Caption := '';
      LabelValor.Caption := 'R$ 0,00'
    end;

  Form_Venda.Show;
end;

procedure TForm_Venda.ButtonCancelarClick(Sender: TObject);
begin
  Button5Click(Sender);
end;

procedure TForm_Venda.ButtonCancelarMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonCancelarMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Venda.ButtonFinalizarClick(Sender: TObject);
begin
  if ADOQueryItensVenda.RecordCount > 0 then
    begin
      Button6Click(Sender);
    end;
end;

procedure TForm_Venda.ButtonFinalizarMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonFinalizarMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Venda.BtnGVendaClick(Sender: TObject);
begin
  if (DBLFuncionario.KeyValue = null) or (DBLFuncionario.KeyValue = 0) then
    begin
      Application.MessageBox('Selecione um Funcionario!', 'Erro', MB_OK + MB_ICONERROR);
      DBLFuncionario.SetFocus;
      Exit;
    end;

  if (DBLCLiente.KeyValue = null) or (DBLCLiente.KeyValue = 0) then
    begin
      Application.MessageBox('Selecione um Cliente!', 'Erro', MB_OK + MB_ICONERROR);
      DBLCLiente.SetFocus;
      Exit;
    end;

  ADOQueryGerarVenda.Close;
  ADOQueryGerarVenda.Parameters.ParamByName('VENDEDOR').Value := DBLFuncionario.KeyValue;
  ADOQueryGerarVenda.Parameters.ParamByName('CLIENTE').Value := DBLCLiente.KeyValue;
  ADOQueryGerarVenda.Parameters.ParamByName('ULT').Value;
  ADOQueryGerarVenda.ExecSQL;

  CodUltVenda := ADOQueryGerarVenda.Parameters.ParamByName('ULT').Value;

  Label3.Caption := Label3.Caption + ' ' + DBLFuncionario.Text;
  Label2.Caption := Label2.Caption + ' ' + DBLCLiente.Text;
  DBLFuncionario.Visible := False;
  DBLCLiente.Visible := False;
  ImgSelecionarFunc.Visible := False;
  ImgSelecionarCli.Visible := False;
  ButtonIniciarVenda.Visible := False;
  PanelAdicionar.Visible := True;
  if DBLCLiente.Text = ' Cliente padrão' then
    begin
      CliPadrao := True;
    end
  else CliPadrao := False;
end;

procedure TForm_Venda.EditProdutoQtdClick(Sender: TObject);
begin
  EditProdutoQtd.Text:= '';
end;

procedure TForm_Venda.FormCreate(Sender: TObject);
var
  largura : integer;
begin
  LabelQTD.Caption := '0';
  LabelValor.Caption := 'R$ 0,00';
  LabelItem.Caption := '';
  SelecionarFunc := False;
  SelecionarCli := False;
  SelecionarProd := False;
  SelecionarServ := False;
  EditProduto.Text := '';
  EditProdutoQtd.Text := '1';
  DBLServico.KeyValue := 0;
  Form_Venda.WindowState := wsMaximized;
  largura := DBGrid1.Width;
  ADOQueryItensVendaNOME.DisplayWidth := Round(largura * 0.2);
  PanelGerarVenda.Visible := True;
end;

procedure TForm_Venda.FormShow(Sender: TObject);
begin
  ADOQueryFuncionario.Close;
  ADOQueryFuncionario.Open;
  ADOQueryCliente.Close;
  ADOQueryCliente.Open;
  ADOQueryProduto.Close;
  ADOQueryProduto.Open;
  ADOQueryServico.Close;
  ADOQueryServico.Open;
end;

procedure TForm_Venda.ImgSelecionarCliClick(Sender: TObject);
begin
  SelecionarCli := True;

  Form_Venda.Hide;
  Form_Consu_Clientes.ShowModal;
  Form_Venda.Show;

  SelecionarCli := False;
end;

procedure TForm_Venda.ImgSelecionarFuncClick(Sender: TObject);
begin
  SelecionarFunc := True;

  Form_Venda.Hide;
  Form_Consu_Func.ShowModal;
  Form_Venda.Show;

  SelecionarFunc := False;
end;

procedure TForm_Venda.ImgSelecionarProdClick(Sender: TObject);
begin
  SelecionarProd := True;
  
  Form_Venda.Hide;
  Form_Consu_Produto.ShowModal;
  Form_Venda.Show;

  SelecionarProd := False;

end;

procedure TForm_Venda.ImgSelecionarServClick(Sender: TObject);
begin
  SelecionarServ := True;
  
  Form_Venda.Hide;
  Form_Consu_Servicos.ShowModal;
  Form_Venda.Show;

  SelecionarServ := False;
end;

procedure TForm_Venda.ButtonInserirClick(Sender: TObject);
var
  Virgula, s : string;
  inteiro : Boolean;
  i : Integer;
begin
  if CodUltVenda = 0 then
    begin
      Application.MessageBox('Inicie uma venda!','Salão da Laura', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
  if ButtonIniciarVenda.Enabled = TRue then
    begin
      Application.MessageBox('Inicie uma venda!','Salão da Laura', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

  if DBLServico.KeyValue > 0 then
    begin
      BtnServicoClick(Sender);
    end
  else
    BtnProdutoClick(Sender);

  DBLServico.KeyValue := 0;
  EditProduto.Text := '';
  LabelQTD.Caption := IntToStr(ADOQueryItensVenda.RecordCount);
  ADOQueryItensVenda.Last;
  LabelValor.Caption := 'R$ ' + FormatFloat('###0.00', Abs(ADOQueryValorVALOR.AsFloat));

  {
  inteiro := True;

  for i := 0 to Length(LabelValor.Caption) do
    begin
      s := Copy(LabelValor.Caption, i, 1);
      if s = ',' then
        begin
          inteiro := False;
        end;
    end;

  if inteiro = True then
    begin
      LabelValor.Caption := LabelValor.Caption + ',00';
    end
  else
    begin
      Virgula := Copy(LabelValor.Caption, Length(LabelValor.Caption) - 2, 1);
      if Virgula <> ',' then
        begin
          LabelValor.Caption := LabelValor.Caption + '0';
        end;
    end;
  }

end;

procedure TForm_Venda.ButtonInserirMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonInserirMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Venda.ButtonRemoverClick(Sender: TObject);
begin
  if ADOQueryItensVenda.RecordCount > 0 then
    begin
      Button4Click(Sender);
    end;
end;

procedure TForm_Venda.ButtonRemoverMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonRemoverMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Venda.ButtonSairClick(Sender: TObject);
begin
  if PanelAdicionar.Visible = True then
    begin
      if Application.MessageBox('Realmente deseja sair e cancelar a venda?', 'Sair', MB_ICONQUESTION + MB_YESNO +
                                 MB_DEFBUTTON1) = ID_YES then
        begin
          if ADOQueryItensVenda.RecordCount > 0 then
            begin
              Button5Click(Sender);
            end;
          Form_Venda.Close;
        end;
    end
  else Form_Venda.Close;

end;

procedure TForm_Venda.ButtonSairMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonSairMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Venda.DataSourceItensVendaDataChange(Sender: TObject;
  Field: TField);
begin
  LabelItem.Caption := DBGrid1.Columns[0].Field.AsString;
end;

procedure TForm_Venda.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DataSourceItensVenda.DataSet.RecNo)then
        begin
          DBGrid1.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid1.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_Venda.ButtonIniciarVendaClick(Sender: TObject);
begin
  BtnGVendaClick(Sender);
  ButtonIniciarVenda.Enabled := False;
end;

procedure TForm_Venda.ButtonIniciarVendaMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style :=   TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Venda.ButtonIniciarVendaMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style :=   TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

end.
