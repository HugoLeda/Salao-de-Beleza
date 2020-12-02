unit U_BaixaCarnê;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TFormBaixaCarne = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ButtonFechar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonSelecionar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    ButtonNovo: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    DBGrid2: TDBGrid;
    ADOQueryCarnes: TADOQuery;
    ADOQueryItensCarnes: TADOQuery;
    DataSourceCarnes: TDataSource;
    DataSourceItens: TDataSource;
    DBEdit1: TDBEdit;
    ADOQueryCarnesCODIGO: TAutoIncField;
    ADOQueryCarnesNOME: TStringField;
    ADOQueryCarnesCODCARNE: TAutoIncField;
    ADOQueryCarnesCODIGO_VENDA: TIntegerField;
    ADOQueryCarnesQTD_PARCELAS: TIntegerField;
    ADOQueryCarnesQTD_PARCELAS_PAGAS: TIntegerField;
    ADOQueryCarnesVALOR_PAGO: TBCDField;
    ADOQueryCarnesVALOR_PARCELAS: TBCDField;
    ADOQueryCarnesVALOR_TOTAL: TBCDField;
    ADOQueryCarnesSIT: TStringField;
    RadioGroup1: TRadioGroup;
    ButtonFiltrar: TSpeedButton;
    Panel2: TPanel;
    edvalortotal: TEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelTroco: TLabel;
    Label4: TLabel;
    ADOQueryItensCarnesCODIGO_ITEM_CARNE: TAutoIncField;
    ADOQueryItensCarnesVENCIMENTO: TStringField;
    ADOQueryItensCarnesSIT: TStringField;
    ADOQueryItensCarnesVALOR_PARCELAS: TBCDField;
    ButtonVenda: TSpeedButton;
    ADOQueryPagamentoCarnê: TADOQuery;
    ADOQueryConsultaVenda: TADOQuery;
    ADOQueryPagamentoCarnêI: TADOQuery;
    ADOQueryItensCarneI: TADOQuery;
    ADOQueryCarneSituacao: TADOQuery;
    ADOQueryFiltro: TADOQuery;
    ADOQueryCarnesSITUACAO: TBooleanField;
    ADOQueryFiltroCODCARNE: TAutoIncField;
    ADOQueryFiltroCODIGO: TAutoIncField;
    ADOQueryFiltroNOME: TStringField;
    ADOQueryFiltroCODIGO_VENDA: TIntegerField;
    ADOQueryFiltroQTD_PARCELAS: TIntegerField;
    ADOQueryFiltroQTD_PARCELAS_PAGAS: TIntegerField;
    ADOQueryFiltroVALOR_PARCELAS: TBCDField;
    ADOQueryFiltroVALOR_TOTAL: TBCDField;
    ADOQueryFiltroVALOR_PAGO: TBCDField;
    ADOQueryFiltroSIT: TStringField;
    ADOQueryItensCarneISITUACAO: TBooleanField;
    ADOQueryItensCarnesCODIGO: TAutoIncField;
    ADOQueryFiltroSITUACAO: TBooleanField;
    ADOQueryUpCaixa: TADOQuery;
    Panel3: TPanel;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonSelecionarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSourceItensDataChange(Sender: TObject; Field: TField);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  FormBaixaCarne: TFormBaixaCarne;

implementation

{$R *.dfm}

uses U_Pagamento, U_Principal, U_Login, U_ConsuVenda;

procedure TFormBaixaCarne.ButtonCancelarClick(Sender: TObject);
begin
  DBGrid1.Enabled := True;
  GroupBox1.Visible := False;
  ButtonCancelar.Visible := False;
  ButtonSelecionar.Visible := True;
  ButtonFiltrar.Enabled := True;
  SearchBox1.SetFocus;
end;

procedure TFormBaixaCarne.ButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBaixaCarne.ButtonFiltrarClick(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    begin
      ADOQueryFiltro.Close;
      ADOQueryFiltro.Parameters.ParamByName('SITUACAO').Value := 'FALSE';
      ADOQueryFiltro.Open;
      DataSourceCarnes.DataSet := ADOQueryFiltro;
    end
  else if RadioGroup1.ItemIndex = 1 then
    begin
      ADOQueryFiltro.Close;
      ADOQueryFiltro.Parameters.ParamByName('SITUACAO').Value := 'TRUE';
      ADOQueryFiltro.Open;
      DataSourceCarnes.DataSet := ADOQueryFiltro;
    end
  else if RadioGroup1.ItemIndex = 2 then
    begin
      ADOQueryCarnes.Close;
      ADOQueryCarnes.Open;
      DataSourceCarnes.DataSet := ADOQueryCarnes;
    end;
end;

procedure TFormBaixaCarne.ButtonNovoClick(Sender: TObject);
var
  Preco, Pago, Troco, ValorPago : Float64;
  Ponto : Integer;
begin
  if ADOQueryCarnes.RecordCount > 0 then
    begin
      if Length(edvalortotal.Text) = 0 then
        begin
          Application.MessageBox('Informe o Valor Pago','Atenção',MB_OK + MB_ICONWARNING);
          Exit;
        end;

      Preco := (DBGrid2.Columns.Items[0].Field.AsFloat);
      ValorPago := StrToFloat(edvalortotal.Text);
      if ValorPago >= Preco then
        begin
          Troco := (ValorPago - Preco);
          LabelTroco.Caption := 'Troco: ' + FormatFloat('###0.00', Abs(Troco));
          LabelTroco.Visible := True;
        end
      else
        begin
          Application.MessageBox('O valor pago não é suficiente!','Atenção',MB_OK + MB_ICONWARNING);
          Exit;
        end;

      Pago := StrToFloat(DBGrid1.Columns.Items[6].Field.Text) + Preco;

      //Ver com o g an
      if DataSourceCarnes.DataSet = ADOQueryFiltro then
        begin
          Ponto := ADOQueryFiltro.RecNo;

          ADOQueryCarnes.RecNo := Ponto;
          DataSourceCarnes.DataSet := ADOQueryCarnes;
        end;

      ADOQueryPagamentoCarnê.Close;
      ADOQueryPagamentoCarnê.Parameters.ParamByName('CODIGO_ITEM_CARNE').Value := ADOQueryItensCarnesCODIGO_ITEM_CARNE.AsInteger;
//      ADOQueryPagamentoCarnê.Parameters.ParamByName('DATA_PAGAMENTO').Value :=
      ADOQueryPagamentoCarnê.Parameters.ParamByName('VALOR_PAGO').Value := StringReplace(edvalortotal.Text, ',','.', [rfReplaceAll]);
      ADOQueryPagamentoCarnê.Parameters.ParamByName('TROCO').Value := FormatFloat('###0.00', Abs(Troco));
      ADOQueryPagamentoCarnê.Parameters.ParamByName('USUARIO').Value := Form_Login.ADOQueryVerificaUsuCODIGO.AsInteger;

      ADOQueryPagamentoCarnê.Parameters.ParamByName('CAIXA').Value := Form_Principal.CodCaixa;
      ADOQueryPagamentoCarnê.Parameters.ParamByName('VALOR').Value :=  FormatFloat('###0.00', Abs(Preco));
      ADOQueryPagamentoCarnê.Parameters.ParamByName('DESCRICAO').Value := 'Recbimento de carnê';
      ADOQueryPagamentoCarnê.ExecSQL;

      ADOQueryPagamentoCarnêI.Close;
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('SITUACAO').Value := 1;
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('CODIGO_CARNE').Value := StrToInt(DBGrid1.Columns.Items[0].Field.Text);
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('CODIGO_ITEM_CARNE').Value := ADOQueryItensCarnesCODIGO_ITEM_CARNE.AsInteger;

      ADOQueryPagamentoCarnêI.Parameters.ParamByName('VALOR_PAGO').Value := FormatFloat('###0.00', Abs(Pago));
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('QTD_PARCELAS_PAGAS').Value := StrToInt((DBGrid1.Columns.Items[3].Field.Text)) + 1;
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('CODCARNE').Value := StrToInt(DBGrid1.Columns.Items[0].Field.Text);
      ADOQueryPagamentoCarnêI.Parameters.ParamByName('CODVENDA').Value := ADOQueryCarnesCODIGO_VENDA.AsInteger;
      ADOQueryPagamentoCarnêI.ExecSQL;

      ADOQueryUpCaixa.Close;
      ADOQueryUpCaixa.Parameters.ParamByName('VALOR').Value := Preco + Form_Principal.ADOQueryVerificaCaixaVALOR_CAIXA.AsFloat;
      ADOQueryUpCaixa.Parameters.ParamByName('CODCAIXA').Value := Form_Principal.CodCaixa;
      ADOQueryUpCaixa.ExecSQL;

      ADOQueryItensCarneI.Close;
      ADOQueryItensCarneI.Parameters.ParamByName('CODCARNE').Value := ADOQueryCarnesCODCARNE.AsInteger;
      ADOQueryItensCarneI.Open;

      if not (ADOQueryItensCarneI.RecordCount > 0) then
        begin
          ADOQueryCarneSituacao.Close;
          ADOQueryCarneSituacao.Parameters.ParamByName('CODCARNE').Value := ADOQueryCarnesCODCARNE.AsInteger;
          ADOQueryCarneSituacao.ExecSQL;
        end;

      ADOQueryFiltro.Close;
      ADOQueryFiltro.Open;

      Ponto := ADOQueryCarnes.RecNo;

      ADOQueryCarnes.Close;
      ADOQueryCarnes.Open;

      ADOQueryCarnes.RecNo := Ponto;

      ADOQueryItensCarnes.Close;
      ADOQueryItensCarnes.Open;

      Application.MessageBox(Pchar(FloatToStr(Troco)),'Troco',MB_OK + MB_ICONINFORMATION);
    end;
end;

procedure TFormBaixaCarne.ButtonSelecionarClick(Sender: TObject);
begin
  if ADOQueryCarnes.RecordCount < 1 then
    begin
      Application.MessageBox('Selecione um registro!','Salão da Laura', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
  GroupBox1.Visible := True;
  ADOQueryItensCarnes.Close;
  ADOQueryItensCarnes.Parameters.ParamByName('CODCARNE').Value := DBGrid1.Columns.Items[0].Field.AsInteger;
  ADOQueryItensCarnes.Open;
  DBGrid1.Enabled := False;
  ButtonSelecionar.Visible := False;
  ButtonCancelar.Visible := True;
  ButtonFiltrar.Enabled := False;
  DBGrid2.SetFocus;
end;

procedure TFormBaixaCarne.ButtonVendaClick(Sender: TObject);
begin
  Form_Consu_Venda.ShowModal;
end;

procedure TFormBaixaCarne.DataSourceItensDataChange(Sender: TObject;
  Field: TField);
begin

  if ADOQueryItensCarnesSIT.AsString = 'Pago' then
    begin
      Panel2.Visible := False;
    end
  else
    begin
      Panel2.Visible := True;
    end;

  edvalortotal.Text := '';
  LabelTroco.Visible := False;
end;

procedure TFormBaixaCarne.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DataSourceCarnes.DataSet.RecNo)then
        begin
          DBGrid1.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid1.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFormBaixaCarne.DBGrid1TitleClick(Column: TColumn);
begin
  if DataSourceCarnes.DataSet = ADOQueryFiltro then
    begin
      LabelPesquisar.Caption := Column.Title.Caption + ': ';
      CampoFiltro := Column.FieldName;

      if (ADOQueryFiltro.FieldByName(CampoFiltro)is TAutoIncField) or
         (ADOQueryFiltro.FieldByName(CampoFiltro)is TIntegerField) or
         (ADOQueryFiltro.FieldByName(CampoFiltro)is TLargeintField)or
         (ADOQueryFiltro.FieldByName(CampoFiltro)is TBCDField)then
        begin
          SearchBox1.NumbersOnly := True;
        end
      else SearchBox1.NumbersOnly := False;

      SearchBox1.Text := '';
      SearchBox1.SetFocus;
      ADOQueryFiltro.Filtered := False;
    end
  else
    begin
      LabelPesquisar.Caption := Column.Title.Caption + ': ';
      CampoFiltro := Column.FieldName;

      if (ADOQueryCarnes.FieldByName(CampoFiltro)is TAutoIncField) or
         (ADOQueryCarnes.FieldByName(CampoFiltro)is TIntegerField) or
         (ADOQueryCarnes.FieldByName(CampoFiltro)is TLargeintField)or
         (ADOQueryCarnes.FieldByName(CampoFiltro)is TBCDField)then
        begin
          SearchBox1.NumbersOnly := True;
        end
      else SearchBox1.NumbersOnly := False;

      SearchBox1.Text := '';
      SearchBox1.SetFocus;
      ADOQueryCarnes.Filtered := False;
    end;
end;

procedure TFormBaixaCarne.DBGrid2CellClick(Column: TColumn);
begin
  if (DBGrid2.Columns.Items[2].Field.Text = 'Pago' )then
    begin
      ButtonNovo.Enabled := False;
    end
  else
    begin
      ButtonNovo.Enabled := True;
    end;
end;

procedure TFormBaixaCarne.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid2 do
    begin
      if Odd(DataSourceItens.DataSet.RecNo)then
        begin
          DBGrid2.Canvas.Brush.Color := $00C7CBEE;
        end;
    end;
  if (gdSelected in State) then
   begin
    TDBGrid(Sender).Canvas.Brush.Color := $00a4a2e4;
   end;

  DBGrid2.Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFormBaixaCarne.edvalortotalKeyUp(Sender: TObject; var Key: Word;
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

procedure TFormBaixaCarne.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Principal.ButtonMoviCaixaClick(Sender);
  Form_Principal.ButtonMoviCaixaClick(Sender);
end;

procedure TFormBaixaCarne.FormCreate(Sender: TObject);
begin
  FormBaixaCarne.WindowState := wsMaximized;
end;

procedure TFormBaixaCarne.FormShow(Sender: TObject);
begin
  RadioGroup1.ItemIndex := 2;
  ButtonFiltrarClick(Sender);
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption;
  CampoFiltro := DBGrid1.Columns[1].FieldName;
  GroupBox1.Visible := False;
  SearchBox1.SetFocus;
  DBGrid1.Enabled := True;
end;

procedure TFormBaixaCarne.SearchBox1Change(Sender: TObject);
begin
  if DataSourceCarnes.DataSet = ADOQueryFiltro then
  begin
    if Length(SearchBox1.Text) = 0 then
      begin
        ADOQueryFiltro.Filtered := False;
      end
    else if (ADOQueryFiltro.FieldByName(CampoFiltro) is TStringField) then
      begin
        SearchBox1InvokeSearch(Sender);
      end;
  end
else
  begin
   if Length(SearchBox1.Text) = 0 then
      begin
        ADOQueryCarnes.Filtered := False;
      end
    else if (ADOQueryCarnes.FieldByName(CampoFiltro) is TStringField) then
      begin
        SearchBox1InvokeSearch(Sender);
      end;
  end;
end;

procedure TFormBaixaCarne.SearchBox1InvokeSearch(Sender: TObject);
begin
  if DataSourceCarnes.DataSet = ADOQueryFiltro then
    begin
      if Length(SearchBox1.Text) = 0 then
        begin
          ADOQueryFiltro.Filtered := False;
          exit;
        end;

       if (ADOQueryFiltro.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
         begin
           ADOQueryFiltro.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
         end
       else
         begin
           ADOQueryFiltro.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
         end;
       ADOQueryFiltro.Filtered := True;
    end
  else
    begin
      if Length(SearchBox1.Text) = 0 then
        begin
          ADOQueryCarnes.Filtered := False;
          exit;
        end;

       if (ADOQueryCarnes.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
         begin
           ADOQueryCarnes.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
         end
       else
         begin
           ADOQueryCarnes.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
         end;
       ADOQueryCarnes.Filtered := True;
    end;
end;

end.
