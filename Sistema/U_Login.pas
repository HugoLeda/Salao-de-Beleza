unit U_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Data.DB, Data.Win.ADODB, Vcl.Buttons, IdBaseComponent,
  IdNetworkCalculator;

type
  TForm_Login = class(TForm)
    Fundo: TImage;
    Edit_Usuario: TEdit;
    Edit_Senha: TEdit;
    Button_Login: TButton;
    Olho_Fechado: TImage;
    Label1: TLabel;
    ADOConnection: TADOConnection;
    ADOQueryVerificaUsu: TADOQuery;
    ADOQueryVerificaUsuCODIGO: TAutoIncField;
    ADOQueryVerificaUsuLOGINUSU: TStringField;
    ADOQueryVerificaUsuSENHA: TStringField;
    ADOQueryVerificaUsuFUNCIONARIO: TIntegerField;
    ADOQueryVerificaUsuSUPERUSU: TBooleanField;
    ADOQueryVerificaSenha: TADOQuery;
    Label2: TLabel;
    ADOQueryVerificaSenhaCODIGO: TAutoIncField;
    ADOQueryVerificaSenhaLOGINUSU: TStringField;
    ADOQueryVerificaSenhaSENHA: TStringField;
    ADOQueryVerificaSenhaFUNCIONARIO: TIntegerField;
    ADOQueryVerificaSenhaSUPERUSU: TBooleanField;
    Olho_Aberto: TImage;
    AUsuario: TLabel;
    Senha: TLabel;
    SpeedButton1: TSpeedButton;
    ImUsu: TImage;
    ImSenha: TImage;
    procedure Olho_FechadoClick(Sender: TObject);
    procedure Olho_AbertoClick(Sender: TObject);
    procedure Button_LoginClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Edit_SenhaChange(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Edit_SenhaKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImUsuClick(Sender: TObject);
    procedure ImSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Login: TForm_Login;

implementation

{$R *.dfm}

uses U_Principal, U_RecuperarSenha;

procedure SetMainForm(NovoMainForm: TForm);
var
  TmpMain: ^TCustomForm;
begin
  TmpMain := @Application.Mainform;
  TmpMain^ := NovoMainForm;
end;

procedure TForm_Login.Button_LoginClick(Sender: TObject);
var
  senha : string;
  i : integer;
begin

  ADOQueryVerificaUsu.Close;
  ADOQueryVerificaUsu.Parameters.ParamByName('LOGINUSU').Value := Edit_Usuario.Text;
  ADOQueryVerificaUsu.Open;

  senha := Edit_Senha.Text;

  //testa se o usuário é válido
  if ADOQueryVerificaUsu.RecordCount > 0 then
    begin

      ADOQueryVerificaSenha.Close;
      ADOQueryVerificaSenha.Parameters.ParamByName('SENHA').Value := Edit_Senha.Text;
      ADOQueryVerificaSenha.Parameters.ParamByName('LOGINUSU').Value := ADOQueryVerificaUsuLOGINUSU.AsString;
      ADOQueryVerificaSenha.Open;

      ////testa a senha
      if (ADOQueryVerificaSenha.RecordCount > 0) then
        begin
          {Form_Login.Enabled := False;
          Form_Login.Height := 1;
          Form_Login.Width := 1;}
          if ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
            begin
              //Form_Principal.MainMenu1.Items[1].Enabled := False;
              //Form_Principal.MainMenu1.Items[4].Enabled := False;
              for i := 0 to 14 do
                begin
                  Form_Principal.MainMenu1.Items[1].Items[i].Enabled := False;
                end;
              Form_Principal.MainMenu1.Items[1].Items[2].Enabled := True;
              Form_Principal.MainMenu1.Items[2].Items[6].Enabled := False;
              Form_Principal.MainMenu1.Items[2].Items[14].Enabled := False;
              Form_Principal.MainMenu1.Items[6].Enabled := False;
              Form_Principal.MainMenu1.Items[7].Enabled := False;
              Form_Principal.ImgUsuarios.Enabled := False;
              Form_Principal.ImgUsuarios.Hint := 'Apenas um super usuário tem acesso a esse recurso';
              Form_Principal.ImgUsuarios.ShowHint := True;
              Form_Principal.ImgFuncionario.Enabled := False;
              Form_Principal.ImgFuncionario.Hint := 'Apenas um super usuário tem acesso a esse recurso';
              Form_Principal.ImgFuncionario.ShowHint := True;
              Form_Principal.PMRelatorios.Destroy;
            end;
          Form_Login.Hide;
          Form_Principal.ShowModal;
          Form_Login.Close;
        end
      else
        begin
          Application.MessageBox('Senha incorreta!','Alerta', MB_OK + MB_ICONWARNING);
          Label1.Visible := False;
          Label2.Visible := True;
        end;
    end
  else
    begin
      Application.MessageBox('Usuário não encontrado!','Alerta', MB_OK + MB_ICONWARNING);
    end;

end;

procedure TForm_Login.Edit_SenhaChange(Sender: TObject);
begin
  Edit_Senha.PasswordChar:='*';
end;

procedure TForm_Login.Edit_SenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Button_LoginClick(Sender);
    end;
end;

procedure TForm_Login.ImSenhaClick(Sender: TObject);
begin
  Edit_Senha.SetFocus;
end;

procedure TForm_Login.ImUsuClick(Sender: TObject);
begin
  Edit_Usuario.SetFocus;
end;

procedure TForm_Login.Label1Click(Sender: TObject);
begin
  Form_RecuperarSenha.ShowModal;
end;

procedure TForm_Login.Label2Click(Sender: TObject);
begin
  Form_RecuperarSenha.ShowModal;
  Form_RecuperarSenha.Edit_Senha.PasswordChar := '*';
  Label1.Visible := True;
  Label2.Visible := False;
end;

procedure TForm_Login.Olho_AbertoClick(Sender: TObject);
begin
  Olho_Fechado.Visible := True;
  Olho_Aberto.Visible := False;

  Edit_Senha.PasswordChar:=#0;
end;

procedure TForm_Login.Olho_FechadoClick(Sender: TObject);
begin
  Olho_Fechado.Visible := False;
  Olho_Aberto.Visible := True;

  Edit_Senha.PasswordChar:='*';

end;

procedure TForm_Login.SpeedButton1Click(Sender: TObject);
begin
  Button_LoginClick(Sender);
end;

end.
