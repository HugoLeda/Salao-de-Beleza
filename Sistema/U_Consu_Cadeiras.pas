unit U_Consu_Cadeiras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, Vcl.WinXCtrls,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TForm_Consu_Cadeiras = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery1TIPO: TStringField;
    ADOQuery1DESCRICAO: TStringField;
    ADOQuery1DATA_CADASTRO: TStringField;
    ButtonVoltar: TSpeedButton;
    ButtonCancelar: TSpeedButton;
    ButtonSalvar: TSpeedButton;
    ButtonEditar: TSpeedButton;
    ButtonNovo: TSpeedButton;
    SearchBox1: TSearchBox;
    LabelPesquisar: TLabel;
    EditCodigo: TEdit;
    Edittipo: TEdit;
    EditUModificacao: TEdit;
    EditDescricao: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOQueryRegistroSelecionado: TADOQuery;
    ADOQueryRegistroSelecionadoCODIGO: TAutoIncField;
    ADOQueryRegistroSelecionadoTIPO: TStringField;
    ADOQueryRegistroSelecionadoDESCRICAO: TStringField;
    ADOQueryRegistroSelecionadoDATA_CADASTRO: TStringField;
    EditDCadastro: TEdit;
    ADOQueryUpdate: TADOQuery;
    ADOQuery1DATA_ULT_MODIFICACAO: TStringField;
    Label6: TLabel;
    ButtonExcluir: TSpeedButton;
    ADOQueryExclusao: TADOQuery;
    GroupBox3: TGroupBox;
    ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO: TStringField;
    ADOQueryVeriAgendamento: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonEditarClick(Sender: TObject);
    procedure ButtonVoltarClick(Sender: TObject);
    procedure EditDescricaoChange(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure EditDescricaoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  Form_Consu_Cadeiras: TForm_Consu_Cadeiras;

implementation

{$R *.dfm}

uses U_Cadastro_Cadeiras, U_Principal, U_Login;

procedure TForm_Consu_Cadeiras.ButtonCancelarClick(Sender: TObject);
begin
  ButtonCancelar.Enabled := False;
  ButtonSalvar.Enabled := False;
  ButtonEditar.Enabled := True;
  SearchBox1.Enabled := True;
  FormShow(Sender);
end;

procedure TForm_Consu_Cadeiras.ButtonEditarClick(Sender: TObject);
begin
  if EditCodigo.Text <> '' then
    begin
      Edittipo.ReadOnly := False;
      EditDescricao.ReadOnly := False;
      EditCodigo.ShowHint := True;
      EditDCadastro.ShowHint := True;
      EditUModificacao.ShowHint := True;
      Edittipo.SetFocus;
      ButtonExcluir.Enabled := False;
      ButtonSalvar.Enabled := True;
      ButtonCancelar.Enabled := True;
      ButtonEditar.Enabled := False;
      DBGrid1.Enabled := False;
      SearchBox1.Enabled := False;
    end
  else
    begin
      Application.MessageBox('Selecione um registro!', 'Informação', MB_ICONINFORMATION + MB_OK);
    end;
end;

procedure TForm_Consu_Cadeiras.ButtonExcluirClick(Sender: TObject);
Var
  Dia : string;
begin
  Dia := DateToStr(Date);
  ADOQueryVeriAgendamento.Close;
  ADOQueryVeriAgendamento.Parameters.ParamByName('DIA').Value := Dia;
  ADOQueryVeriAgendamento.Parameters.ParamByName('CADEIRA').Value := EditCodigo.Text;
  ADOQueryVeriAgendamento.Open;

  if ADOQueryVeriAgendamento.RecordCount > 0 then
    begin
      Application.MessageBox('Não é possível excluir essa cadeira, pois ele possui um agendamento marcado', 'Erro', MB_OK + MB_ICONERROR);
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
              Application.MessageBox('Registro excluído com sucesso', '', MB_OK);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
              EditCodigo.Text := '';
              Edittipo.Text := '';
              EditDescricao.Text := '';
              EditUModificacao.Text := '';
              EditDCadastro.Text := '';
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
              Application.MessageBox('Registro excluído com sucesso', '', MB_OK);
              ADOQuery1.Close;
              ADOQuery1.Open;
              SearchBox1.Text := '';
              SearchBox1.SetFocus;
              EditCodigo.Text := '';
              Edittipo.Text := '';
              EditDescricao.Text := '';
              EditUModificacao.Text := '';
              EditDCadastro.Text := '';
            end;
        end;
    end
  else
    begin
      Application.MessageBox('Selecione um registro para editar!', 'Alerta', MB_ICONWARNING + MB_OK);
    end;
end;

procedure TForm_Consu_Cadeiras.ButtonSalvarClick(Sender: TObject);
begin
  if (Edittipo.Text <> '') and (EditDescricao.Text <> '') then
    begin
      ADOQueryUpdate.Close;
      ADOQueryUpdate.Parameters.ParamByName('TIPO').Value := Edittipo.Text;
      ADOQueryUpdate.Parameters.ParamByName('DESCRICAO').Value := EditDescricao.Text;
      ADOQueryUpdate.Parameters.ParamByName('CODIGO').Value := EditCodigo.Text;
      ADOQueryUpdate.ExecSQL;
      ADOQuery1.Close;
      ADOQuery1.Open;
      Application.MessageBox('Alteração concluída com sucesso!', 'Alteração', MB_OK + MB_ICONINFORMATION);
      SearchBox1.Enabled := True;
      FormShow(Sender);
    end
  else
    begin
      Application.MessageBox('Preencha os campos Tipo e Descrição', 'Alerta', MB_ICONWARNING + MB_OK );
    end;
end;

procedure TForm_Consu_Cadeiras.ButtonVoltarClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja sair e descartar as alterações?', 'Sair',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Cadeiras.Close;
        end;
    end
  else
    Form_Consu_Cadeiras.Close;
end;

procedure TForm_Consu_Cadeiras.DBGrid1CellClick(Column: TColumn);
var
  CodLinha: Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;
  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  Edittipo.Text := ADOQueryRegistroSelecionadoTIPO.AsString;
  EditDescricao.Text := ADOQueryRegistroSelecionadoDESCRICAO.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
end;

procedure TForm_Consu_Cadeiras.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Cadeiras.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  CodLinha: Integer;
begin
  CodLinha := DBGrid1.Columns[0].Field.AsInteger; // vai mostrar a coluna que voce quer
  ADOQueryRegistroSelecionado.Close;
  ADOQueryRegistroSelecionado.Parameters.ParamByName('CODIGO').Value := CodLinha;
  ADOQueryRegistroSelecionado.Open;
  EditCodigo.Text := ADOQueryRegistroSelecionadoCODIGO.AsString;
  Edittipo.Text := ADOQueryRegistroSelecionadoTIPO.AsString;
  EditDescricao.Text := ADOQueryRegistroSelecionadoDESCRICAO.AsString;
  EditDCadastro.Text := ADOQueryRegistroSelecionadoDATA_CADASTRO.AsString;
  EditUModificacao.Text := ADOQueryRegistroSelecionadoDATA_ULT_MODIFICACAO.AsString;
end;

procedure TForm_Consu_Cadeiras.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Cadeiras.EditDescricaoChange(Sender: TObject);
var
  qtdcaracteres : Integer;
begin
  qtdcaracteres :=  length(EditDescricao.text);
  Label6.Caption := inttostr(qtdcaracteres)+'\500';

end;

procedure TForm_Consu_Cadeiras.EditDescricaoKeyPress(Sender: TObject;
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

procedure TForm_Consu_Cadeiras.FormShow(Sender: TObject);
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
  EditCodigo.Text := '';
  Edittipo.Text := '';
  EditDescricao.Text := '';
  EditUModificacao.Text := '';
  EditDCadastro.Text := '';
  EditCodigo.ReadOnly := True;;
  Edittipo.ReadOnly := True;
  EditDescricao.ReadOnly := True;
  EditUModificacao.ReadOnly := True;
  EditDCadastro.ReadOnly := True;

  if Form_Login.ADOQueryVerificaUsuSUPERUSU.AsBoolean = False then
    begin
      ButtonNovo.Visible := False;
      ButtonEditar.Visible := False;
      ButtonCancelar.Visible := False;
      ButtonSalvar.Visible := False;
      ButtonExcluir.Visible := False;
    end;
end;

procedure TForm_Consu_Cadeiras.SearchBox1Change(Sender: TObject);
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

procedure TForm_Consu_Cadeiras.SearchBox1InvokeSearch(Sender: TObject);
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

procedure TForm_Consu_Cadeiras.ButtonNovoClick(Sender: TObject);
begin
  if ButtonSalvar.Enabled = True then
    begin
      if Application.MessageBox('Deseja coninuar e descartar as alterações?', 'Alterações não foram salvas',
                                MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = ID_YES then
        begin
          Form_Consu_Cadeiras.Hide;
          Form_Cadastro_Cadeiras.ShowModal;
          ButtonSalvar.Enabled := False;
          ButtonCancelar.Enabled := False;
          Form_Consu_Cadeiras.Show;
          SearchBox1.SetFocus;
        end;
    end
  else
    begin
      Form_Consu_Cadeiras.Hide;
      Form_Cadastro_Cadeiras.ShowModal;
      ButtonSalvar.Enabled := False;
      ButtonCancelar.Enabled := False;
      Form_Consu_Cadeiras.Show;
      SearchBox1.SetFocus;
    end;
end;

end.
