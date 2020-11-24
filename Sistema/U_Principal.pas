unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, frxClass, frxExportBaseDialog,
  frxExportPDF, frxDBSet, SHELLAPI;

type
  TForm_Principal = class(TForm)
    MainMenu1: TMainMenu;
    Sair1: TMenuItem;
    Financeiro1: TMenuItem;
    Reservas1: TMenuItem;
    Relatrios1: TMenuItem;
    ActionList1: TActionList;
    CadastroUsuario: TAction;
    Usurios1: TMenuItem;
    Clientes1: TMenuItem;
    CadastroCliene: TAction;
    Produtos2: TMenuItem;
    Fornecedores1: TMenuItem;
    Servios1: TMenuItem;
    caixa1: TMenuItem;
    Estoque1: TMenuItem;
    CadastroFuncionario: TAction;
    Cadeiras1: TMenuItem;
    CadastroServico: TAction;
    CadastroCadeiras: TAction;
    CadastroProdutos: TAction;
    CadastroFornecedores: TAction;
    Backup1: TMenuItem;
    ConsuCadeiras: TAction;
    ConsuServico: TAction;
    ConsuFunc: TAction;
    ConsuUsuarios: TAction;
    PanelBotoes: TPanel;
    PanelDireita: TPanel;
    ConsuProduto: TAction;
    ConsuFornecedores: TAction;
    ConsuClientes: TAction;
    ConsuMateriais: TAction;
    Materiais1: TMenuItem;
    Estoque: TAction;
    ImgRelatorios: TImage;
    ImgCaixa: TImage;
    ImgFinanceiro: TImage;
    ImgSair: TImage;
    ImgMateriais: TImage;
    ImgFuncionario: TImage;
    ImgFornecedores: TImage;
    ImgClientes: TImage;
    ImgCadeira: TImage;
    ImgEstoque: TImage;
    Splitter1: TSplitter;
    ImgProdutos: TImage;
    ImgServicos: TImage;
    ImgUsuarios: TImage;
    ImgBackup: TImage;
    ScrollBox1: TScrollBox;
    SplitterTopo: TSplitter;
    PanelData: TPanel;
    PanelBarra: TPanel;
    PanelUsuLogado: TPanel;
    PanelBarra2: TPanel;
    PanelCaixa: TPanel;
    Panel8: TPanel;
    PMCadeira: TPopupMenu;
    Consulta1: TMenuItem;
    Cadastro1: TMenuItem;
    N1: TMenuItem;
    Cadastros1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Consultas1: TMenuItem;
    ConsuCadeiras1: TMenuItem;
    N9: TMenuItem;
    ConsuClientes1: TMenuItem;
    N10: TMenuItem;
    ConsuFornecedores1: TMenuItem;
    N11: TMenuItem;
    ConsuFunc1: TMenuItem;
    N13: TMenuItem;
    ConsuMateriais1: TMenuItem;
    N14: TMenuItem;
    ConsuProduto1: TMenuItem;
    N15: TMenuItem;
    ConsuServico1: TMenuItem;
    N16: TMenuItem;
    ConsuUsuarios1: TMenuItem;
    CadastroMateriais: TAction;
    Consultarestoque1: TMenuItem;
    N17: TMenuItem;
    Registrarmovimentao1: TMenuItem;
    Produtos1: TMenuItem;
    Materiaisdetrabalho1: TMenuItem;
    N19: TMenuItem;
    MovimentacoesEstoque: TAction;
    PMClientes: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PMEstoque: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PMFornecedores: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PMFuncionarios: TPopupMenu;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    PMMateriais: TPopupMenu;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    PMServicos: TPopupMenu;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    PMProdutos: TPopupMenu;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    PMUsuarios: TPopupMenu;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    ButtonAbrirMenu: TButton;
    ButtonFecharMenu: TButton;
    Timer1: TTimer;
    Calendario: TImage;
    LabelData: TLabel;
    LabelHora: TLabel;
    PanelIconesData: TPanel;
    Hora: TImage;
    PanelUser: TPanel;
    IconUser: TImage;
    PanelGrids: TPanel;
    Agendamento: TAction;
    ImgAgendamento: TImage;
    Agendamento1: TMenuItem;
    LabelUsu: TLabel;
    PanelOpcoes: TPanel;
    PanelEstoque: TPanel;
    RelProduto: TAction;
    RelMateriais: TAction;
    RelMovimentacoes: TAction;
    PMRelatorios: TPopupMenu;
    Produtos3: TMenuItem;
    Materiais2: TMenuItem;
    N20: TMenuItem;
    Movimentaesdeestoque1: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    Movimentaesdeestoque2: TMenuItem;
    ImageCaixa: TImage;
    ButtonAbrirCaixa: TSpeedButton;
    ADOConnection1: TADOConnection;
    LabelValorCaixa: TLabel;
    ImageFecharMenu: TImage;
    ImageAbrirMenu: TImage;
    ImageEstoque: TImage;
    PanelMenu: TPanel;
    LabelEstoque: TLabel;
    PanelMateriais: TPanel;
    PanelProdutos: TPanel;
    LabelMateriais: TLabel;
    LabelProdutos: TLabel;
    Panel1: TPanel;
    ImageConfiguracao: TImage;
    LabelConfiguracao: TLabel;
    ButtonFecharCaixa: TSpeedButton;
    ButtonAgendamentos: TSpeedButton;
    ButtonMoviCaixa: TSpeedButton;
    Image1: TImage;
    DBGridAgendamentosGrid: TDBGrid;
    DBGridEntradasCaixa: TDBGrid;
    LabelAgendamentosDia: TLabel;
    LabelEntradasCaixa: TLabel;
    LabelSaidasCaixa: TLabel;
    DBGridSaidasCaixa: TDBGrid;
    ADOQueryAgendamentosDia: TADOQuery;
    DataSourceAgendamentos: TDataSource;
    ADOQueryAgendamentosDiaCODAGENDAMENTO: TAutoIncField;
    ADOQueryAgendamentosDiaDIA: TWideStringField;
    ADOQueryAgendamentosDiaDATA: TStringField;
    ADOQueryAgendamentosDiaHORA: TWideStringField;
    ADOQueryAgendamentosDiaHORARIO: TStringField;
    ADOQueryAgendamentosDiaNOME: TStringField;
    ADOQueryAgendamentosDiaPRECO: TBCDField;
    ADOQueryAgendamentosDiaDURACAO: TIntegerField;
    ADOQueryAgendamentosDiaCODFUNC: TAutoIncField;
    ADOQueryAgendamentosDiaFUNC: TStringField;
    ADOQueryAgendamentosDiaCODCLI: TAutoIncField;
    ADOQueryAgendamentosDiaCLI: TStringField;
    ADOQueryAgendamentosDiaCODCADEIRA: TAutoIncField;
    ADOQueryAgendamentosDiaCADEIRA: TStringField;
    ADOQueryVerificaCaixa: TADOQuery;
    ADOQueryVerificaCaixaCODIGO: TAutoIncField;
    ADOQueryVerificaCaixaDATA_ABERTURA: TWideStringField;
    ADOQueryVerificaCaixaHORA_ABERTURA: TWideStringField;
    ADOQueryVerificaCaixaVALOR_ABERTURA: TBCDField;
    ADOQueryVerificaCaixaDATA_FECHAMENTO: TWideStringField;
    ADOQueryVerificaCaixaHORA_FECHAMENTO: TWideStringField;
    ADOQueryVerificaCaixaVALOR_CAIXA: TBCDField;
    ADOQueryVerificaCaixaUSUARIO: TIntegerField;
    ADOQueryFecharCaixa: TADOQuery;
    ADOQueryEntradasCaixa: TADOQuery;
    ADOQuerySaidasCaixa: TADOQuery;
    DataSourceEntradas: TDataSource;
    DataSourceSaidas: TDataSource;
    ADOQueryEntradasCaixaDIA: TStringField;
    ADOQueryEntradasCaixaHORA: TStringField;
    ADOQueryEntradasCaixaCODIGO: TAutoIncField;
    ADOQueryEntradasCaixaCAIXA: TIntegerField;
    ADOQueryEntradasCaixaDATA: TDateTimeField;
    ADOQueryEntradasCaixaVALOR: TBCDField;
    ADOQueryEntradasCaixaDESCRICAO: TStringField;
    ADOQuerySaidasCaixaDIA: TStringField;
    ADOQuerySaidasCaixaHORA: TStringField;
    ADOQuerySaidasCaixaCODIGO: TAutoIncField;
    ADOQuerySaidasCaixaCAIXA: TIntegerField;
    ADOQuerySaidasCaixaDATA: TDateTimeField;
    ADOQuerySaidasCaixaVALOR: TBCDField;
    ADOQuerySaidasCaixaDESCRICAO: TStringField;
    ButtonRegistrarMovimentacoes: TSpeedButton;
    ScrollBoxGrids: TScrollBox;
    ADOQueryVeriEstoque: TADOQuery;
    ADOQueryVeriEstoqueCODIGO: TAutoIncField;
    ADOQueryVeriEstoquePRODUTO: TIntegerField;
    ADOQueryVeriEstoqueDATA_VALIDADE: TWideStringField;
    ADOQueryVeriEstoqueQTD: TIntegerField;
    ADOQueryVeriEstoqueQTD_ALERTA: TIntegerField;
    ADOQueryVeriMateriais: TADOQuery;
    ADOQueryVeriMateriaisQTD_DISPONIVEL: TIntegerField;
    ADOQueryVeriMateriaisQTD_ALERTA: TIntegerField;
    Backup: TAction;
    DataSourceCaixa: TDataSource;
    Venda: TAction;
    frxPDFExport1: TfrxPDFExport;
    Relatorio: TfrxReport;
    DBCaixa: TfrxDBDataset;
    DBEntradas: TfrxDBDataset;
    DBSaidas: TfrxDBDataset;
    ADOQueryCaixaa: TADOQuery;
    ADOQueryCaixaaDIA: TStringField;
    ADOQueryCaixaaHORA: TStringField;
    ADOQueryCaixaaHORA_1: TStringField;
    ADOQueryCaixaaHORA_2: TStringField;
    ADOQueryCaixaaVALOR_ABERTURA: TBCDField;
    ADOQueryCaixaaVALOR_CAIXA: TBCDField;
    ADOQueryCaixaaLOGINUSU: TStringField;
    ADOQueryCaixaaCODIGO: TAutoIncField;
    Financeiro: TAction;
    ConsuVenda: TAction;
    PMFinanceiro: TPopupMenu;
    Financeiro2: TMenuItem;
    N12: TMenuItem;
    HistricodeVendas1: TMenuItem;
    Carns1: TMenuItem;
    N18: TMenuItem;
    HistricodeVendas2: TMenuItem;
    ADOQueryVendaEntrada: TADOQuery;
    ButtonMoviparaFechar: TButton;
    ADOQueryVendaSaida: TADOQuery;
    ImgManual: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure CadastroUsuarioExecute(Sender: TObject);
    procedure CadastroClieneExecute(Sender: TObject);
    procedure CadastroFuncionarioExecute(Sender: TObject);
    procedure CadastroServicoExecute(Sender: TObject);
    procedure CadastroCadeirasExecute(Sender: TObject);
    procedure CadastroProdutosExecute(Sender: TObject);
    procedure CadastroFornecedoresExecute(Sender: TObject);
    procedure ConsuCadeirasExecute(Sender: TObject);
    procedure ConsuServicoExecute(Sender: TObject);
    procedure ConsuFuncExecute(Sender: TObject);
    procedure ConsuUsuariosExecute(Sender: TObject);
    procedure ConsuProdutoExecute(Sender: TObject);
    procedure ConsuFornecedoresExecute(Sender: TObject);
    procedure ConsuClientesExecute(Sender: TObject);
    procedure ConsuMateriaisExecute(Sender: TObject);
    procedure EstoqueExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CadastroMateriaisExecute(Sender: TObject);
    procedure MovimentacoesEstoqueExecute(Sender: TObject);
    procedure ButtonAbrirMenuClick(Sender: TObject);
    procedure ButtonFecharMenuClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AgendamentoExecute(Sender: TObject);
    procedure RelProdutoExecute(Sender: TObject);
    procedure RelMateriaisExecute(Sender: TObject);
    procedure RelMovimentacoesExecute(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImageFecharMenuClick(Sender: TObject);
    procedure ImageAbrirMenuClick(Sender: TObject);
    procedure LabelMateriaisClick(Sender: TObject);
    procedure LabelProdutosClick(Sender: TObject);
    procedure ButtonAgendamentosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridAgendamentosGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ButtonAbrirCaixaClick(Sender: TObject);
    procedure ButtonFecharCaixaClick(Sender: TObject);
    procedure ButtonMoviCaixaClick(Sender: TObject);
    procedure DBGridEntradasCaixaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridSaidasCaixaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ButtonRegistrarMovimentacoesClick(Sender: TObject);
    procedure BackupExecute(Sender: TObject);
    procedure ButtonRegistrarMovimentacoesMouseEnter(Sender: TObject);
    procedure ButtonRegistrarMovimentacoesMouseLeave(Sender: TObject);
    procedure ButtonAgendamentosMouseLeave(Sender: TObject);
    procedure ButtonAgendamentosMouseEnter(Sender: TObject);
    procedure ButtonMoviCaixaMouseEnter(Sender: TObject);
    procedure ButtonMoviCaixaMouseLeave(Sender: TObject);
    procedure ButtonFecharCaixaMouseLeave(Sender: TObject);
    procedure ButtonFecharCaixaMouseEnter(Sender: TObject);
    procedure LabelMateriaisMouseLeave(Sender: TObject);
    procedure LabelMateriaisMouseEnter(Sender: TObject);
    procedure LabelProdutosMouseEnter(Sender: TObject);
    procedure LabelProdutosMouseLeave(Sender: TObject);
    procedure VendaExecute(Sender: TObject);
    procedure FinanceiroExecute(Sender: TObject);
    procedure ADOQueryVerificaCaixaAfterOpen(DataSet: TDataSet);
    procedure ConsuVendaExecute(Sender: TObject);
    procedure Movimentaesdeestoque2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Usu, CodCaixa : Integer;
    SuperUsu : Boolean;
    ValorCaixa : Float64;
    ProdEmFalta : Boolean;
    Tabela : string;
  end;

var
  Form_Principal: TForm_Principal;

implementation

{$R *.dfm}

uses U_Login, U_Cadastro_Usuario, U_Cadastro_Clientes, U_Cadastro_Funcionarios,
  U_Cadastro_Servicos, U_Cadastro_Cadeiras, U_Cadastro_Produto,
  U_Cadastro_Fornecedores, U_Consu_Cadeiras, U_Consu_Servicos,
  U_Consu_Funcionarios, U_Consu_Usuarios, U_Consu_Produto, U_Consu_Fornecedores,
  U_Consu_Clientes, U_Consu_Materiais, U_Estoque, U_MovimentacoesEstoque,
  U_Splash, Unit_Cadastro_Materiais, U_Agendar_Servico, U_Caixa, U_MoviCaixa,
  U_Backup, U_Venda, U_BaixaCarnê, U_ConsuVenda;

procedure TForm_Principal.ConsuVendaExecute(Sender: TObject);
begin
  Form_Consu_Venda.ShowModal;
end;

procedure TForm_Principal.ADOQueryVerificaCaixaAfterOpen(DataSet: TDataSet);
begin
  ValorCaixa := ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat;
  LabelValorCaixa.Caption := 'R$ ' + FormatFloat('##0.00', Abs(ValorCaixa))
end;

procedure TForm_Principal.AgendamentoExecute(Sender: TObject);
begin
  Form_Agendar_Servico.ShowModal;
end;

procedure TForm_Principal.BackupExecute(Sender: TObject);
var
  local : string;
begin
  local := ExtractFilePath(Application.ExeName);
  local := local + 'Manual\Manual-do-Usuário.pdf';
  if FileExists(local) then
    begin
      ShellExecute(handle,'open',PChar(local), '','',SW_SHOWNORMAL);
    end
  else Application.MessageBox('O manual não foi encontrado!','Erro',MB_OK + MB_ICONERROR);
end;

procedure TForm_Principal.ButtonAbrirCaixaClick(Sender: TObject);
var
  Virgula : string;
begin
  Form_AbrirCaixa.ShowModal;
  CodCaixa := Form_AbrirCaixa.CodCaixa;
  ButtonAbrirCaixa.Visible := False;
  ADOQueryVerificaCaixa.Close;
  ADOQueryVerificaCaixa.Open;
  ADOQueryVerificaCaixa.First;
  if ADOQueryVerificaCaixaDATA_FECHAMENTO.Value = '' then
    begin
      CodCaixa := ADOQueryVerificaCaixaCODIGO.AsInteger;
      ButtonAbrirCaixa.Visible := False;
      LabelValorCaixa.Visible := True;
      ValorCaixa := ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat;
      LabelValorCaixa.Caption := 'R$ ' + FormatFloat('##0.00', Abs(ValorCaixa));

      {
      Virgula := Copy(LabelValorCaixa.Caption, Length(LabelValorCaixa.Caption) - 2, 1);
      if Virgula <> ',' then
        begin
          LabelValorCaixa.Caption := LabelValorCaixa.Caption + '0';
        end;
      }
    end;
  LabelValorCaixa.Visible := True;
  ButtonMoviCaixa.Visible := True;
  ButtonFecharCaixa.Visible := True;
end;

procedure TForm_Principal.ButtonAbrirMenuClick(Sender: TObject);
var
  i : integer;
begin

  for I := PanelDireita.Width to 310 do
    begin
      PanelDireita.Width := PanelDireita.Width + 1;
    end;

end;

procedure TForm_Principal.ButtonAgendamentosClick(Sender: TObject);
begin
  if DBGridAgendamentosGrid.Visible = False then
    begin
      LabelAgendamentosDia.Visible := True;
      DBGridAgendamentosGrid.Visible := True;
      ButtonAgendamentos.Caption := 'Ocultar Agendamentos';
    end
  else
    begin
      LabelAgendamentosDia.Visible := False;
      DBGridAgendamentosGrid.Visible := False;
      ButtonAgendamentos.Caption := 'Mostrar Agendamentos';
    end
end;

procedure TForm_Principal.ButtonAgendamentosMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.ButtonAgendamentosMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.ButtonFecharCaixaClick(Sender: TObject);
begin
  if Application.MessageBox('Realmente deseja fechar o caixa?','Fechar Caixa',
                             MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
    begin
      ADOQueryFecharCaixa.Close;
      ADOQueryFecharCaixa.Parameters.ParamByName('USU').Value := Usu;
      ADOQueryFecharCaixa.Parameters.ParamByName('COD').Value := CodCaixa;
      ADOQueryFecharCaixa.ExecSQL;
      if Application.MessageBox('Deseja gerar um relatório?','Caixa Fechado',
                                 MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          ADOQueryEntradasCaixa.Close;
          ADOQueryEntradasCaixa.Parameters.ParamByName('CODCAIXA').Value := CodCaixa;
          ADOQueryEntradasCaixa.Open;
          if ADOQueryEntradasCaixa.RecordCount < 1 then
            begin
              ADOQueryVendaEntrada.Close;
              ADOQueryVendaEntrada.Parameters.ParamByName('CAIXA').Value := CodCaixa;
              ADOQueryVendaEntrada.ExecSQL;
            end;
          ADOQuerySaidasCaixa.Close;
          ADOQuerySaidasCaixa.Parameters.ParamByName('CODCAIXA').Value := CodCaixa;
          ADOQuerySaidasCaixa.Open;
          if ADOQuerySaidasCaixa.RecordCount < 1 then
            begin
              ADOQueryVendaSaida.Close;
              ADOQueryVendaSaida.Parameters.ParamByName('CAIXA').Value := CodCaixa;
              ADOQueryVendaSaida.ExecSQL;
            end;
          ADOQueryCaixaa.Close;
          ADOQueryCaixaa.Parameters.ParamByName('COD').Value := CodCaixa;
          ADOQueryCaixaa.Open;
          ADOQueryEntradasCaixa.Close;
          ADOQueryEntradasCaixa.Open;
          ADOQuerySaidasCaixa.Close;
          ADOQuerySaidasCaixa.Open;
          Relatorio.ShowReport();
        end;
      ButtonMoviCaixa.Visible := False;
      ButtonFecharCaixa.Visible := False;
      ButtonAbrirCaixa.Visible := True;
      LabelValorCaixa.Visible := False;
      DBGridEntradasCaixa.Visible := True;
      ButtonMoviCaixaClick(Sender);
    end;

end;

procedure TForm_Principal.ButtonFecharCaixaMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.ButtonFecharCaixaMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.ButtonFecharMenuClick(Sender: TObject);
var
  i : integer;
begin
  for i := PanelDireita.Width downto 10 do
    begin
      PanelDireita.Width := PanelDireita.Width - 1;
    end;
end;

procedure TForm_Principal.ButtonMoviCaixaClick(Sender: TObject);
begin
  if DBGridEntradasCaixa.Visible = False then
    begin
      ADOQuerySaidasCaixa.Close;
      ADOQuerySaidasCaixa.Parameters.ParamByName('CODCAIXA').Value := CodCaixa;
      ADOQuerySaidasCaixa.Open;
      ADOQueryEntradasCaixa.Close;
      ADOQueryEntradasCaixa.Parameters.ParamByName('CODCAIXA').Value := CodCaixa;
      ADOQueryEntradasCaixa.Open;
      DBGridEntradasCaixa.Visible := True;
      DBGridSaidasCaixa.Visible := True;
      LabelEntradasCaixa.Visible := True;
      LabelSaidasCaixa.Visible := True;
      ButtonRegistrarMovimentacoes.Visible := True;
      ButtonMoviCaixa.Caption := 'Ocultar Movimentações de Caixa';
    end
  else
    begin
      DBGridEntradasCaixa.Visible := False;
      DBGridSaidasCaixa.Visible := False;
      ButtonRegistrarMovimentacoes.Visible := False;
      LabelEntradasCaixa.Visible := False;
      LabelSaidasCaixa.Visible := False;
      ButtonMoviCaixa.Caption := 'Exibir Movimentações de Caixa';
    end;
  ADOQueryVerificaCaixa.Close;
  ADOQueryVerificaCaixa.Open;
  LabelValorCaixa.Caption := 'R$ ' + FormatFloat('###0.00', Abs(ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat));
end;

procedure TForm_Principal.ButtonMoviCaixaMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.ButtonMoviCaixaMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.ButtonRegistrarMovimentacoesClick(Sender: TObject);
begin
  Form_MoviCaixa.ShowModal;
end;

procedure TForm_Principal.ButtonRegistrarMovimentacoesMouseEnter(
  Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style :=   TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.ButtonRegistrarMovimentacoesMouseLeave(
  Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.CadastroCadeirasExecute(Sender: TObject);
begin
  Form_Cadastro_Cadeiras.ShowModal;
end;

procedure TForm_Principal.CadastroClieneExecute(Sender: TObject);
begin
  Form_Cadastro_Clientes.ShowModal;
end;

procedure TForm_Principal.CadastroFornecedoresExecute(Sender: TObject);
begin
   Form_Cadastro_Fornecedores.ShowModal;
end;

procedure TForm_Principal.CadastroFuncionarioExecute(Sender: TObject);
begin
  Form_Cadastro_Funcionario.ShowModal;
end;

procedure TForm_Principal.CadastroMateriaisExecute(Sender: TObject);
begin
  Form_Cadastro_Materiais.ShowModal;
end;

procedure TForm_Principal.CadastroProdutosExecute(Sender: TObject);
begin
  Form_Cadastro_Produto.ShowModal;
end;

procedure TForm_Principal.CadastroServicoExecute(Sender: TObject);
begin
 Form_Cadastro_Servicos.ShowModal;
end;

procedure TForm_Principal.CadastroUsuarioExecute(Sender: TObject);
begin
   Form_Cadastro_Usu.ShowModal;
end;

procedure TForm_Principal.ConsuCadeirasExecute(Sender: TObject);
begin
  Form_Consu_Cadeiras.ShowModal;
end;

procedure TForm_Principal.ConsuClientesExecute(Sender: TObject);
begin
  Form_Consu_Clientes.ShowModal;
end;

procedure TForm_Principal.ConsuFornecedoresExecute(Sender: TObject);
begin
  Form_Consu_Fornecedores.ShowModal;
end;

procedure TForm_Principal.ConsuFuncExecute(Sender: TObject);
begin
  Form_Consu_Func.ShowModal;
end;

procedure TForm_Principal.ConsuMateriaisExecute(Sender: TObject);
begin
  Form_Consu_Materiais.ShowModal;
end;

procedure TForm_Principal.ConsuProdutoExecute(Sender: TObject);
begin
  Form_Consu_Produto.ShowModal;
end;

procedure TForm_Principal.ConsuServicoExecute(Sender: TObject);
begin
  Form_Consu_Servicos.ShowModal;
end;

procedure TForm_Principal.ConsuUsuariosExecute(Sender: TObject);
begin
  Form_Consu_Usuarios.ShowModal;
end;

procedure TForm_Principal.DBGridAgendamentosGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGridAgendamentosGrid do
    begin
      if Odd(DataSourceAgendamentos.DataSet.RecNo)then
        begin
          DBGridAgendamentosGrid.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGridAgendamentosGrid.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_Principal.DBGridEntradasCaixaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGridEntradasCaixa do
    begin
      if Odd(DataSourceEntradas.DataSet.RecNo)then
        begin
          DBGridEntradasCaixa.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGridEntradasCaixa.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_Principal.DBGridSaidasCaixaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGridSaidasCaixa do
    begin
      if Odd(DataSourceSaidas.DataSet.RecNo)then
        begin
          DBGridSaidasCaixa.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGridSaidasCaixa.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm_Principal.EstoqueExecute(Sender: TObject);
begin
  Form_Movimentacoes_Estoque.ShowModal;
end;

procedure TForm_Principal.FinanceiroExecute(Sender: TObject);
begin
  if ButtonAbrirCaixa.Visible = False then
    begin
      FormBaixaCarne.ShowModal;
    end
  else Application.MessageBox('É necessário que o caixa esteja aberto para realizar uma venda!','Salão da Laura',MB_OK + MB_ICONINFORMATION);
end;

procedure TForm_Principal.FormCreate(Sender: TObject);
begin
  Form_Principal.Hide;
  Form_Principal.WindowState := wsMaximized;
end;

procedure TForm_Principal.FormShow(Sender: TObject);
var
  Dia, Virgula, s : string;
  i : integer;
  inteiro : Boolean;
begin
  Dia := DateToStr(Date);
  ADOQueryAgendamentosDia.Close;
  ADOQueryAgendamentosDia.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryAgendamentosDia.Open;
  LabelUsu.Caption := 'Usuário: ' + Form_Login.ADOQueryVerificaUsuLOGINUSU.AsString;
  LabelValorCaixa.Visible := False;
  VertScrollBar.Position := 0;
  Usu := Form_Login.ADOQueryVerificaUsuCODIGO.AsInteger;
  SuperUsu := Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean;

  //Parte do caixa
  ADOQueryVerificaCaixa.Close;
  ADOQueryVerificaCaixa.Open;
  ADOQueryVerificaCaixa.First;
  if ADOQueryVerificaCaixaDATA_FECHAMENTO.Value = '' then
    begin
      CodCaixa := ADOQueryVerificaCaixaCODIGO.AsInteger;
      ButtonAbrirCaixa.Visible := False;
      LabelValorCaixa.Visible := True;
      ValorCaixa := ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat;
      LabelValorCaixa.Caption := 'R$ ' + FormatFloat('##0.00', Abs(ValorCaixa));
      {
      inteiro := True;
      for i := 0 to Length(LabelValorCaixa.Caption) do
        begin
          s := Copy(LabelValorCaixa.Caption, i, 1);
          if s = ',' then
            begin
              inteiro := False;
            end;
        end;

      if inteiro = True then
        begin
          LabelValorCaixa.Caption := LabelValorCaixa.Caption + ',00';
        end
      else
        begin
          Virgula := Copy(LabelValorCaixa.Caption, Length(LabelValorCaixa.Caption) - 2, 1);
          if Virgula <> ',' then
            begin
              LabelValorCaixa.Caption := LabelValorCaixa.Caption + '0';
            end;
        end;
      }

      ButtonMoviCaixa.Visible := True;
      ButtonFecharCaixa.Visible := True;
    end
  else
    begin
      ButtonAbrirCaixa.Visible := True;
      LabelValorCaixa.Visible := False;
      ButtonFecharCaixa.Visible := False;
      ButtonMoviCaixa.Visible := False;
    end;

  //Verifica se tem produto em falta
  ADOQueryVeriEstoque.Close;
  ADOQueryVeriEstoque.Open;
  if ADOQueryVeriEstoque.RecordCount > 0 then
    begin
      ProdEmFalta := True;
      PanelProdutos.Color := $00543C84;
      PanelProdutos.Hint := 'Produtos em falta!';
    end
  else
    begin
      PanelProdutos.Color := $00C7CBEE;
      ProdEmFalta := False;
      PanelProdutos.Hint := 'Estoque Bom!';
    end;

  //Verifica se tem materiais em falta
  ADOQueryVeriMateriais.Close;
  ADOQueryVeriMateriais.Open;
  if ADOQueryVeriMateriais.RecordCount > 0 then
    begin
      PanelMateriais.Color := $00543C84;
      PanelMateriais.Hint := 'Produtos em falta!';
    end
  else
    begin
      PanelMateriais.Color := $00C7CBEE;
      PanelMateriais.Hint := 'Estoque Bom!';
    end;
end;

procedure TForm_Principal.ImageAbrirMenuClick(Sender: TObject);
begin
  ImageAbrirMenu.Visible := False;
  ButtonAbrirMenuClick(Sender);
  ImageFecharMenu.Visible := True;
end;

procedure TForm_Principal.ImageFecharMenuClick(Sender: TObject);
begin
  ImageFecharMenu.Visible := False;
  ButtonFecharMenuClick(Sender);
  ImageAbrirMenu.Visible := True;
end;

procedure TForm_Principal.ImgSairClick(Sender: TObject);
begin
  if ButtonAbrirCaixa.Visible = False then
    begin
      if Application.MessageBox('O caixa está aberto, realmente deseja sair?', 'Sair', MB_ICONQUESTION + MB_YESNO
                             + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Principal.Close;
        end;
    end
  else if Application.MessageBox('Realmente deseja sair?', 'Sair', MB_ICONQUESTION + MB_YESNO
                             + MB_DEFBUTTON1) = ID_YES then
     begin
      Form_Principal.Close;
     end;
end;

procedure TForm_Principal.LabelMateriaisClick(Sender: TObject);
begin
  Form_Consu_Materiais.ShowModal;
end;

procedure TForm_Principal.LabelMateriaisMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.LabelMateriaisMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.LabelProdutosClick(Sender: TObject);
begin
  if ProdEmFalta = True then
    begin
      Form_Movimentacoes_Estoque.DataSource1.DataSet := Form_Movimentacoes_Estoque.ADOQueryEmFalta;
      Form_Movimentacoes_Estoque.ShowModal;
      Form_Movimentacoes_Estoque.DataSource1.DataSet := Form_Movimentacoes_Estoque.ADOQueryGrid;
    end
  else Form_Movimentacoes_Estoque.ShowModal;
end;

procedure TForm_Principal.LabelProdutosMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Principal.LabelProdutosMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Principal.MovimentacoesEstoqueExecute(Sender: TObject);
begin
  Form_Estoque.ShowModal;
end;

procedure TForm_Principal.Movimentaesdeestoque2Click(Sender: TObject);
begin
  Form_Movimentacoes_Estoque.FormShow(Sender);
  Form_Movimentacoes_Estoque.Relatorio.ShowReport();
end;

procedure TForm_Principal.RelMateriaisExecute(Sender: TObject);
begin
  Form_Consu_Materiais.Relatorio.ShowReport();
end;

procedure TForm_Principal.RelMovimentacoesExecute(Sender: TObject);
begin
  Form_Movimentacoes_Estoque.ADOQueryTodos.Close;
  Form_Movimentacoes_Estoque.ADOQueryTodos.Open;
  Form_Movimentacoes_Estoque.DataSource2.DataSet := Form_Movimentacoes_Estoque.ADOQueryTodos;
  Form_Movimentacoes_Estoque.Relatorio.ShowReport();
end;

procedure TForm_Principal.RelProdutoExecute(Sender: TObject);
begin
  Form_Consu_Produto.RelatorioProduto.ShowReport();
end;

procedure TForm_Principal.Sair1Click(Sender: TObject);
begin
  if Application.MessageBox('Realmente deseja fechar o sistema?', 'Salão da Laura', MB_YESNO + MB_DEFBUTTON1) = ID_YES then
     begin
      Form_Principal.Close;
     end;
end;


procedure TForm_Principal.Timer1Timer(Sender: TObject);
begin
  LabelData.Caption := 'Data: ' + DateToStr(Date);
  LabelHora.Caption := 'Hora: ' + TimeToStr(Time);
end;

procedure TForm_Principal.VendaExecute(Sender: TObject);
begin
  if ButtonAbrirCaixa.Visible = False then
    begin
      Form_Venda.ShowModal;
    end
  else Application.MessageBox('É necessário que o caixa esteja aberto para realizar uma venda!','Salão da Laura',MB_OK + MB_ICONINFORMATION);
end;

end.
