unit U_Pagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Data.Win.ADODB, Vcl.ComCtrls, Vcl.WinXPickers, Vcl.Samples.Spin, Vcl.DBCtrls,
  frxCtrls, Vcl.Buttons;

type
  TFormPagamento = class(TForm)
    PanelSelecionar: TPanel;
    RadioGroup1: TRadioGroup;
    PanelVista: TPanel;
    PanelParcelado: TPanel;
    ADOQueryValorCompra: TADOQuery;
    LabelValorCompra: TLabel;
    ADOConnectionPagamento: TADOConnection;
    ADOQueryValorCompraVALOR: TBCDField;
    ADOQueryDataAtual: TADOQuery;
    ADOQueryPagamentoaVista: TADOQuery;
    Button1: TButton;
    LabelValorPago: TLabel;
    edvalortotal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ADOQueryDataAtualGETDATE: TStringField;
    LabelTroco: TLabel;
    ADOQueryGerarCarnê: TADOQuery;
    ADOQueryInserirItensCarnê: TADOQuery;
    Button2: TButton;
    ADOQueryDiaAtual: TADOQuery;
    LabelVParcela: TLabel;
    ADOQueryDiaAtualDIA: TIntegerField;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOQueryCliente: TADOQuery;
    ADOQueryClienteCLIENTE: TIntegerField;
    EditParcelas: TEdit;
    EditDiaVencimento: TEdit;
    SpeedButton1: TSpeedButton;
    LabelValorTotalParcelado: TLabel;
    SpeedButton2: TSpeedButton;
    ADOQueryFinalizarVenda: TADOQuery;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditParcelasChange(Sender: TObject);
    procedure edvalortotalChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Troco, Pago, Valor, VParcelas: Float64;
    CODCARNE : Integer;
    Pagamento : Boolean;
  end;

var
  FormPagamento: TFormPagamento;

implementation

{$R *.dfm}

uses U_Venda, U_Principal, U_Login;

procedure TFormPagamento.Button1Click(Sender: TObject);
var
  ValorCaixa : Float64;
begin
  Pago := StrToFloat(edvalortotal.Text);

  if Length(edvalortotal.Text) = 0 then
    begin
      Application.MessageBox('Informe o valor pago!','Atenção', MB_OK + MB_ICONWARNING);
      edvalortotal.SetFocus;
      Exit;
    end;

  if Pago < Valor then
    begin
      Application.MessageBox('Valor insuficiente!','Atenção', MB_OK + MB_ICONWARNING);
      edvalortotal.SetFocus;
      Exit;
    end;

  Troco := Pago - Valor;

  ADOQueryPagamentoaVista.Close;
  ADOQueryPagamentoaVista.Parameters.ParamByName('CODIGO_VENDA').Value := Form_Venda.CodUltVenda;
  ADOQueryPagamentoaVista.Parameters.ParamByName('VALOR_PAGO').Value := Pago; //StringReplace(edvalortotal.Text, ',','.', []);
  ADOQueryPagamentoaVista.Parameters.ParamByName('TROCO').Value := Troco; //StringReplace(LabelTroco.Caption, ',','.', []);
  ADOQueryPagamentoaVista.Parameters.ParamByName('USUARIO').Value := Form_Login.ADOQueryVerificaUsuCODIGO.AsInteger;

  ADOQueryPagamentoaVista.Parameters.ParamByName('CAIXA').Value := Form_Principal.CODCAIXA;
  ADOQueryPagamentoaVista.Parameters.ParamByName('VALOR').Value := StringReplace(FloatToStr(Valor), ',','.', []);
  ADOQueryPagamentoaVista.Parameters.ParamByName('DESCRICAO').Value := 'Recebimento à Vista';
  ValorCaixa := Form_Principal.ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat + Valor;
  ADOQueryPagamentoaVista.Parameters.ParamByName('VALORCAIXA').Value := ValorCaixa;
  ADOQueryPagamentoaVista.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
  ADOQueryPagamentoaVista.ExecSQL;

  LabelValorPago.Visible := True;
  LabelTroco.Caption := 'R$' + FormatFloat('###0.00', Abs(Troco)) + '.';
  LabelTroco.Visible := True;
  RadioGroup1.Enabled := False;

  Form_Principal.ADOQueryVerificaCaixa.Close;
  Form_Principal.ADOQueryVerificaCaixa.Open;
end;

procedure TFormPagamento.Button2Click(Sender: TObject);
Var
  Mes, Dia, Ano : Word;
  DiaVenc, MesVenc, AnoVenc : Integer;
  i : Integer;
  DVencimento : string;
begin
  if (EditDiaVencimento.Text = '') or (EditParcelas.Text = '') then
    begin
      Application.MessageBox('Preencha todos os campos!','Salão da Laura',MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

  VParcelas := Valor / StrToInt(EditParcelas.Text);

  ADOQueryGerarCarnê.Close;
  ADOQueryGerarCarnê.Parameters.ParamByName('CODIGO_VENDA').Value := Form_Venda.CodUltVenda;
  ADOQueryGerarCarnê.Parameters.ParamByName('VALOR_TOTAL').Value := Valor;
  ADOQueryGerarCarnê.Parameters.ParamByName('VALOR_PAGO').Value := 0;
  ADOQueryGerarCarnê.Parameters.ParamByName('QTD_PARCELAS').Value := StrToInt(EditParcelas.Text);
  ADOQueryGerarCarnê.Parameters.ParamByName('QTD_PARCELAS_PAGAS').Value := 0;
  ADOQueryGerarCarnê.Parameters.ParamByName('VALOR_PARCELAS').Value := VParcelas;
  ADOQueryGerarCarnê.Parameters.ParamByName('SITUACAO').Value := 0;
  ADOQueryGerarCarnê.Parameters.ParamByName('CODCARNE').Value;
  ADOQueryGerarCarnê.ExecSQL;

  CODCARNE := ADOQueryGerarCarnê.Parameters.ParamByName('CODCARNE').Value;

  DecodeDate(Date, Ano, Mes, Dia);
  //ShowMessage('Mes do Decode'+IntToStr(mes));

  DiaVenc := StrToInt(EditParcelas.Text);
  MesVenc := Mes;
  AnoVenc := Ano;

  if  DiaVenc > 28  then
    begin
      Application.MessageBox('O dia de vencimente será 28, pois esta é a data limite!', 'Salão da Laura', MB_OK + MB_ICONINFORMATION);
      DiaVenc := 28;
    end;

  if MesVenc < 12 then
    begin
      MesVenc := MesVenc + 1;
    end
  else
    begin
      MesVenc := 01;
      AnoVenc := AnoVenc + 1;
    end;

  i := 1;
  for i := 1 to StrToInt(EditParcelas.Text) do
    begin
      DVencimento := IntToStr(DiaVenc) + '-' + IntToStr(MesVenc) + '-' + IntToStr(AnoVenc);
      ADOQueryInserirItensCarnê.Close;
      ADOQueryInserirItensCarnê.Parameters.ParamByName('CODCARNE').Value := CODCARNE;
      ADOQueryInserirItensCarnê.Parameters.ParamByName('DATA_VENCIMENTO').Value := DVencimento;
      ADOQueryInserirItensCarnê.Parameters.ParamByName('SITUACAO').Value := 0;
      ADOQueryInserirItensCarnê.ExecSQL;
      if MesVenc < 12 then
        begin
          MesVenc := MesVenc + 1;
        end
      else
        begin
          MesVenc := 01;
          AnoVenc := AnoVenc + 1;
        end;
    end;
  Application.MessageBox('Carnê gerado com sucesso!','Salão da Laura',MB_OK + MB_ICONINFORMATION);
  RadioGroup1.Enabled := False;
end;

procedure TFormPagamento.EditParcelasChange(Sender: TObject);
begin
  if (StrToInt(EditParcelas.Text) < 1) then
    begin
      EditParcelas.Text := '1';
    end
  else if StrToInt(EditParcelas.Text) > 12 then
    begin
      Application.MessageBox('Parcelamento em no máximo 12 vezes!','Salão da Laura',MB_OK + MB_ICONINFORMATION);
      EditParcelas.Text := '12';
    end;

  VParcelas :=  Valor / StrToInt(EditParcelas.Text) ;
  LabelVParcela.Caption := FormatFloat('###0.00', Abs(VParcelas));
  {if (EditParcelas.Text <> '') then
    begin
        if (StrToInt(EditParcelas.Text) < 1) Or (StrToInt(EditParcelas.Text) > 12) then
        begin
          //LabelAvisoParcela.Caption := 'Parcelas até 12 vezes';
          //EditParcelas.Text := '';
        end
    else if (StrToInt(EditParcelas.Text) = 2) Or (StrToInt(EditParcelas.Text) = 3) Or (StrToInt(EditParcelas.Text) = 4) Or (StrToInt(EditParcelas.Text) = 5) Or (StrToInt(EditParcelas.Text) = 6) Or (StrToInt(EditParcelas.Text) = 7) Or (StrToInt(EditParcelas.Text) = 8) Or (StrToInt(EditParcelas.Text) = 9) then
        begin
          VParcelas := ADOQueryValorCompraVALOR.AsFloat /  StrToInt(EditParcelas.Text);
          LabelVParcela.Caption := FormatFloat('###0.00', Abs(VParcelas));
        end
    else  if (StrToInt(EditParcelas.Text) = 10) Or (StrToInt(EditParcelas.Text) = 11) Or (StrToInt(EditParcelas.Text) = 12) then
        begin
          VParcelas := ADOQueryValorCompraVALOR.AsFloat /  StrToInt(EditParcelas.Text);
          LabelVParcela.Caption := FormatFloat('###0.00', Abs(VParcelas));
        end;
    end;}
end;

procedure TFormPagamento.edvalortotalChange(Sender: TObject);
begin
  if (edvalortotal.Text <> '') then
    begin
          Valor := ADOQueryValorCompraVALOR.AsFloat;

          Pago := StrToFloat(edvalortotal.Text);

          Troco := Pago - Valor;

          LabelTroco.Caption := FormatFloat('###0.00', Abs(Troco));
    end;
end;

procedure TFormPagamento.edvalortotalKeyUp(Sender: TObject; var Key: Word;
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

procedure TFormPagamento.FormShow(Sender: TObject);
begin
  Pagamento := False;
  ADOQueryValorCompra.Close;
  ADOQueryValorCompra.Parameters.ParamByName('CODIGO').Value := Form_Venda.CodUltVenda;
  ADOQueryValorCompra.Open;
  Self.Height := 200;
  edvalortotal.Text := '';
  EditDiaVencimento.Text := '';
  LabelValorPago.Visible := False;
  LabelTroco.Visible := False;
  Valor :=  ADOQueryValorCompraVALOR.AsFloat;
  LabelValorTotalParcelado.Caption := 'Valor da Compra: R$ ' + FormatFloat('###0.00', Abs(Valor));
  LabelValorCompra.Caption := 'R$' + FormatFloat('###0.00', Abs(Valor));
  RadioGroup1.ItemIndex := 0;
  RadioGroup1.Enabled := True;
  edvalortotal.ReadOnly := False;
  EditDiaVencimento.ReadOnly := False;
  EditParcelas.ReadOnly := False;
  SpeedButton1.Enabled := True;
  SpeedButton2.Enabled := True;

  if Form_Venda.CliPadrao = True then
    begin
      RadioGroup1.Enabled := False;
    end;

end;

procedure TFormPagamento.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    PanelVista.Visible := True;
    PanelParcelado.Visible := False;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
    PanelParcelado.Visible := True;
    PanelVista.Visible := False;
  end;
end;

procedure TFormPagamento.SpeedButton1Click(Sender: TObject);
begin
  Button2Click(Sender);
  SpeedButton1.Enabled := False;
  EditParcelas.ReadOnly := True;
  EditDiaVencimento.ReadOnly := True;
  Pagamento := True;
  ADOQueryFinalizarVenda.Close;
  ADOQueryFinalizarVenda.Parameters.ParamByName('COD').Value := Form_Venda.CodUltVenda;
  ADOQueryFinalizarVenda.ExecSQL;
end;

procedure TFormPagamento.SpeedButton2Click(Sender: TObject);
begin
  Button1Click(Sender);
  SpeedButton2.Enabled := False;
  edvalortotal.ReadOnly := True;
  Pagamento := True;
  ADOQueryFinalizarVenda.Close;
  ADOQueryFinalizarVenda.Parameters.ParamByName('COD').Value := Form_Venda.CodUltVenda;
  ADOQueryFinalizarVenda.ExecSQL;
end;

end.
