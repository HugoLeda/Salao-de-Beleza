unit U_ConsuVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.WinXCtrls;

type
  TForm_Consu_Venda = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    ButtonFechar: TSpeedButton;
    DBGrid1: TDBGrid;
    LabelPesquisar: TLabel;
    ADOConnection1: TADOConnection;
    SearchBox1: TSearchBox;
    ButtonItens: TSpeedButton;
    GroupBoxItens: TGroupBox;
    GroupBox4: TGroupBox;
    DBGrid2: TDBGrid;
    ButtonFecharItens: TSpeedButton;
    Splitter1: TSplitter;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADOQuery1NOME: TStringField;
    ADOQuery1CPF: TStringField;
    ADOQuery1FUNCIONARIO: TStringField;
    ADOQuery1VALOR: TBCDField;
    ADOQuery1DATA: TStringField;
    ADOQuery1CODIGO: TAutoIncField;
    ADOQuery2CHAVE: TAutoIncField;
    ADOQuery2CODIGO_VENDA: TIntegerField;
    ADOQuery2NOME: TStringField;
    ADOQuery2PRECO: TBCDField;
    ADOQuery2PRODUTO: TIntegerField;
    ADOQuery2SERVICO: TIntegerField;
    ADOQuery2QTD: TIntegerField;
    procedure ButtonFecharItensMouseEnter(Sender: TObject);
    procedure ButtonFecharItensMouseLeave(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonFecharClick(Sender: TObject);
    procedure ButtonFecharItensClick(Sender: TObject);
    procedure ButtonItensClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CampoFiltro : string;
  end;

var
  Form_Consu_Venda: TForm_Consu_Venda;

implementation

{$R *.dfm}

procedure TForm_Consu_Venda.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TForm_Consu_Venda.DBGrid1TitleClick(Column: TColumn);
begin
  LabelPesquisar.Caption := Column.Title.Caption + ': ';
  CampoFiltro := Column.FieldName;

  if (ADOQuery1.FieldByName(CampoFiltro)is TAutoIncField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TIntegerField) or
     (ADOQuery1.FieldByName(CampoFiltro)is TLargeintField)or
     (ADOQuery1.FieldByName(CampoFiltro)is TBCDField)then
    begin
      SearchBox1.NumbersOnly := True;
    end
  else SearchBox1.NumbersOnly := False;

  SearchBox1.Text := '';
  SearchBox1.SetFocus;
  ADOQuery1.Filtered := False;
end;

procedure TForm_Consu_Venda.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid2 do
    begin
      if Odd(DataSource2.DataSet.RecNo)then
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

procedure TForm_Consu_Venda.FormCreate(Sender: TObject);
begin
  Form_Consu_Venda.WindowState := wsMaximized;
end;

procedure TForm_Consu_Venda.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.Open;
  SearchBox1.Text := '';
  LabelPesquisar.Caption := DBGrid1.Columns[0].Title.Caption + ': ';
  CampoFiltro := DBGrid1.Columns[0].FieldName;
  Splitter1.Visible := False;
  GroupBoxItens.Visible := False;
  SearchBox1.Enabled := True;
  SearchBox1.SetFocus;
end;

procedure TForm_Consu_Venda.SearchBox1Change(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
    end
  else if (ADOQuery1.FieldByName(CampoFiltro) is TStringField) then
    begin
      SearchBox1InvokeSearch(Sender);
    end;
end;

procedure TForm_Consu_Venda.SearchBox1InvokeSearch(Sender: TObject);
begin
  if Length(SearchBox1.Text) = 0 then
    begin
      ADOQuery1.Filtered := False;
      exit;
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

procedure TForm_Consu_Venda.ButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_Consu_Venda.ButtonFecharItensClick(Sender: TObject);
begin
  GroupBoxItens.Visible := False;
  Splitter1.Visible := False;
  SearchBox1.Enabled := True;
  SearchBox1.SetFocus;
  ButtonItens.Visible := True;
  DBGrid1.Enabled := True;
end;

procedure TForm_Consu_Venda.ButtonFecharItensMouseEnter(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style + [fsUnderline];
end;

procedure TForm_Consu_Venda.ButtonFecharItensMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Font.Style := TSpeedButton(Sender).Font.Style - [fsUnderline];
end;

procedure TForm_Consu_Venda.ButtonItensClick(Sender: TObject);
begin
  ADOQuery2.Close;
  ADOQuery2.Parameters.ParamByName('CODVENDA').Value := ADOQuery1CODIGO.AsInteger;
  ADOQuery2.Open;
  GroupBoxItens.Visible := True;
  Splitter1.Visible := True;
  SearchBox1.Enabled := False;
  ButtonItens.Visible := False;
  DBGrid1.Enabled := False;
end;

end.
