unit U_MoviCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.DBCtrls, Data.Win.ADODB,
  Vcl.Imaging.pngimage, Vcl.Samples.Spin, Vcl.Buttons;

type
  TForm_MoviCaixa = class(TForm)
    Label2: TLabel;
    ADOConnection1: TADOConnection;
    Image1: TImage;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    ButtonLimpar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonSair: TSpeedButton;
    ADOQueryEntrada: TADOQuery;
    ADOQuerySaida: TADOQuery;
    ADOQuerySaidaCODIGO: TAutoIncField;
    ADOQuerySaidaPRODUTO: TIntegerField;
    ADOQuerySaidaDATA_VALIDADE: TWideStringField;
    ADOQuerySaidaQTD: TIntegerField;
    ADOQuerySaidaQTD_ALERTA: TIntegerField;
    Label1: TLabel;
    edValorTotal: TEdit;
    EditDescricao: TEdit;
    ADOQueryUpSaida: TADOQuery;
    ADOQueryUp: TADOQuery;
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edValorTotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_MoviCaixa: TForm_MoviCaixa;

implementation

{$R *.dfm}

uses U_Principal;

procedure TForm_MoviCaixa.ButtonLimparClick(Sender: TObject);
begin
  edValorTotal.Text := '';
  EditDescricao.Text := '';
  RadioGroup1.ItemIndex := -1;
end;

procedure TForm_MoviCaixa.ButtonSairClick(Sender: TObject);
begin
  Form_MoviCaixa.Close;
end;

procedure TForm_MoviCaixa.ButtonSalvarClick(Sender: TObject);
var
  Valor : Float64;
  a : string;
begin
  if ((edValorTotal.Text = '') or (EditDescricao.Text = '')) then
    begin
      Application.MessageBox('Preencha todos os campos!','Atenção', MB_OK + MB_ICONWARNING);
      Exit;
    end;

  if RadioGroup1.ItemIndex = 0 then
    begin
      Valor := Form_Principal.ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat + StrToFloat(edValorTotal.Text);
      ADOQueryEntrada.Close;
      ADOQueryEntrada.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
      ADOQueryEntrada.Parameters.ParamByName('VALOR').Value := edValorTotal.Text;
      ADOQueryEntrada.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
      ADOQueryEntrada.ExecSQL;
      ADOQueryUp.Close;
      a := FormatFloat('##0.00', Abs(valor));
      ADOQueryUp.Parameters.ParamByName('VALOR').Value := StringReplace(FormatFloat('##0.00', Abs(Valor)), ',','.', [rfReplaceAll]);
      ADOQueryUp.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
      ADOQueryUp.ExecSQL;
      if Application.MessageBox(PChar('Movimentação regsitrada com sucesso!' + #13 +
                                'Deseja registrar outra?'),PChar('Salão da Laura'),
                                 MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 ) = ID_YES then
        begin
          ButtonLimparClick(Sender);
        end
      else Form_MoviCaixa.Close;
    end
  else if RadioGroup1.ItemIndex = 1 then
    begin
      Valor := Form_Principal.ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat - StrToFloat(edValorTotal.Text);
      if Valor < 0 then
        begin
          Application.MessageBox('Quantidade não disponível em caixa!','Erro', MB_OK + MB_ICONERROR);
          Exit;
        end;
      ADOQuerySaida.Close;
      ADOQuerySaida.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
      ADOQuerySaida.Parameters.ParamByName('VALOR').Value := edValorTotal.Text;
      ADOQuerySaida.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
      ADOQuerySaida.ExecSQL;
      ADOQueryUp.Close;
      ADOQueryUp.Parameters.ParamByName('VALOR').Value := StringReplace(FormatFloat('##0.00', Abs(Valor)), ',','.', [rfReplaceAll]);
      ADOQueryUp.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
      ADOQueryUp.ExecSQL;
      if Application.MessageBox(PChar('Movimentação regsitrada com sucesso!' + #13 +
                                'Deseja registrar outra?'),PChar('Salão da Laura'),
                                 MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 ) = ID_YES then
        begin
          ButtonLimparClick(Sender);
        end
      else Form_MoviCaixa.Close;
    end
  else Application.MessageBox('Selecione o tipo', 'Erro', MB_OK + MB_ICONERROR);
end;

procedure TForm_MoviCaixa.edValorTotalKeyUp(Sender: TObject; var Key: Word;
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

procedure TForm_MoviCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Principal.FormShow(Sender);
  Form_Principal.ButtonMoviCaixaClick(Sender);
  Form_Principal.ButtonMoviCaixaClick(Sender);
end;

procedure TForm_MoviCaixa.FormShow(Sender: TObject);
begin
  ButtonLimparClick(Sender);
end;

end.
