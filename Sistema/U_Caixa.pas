unit U_Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Data.Win.ADODB;

type
  TForm_AbrirCaixa = class(TForm)
    edvalortotal: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ADOQueryAbrirCaixa: TADOQuery;
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    CodCaixa : Integer;
    ValorCaixa : Float64;
    { Public declarations }
  end;

var
  Form_AbrirCaixa: TForm_AbrirCaixa;

implementation

{$R *.dfm}

uses U_Principal, U_Login;

procedure TForm_AbrirCaixa.edvalortotalKeyUp(Sender: TObject; var Key: Word;
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

procedure TForm_AbrirCaixa.FormShow(Sender: TObject);
begin
  edvalortotal.Text := '';
end;

procedure TForm_AbrirCaixa.SpeedButton1Click(Sender: TObject);
begin
  Form_AbrirCaixa.Close;
end;

procedure TForm_AbrirCaixa.SpeedButton2Click(Sender: TObject);
begin
  if edvalortotal.Text = '' then
    begin
      Application.MessageBox('Preencha o valor!','Erro', MB_OK + MB_ICONERROR);
      Exit;
    end;
  ValorCaixa := StrToFloat(edvalortotal.Text);
  if ValorCaixa < 0 then
    begin
      Application.MessageBox('Valor inválido!','Erro',MB_OK + MB_ICONERROR);
      Exit;
    end;
  ADOQueryAbrirCaixa.Close;
  ADOQueryAbrirCaixa.Parameters.ParamByName('VALOR').Value := ValorCaixa;
  ADOQueryAbrirCaixa.Parameters.ParamByName('VALOR2').Value := ValorCaixa;
  ADOQueryAbrirCaixa.Parameters.ParamByName('USU').Value := Form_Login.ADOQueryVerificaUsuCODIGO.AsInteger;
  ADOQueryAbrirCaixa.Parameters.ParamByName('ULT').Value;
  ADOQueryAbrirCaixa.ExecSQL;
  CodCaixa := ADOQueryAbrirCaixa.Parameters.ParamByName('ULT').Value;
  Form_Principal.ButtonAbrirCaixa.Visible := False;
  Form_AbrirCaixa.Close;
end;

end.
