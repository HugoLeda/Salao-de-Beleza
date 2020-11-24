unit U_Cadastro_Servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Samples.Spin;

type
  TForm_Cadastro_Servicos = class(TForm)
    Image1: TImage;
    ButtonNovo: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonLimpar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    EditNome: TEdit;
    edvalortotal: TEdit;
    EditDescricao: TEdit;
    EditDuracao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Label6: TLabel;
    Image3: TImage;
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditDescricaoChange(Sender: TObject);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cadastro_Servicos: TForm_Cadastro_Servicos;

implementation

{$R *.dfm}

function SomenteNumero(str : string) : string;
var
    x : integer;
begin
    Result := '';
    for x := 0 to Length(str) - 1 do
        if (str.Chars[x] In ['0'..'9']) then
            Result := Result + str.Chars[x];
end;

function DeleteChar(const Ch: Char; const S: string): string;
var
  Posicao: integer;
begin
  Result := S;
  Posicao := Pos(Ch, Result);
  while Posicao > 0 do
    begin
      Delete(Result, Posicao, 1);
      Posicao := Pos(Ch, Result);
    end;
end;

procedure TForm_Cadastro_Servicos.ButtonLimparClick(Sender: TObject);
begin
  EditNome.Text := '';
  edvalortotal.Text := '';
  EditDescricao.Text := '';
  EditDuracao.Text := '';
  Label5.Caption := '0/500';
  EditNome.SetFocus;
end;

procedure TForm_Cadastro_Servicos.ButtonNovoClick(Sender: TObject);
begin
  ButtonLimparClick(Sender);
  ButtonSalvar.Enabled := True;
  ButtonNovo.Enabled := False;
end;

procedure TForm_Cadastro_Servicos.ButtonSairClick(Sender: TObject);
begin
  if (EditNome.Text <> '') or (edvalortotal.Text <> '') or (EditDescricao.Text <> '') or (EditDuracao.Text <> '') then
    begin
      if Application.MessageBox('Deseja sair?','Sair',mb_iconquestion + MB_YESNO + mb_defbutton1) = id_yes then
        begin
          ButtonLimparClick(Sender);
          Form_Cadastro_Servicos.Close;
        end;
    end
  else Form_Cadastro_Servicos.Close;
end;

procedure TForm_Cadastro_Servicos.ButtonSalvarClick(Sender: TObject);
begin

  DeleteChar('.', edvalortotal.Text);
  DeleteChar('R', edvalortotal.Text);
  DeleteChar('$', edvalortotal.Text);

  if (EditNome.Text <> '') and (edvalortotal.Text <> '') and (EditDescricao.Text <> '') and (EditDuracao.Text <> '') then
    begin
      ADOQuery1.Parameters.ParamByName('NOME').Value := EditNome.Text;
      ADOQuery1.Parameters.ParamByName('PRECO').Value := edvalortotal.Text;
      ADOQuery1.Parameters.ParamByName('DURACAO').Value := EditDuracao.Text;
      ADOQuery1.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
      ADOQuery1.ExecSQL;
      Application.MessageBox(PChar(EditNome.Text + ' foi cadastrado com sucesso!'), PChar('Cadastro de serviço'), MB_OK + MB_ICONINFORMATION);
      ButtonSalvar.Enabled := False;
      ButtonNovo.Enabled := True;
    end
  else
   begin
     Application.MessageBox('Preencha todos os campos', 'Erro', MB_OK + MB_ICONERROR);
   end;
end;

procedure TForm_Cadastro_Servicos.EditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(EditDescricao.text);
  Label5.Caption := inttostr(qtdcaracteres)+'\500';
end;

procedure TForm_Cadastro_Servicos.edvalortotalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s: String;
begin
  if (Key in [96..107]) or (Key in [48..57]) then
     begin
      S := edValorTotal.Text;
      S := StringReplace(S,',','',[rfReplaceAll]);
      S := StringReplace(S,'.','',[rfReplaceAll]);
      if Length(s) = 3 then
        begin
          s := Copy(s,1,1)+','+Copy(S,2,15);
          edValorTotal.Text := S;
          edValorTotal.SelStart := Length(S);
        end
      else
        if (Length(s) > 3) and (Length(s) < 6) then
          begin
            s := Copy(s,1,length(s)-2)+','+Copy(S,length(s)-1,15);
            edValorTotal.Text := s;
            edValorTotal.SelStart := Length(S);
          end
        else
          if (Length(s) >= 6) and (Length(s) < 9) then
            begin
              s := Copy(s,1,length(s)-5)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
              edValorTotal.Text := s;
              edValorTotal.SelStart := Length(S);
            end
          else
            if (Length(s) >= 9) and (Length(s) < 12) then
              begin
                s := Copy(s,1,length(s)-8)+'.'+Copy(s,length(s)-7,3)+'.'+
                       Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                edValorTotal.Text := s;
                edValorTotal.SelStart := Length(S);
              end
            else
              if (Length(s) >= 12) and (Length(s) < 15)  then
                begin
                  s := Copy(s,1,length(s)-11)+'.'+Copy(s,length(s)-10,3)+'.'+
                          Copy(s,length(s)-7,3)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                  edValorTotal.Text := s;
                  edValorTotal.SelStart := Length(S);
                end;
      end;
end;


procedure TForm_Cadastro_Servicos.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
  ButtonSalvar.Enabled := True;
end;

end.
