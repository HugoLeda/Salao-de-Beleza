unit U_RecuperarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls,SHELLAPI;

type
  TForm_RecuperarSenha = class(TForm)
    Fundo: TImage;
    Button_RecuperarSenha: TButton;
    Button_AlterarSenha: TButton;
    ADOConnection: TADOConnection;
    ADOQueryVeriSenha: TADOQuery;
    ADOQueryVeriSuperUsu: TADOQuery;
    Edit_Usuario: TEdit;
    OlhoAberto: TImage;
    OlhoFechado: TImage;
    ADOQueryVeriSuperUsuCODIGO: TAutoIncField;
    ADOQueryVeriSuperUsuLOGINUSU: TStringField;
    ADOQueryVeriSuperUsuSENHA: TStringField;
    ADOQueryVeriSuperUsuFUNCIONARIO: TIntegerField;
    ADOQueryVeriSuperUsuSUPERUSU: TBooleanField;
    ADOQueryVeriSenhaCODIGO: TAutoIncField;
    ADOQueryVeriSenhaLOGINUSU: TStringField;
    ADOQueryVeriSenhaSENHA: TStringField;
    ADOQueryVeriSenhaFUNCIONARIO: TIntegerField;
    ADOQueryVeriSenhaSUPERUSU: TBooleanField;
    ADOQueryCarregaApenas: TADOQuery;
    ADOQueryNome: TADOQuery;
    ADOQueryNomeCodigo: TAutoIncField;
    ADOQueryNomeNome: TStringField;
    ADOQueryNomeD_NASC: TWideStringField;
    ADOQueryNomeRG: TStringField;
    ADOQueryNomeCPF: TStringField;
    ADOQueryNomeENDERECO: TStringField;
    ADOQueryNomeSALARIO: TBCDField;
    ButtonConfirmar: TButton;
    Senha_Recuperada: TMemo;
    Image_Senha: TImage;
    Mensagem: TLabel;
    Button_Cancelar: TButton;
    LabelC: TLabel;
    OlhoAberto2: TImage;
    OlhoFechado2: TImage;
    ADOQueryAtualizarSenha: TADOQuery;
    ADOQueryCarregaApenas2: TADOQuery;
    ADOQueryNome2: TADOQuery;
    ADOQueryCarregaApenas2CODIGO: TAutoIncField;
    ADOQueryCarregaApenas2LOGINUSU: TStringField;
    ADOQueryCarregaApenas2SENHA: TStringField;
    ADOQueryCarregaApenas2FUNCIONARIO: TIntegerField;
    ADOQueryCarregaApenas2SUPERUSU: TBooleanField;
    ADOQueryNome2Codigo: TAutoIncField;
    ADOQueryNome2Nome: TStringField;
    ADOQueryNome2D_NASC: TWideStringField;
    ADOQueryNome2RG: TStringField;
    ADOQueryNome2CPF: TStringField;
    ADOQueryNome2ENDERECO: TStringField;
    ADOQueryNome2SALARIO: TBCDField;
    DataSourceGrid: TDataSource;
    ADOQueryGrid: TADOQuery;
    ADOQueryGridNomedofuncionário: TStringField;
    ADOQueryGridLogindeusuário: TStringField;
    ADOQueryGridCPF: TStringField;
    Titulo: TLabel;
    Formulario: TImage;
    DBGrid1: TDBGrid;
    Usuario: TLabel;
    Senha: TLabel;
    ConfirmaGrid: TButton;
    ADOQueryGridCODIGO: TAutoIncField;
    Edit_Senha: TEdit;
    Button_Abrir: TButton;
    ADOQueryCarregaApenasLOGINUSU: TStringField;
    ADOQueryCarregaApenasFUNCIONARIO: TIntegerField;
    ADOQueryCarregaApenasSENHA: TStringField;
    procedure OlhoAbertoClick(Sender: TObject);
    procedure OlhoFechadoClick(Sender: TObject);
    procedure Button_AlterarSenhaClick(Sender: TObject);
    procedure Button_RecuperarSenhaClick(Sender: TObject);
    procedure ButtonConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_CancelarClick(Sender: TObject);
    procedure OlhoAberto2Click(Sender: TObject);
    procedure OlhoFechado2Click(Sender: TObject);
    procedure ConfirmaGridClick(Sender: TObject);
    procedure Button_AbrirClick(Sender: TObject);
    //procedure Edit_UsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    a : Integer;
  end;

var
  Form_RecuperarSenha: TForm_RecuperarSenha;

implementation

{$R *.dfm}

procedure TForm_RecuperarSenha.ButtonConfirmarClick(Sender: TObject);
begin
  if (Edit_Usuario.Text = Edit_Senha.Text) and (Edit_Usuario.Text <> '') then
    begin
      //atualiza o banco com a nova senha
      ADOQueryAtualizarSenha.Parameters.ParamByName('CODIGO').Value := ADOQueryCarregaApenas2CODIGO.AsInteger;
      ADOQueryAtualizarSenha.Parameters.ParamByName('SENHA').Value := Edit_Senha.Text;
      ADOQueryAtualizarSenha.ExecSQL;

      Mensagem.Left := Mensagem.Left - 15;
      Mensagem.Top := Mensagem.Top + 25;
      Mensagem.Caption := 'Senha alterada com suceso!';
      Mensagem.Visible := True;
      ButtonConfirmar.Enabled := False;
      Button_Cancelar.Caption := 'Voltar';
    end
  else if (Edit_Usuario.Text = Edit_Senha.Text) and (Edit_Usuario.Text = '') then
    begin
      Application.MessageBox('Senha inválida!','Erro', MB_OK + MB_ICONERROR);
    end
  else
    begin
      Application.MessageBox('As senhas não correspondem!', 'Alerta', MB_OK + MB_ICONWARNING);
      Button_Cancelar.Caption := 'Cancelar';
    end;

end;

procedure TForm_RecuperarSenha.Button_AbrirClick(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar('SENHA_RECUPERADA\Recuperação de senha.txt'), '','',SW_SHOWNORMAL);
end;

procedure TForm_RecuperarSenha.Button_AlterarSenhaClick(Sender: TObject);
var
  login_desejado_recuperar : string;
  login_desejado_recuperar2 : string;
  qtd_login_encontrado : Integer;
begin
  Button_RecuperarSenha.Visible := False;
  Button_AlterarSenha.Visible := False;
  ButtonConfirmar.Visible := True;
  ButtonConfirmar.Enabled := False;
  Button_Cancelar.Caption := 'Cancelar';
  Button_Cancelar.Visible := True;

  ADOQueryVeriSuperUsu.Close;
  ADOQueryVeriSuperUsu.Parameters.ParamByName('LOGINUSU').Value := Edit_Usuario.Text;
  ADOQueryVeriSuperUsu.Open;

  if ADOQueryVeriSuperUsu.RecordCount > 0 then
    begin
      ADOQueryVeriSenha.Close;
      ADOQueryVeriSenha.Parameters.ParamByName('SENHA').Value := Edit_Senha.Text;
      ADOQueryVeriSenha.Parameters.ParamByName('LOGINUSU').Value := ADOQueryVeriSuperUsuLOGINUSU.AsString;
      ADOQueryVeriSenha.Open;

      if ADOQueryVeriSenha.RecordCount > 0 then
        begin
          if ADOQueryVeriSuperUsuSUPERUSU.AsBoolean = True then
            begin

              login_desejado_recuperar := InputBox(' ','Entre com o nome ou login do usuário: ', '');
              login_desejado_recuperar2 := login_desejado_recuperar;

              ADOQueryCarregaApenas2.Close;
              ADOQueryNome2.Close;

              ADOQueryCarregaApenas2.Parameters.ParamByName('LOGINUSU').Value := login_desejado_recuperar;
              ADOQueryNome2.Parameters.ParamByName('NOME').Value := login_desejado_recuperar;

              ADOQueryCarregaApenas2.Open;
              ADOQueryNome2.Open;
              {if (ADOQueryCarregaApenas.Locate('LOGINUSU', login_desejado_recuperar,[])) or
                 (ADOQueryNome.Locate('NOME',login_desejado_recuperar2,[] )) then}
              if (ADOQueryCarregaApenas2.RecordCount > 0) or (ADOQueryNome2.RecordCount > 0) then

                begin
                  //qtd_login_encontrado := ADOQueryNome2.RecordCount;
                  qtd_login_encontrado := ADOQueryCarregaApenas2.RecordCount;
                  qtd_login_encontrado := qtd_login_encontrado + ADOQueryNome2.RecordCount;
                  //parei aqui
                  if qtd_login_encontrado >= 2 then
                    begin
                      ADOQueryGrid.Close;
                      ADOQueryGrid.Parameters.ParamByName('Nome').Value := login_desejado_recuperar;
                      ADOQueryGrid.Open;

                      DBGrid1.Visible := True;
                      ButtonConfirmar.Visible := False;
                      ConfirmaGrid.Visible := True;
                    end
                  else if qtd_login_encontrado = 1 then
                    begin
                      Application.MessageBox('Digite e confirme a nova senha.','Informação', MB_OK + MB_ICONINFORMATION);
                      Image_Senha.Visible := True;
                      OlhoAberto2.Visible := True;
                      //prepara o edit_usuario para receber a nova senha
                      Edit_Usuario.Width := 174;
                      Edit_Usuario.PasswordChar := '*';
                      Edit_Usuario.Text := ('');
                      Edit_Senha.Text := '';
                      Usuario.Caption := 'Nova senha';

                      Button_Cancelar.Caption := 'Cancelar';
                      Button_Cancelar.Visible := True;
                      ButtonConfirmar.Enabled := True;

                    end
                  else
                    begin
                      Application.MessageBox('Nome ou usuário não encontrado!','Erro', MB_OK + MB_ICONERROR);
                    end;
                end
              else
                begin
                  Application.MessageBox('Nome ou usuário não encontrado!','Erro', MB_OK + MB_ICONERROR);
                  ButtonConfirmar.Visible := False;
                  Button_RecuperarSenha.Visible := True;
                  Button_AlterarSenha.Visible := True;
                end;
            end
          else
            begin
              Application.MessageBox('Somente um super usuário pode realizar essa ação','Informação', MB_OK + MB_ICONINFORMATION);
              ButtonConfirmar.Visible := False;
              Button_Cancelar.Visible := False;
              Button_RecuperarSenha.Visible := True;
              Button_AlterarSenha.Visible := True;
            end;
        end
      else
        begin
          Application.MessageBox('Senha incorreta!','Erro',MB_OK + MB_ICONERROR);
          ButtonConfirmar.Visible := False;
          Button_Cancelar.Visible := False;
          Button_RecuperarSenha.Visible := True;
          Button_AlterarSenha.Visible := True;
        end;
    end
  else
    begin
      Application.MessageBox('Usuário inválido!','Erro', MB_OK + MB_ICONERROR);
      ButtonConfirmar.Visible := False;
      Button_Cancelar.Visible := False;
      Button_RecuperarSenha.Visible := True;
      Button_AlterarSenha.Visible := True;
    end;
end;

procedure TForm_RecuperarSenha.Button_CancelarClick(Sender: TObject);
begin
  Form_RecuperarSenha.Close;
end;

procedure TForm_RecuperarSenha.Button_RecuperarSenhaClick(Sender: TObject);
var
  login_desejado_recuperar : string;
  login_desejado_recuperar2 : string;
  qtd_login_encontrado : integer;
begin
  Button_RecuperarSenha.Visible := False;
  Button_AlterarSenha.Visible := False;
  ButtonConfirmar.Visible := True;
  ButtonConfirmar.Enabled := False;
  Button_Cancelar.Caption := 'Cancelar';
  Button_Cancelar.Visible := True;

  ADOQueryVeriSuperUsu.Close;
  ADOQueryVeriSuperUsu.Parameters.ParamByName('LOGINUSU').Value := Edit_Usuario.Text;
  ADOQueryVeriSuperUsu.Open;

  if ADOQueryVeriSuperUsu.RecordCount > 0 then
    begin
      ADOQueryVeriSenha.Close;
      ADOQueryVeriSenha.Parameters.ParamByName('SENHA').Value := Edit_Senha.Text;
      ADOQueryVeriSenha.Parameters.ParamByName('LOGINUSU').Value := ADOQueryVeriSuperUsuLOGINUSU.AsString;
      ADOQueryVeriSenha.Open;

      if ADOQueryVeriSenha.RecordCount > 0 then
        begin
          if ADOQueryVeriSuperUsuSUPERUSU.AsBoolean = True then
            begin

              login_desejado_recuperar := InputBox(' ','Entre com o nome ou login do usuário: ', '');
              login_desejado_recuperar2 := login_desejado_recuperar;

              ADOQueryCarregaApenas2.Close;
              ADOQueryNome2.Close;

              ADOQueryCarregaApenas2.Parameters.ParamByName('LOGINUSU').Value := login_desejado_recuperar;
              ADOQueryNome2.Parameters.ParamByName('NOME').Value := login_desejado_recuperar;

              ADOQueryCarregaApenas2.Open;
              ADOQueryNome2.Open;
              {if (ADOQueryCarregaApenas.Locate('LOGINUSU', login_desejado_recuperar,[])) or
                 (ADOQueryNome.Locate('NOME',login_desejado_recuperar2,[] )) then}
              if (ADOQueryCarregaApenas2.RecordCount > 0) or (ADOQueryNome2.RecordCount > 0) then
                begin

                  qtd_login_encontrado := ADOQueryNome2.RecordCount;
                  qtd_login_encontrado := qtd_login_encontrado + ADOQueryCarregaApenas2.RecordCount;

                  if qtd_login_encontrado >= 2 then
                    begin

                      ADOQueryGrid.Close;
                      ADOQueryGrid.Parameters.ParamByName('Nome').Value := login_desejado_recuperar;
                      ADOQueryGrid.Open;

                      DBGrid1.Visible := True;
                      ButtonConfirmar.Visible := False;
                      ConfirmaGrid.Visible := True;
                      a := 1;
                    end
                  else if qtd_login_encontrado = 1 then
                    begin
                      if ADOQueryCarregaApenas2.RecordCount = 1 then
                        begin
                          Senha_Recuperada.Lines.Add( 'Usuário: ' + ADOQueryCarregaApenas2LOGINUSU.AsString );
                          Senha_Recuperada.Lines.Add( 'Senha: ' + ADOQueryCarregaApenas2Senha.AsString );
                        end
                      else
                        begin
                          ADOQueryCarregaApenas.Close;
                          ADOQueryCarregaApenas.Parameters.ParamByName('NOME').Value := login_desejado_recuperar;
                          ADOQueryCarregaApenas.Open;
                          Senha_Recuperada.Lines.Add( 'Usuário: ' + ADOQueryCarregaApenasLOGINUSU.AsString );
                          Senha_Recuperada.Lines.Add( 'Senha: ' + ADOQueryCarregaApenasSenha.AsString );
                        end;
                      Senha_Recuperada.Lines.SaveToFile( 'SENHA_RECUPERADA\Recuperação de senha.txt');
                      Senha_Recuperada.Lines.Clear;
                      Mensagem.Font.Size := 8;
                      Mensagem.Caption := 'Senha recuperada em:';
                      Mensagem.Visible := True;
                      LabelC.Caption := 'Recuperação de senha.txt';
                      LabelC.Visible := True;
                      Button_Cancelar.Caption := 'Voltar';
                      Button_Cancelar.Visible := True;
                      Button_Abrir.Visible := True;
                    end
                  else
                    begin
                      Application.MessageBox('Nome ou usuário não encontrado!','Erro', MB_OK + MB_ICONERROR);
                    end;
                end
              else
                begin
                  Application.MessageBox('Nome ou usuário não encontrado!','Erro', MB_OK + MB_ICONERROR);
                  ButtonConfirmar.Visible := False;
                  Button_Cancelar.Visible := False;
                  Button_RecuperarSenha.Visible := True;
                  Button_AlterarSenha.Visible := True;
                end;
            end
          else
            begin
              Application.MessageBox('Somente um super usuário pode realizar essa ação','Informação', MB_OK + MB_ICONINFORMATION);
              ButtonConfirmar.Visible := False;
              Button_Cancelar.Visible := False;
              Button_RecuperarSenha.Visible := True;
              Button_AlterarSenha.Visible := True;
            end;
        end
      else
        begin
          Application.MessageBox('Senha incorreta!','Erro',MB_OK + MB_ICONERROR);
          ButtonConfirmar.Visible := False;
          Button_Cancelar.Visible := False;
          Button_RecuperarSenha.Visible := True;
          Button_AlterarSenha.Visible := True;
        end;
    end
  else
    begin
      Application.MessageBox('Usuário inválido!','Erro', MB_OK + MB_ICONERROR);
      ButtonConfirmar.Visible := False;
      Button_Cancelar.Visible := False;
      Button_RecuperarSenha.Visible := True;
      Button_AlterarSenha.Visible := True;
    end;
end;

procedure TForm_RecuperarSenha.ConfirmaGridClick(Sender: TObject);
var
  usu_selecionado, nome_selecionado, local : string;
begin

  usu_selecionado := dbgrid1.Columns[1].Field.AsString; //Pega o código do usuário na linha selecionada
  nome_selecionado := dbgrid1.Columns[3].Field.AsString; //Pega o nome do usuário na linha selecionada
  DBGrid1.Visible := False;

  //prepara o formulario para digitar e confirmar a nova senha
  if a = 1 then
    begin
      Senha_Recuperada.Lines.Clear;
      Senha_Recuperada.Lines.Add( 'Usuário: ' + ADOQueryCarregaApenas2LOGINUSU.AsString );
      Senha_Recuperada.Lines.Add( 'Senha: ' + ADOQueryCarregaApenas2Senha.AsString );
      Senha_Recuperada.Lines.SaveToFile( 'SENHA_RECUPERADA\Recuperação de senha.txt');
      Senha_Recuperada.Lines.Clear;

      Mensagem.Font.Size := 8;
      Mensagem.Caption := 'Senha recuperada em:';
      Mensagem.Visible := True;
      local := ExtractFilePath(Application.ExeName);
      LabelC.Caption := local;
      LabelC.Visible := True;
      Button_Cancelar.Caption := 'Voltar';
      Button_Cancelar.Visible := True;
      Button_Abrir.Visible := True;
    end
  else
    begin
      Image_Senha.Visible := True;
      OlhoAberto2.Visible := True;
      OlhoAberto.Visible := True;
      OlhoFechado.Visible := False;

      Edit_Usuario.Width := 174;
      Edit_Usuario.PasswordChar := '*';
      Edit_Usuario.Text := ('');
      Edit_Senha.Text := '';
      Edit_Usuario.PasswordChar := '*';
      Edit_Senha.PasswordChar := '*';
      Usuario.Caption := 'Nova senha';
      Senha.Caption := 'Confirme a senha';

      Button_Cancelar.Caption := 'Cancelar';
      Button_Cancelar.Visible := True;
      ButtonConfirmar.Enabled := True;
      ButtonConfirmar.Visible := True;
      ConfirmaGrid.Visible := False;
      Application.MessageBox(PChar('Digite e confirme a nova senha para ' + usu_selecionado), PChar('Informação'), MB_OK +MB_ICONINFORMATION);
    end;

end;

{*procedure TForm_RecuperarSenha.Edit_UsuarioClick(Sender: TObject);
begin
  if Usuario.Caption <> 'Login do superusuário' then
    begin
      Edit_Usuario.PasswordChar := '*';
    end;

end;*}

procedure TForm_RecuperarSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //deixa o from preparada para ser acessado dnv
  Form_RecuperarSenha.Button_RecuperarSenha.Visible := True;
  Form_RecuperarSenha.Button_AlterarSenha.Visible := True;
  Form_RecuperarSenha.OlhoAberto.Visible := True;
  Form_RecuperarSenha.ButtonConfirmar.Visible := False;
  Form_RecuperarSenha.Button_Cancelar.Visible := False;
  Form_RecuperarSenha.Button_Abrir.Visible := False;
  Form_RecuperarSenha.ConfirmaGrid.Visible := False;
  Form_RecuperarSenha.Image_Senha.Visible := False;
  Form_RecuperarSenha.OlhoFechado.Visible := False;
  Mensagem.Visible := False;
  LabelC.Visible := False;
  DBGrid1.Visible := False;
  Edit_Usuario.Text := '';
  Edit_Usuario.Width := 201;
  Edit_Usuario.PasswordChar := #0;
  Edit_Senha.Text := '';
  Edit_Senha.PasswordChar := '*';
  Usuario.Caption := 'Login do superusuário';
  Senha.Caption := 'Senha';

end;

procedure TForm_RecuperarSenha.OlhoAberto2Click(Sender: TObject);
begin
  OlhoAberto2.Visible := False;
  OlhoFechado2.Visible := True;
  Edit_Usuario.PasswordChar := #0;
end;

procedure TForm_RecuperarSenha.OlhoAbertoClick(Sender: TObject);
begin
  OlhoAberto.Visible := False;
  OlhoFechado.Visible := True;
  Edit_Senha.PasswordChar := #0;
end;

procedure TForm_RecuperarSenha.OlhoFechado2Click(Sender: TObject);
begin
  OlhoAberto2.Visible := True;
  OlhoFechado2.Visible := False;
  Edit_Usuario.PasswordChar := '*';
end;

procedure TForm_RecuperarSenha.OlhoFechadoClick(Sender: TObject);
begin
  OlhoAberto.Visible := True;
  OlhoFechado.Visible := False;
  Edit_Senha.PasswordChar := '*';
end;

end.
