unit U_Consu_Servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls;

type
  TForm_Consu_Servicos = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ButtonFechar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonEditar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    ButtonNovo: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    ButtonExcluir: TSpeedButton;
    ADOQuery1: TADOQuery;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1NOME: TStringField;
    ADOQuery1PRECO: TBCDField;
    ADOQuery1DURACAO: TIntegerField;
    ADOQuery1DESCRICAO: TStringField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ADOQuery1DATA_ULT_MODIFICACAO: TStringField;
    DataSource1: TDataSource;
    EditUModificacao: TEdit;
    EditCodigo: TEdit;
    EditDuracao: TEdit;
    EditDescricao: TEdit;
    EditNome: TEdit;
    EditPreco: TEdit;
    EditDCadastro: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditQtd: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ADOQueryRegistroSelecionado: TADOQuery;
    ADOQueryExclusao: TADOQuery;
    ADOQueryUpdate: TADOQuery;
    ADOQueryRegistroSelecionadoCODIGO: TAutoIncField;
    ADOQueryRegistroSelecionadoNOME: TStringField;
    ADOQueryRegistroSelecionadoPRECO: TBCDField;
    ADOQueryRegistroSelecionadoDURACAO: TIntegerField;
    ADOQueryRegistroSelecionadoDESCRICAO: TStringField;
    ADOQueryRegistroSelecionadoDATA_CADASTRO: TStringField;
    ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO: TStringField;
    ADOQueryQtd: TADOQuery;
    ADOQueryQtdQTD: TIntegerField;
    edvalortotal: TEdit;
    ADOQueryVeriAgendamento: TADOQuery;
    ButtonSelecionar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonFecharClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EditDescricaoChange(Sender: TObject);
    procedure EditDescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure edvalortotalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonSelecionarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  Form_Consu_Servicos: TForm_Consu_Servicos;

implementation

{$R *.dfm}

uses U_Cadastro_Servicos, U_Login, U_Venda;

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

procedure TForm_Consu_Servicos.ButtonCancelarClick(Sender: TObject);
begin
  ButtonCancelar.Enabled := False;
  ButtonSalvar.Enabled := False;
  ButtonEditar.Enabled := True;
  FormShow(Sender);
end;

procedure TForm_Consu_Servicos.ButtonEditarClick(Sender: TObject);
begin
  if EditCodigo.Text <> '' then
    begin
      EditDuracao.ReadOnly := False;
      EditDescricao.ReadOnly := False;
      EditNome.ReadOnly := False;
      EditPreco.ReadOnly := False;
      EditCodigo.ShowHint := True;
      EditDCadastro.ShowHint := True;
      EditUModificacao.ShowHint := True;
      EditQtd.ShowHint := True;
      EditNome.SetFocus;
      ButtonExcluir.Enabled := False;
      ButtonSalvar.Enabled := True;
      ButtonCancelar.Enabled := True;
      ButtonEditar.Enabled := False;
      SearchBox1.Enabled := False;
      DBGrid1.Enabled := False;
      DeleteChar('R', EditPreco.Text);
      DeleteChar('$', EditPreco.Text);
      DeleteChar('.', EditPreco.Text);
      edvalortotal.Text := EditPreco.Text;
      EditPreco.Visible := False;
      edvalortotal.Visible := True;
    end
  else
    begin
      Application.MessageBox('Selecione um registro!', 'Informação', MB_ICONINFORMATION + MB_OK);
    end;
end;

procedure TForm_Consu_Servicos.ButtonExcluirClick(Sender: TObject);
Var
  Dia : string;
begin
  Dia := DateToStr(Date);
  ADOQueryVeriAgendamento.Close;
  ADOQueryVeriAgendamento.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryVeriAgendamento.Parameters.ParamByName('SERVICO').Value := EditCodigo.Text;
  ADOQueryVeriAgendamento.Open;

  if ADOQueryVeriAgendamento.RecordCount > 0 then
    begin
      Application.MessageBox('Não é possível excluir esse serviço, pois ele possui um agendamento marcado', 'Erro', MB_OK + MB_ICONERROR);
      Exit;
    end;

  if EditCodigo.Text <> '' then
    begin
      if ButtonEditar.Enabled = False then
        begin
          if Application.MessageBox('Deseja excluir e descartar as alterações?', 'Excluir',
                              MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
              EditCodigo.Text := '';
              EditNome.Text := '';
              EditDescricao.Text := '';
              EditUModificacao.Text := '';
              EditDCadastro.Text := '';
              EditDuracao.Text := '';
              EditPreco.Text := '';
              EditQtd.Text := '';
            end;
        end
      else
        begin
          if Application.MessageBox('Deseja excluir o registro?', 'Excluir',
                                   MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
            begin
              ADOQueryExclusao.Close;
              ADOQueryExclusao.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
              ADOQueryExclusao.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso', 'Exclusão', MB_OK + MB_ICONINFORMATION);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
              EditCodigo.Text := '';
              EditNome.Text := '';
              EditDescricao.Text := '';
              EditUModificacao.Text := '';
              EditDCadastro.Text := '';
              EditDuracao.Text := '';
              EditPreco.Text := '';
              EditQtd.Text := ''
            end;
        end;
    end
  else
    begin
      Application.MessageBox('Selecione um registro!', 'Erro', MB_ICONERROR + MB_OK);
    end;
end;

procedure TForm_Consu_Servicos.ButtonFecharClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Servicos.Close;
        end;
    end
  else
    Form_Consu_Servicos.Close;
end;

procedure TForm_Consu_Servicos.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Servicos.Hide;
          Form_Cadastro_Servicos.ShowModal;
          ButtonSalvar.Enabled := False;
          ButtonCancelar.Enabled := False;
          Form_Consu_Servicos.Show;
          SearchBox1.SetFocus;
        end;
    end
  else
    begin
      Form_Consu_Servicos.Hide;
      Form_Cadastro_Servicos.ShowModal;
      ButtonSalvar.Enabled := False;
      ButtonCancelar.Enabled := False;
      Form_Consu_Servicos.Show;
      SearchBox1.SetFocus;
    end;
end;

procedure TForm_Consu_Servicos.ButtonSalvarClick(Sender: TObject);
begin
  DeleteChar('R', edvalortotal.Text);
  DeleteChar('$', edvalortotal.Text);
  DeleteChar('.', edvalortotal.Text);
  EditPreco.Text := edvalortotal.Text;
  if (EditNome.Text <> '') and (EditDescricao.Text <> '') and
     (EditDuracao.Text <> '') and (EditPreco.Text <> '') then
    begin
      ADOQueryUpdate.Close;
      ADOQueryUpdate.Parameters.ParamByName('NOME').Value := EditNome.Text;
      ADOQueryUpdate.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
      ADOQueryUpdate.Parameters.ParamByName('DURACAO').Value := EditDuracao.Text;
      ADOQueryUpdate.Parameters.ParamByName('PRECO').Value := EditPreco.Text;
      ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
      ADOQueryUpdate.ExecSQL;
      ADOQuery1.Close;
      ADOQuery1.Open;
      Application.MessageBox('Alteração concluída com sucesso!', 'Alteração', MB_OK + MB_ICONINFORMATION);
      FormShow(Sender);
    end
  else
    begin
      Application.MessageBox('Preencha os campos Nome, Descrção, Preço e Duração!', 'Erro', MB_ICONERROR + MB_OK );
    end;
end;

procedure TForm_Consu_Servicos.ButtonSelecionarClick(Sender: TObject);
begin
  Form_Venda.DBLServico.KeyValue := ADOQuery1CODIGO.AsInteger;
  Form_Consu_Servicos.Close;
end;

procedure TForm_Consu_Servicos.DBGrid1CellClick(Column: TColumn);
var
  CodLinha: Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;
  ADOQueryQtd.Close;
  ADOQueryQtd.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryQtd.Open;
  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditDescricao.Text := ADOQueryRegistroSelecionadoDESCRICAO.AsString;
  EditPreco.Text := 'R$ ' + ADOQueryRegistroSelecionadoPRECO.AsString;
  EditDuracao.Text := ADOQueryRegistroSelecionadoDURACAO.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
  EditQtd.Text := ADOQueryQtdQTD.AsString;
end;

procedure TForm_Consu_Servicos.DBGrid1DblClick(Sender: TObject);
begin
  ButtonSelecionarClick(Sender);
end;

procedure TForm_Consu_Servicos.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    begin
      if Odd(DataSource1.DataSet.RecNo)then
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

procedure TForm_Consu_Servicos.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  CodLinha: Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;
  ADOQueryQtd.Close;
  ADOQueryQtd.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryQtd.Open;
  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  EditNome.Text := ADOQueryRegistroSelecionadoNOME.AsString;
  EditDescricao.Text := ADOQueryRegistroSelecionadoDESCRICAO.AsString;
  EditPreco.Text := 'R$ ' + ADOQueryRegistroSelecionadoPRECO.AsString;
  EditDuracao.Text := ADOQueryRegistroSelecionadoDURACAO.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
  EditQtd.Text := ADOQueryQtdQTD.AsString;
end;

procedure TForm_Consu_Servicos.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TBCDField)then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Servicos.EditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(EditDescricao.text);
  Label10.Caption := inttostr(qtdcaracteres)+'\500';
end;

procedure TForm_Consu_Servicos.EditDescricaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Key = #13 then
        begin
          ButtonSalvarClick(Sender);
        end;
    end;
end;

procedure TForm_Consu_Servicos.edvalortotalKeyUp(Sender: TObject; var Key: Word;
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


procedure TForm_Consu_Servicos.FormShow(Sender: TObject);
begin
  // Configuração grid e pesquisa
  ADOQuery1.Close;
  ADOQuery1.Open;
  ADOQuery1.Filtered := False;
  SearchBox1.Enabled := True;
  DBGrid1.Enabled := True;
  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  LabelPesquisar.Caption := DBGrid1.Columns[1].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[1].FieldName;

  //
  ButtonSalvar.Enabled := False;
  ButtonCancelar.Enabled := False;
  ButtonEditar.Enabled := True;
  ButtonExcluir.Enabled := True;
  ButtonNovo.Enabled := True;

  ButtonNovo.Visible := True;
  ButtonEditar.Visible := True;
  ButtonCancelar.Visible := True;
  ButtonSalvar.Visible := True;
  ButtonExcluir.Visible := True;
  ButtonSelecionar.Visible := False;
  GroupBox1.Visible := False;

  EditCodigo.Text := '';
  EditNome.Text := '';
  EditDescricao.Text := '';
  EditUModificacao.Text := '';
  EditDuracao.Text := '';
  EditDCadastro.Text := '';
  EditPreco.Text := '';
  EditQtd.Text := '';
  EditCodigo.ReadOnly := True;;
  EditNome.ReadOnly := True;
  EditDescricao.ReadOnly := True;
  EditUModificacao.ReadOnly := True;
  EditDuracao.ReadOnly := True;
  EditDCadastro.ReadOnly := True;
  EditPreco.ReadOnly := True;
  EditQtd.ReadOnly := True;
  EditPreco.Visible := True;
  edvalortotal.Visible := False;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;

  if Form_Venda.SelecionarServ = True then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
      ButtonSelecionar.Visible := True;
      GroupBox1.Visible := False;
    end;
end;

procedure TForm_Consu_Servicos.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      ADOQueryRegistroSelecionado.Close;
    end
  else
    begin
      SearchBox1InvokeSearch(Sender);
    end;
end;

procedure TForm_Consu_Servicos.SearchBox1InvokeSearch(Sender: TObject);
begin

  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      exit
    end;

  if (ADOQuery1.FieldByName(CampoFiltro) is TStringField) and (Length(SearchBox1.Text) <> 0) then
     begin
       ADOQuery1.Filter := CampoFiltro + ' like ' + QuotedStr('*' + SearchBox1.Text + '*');
     end
   else
     begin
       ADOQuery1.Filter := CampoFiltro + ' = ' + SearchBox1.Text;
     end;
   ADOQuery1.Filtered := True;
end;

end.
