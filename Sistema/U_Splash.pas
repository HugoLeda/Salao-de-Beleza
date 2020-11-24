unit U_Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Samples.Gauges;

type
  TForm_Splash = class(TForm)
    Image1: TImage;
    Gauge1: TGauge;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Splash: TForm_Splash;

implementation

{$R *.dfm}

uses U_Login, U_Loading, U_Principal, U_RecuperarSenha, U_Cadastro_Usuario,
  U_Cadastro_Clientes, U_Cadastro_Funcionarios, U_Cadastro_Produto,
  U_Consu_Servicos, U_Cadastro_Cadeiras, U_Cadastro_Fornecedores,
  U_Cadastro_Servicos, U_Agendar_Servico, U_Consu_Cadeiras,
  U_Consu_Funcionarios, U_Consu_Usuarios, U_Consu_Produto, U_Consu_Fornecedores,
  U_Consu_Clientes, Unit_Cadastro_Materiais, U_Consu_Materiais, U_Estoque,
  U_MovimentacoesEstoque, U_Backup, U_BaixaCarnê, U_Caixa, U_Consu_Carnes,
  U_FormataEdit, U_MoviCaixa, U_Pagamento, U_Venda, U_ConsuVenda;

procedure SetMainForm(NovoMainForm: TForm);
var
  TmpMain: ^TCustomForm;
begin
  TmpMain := @Application.Mainform;
  TmpMain^ := NovoMainForm;
end;

procedure TForm_Splash.Timer1Timer(Sender: TObject);
begin
  Gauge1.Progress := Gauge1.Progress + 5;

  //Criação dos forms
  if Gauge1.Progress = 10 then
    begin
      //Cadastros
      Application.CreateForm(TForm_Cadastro_Usu, Form_Cadastro_Usu);
      Application.CreateForm(TForm_Cadastro_Clientes, Form_Cadastro_Clientes);
      Application.CreateForm(TForm_Cadastro_Funcionario, Form_Cadastro_Funcionario);
      Application.CreateForm(TForm_Cadastro_Produto, Form_Cadastro_Produto);
      Application.CreateForm(TForm_Consu_Servicos, Form_Consu_Servicos);
      Application.CreateForm(TForm_Cadastro_Cadeiras, Form_Cadastro_Cadeiras);
      Application.CreateForm(TForm_Cadastro_Fornecedores, Form_Cadastro_Fornecedores);
      Application.CreateForm(TForm_Cadastro_Servicos, Form_Cadastro_Servicos);
    end
  else if Gauge1.Progress = 30 then
    begin
      //Consultas
      Application.CreateForm(TForm_Consu_Cadeiras, Form_Consu_Cadeiras);
      Application.CreateForm(TForm_Consu_Func, Form_Consu_Func);
      Application.CreateForm(TForm_Consu_Usuarios, Form_Consu_Usuarios);
      Application.CreateForm(TForm_Consu_Produto, Form_Consu_Produto);
      Application.CreateForm(TForm_Consu_Fornecedores, Form_Consu_Fornecedores);
      Application.CreateForm(TForm_Consu_Clientes, Form_Consu_Clientes);
      Application.CreateForm(TForm_Cadastro_Materiais, Form_Cadastro_Materiais);
      Application.CreateForm(TForm_Consu_Materiais, Form_Consu_Materiais);
    end
  else if Gauge1.Progress = 50 then
    begin
      //Forms restantes
      Application.CreateForm(TForm_Loading, Form_Loading);
      Application.CreateForm(TForm_Principal, Form_Principal);
      Application.CreateForm(TForm_RecuperarSenha, Form_RecuperarSenha);
      Application.CreateForm(TForm_Agendar_Servico, Form_Agendar_Servico);
      Application.CreateForm(TForm_Estoque, Form_Estoque);
      Application.CreateForm(TForm_Movimentacoes_Estoque, Form_Movimentacoes_Estoque);
    end
  else if Gauge1.Progress = 80 then
    begin
      Application.CreateForm(TForm_AbrirCaixa, Form_AbrirCaixa);
      Application.CreateForm(TForm_MoviCaixa, Form_MoviCaixa);
      Application.CreateForm(TForm_Backup, Form_Backup);
      Application.CreateForm(TForm_BaseConsu, Form_BaseConsu);
      Application.CreateForm(TForm_Venda, Form_Venda);
      Application.CreateForm(TFormBaixaCarne, FormBaixaCarne);
      Application.CreateForm(TFormPagamento, FormPagamento);
      Application.CreateForm(TForm_Consu_Venda, Form_Consu_Venda);
    end;

  if Gauge1.Progress = 100 then
    begin
      Timer1.Enabled := False;
      Form_Splash.Width := 1;
      Form_Splash.Height := 1;
      Application.CreateForm(TForm_Login, Form_Login);
      SetMainForm(Form_Login);
      Form_Login.Show;
    end;


end;

end.
