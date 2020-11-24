unit U_Cadastro_Usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Datasnap.DBClient, Vcl.Buttons, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, U_FormataEdit, Vcl.Imaging.pngimage;

type
  TForm_Cadastro_Usu = class(TForm)
    ADOConnection: TADOConnection;
    ADOQueryFuncionarios: TADOQuery;
    ADOQueryFuncionariosNome: TStringField;
    ADOQueryFuncionariosCodigo: TAutoIncField;
    ADOQueryFuncionariosD_NASC: TWideStringField;
    ADOQueryFuncionariosRG: TStringField;
    ADOQueryFuncionariosCPF: TStringField;
    ADOQueryFuncionariosENDERECO: TStringField;
    ADOQueryFuncionariosSALARIO: TBCDField;
    Image1: TImage;
    Novo: TSpeedButton;
    Limpar: TSpeedButton;
    Confirmar: TSpeedButton;
    CheckBox1: TCheckBox;
    OlhoAberto: TImage;
    OlhoFechado: TImage;
    OlhoFechado2: TImage;
    OlhoAberto2: TImage;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    LabelEdi: TLabel;
    Label1: TLabel;
    ADOQueryVerifica: TADOQuery;
    ADOQueryverificaLogin: TADOQuery;
    Sair: TSpeedButton;
    LabeledEdit1: TEdit;
    LabeledEdit2: TEdit;
    LabeledEdit3: TEdit;
    LabeledEdit4: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    ADOQueryUsuarios: TADOQuery;
    Image3: TImage;
    DBLFunc: TDBLookupComboBox;
    ADOFuncioarios: TADOQuery;
    ADOFuncioariosCODIGO: TAutoIncField;
    ADOFuncioariosNOME: TStringField;
    ADOFuncioariosTELEFONE: TStringField;
    ADOFuncioariosD_NASC: TWideStringField;
    ADOFuncioariosSEXO: TStringField;
    ADOFuncioariosRG: TStringField;
    ADOFuncioariosCPF: TStringField;
    ADOFuncioariosCIDADE: TIntegerField;
    ADOFuncioariosESTADO: TIntegerField;
    ADOFuncioariosENDERECO: TStringField;
    ADOFuncioariosBAIRRO: TStringField;
    ADOFuncioariosSALARIO: TBCDField;
    ADOFuncioariosCARGO: TStringField;
    ADOFuncioariosDATA_CADASTRO: TWideStringField;
    ADOFuncioariosDATA_ULT_MODIFICACAO: TWideStringField;
    ADOFuncioariosDISPONIVEL: TBooleanField;
    DataSourceFunc: TDataSource;
    procedure LimparClick(Sender: TObject);
    procedure NovoClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
    procedure OlhoAbertoClick(Sender: TObject);
    procedure OlhoFechadoClick(Sender: TObject);
    procedure OlhoAberto2Click(Sender: TObject);
    procedure OlhoFechado2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Usu: TForm_Cadastro_Usu;

implementation

{$R *.dfm}

//uses U_FormataEdit;


{ TForm_Cadastro_Usu }

procedure TForm_Cadastro_Usu.LimparClick(Sender: TObject);
begin
  LabeledEdit1.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  Edit1.Visible := False;
  LabelEdi.Visible := False;
  CheckBox1.Checked := False;
  CheckBox2.Checked := False;
  OlhoAberto.Visible := True;
  OlhoAberto2.Visible := True;
  OlhoFechado.Visible := False;
  OlhoFechado2.Visible := False;
  LabeledEdit3.PasswordChar := '*';
  LabeledEdit4.PasswordChar := '*';
  DBLFunc.SetFocus;
  DBLFunc.KeyValue := 0;
end;

procedure TForm_Cadastro_Usu.CheckBox2Click(Sender: TObject);
begin
  LabeledEdit1.Text := '';
  Edit1.Text := '';
  if CheckBox2.Checked = True then
    begin
      {Label2.Visible := False;
      LabeledEdit1.Visible := False;
      Edit1.Visible := True;
      LabelEdi.Visible := True;}
      DBLFunc.ListField := 'CPF';
    end
  else
    begin
      {Label2.Visible := True;
      LabeledEdit1.Visible := True;
      Edit1.Visible := False;
      LabelEdi.Visible := False;}
      DBLFunc.ListField := 'NOME';
    end;
end;

procedure TForm_Cadastro_Usu.ConfirmarClick(Sender: TObject);
var
  CodFunc, SuperUsu : Integer;
  Msg : string;
begin
  if CheckBox1.Checked then
    begin
      SuperUsu := 1;
    end
  else
    begin
      SuperUsu := 0;
    end;

  {ADOQueryFuncionarios.Close;
  ADOQueryFuncionarios.Parameters.ParamByName('NOME').Value := LabeledEdit1.Text;
  ADOQueryFuncionarios.Parameters.ParamByName('CPF').Value := Edit1.Text;
  ADOQueryFuncionarios.Open;}
  CodFunc := DBLFunc.KeyValue;
  if CodFunc >= 1 then
    begin
      ADOQueryVerifica.Close;
      ADOQueryVerifica.Parameters.ParamByName('CODFUNC').Value := CodFunc;
      ADOQueryVerifica.Open;
      if ADOQueryVerifica.RecordCount = 0 then
        begin
          ADOQueryverificaLogin.Close;
          ADOQueryverificaLogin.Parameters.ParamByName('LOGINUSU').Value := LabeledEdit2.Text;
          ADOQueryverificaLogin.Open;
          if ((ADOQueryverificaLogin.RecordCount = 0) and (LabeledEdit3.Text <> '')) then
            begin
              if (LabeledEdit3.Text = LabeledEdit4.Text) and (LabeledEdit3.Text <> '' ) then
                begin
                  ADOQueryUsuarios.Parameters.ParamByName('LOGINUSU').Value := LabeledEdit2.Text;
                  ADOQueryUsuarios.Parameters.ParamByName('SENHA').Value := LabeledEdit3.Text;
                  ADOQueryUsuarios.Parameters.ParamByName('FUNCIONARIO').Value := CodFunc;
                  ADOQueryUsuarios.Parameters.ParamByName('SUPERUSU').Value := SuperUsu;
                  ADOQueryUsuarios.ExecSQL;
                  Msg := 'Cadastro realizado com sucesso!'+#13+#13+'Login: '+LabeledEdit2.Text+#13+'Senha: '+LabeledEdit3.Text;
                  Application.MessageBox(PChar(Msg), PChar ('Cadastro de usuário'), MB_OK);
                  Confirmar.Enabled := False;
                  Novo.Enabled := True;
                end
              else Application.MessageBox('As senhas não correspondem!','Erro', MB_OK + MB_ICONERROR);
            end
          else Application.MessageBox('Login indisponível ou inválido.', 'Erro', MB_OK + MB_ICONERROR);
        end
      else Application.MessageBox('O funcionário já possui um login.', 'Erro', MB_OK + MB_ICONERROR);
    end
  else Application.MessageBox('Erro ao selecionar funcionário.','Erro', MB_OK + MB_ICONINFORMATION);
end;

procedure TForm_Cadastro_Usu.FormShow(Sender: TObject);
begin
  ADOFuncioarios.Close;
  ADOFuncioarios.Open;
  LimparClick(Sender);
  Confirmar.Enabled := True;
end;

procedure TForm_Cadastro_Usu.NovoClick(Sender: TObject);
begin
  LimparClick(Sender);
  Confirmar.Enabled := True;
  Novo.Enabled := False;
end;

procedure TForm_Cadastro_Usu.OlhoAbertoClick(Sender: TObject);
begin
  OlhoAberto.Visible := False;
  OlhoFechado.Visible := True;
  LabeledEdit3.PasswordChar := #0;
end;

procedure TForm_Cadastro_Usu.OlhoFechadoClick(Sender: TObject);
begin
  OlhoAberto.Visible := True;
  OlhoFechado.Visible := False;
  LabeledEdit3.PasswordChar := '*';
end;

procedure TForm_Cadastro_Usu.SairClick(Sender: TObject);
begin
  Form_Cadastro_Usu.Close;
end;

procedure TForm_Cadastro_Usu.OlhoAberto2Click(Sender: TObject);
begin
  OlhoAberto2.Visible := False;
  OlhoFechado2.Visible := True;
  LabeledEdit4.PasswordChar := #0;
end;

procedure TForm_Cadastro_Usu.OlhoFechado2Click(Sender: TObject);
begin
  OlhoAberto2.Visible := True;
  OlhoFechado2.Visible := False;
  LabeledEdit4.PasswordChar := '*';
end;

end.
