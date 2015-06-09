unit Setup4;

{ $define localdebug }

interface

uses
  Sysutils,
  ActiveX, dbxmssql,
  System.IniFiles, StrUtils,
  Winapi.Windows, Winapi.Messages, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd,
  Vcl.StdCtrls, Vcl.CheckLst, Datasnap.DBClient, Datasnap.Provider, Data.DB,
  Data.SqlExpr, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, W7Classes,
  W7Bars, CurvyControls, AdvGlowButton;

type
  TSetupForm = class(TForm)
    FYSPAF_setup: TSQLConnection;
    DTB_GetTidbokTyp: TSQLDataSet;
    DataSource1: TDataSource;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    TidBokGrid: TDBAdvGrid;
    CurvyPanel1: TCurvyPanel;
    W7InformationBar1: TW7InformationBar;
    TidbokKolumner: TCheckListBox;
    ButtonOk: TAdvGlowButton;
    ButtonCancel: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    // Procedure Get(
  private
    { Private declarations }
    function GetPsw2(Psw1: string): String;

  public
    { Public declarations }
    ParamString, DatabasName, ServerName, Provider, user, password: String;
    Changed, DatabaseOK, AllOk: Boolean;
    DaysShown : Integer;
    procedure ReadFromIniFile;
    procedure WriteToInifile;
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.dfm}

procedure TSetupForm.FormCreate(Sender: TObject);
var
  I: Integer;
  S: String;
begin

  AllOk := False;
  DatabaseOK := False;
  TidBokGrid.Hide;
  ClientDataSet1.Active:=False;
{$IFDEF localdebug}
  TidBokGrid.Show;
{$ENDIF}
  CoInitialize(nil);
  ReadFromIniFile;
  Changed := False;

  FYSPAF_setup.Close;
  FYSPAF_setup.ConnectionName := ServerName;
  FYSPAF_setup.DriverName := 'MSSQL';
  FYSPAF_setup.Params.Values['HostName']   := ServerName;
  FYSPAF_setup.Params.Values['Database']   := DatabasName;
  FYSPAF_setup.Params.Values['User_name']  := user;
  FYSPAF_setup.Params.Values['Password']   := password;
  FYSPAF_setup.LoadParamsOnConnect := False;
  FYSPAF_setup.LoginPrompt := False;

  try
    ClientDataSet1.Active := true; // �ppnar databasen
    DatabaseOK := true;
  except
    DatabaseOK := False;
    Application.MessageBox(PChar('Databaskopplingen till  databasen, ['+ DatabasName +
        '] p� servern ['+ Servername + '] kunde inte uppr�ttas!'),
      'Databasfel', mb_OK);
    // Exit
  end;

  for I := 1 to TidBokGrid.RowCount - 1 do
  begin
    S := TidBokGrid.Cells[1, I];
    if TidbokKolumner.Items.IndexOf(S) < 0 then
      TidbokKolumner.Items.Add(S)
  end;

  FYSPAF_setup.Close;
  CoUninitialize;
end;

function TSetupForm.GetPsw2(Psw1: string): String;
var
  S: String;
  I: Integer;
begin
  S := '';
  I := 1;
  S := Psw1[12 + I] + Psw1[18 + I] + Psw1[2 + I] + Psw1[6 + I] + Psw1[11 + I] +
    Psw1[22 + I] + Psw1[8 + I] + Psw1[28 + I];
  Result := S;
end;

procedure TSetupForm.ButtonCancelClick(Sender: TObject);
begin
  Changed := False;
  Close
end;

procedure TSetupForm.ButtonOkClick(Sender: TObject);
begin
  WriteToInifile;
end;

procedure TSetupForm.ReadFromIniFile;
var
  SettingFile, SettingFilePAF: TIniFile;
  I, SPos: Integer;
  PswKrypt, S, ts, bs, kol: String;
  ws: Widestring;
  Ch: Boolean;

begin
  S := 'Fel';
  ParamString := '';
  SettingFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  AllOk := true;
  if paramcount > 0 then
    ParamString := ParamStr(1);

  if ParamString > '' then
  begin // Data fr�n inifil i parameterlista, trol paf.ini
    if Sysutils.FileExists(ParamString) then
    begin
      SettingFilePAF := TIniFile.Create(ParamString);
      DatabasName := SettingFilePAF.ReadString('common', 'database', S);
      ServerName := SettingFilePAF.ReadString('common', 'server', S);
      Provider := SettingFilePAF.ReadString('common', 'provider', S);
      PswKrypt := SettingFilePAF.ReadString('common', 'sps', S);
      user := 'pa';
      //user := 'fyslabx'; //TEMP
      // password := 'purkebas';
      password := GetPsw2(PswKrypt);
      //password := 'krulle'; //TEMP

      SettingFilePAF.Free;
    end
    else
    begin
      ts := 'Inifilen: ' + ParamString + ' kunde inte l�sas.';
      Application.MessageBox(PWidechar(ts), 'Fel!', mb_OK);
      AllOk := False;
    end
  end

  else

  begin // Ta databas fr�n programmets inifil
    DatabasName := SettingFile.ReadString('DatabasInst', 'DataBase', S);
    ServerName := SettingFile.ReadString('DatabasInst', 'Server', S);
    Provider := SettingFile.ReadString('DatabasInst', 'provider', S);


    user := 'pa';
    password := 'purkebas'
  end;
  // nedanst�ende l�ses alltid fr�n lokal inifil
  TidbokKolumner.Items.Clear;
  try
    // for I := 1 to Clb_Tidbok.Items.Count - 1 do
    // begin
    I := 1;
    repeat
      S := '';
      ts := '';
      ts := SettingFile.ReadString('Valda kolumner', 'Kolumn' + IntToStr(I), S);
      if ts = '' then
      begin
        Break;
      end;

      SPos := PosEx(';', ts);
      S := Copy(ts, 0, SPos - 1);
      bs := Copy(ts, SPos + 1, Length(ts) - SPos + 1);
      try
        Ch := StrToBool(bs);
      except
        Ch := False;
      end;
      TidbokKolumner.Items.Add(S);
      TidbokKolumner.Checked[I - 1] := Ch;
      inc(I);
    until ts = '';
    DaysShown := SettingFile.ReadInteger('Inst','Visadedagar',1);
    // end
  finally
    SettingFile.Free;
  end;
  Changed := true;
end;

procedure TSetupForm.WriteToInifile;
var
  SettingFile: TIniFile;
  I: Integer;
begin
  // Spara till fil eller registry
  SettingFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    for I := 0 to TidbokKolumner.Items.Count - 1 do
    begin
      SettingFile.WriteString('Valda kolumner', 'Kolumn' + IntToStr(I),
        TidbokKolumner.Items[I] + ';' + BoolToStr(TidbokKolumner.Checked[I]));
    end;
      SettingFile.WriteInteger('Inst','Visadedagar',DaysShown);
  finally
    SettingFile.Free;
  end;
  Changed := true;;
  Close;
end;

end.
