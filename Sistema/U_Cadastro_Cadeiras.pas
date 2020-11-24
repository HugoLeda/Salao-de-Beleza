unit U_Cadastro_Cadeiras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TForm_Cadastro_Cadeiras = class(TForm)
    Image1: TImage;
    ADOConnection1: TADOConnection;
    ButtonNovo: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ADOQuery1: TADOQuery;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Label4: TLabel;
    Image3: TImage;
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Cadeiras: TForm_Cadastro_Cadeiras;

implementation

{$R *.dfm}

procedure TForm_Cadastro_Cadeiras.ButtonLimparClick(Sender: TObject);
begin
  Edit1.text := '';
  Edit2.text := '';
  Label3.Caption := '0/500';
  Edit1.SetFocus;
end;

procedure TForm_Cadastro_Cadeiras.ButtonNovoClick(Sender: TObject);
begin
  ButtonSalvar.Enabled := True;
  ButtonNovo.Enabled := False;
  ButtonLimparClick(Sender);
end;

procedure TForm_Cadastro_Cadeiras.ButtonSairClick(Sender: TObject);
begin
  if (Edit1.Text <> '') or (Edit2.Text <> '') then
    begin
      if Application.MessageBox('Deseja sair?','Sair', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = id_yes then
        begin
          Form_Cadastro_Cadeiras.Close;
        end;
    end
  else Form_Cadastro_Cadeiras.Close;

end;

procedure TForm_Cadastro_Cadeiras.ButtonSalvarClick(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then
    begin
      ADOQuery1.Parameters.ParamByName('TIPO').Value := Edit1.Text;
      ADOQuery1.Parameters.ParamByName('DESCRICAO').Value := Edit2.Text;
      ADOQuery1.ExecSQL;
      Application.MessageBox('Cadastro concluído com sucesso!','Cadastro', MB_OK + MB_ICONINFORMATION);
      ButtonSalvar.Enabled := False;
      ButtonNovo.Enabled := True;
    end
  else
    begin
      Application.MessageBox('Preencha todos os campos','Alerta', MB_OK + MB_ICONINFORMATION);
    end;

end;

procedure TForm_Cadastro_Cadeiras.Edit2Change(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(Edit2.text);
  Label3.Caption := inttostr(qtdcaracteres)+'\500';
end;

procedure TForm_Cadastro_Cadeiras.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
  ButtonSalvar.Enabled := True;
end;

end.
