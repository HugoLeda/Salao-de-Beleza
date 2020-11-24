program Project1;

uses
  Vcl.Forms,
  U_Login in 'U_Login.pas' {Form_Login},
  U_Principal in 'U_Principal.pas' {Form_Principal},
  U_RecuperarSenha in 'U_RecuperarSenha.pas' {Form_RecuperarSenha},
  U_Cadastro_Usuario in 'U_Cadastro_Usuario.pas' {Form_Cadastro_Usu},
  U_FormataEdit in 'U_FormataEdit.pas',
  U_Cadastro_Clientes in 'U_Cadastro_Clientes.pas' {Form_Cadastro_Clientes},
  U_Cadastro_Funcionarios in 'U_Cadastro_Funcionarios.pas' {Form_Cadastro_Funcionario},
  U_Cadastro_Produto in 'U_Cadastro_Produto.pas' {Form_Cadastro_Produto},
  U_Consu_Servicos in 'U_Consu_Servicos.pas' {Form_Consu_Servicos},
  U_Cadastro_Cadeiras in 'U_Cadastro_Cadeiras.pas' {Form_Cadastro_Cadeiras},
  U_Cadastro_Fornecedores in 'U_Cadastro_Fornecedores.pas' {Form_Cadastro_Fornecedores},
  U_Cadastro_Servicos in 'U_Cadastro_Servicos.pas' {Form_Cadastro_Servicos},
  DateTimePicker.Interposer in 'DateTimePicker.Interposer.pas',
  U_Agendar_Servico in 'U_Agendar_Servico.pas' {Form_Agendar_Servico},
  U_Consu_Cadeiras in 'U_Consu_Cadeiras.pas' {Form_Consu_Cadeiras},
  U_Consu_Funcionarios in 'U_Consu_Funcionarios.pas' {Form_Consu_Func},
  U_Consu_Usuarios in 'U_Consu_Usuarios.pas' {Form_Consu_Usuarios},
  U_Consu_Produto in 'U_Consu_Produto.pas' {Form_Consu_Produto},
  U_Consu_Fornecedores in 'U_Consu_Fornecedores.pas' {Form_Consu_Fornecedores},
  U_Consu_Clientes in 'U_Consu_Clientes.pas' {Form_Consu_Clientes},
  Unit_Cadastro_Materiais in 'Unit_Cadastro_Materiais.pas' {Form_Cadastro_Materiais},
  U_Consu_Materiais in 'U_Consu_Materiais.pas' {Form_Consu_Materiais},
  U_MovimentacoesEstoque in 'U_MovimentacoesEstoque.pas' {Form_Movimentacoes_Estoque},
  U_Loading in 'U_Loading.pas' {Form_Loading},
  U_Splash in 'U_Splash.pas' {Form_Splash},
  U_Caixa in 'U_Caixa.pas' {Form_AbrirCaixa},
  U_MoviCaixa in 'U_MoviCaixa.pas' {Form_MoviCaixa},
  U_Backup in 'U_Backup.pas' {Form_Backup},
  U_Consu_Carnes in 'U_Consu_Carnes.pas' {Form_BaseConsu},
  U_Venda in 'U_Venda.pas' {Form_Venda},
  U_BaixaCarnê in 'U_BaixaCarnê.pas' {FormBaixaCarne},
  U_Pagamento in 'U_Pagamento.pas' {FormPagamento},
  U_ConsuVenda in 'U_ConsuVenda.pas' {Form_Consu_Venda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Salão da Laura';
  Application.CreateForm(TForm_Splash, Form_Splash);
  Application.Run;
end.
