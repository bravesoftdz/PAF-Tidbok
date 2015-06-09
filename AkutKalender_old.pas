///	<summary>
///	  This is the man module in Akutkalender
///	</summary>
///	<remarks>
///	  Alpha 0,5
///	</remarks>
unit AkutKalender_old;

{$define utv}
{ $define demo }

interface

uses

  CodesiteLogging,
  Windows, Messages, ComCtrls, SysUtils, Variants, Classes, Graphics, Controls,
  Forms,
  Dialogs, Menus, AdvMenus, AdvToolBar, AdvGlowButton, AdvSmoothMenu,
  AdvSmoothCalendar, GDIPRadioItem, GDIPCheckItem, GDIPCustomItem, GDIPTextItem,
  GDIPImageTextItem, GDIPGraphicItem, GDIPButtonItem, CustomItemsContainer,
  AdvPolyList, CurvyControls, AdvMemo, AdvSmoothLabel, ExtCtrls, AdvSplitter,
  DB, ADODB, GDIPHTMLItem, GDIPImageTextButtonItem,
  GDIPDropDownItem, GDIPSectionItem, GDIPImageSectionItem, GDIPGroupItem,
  StdCtrls, AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker,
  DBAdvSmoothDatePicker, AdvSmoothLedLabel, DBAdvSmoothLedLabel,
  AdvSmoothCalculator, RibbonLunaStyleActnCtrls, Ribbon, AdvmSQLS, AdvEdit,
  AdvEdBtn, PlannerDatePicker, PlannerDBDatePicker, DBTables, FMTBcd,
  SqlExpr, AdvOfficeButtons, ParamLabel, Mask, AdvDropDown,
  AdvCalculatorDropdown, AdvGroupBox, DBPlannerDatePicker, Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvDateTimePicker,
  DateUtils, AdvSpin, W7Classes, W7Bars, CalPanel,
  ItemEdit2, PAFPlanner, Vcl.DBGrids,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Planner, PlannerWaitList,
  AdvDBLookupComboBox,
  Setup2, Datasnap.Provider, Datasnap.DBClient
  ;

type

  ShortString = String[15];
  Longstring = String[50];

  TMainForm = class(TForm)
    AdvSmoothLabel1: TAdvSmoothLabel;
    AdvSplitter1: TAdvSplitter;
    CurvyPanel1: TCurvyPanel;
    CurvyPanel2: TCurvyPanel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    PopupMenuItem: TAdvPopupMenu;
    Visaalladata1: TMenuItem;
    Annanavdelning1: TMenuItem;
    Sng1: TMenuItem;
    Timer1: TTimer;
    RadioB_Dygn_1: TRadioButton;
    RadioB_2Dygn: TRadioButton;
    CheckBoxHelger: TAdvOfficeCheckBox;
    PAF_T: TADOConnection;
    Timer2: TTimer;
    RemissGrid: TDBAdvGrid;
    AdvMainMenu1: TAdvMainMenu;
    File1: TMenuItem;
    DayGrid: TDBAdvGrid;
    DataSourceGetRemiss: TDataSource;
    ADOStoredProcGetRemiss: TADOStoredProc;
    ChekboxHelaDagen: TAdvOfficeCheckBox;
    AdvSplitter2: TAdvSplitter;
    PopupMenuItemNew: TAdvPopupMenu;
    abortmarkering1: TMenuItem;
    AdvSplitter4: TAdvSplitter;
    MYPAFWaitList1: TMYPAFWaitList;
    MyPAFPlanner1: TMyPAFPlanner;
    DatePicker1: TPlannerDatePicker;
    ADOStoredProcGetTidbok: TADOStoredProc;
    DataSourceGetTidbok: TDataSource;
    BindingsList1: TBindingsList;
    BindGridListDayGrid1: TBindGridList;
    ADOStoredProcGetTdbTyp: TADOStoredProc;
    DataSourceGetTdbTyp: TDataSource;
    Instllningar1: TMenuItem;
    Lokalainstllningar1: TMenuItem;
    TidbokGrid: TDBAdvGrid;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;


    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure RadioB_2DygnClick(Sender: TObject);
    procedure RadioB_Dygn_1Click(Sender: TObject);
    procedure DatePicker1Change(Sender: TObject);

    // procedure DBActiveDaySource1InsertItem(Sender: TObject;
    // APlannerItem: TPlannerItem);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure CheckBoxHelgerClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CalPanel1DateChange(Sender: TObject;
      origDate, newDate: TDateTime);


    (*
    procedure DBActiveDaySource1FieldsToItem(Sender: TObject; Fields: TFields;
      Item: TMyPAFItem);
    procedure DBActiveDaySource1ItemToFields(Sender: TObject; Fields: TFields;
      Item: TMyPAFItem);

    procedure DayPlannerDragDropItem(Sender, Source: TObject; X, Y: Integer;
      PlannerItem: TMyPAFItem);
    procedure DayPlannerDragDropCell(Sender, Source: TObject; X, Y: Integer);
    procedure DayPlannerDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBDayPlannerPlannerRightClick(Sender: TObject;
      Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure VisaHelgdagar_CheckClick(Sender: TObject);
    *)

    procedure ChekboxHelaDagenClick(Sender: TObject);
    procedure abortmarkering1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    // ******************************************
    // Edit
    procedure MyPAFPlanner1Items0EditModal(Sender: TObject);
    procedure MyPAFPlanner1ItemStartEdit(Sender: TObject; Item: TPlannerItem);
    procedure MYPAFWaitList1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    // ******************************************
    // Inst�llningar
    procedure Lokalainstllningar1Click(Sender: TObject);

    // ******************************************
    // Dragdropp ********************************
    procedure MyPAFPlanner1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MyPAFPlanner1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MyPAFPlanner1PlannerRightClick(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);



  private
    { Private declarations }
    // Avsedd som en lokal array f�r sparandet av dagens och morgondagens data
    // skall spara p� antalet l�sningar i databasen, om jag t�nkt r�tt ;-)
    // NS 2011-05-10
    // TLocalArray: array[1..500] of TLocalitem;

    // Skall morgondagen visas eller ej?
    // NS 2011-05-06
    imorgon: Boolean;
    CurrDay: TDateTime;
    FItem: TMyPAFItem;
    // DisplayMinutes: Integer;
    function FieldByName(const DBGrid: TDBAdvGrid; NameS: String): Integer;
    procedure ReadDayFromPAF(dt: TDateTime);
    procedure NewitemFromPaf(Tdb: TMyPAFItem);
    procedure NewItemToWaitlist(Tdb: TMyPAFItem);
    procedure ReadRemissFromPaf;
    procedure HeaderSetup;
    function TBHeaderToPlace(H: String): Integer;
    class function KodToMinuter(kod: String): Integer;
    procedure PlaceToDrop(X, Y: Integer; var aDT: TDateTime; aRoom: String);
    procedure AddLunch(starttime, endtime: TDateTime);
    function ProdKodTotext(kod: String): String;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
(*
procedure TMainForm.DBActiveDaySource1FieldsToItem(Sender: TObject;
  Fields: TFields; Item: TMyPAFItem);
begin
  try
    Item.Color := TColor(Fields.FieldByName('Color').AsInteger)
  except
    Item.Color := clSilver;
  end;
end;

procedure TMainForm.DBActiveDaySource1ItemToFields(Sender: TObject;
  Fields: TFields; Item: TMyPAFItem);
begin
  Fields.FieldByName('Color').AsInteger := Integer(Item.Color)
end;
*)



function TMainForm.FieldByName(const DBGrid: TDBAdvGrid; NameS: String)
  : Integer;
var
  col, idx: Integer;
begin
  col := 0;
  for idx := 0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[idx].FieldName = NameS then
    begin
      col := idx;
      Break;
    end;
  end;

  if col > 0 then
    Result := col
  else
    Result := 0;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // MyPafPlanner1.Free
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  RowsPerHour: Integer;
begin
  CurrDay := now; // dagens datum

{$IFDEF utv}
  CurrDay := StrToDate('2011-09-15'); // Ska ers�ttas med dagens datum
{$ENDIF}
  imorgon := TRUE;
  DatePicker1.Date := CurrDay;
  RadioB_Dygn_1.Checked := TRUE;

  MyPAFPlanner1.DateTimeList.Add(CurrDay);

  MyPAFPlanner1.DefaultItem := TMyPAFItem(MyPAFPlanner1.CreateItem);

  // MyPAFPlanner1.DefaultItem.Editor   := MyPafEditor1;
  // hela det h�r uppl�gget �r avsett att ers�ttas med sparade data i registry senare
  with MyPAFPlanner1.Display do
  begin
    DisplayUnit := 15; // Uppdelningen av kalendern i 15 minutersintervall
    RowsPerHour := 60 div DisplayUnit;
    DisplayStart := 6 * RowsPerHour; // Klockan 6
    DisplayEnd := 20 * RowsPerHour; // Klockan 20
    ActiveStart := (7 - 6) * RowsPerHour; // 30 minuter efter displaystart
    ActiveEnd := (19 - 6) * RowsPerHour; // 13 timmar efter displaystart
  end;
  // L�gg till inl�sning av kopplingsdata
  PAF_T.Connected := TRUE;
  HeaderSetup;
  ReadDayFromPAF(CurrDay);
  ReadRemissFromPaf;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DayGrid.Hide;
  RemissGrid.Hide;

{$IFDEF utv}
  // DayGrid.show;
  // RemissGrid.show;
{$ENDIF}
end;

procedure TMainForm.HeaderSetup;
begin

  MyPAFPlanner1.Positions := 7;
  MyPAFPlanner1.PositionGroup := 7;

  // DayPlanner.
  with MyPAFPlanner1.Header do
  begin
    Captions.Clear;
    GroupCaptions.Clear;
    Captions.Add('');
    Captions.Add('Eko-1');
    Captions.Add('Eko-2');
    Captions.Add('Eko-3');
    Captions.Add('Eko-4');
    Captions.Add('Duplex 1');
    Captions.Add('Duplex 2');
    Captions.Add('PCU');
    GroupCaptions.Add(FormatDateTime('dddd dd mmmm yyyy', CurrDay));
  end;
end;

class function TMainForm.KodToMinuter(kod: String): Integer;
begin
  Result := 15;
  if Trim(kod) = '213' then
    Result := 59
  else
    Result := 45;
end;

procedure TMainForm.Lokalainstllningar1Click(Sender: TObject);
begin
   // Justera inst�llningar
   // Fn. bara f�r rum.
   setup2.Form2.Setup(TidbokGrid);
   TidbokGrid.SaveToFile('PafValdaRum.txt');
end;



procedure TMainForm.MyPAFPlanner1Items0EditModal(Sender: TObject);
begin
  // MyPafeditor1.Edit(MyPAFPlanner1,MyPafPlanner1.Items.Selected);
end;

procedure TMainForm.MyPAFPlanner1ItemStartEdit(Sender: TObject;
  Item: TPlannerItem);
begin
  if ItemEditForm.Execute(TMyPAFItem(Item)) = 0 then
    MyPAFPlanner1.Items.Selected := ItemEditForm.Item;
end;

procedure TMainForm.MyPAFPlanner1PlannerRightClick(Sender: TObject; Position,
  FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  with MyPAFPlanner1.CreateItemAtSelection do
  begin
    Text.Text := 'Orsak?';
    // Captiontype:=ctTimeText;
    BackGround := TRUE;
    Layer := 0;
    FixedPos := False;
    Captiontext := 'Blockerad tid';
    Color := RGB(127, 127, 100);
    PopUpMenu := PopupMenuItemNew;
    Update;
  end;

end;

procedure TMainForm.MYPAFWaitList1ItemDblClick(Sender: TObject;
  Item: TPlannerItem);
begin
  if ItemEditForm.Execute(TMyPAFItem(Item)) = 0 then
    MYPAFWaitList1.Items.Selected := ItemEditForm.Item;
end;

procedure TMainForm.abortmarkering1Click(Sender: TObject);
begin
  Beep
end;

procedure TMainForm.AddLunch(starttime, endtime: TDateTime);
var
  i: Integer;
begin
  for i := 0 to 6 do
  begin
    with MyPAFPlanner1.CreateItem do
    begin
      ItemStartTime := starttime;
      ItemEndTime := endtime;
      BackGround := TRUE;
      AllowOverlap := TRUE;
      Alignment := taCenter;
      Color := RGB(150, 200, 150);
      Text.Text := 'Lunch';
      ItemPos := i
    end;
  end;

end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  PAF_T.ConnectionString
end;

procedure TMainForm.CalPanel1DateChange(Sender: TObject;
  origDate, newDate: TDateTime);
var
  D: TDateTime;
begin
  (*
    D:=CalPanel1.Date;
    DayPlanner.DateTimeList.Clear;
    DayPlanner.DateTimeList.Add(D);
    CurrDay:=D;
    ReadDayFromPAF(D);
    HeaderSetup;
  *)
end;

procedure TMainForm.CheckBoxHelgerClick(Sender: TObject);
begin
  if CheckBoxHelger.Checked = TRUE then
  begin
    // Tv� dagar
    // Om helgdagar skall visas s� �r de tv� dagarna t.x fr + l�, annars fr + m�
    //
    MyPAFPlanner1.DateTimeList.Add(CurrDay);
  end
  else

end;

procedure TMainForm.ChekboxHelaDagenClick(Sender: TObject);
begin
  if ChekboxHelaDagen.Checked = TRUE then
    MyPAFPlanner1.Display.ScaleToFit := TRUE
  else
    MyPAFPlanner1.Display.ScaleToFit := False
    // DBDayPlanner.ItemSource:=DBActiveDaySource1;
end;

procedure TMainForm.DatePicker1Change(Sender: TObject);
var
  D: TDateTime;
begin

  D := DatePicker1.Date;
  if D <> CurrDay then
  begin
    MyPAFPlanner1.DateTimeList.Clear;
    MyPAFPlanner1.DateTimeList.Add(D);
    CurrDay := D;
    HeaderSetup;
    ReadDayFromPAF(D);
  end;

end;


//***************************************************************************
//***************************************************************************
// procedurer f�r drag and drop mellan waitlist och planner
//***************************************************************************
//***************************************************************************

procedure TMainForm.MyPAFPlanner1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source is TMYPAFWaitList);
end;

procedure TMainForm.MyPAFPlanner1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Source is TMYPAFWaitList) then
  begin
    (Source as TMYPAFWaitList).MoveToPlanner((Sender as TPlanner),
      (Source as TMYPAFWaitList).ItemIndex, X, Y);
  // Uppdaterar databasen
  // Tilldela en l�mplig l�ngd p� us, om ingen finns


  end;
end;
 (*
procedure TMainForm.DayPlannerDragDropCell(Sender, Source: TObject;
  X, Y: Integer);
var
  plItFrom: TMyPAFItem;
begin

  plItFrom := TMyPAFItem(MyPAFPlanner1.CreateItem);
  if (Source is TMYPAFWaitList) then
  begin
    // PlaceToDrop(X,Y,dt, rum);
    if (MYPAFWaitList1.ItemIndex >= 0) then
    begin

      //plItFrom := TMyPAFItem(MYPAFWaitList1.Items.Selected);
      // [MYPAFWaitList1.ItemIndex]);
      if MyPAFPlanner1.CellToItemNum(X, Y) = 0 then
      begin
        with TMyPAFItem(MyPAFPlanner1.CreateItem) do
        begin
          ItemPos := TBHeaderToPlace(plItFrom.UsRum);
          // Assign(plItFrom);
          // CaptionType := ctText;
          ItemBegin := Y; // M�ste ber�knas om till en tid. Hur??
          ItemEnd := Y + 10;
          ItemPos := X;
          // CaptionText:='NY';
          Captiontext := plItFrom.Captiontext;
          Color := clSilver;
          BackGround := False;
          Text.Text := plItFrom.Text.Text;

          // ItemStartTime := plItFrom.starttime;
          starttime := plItFrom.starttime;
          // ItemEndTime :=
          // OBS ska justeras
          endtime := plItFrom.starttime + plItFrom.utid;

          pid := plItFrom.pid;
          PatNamn := plItFrom.PatNamn;
          RemSign := plItFrom.RemSign;
          RemUsr := plItFrom.RemUsr;
          TdbUsr := plItFrom.TdbUsr;
          UndLak := plItFrom.UndLak;
          Notes := plItFrom.Notes;
          Prodkod := plItFrom.Prodkod;
          Prodtext := plItFrom.Prodtext;
          Notes := plItFrom.Notes;
          Anamnes := plItFrom.Anamnes;
          FrageText := plItFrom.FrageText;
          Update;
          MYPAFWaitList1.Items.Delete(MYPAFWaitList1.ItemIndex);
        end;
      end;
      // plItTo.ItemStartTime := dt;
      // plItTo.ItemEndTime := dt;

      // PlannerItem.Text.Text:='NY fr�n waitlist';

    end;
  end;
  plItFrom.Free

end;


procedure TMainForm.DayPlannerDragDropItem(Sender, Source: TObject;
  X, Y: Integer; PlannerItem: TMyPAFItem);
var
  dt: TDateTime;
  rum: String;
  plItFrom: TPlannerItem;
  plItto: TPlannerItem;
begin
  if (Source is TMYPAFWaitList) then
  begin
    // PlaceToDrop(X,Y,dt, rum);
    if (MYPAFWaitList1.ItemIndex >= 0) then
    begin
      plItFrom := MYPAFWaitList1.Items[MYPAFWaitList1.ItemIndex];
      // PlannerItem.Text.Text:='NY fr�n waitlist';
      PlannerItem.Text.Text := plItFrom.Text.Text;
      PlannerItem.BackGround := False;
      PlannerItem.Color := clSilver;
      PlannerItem.FixedPos := False;
      PlannerItem.Flashing := TRUE;
      PlannerItem.Captiontext := '212 Hj�rteko';

      MYPAFWaitList1.Items.Delete(MYPAFWaitList1.ItemIndex);
    end;
  end;
end;

procedure TMainForm.DayPlannerDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TMYPAFWaitList);
end;


 *)
//***************************************************************************
//***************************************************************************
//***************************************************************************


function TMainForm.ProdKodTotext(kod: String): String;
var
  S: String;
begin
  // TEMP only for testing
  S := Trim(kod);
  if S = '212' then
    Result := 'Hj�rteko';
  if S = '213' then
    Result := 'Avancerat Hj�rteko';
  if S = '516' then
    Result := 'DVT';

end;

procedure TMainForm.PlaceToDrop(X, Y: Integer; var aDT: TDateTime;
  aRoom: String);
begin
  aDT := StrTodateTime('2011-08-20 11:00');
  aRoom := 'EKO-4           ';

end;

procedure TMainForm.PAFWaitList1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  if Assigned(MyPAFPlanner1.Items.Selected) then
  begin
    MYPAFWaitList1.Items.Add.Assign(MyPAFPlanner1.Items.Selected);
    MyPAFPlanner1.FreeItem(MyPAFPlanner1.Items.Selected);
  end;
end;

procedure TMainForm.PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TMyPAFPlanner);
end;

procedure TMainForm.RadioB_2DygnClick(Sender: TObject);
begin
  imorgon := TRUE;
end;

procedure TMainForm.RadioB_Dygn_1Click(Sender: TObject);
begin
  imorgon := False;
end;

procedure TMainForm.NewitemFromPaf(Tdb: TMyPAFItem);
begin
  with TMyPAFItem(MyPAFPlanner1.CreateItem) do
  begin
    // Planerad tid
    if Tdb.Prodkod = '000' then
    begin
      BackGround := TRUE;

      CaptionType := ctTime;
      Captiontext := 'Ledig tid';
      Color := RGB(180, 180, 200)
    end
    else
    begin
      Color := clSilver;
      CaptionType := ctTime;
      Captiontext := Trim(Tdb.Prodkod + ' ' + ProdKodTotext(Tdb.Prodkod));
    end;

    ItemStartTime := Tdb.starttime;
    starttime := Tdb.starttime;
    ItemEndTime := Tdb.endtime;
    endtime := Tdb.endtime;
    ItemPos := TBHeaderToPlace(Tdb.UsRum);
    pid := Tdb.pid;
    PatNamn := Tdb.PatNamn;
    RemSign := Tdb.RemSign;
    RemUsr := Tdb.RemUsr;
    TdbUsr := Tdb.TdbUsr;
    UndLak := Tdb.UndLak;
    Notes := Tdb.Notes;
    Prodkod := Tdb.Prodkod;
    Prodtext := Tdb.Prodtext;
    FrageText := Tdb.FrageText;
    Anamnes := Tdb.Anamnes;
    Notes := Tdb.Notes;

    Text.Text := Trim(Tdb.pid + ' ' + #13 + Tdb.PatNamn);

    Hint := Tdb.Anamnes;
    ShowHint := TRUE;

    Update;
  end
end;

procedure TMainForm.NewItemToWaitlist(Tdb: TMyPAFItem);
begin
  with TMyPAFItem(MYPAFWaitList1.Items.Add) do
  begin
    PatNamn := Tdb.PatNamn;
    Prodkod := Tdb.Prodkod;
    // ItemStartTime := Tdb.starttime;
    // ItemEndTime := Tdb.endtime;
    FrageText := Tdb.FrageText;
    Anamnes := Tdb.Anamnes;
    utid := Tdb.utid;
    CaptionType := ctTime;
    Captiontext := Trim(Prodkod);
    Text.Text := Tdb.pid + ' ' + Trim(Tdb.PatNamn);
    Color := clSilver;
    InPlaceEdit := peMemo;
    Hint := Tdb.FrageText;
    ShowHint := TRUE;
    Update;

  end
end;

procedure TMainForm.ReadDayFromPAF(dt: TDateTime);

var
  i, TempI: Integer;
  LoeInDatePart: Double;
  LengthOfExam: String;

  LokalItem: TMyPAFItem;

begin
  LokalItem := TMyPAFItem(MyPAFPlanner1.CreateItem);
  // try
{$IFDEF utv}
  // Codesite.Send('ReadDayFromPaf');
  // Codesite.Send('Tidbok init',LokalItem);
{$ENDIF}
  MyPAFPlanner1.Items.ClearAll;
  MyPAFPlanner1.Items.BeginUpdate;
  DayGrid.Clear;
  // L�s in dagen fr�n TB1
  ADOStoredProcGetTidbok.Active := False;
  ADOStoredProcGetTidbok.ProcedureName := 'DTB_GetTidbok';

  ADOStoredProcGetTidbok.Parameters.Clear;
  ADOStoredProcGetTidbok.Parameters.CreateParameter('@FranDatum',
    ftFixedWideChar, pdInput, 20, DateToStr(dt));

  ADOStoredProcGetTidbok.Parameters.CreateParameter('@Antdagar', ftInteger,
    pdInput, 4, 0);
  ADOStoredProcGetTidbok.Prepared:=TRUE;
  ADOStoredProcGetTidbok.Active := TRUE;
  ADOStoredProcGetTidbok.ExecProc;

  AddLunch(EncodeTime(11, 30, 0, 0), EncodeTime(12, 15, 0, 0));

  if DayGrid.RowCount > 1 then
  begin
    for i := 1 to DayGrid.RowCount - 2 do
    begin
      DayGrid.Row := i;
      LokalItem.Clear;
      LokalItem.Prodkod := DayGrid.Cells[16, i];
      if LokalItem.Prodkod > '' then
      begin
        LokalItem.starttime := StrTodateTime(DayGrid.Cells[1, i]);
        // Tempor�r tidss�ttning

        LengthOfExam := DayGrid.Cells[FieldByName(DayGrid, 'KTFlg'), i];
        if LengthOfExam < '00' then
          LengthOfExam := '22'
        else
          LengthOfExam := DayGrid.Cells[25, i];

        LoeInDatePart := StrToInt(LengthOfExam) / 1440;
        // Del av dygn ex. 30 minuter dividerat med 1440 minuter (ett dygn)
        LokalItem.endtime := LokalItem.starttime + LoeInDatePart;
        // LokalItem.BestDatum   := StrToDateTime(DayGrid.Cells[FieldByName(DayGrid,'BestDatum'),i]);

        LokalItem.Prodtext := DayGrid.Cells
          [FieldByName(DayGrid, 'ProdText'), i];
        LokalItem.UsRum :=
          Trim(DayGrid.Cells[FieldByName(DayGrid, 'TdbTyp1'), i]);

        LokalItem.pid := DayGrid.Cells[FieldByName(DayGrid, 'Pid'), i];
        LokalItem.PatNamn := DayGrid.Cells[FieldByName(DayGrid, 'NAMN'), i];
        LokalItem.RemUsr := DayGrid.Cells[FieldByName(DayGrid, 'BestText'), i];
        LokalItem.TdbUsr := DayGrid.Cells[FieldByName(DayGrid, 'TdbTyp2'), i];
        LokalItem.FrageText := DayGrid.Cells
          [FieldByName(DayGrid, 'FRAGETEXT'), i];
        LokalItem.Anamnes := DayGrid.Cells[FieldByName(DayGrid, 'ANAMNES'), i];
        LokalItem.Rid := DayGrid.Cells[FieldByName(DayGrid, 'Rid'), i];
        NewitemFromPaf(LokalItem);
      end;

      { $IFDEF utv }
      // Codesite.Send('ReadDayFromPaf');
      // Codesite.Send('Tidbok fylld',LokalItem.pid);
      { $ENDIF }
    end; // For I:= ...
  end; // if Tempgrid ...
  MyPAFPlanner1.Items.EndUpdate;
  // finally
  if LokalItem <> nil then
    LokalItem.Free
    // end;

    // Tidbok.Destroy;
end;

procedure TMainForm.ReadRemissFromPaf;
var
  i: Integer;
  LocalItem: TMyPAFItem;
begin
  LocalItem := TMyPAFItem(MyPAFPlanner1.CreateItem);
  MYPAFWaitList1.Items.ClearAll;

  ADOStoredProcGetRemiss.Active := False;
  ADOStoredProcGetRemiss.Active := TRUE;
  ADOStoredProcGetRemiss.ExecProc;

  for i := 1 to RemissGrid.RowCount - 1 do
  begin
    LocalItem.Clear;
    RemissGrid.Row := i;

    LocalItem.pid := RemissGrid.Cells[FieldByName(RemissGrid, 'PNR'), i];
    LocalItem.PatNamn := RemissGrid.Cells[FieldByName(RemissGrid, 'FORNAMN'), i]
      + ' ' + RemissGrid.Cells[FieldByName(RemissGrid, 'EFTERNAMN'), i];;

    LocalItem.RemUsr := RemissGrid.Cells[FieldByName(RemissGrid, 'REMUSR'), i];
    LocalItem.FrageText := RemissGrid.Cells
      [FieldByName(RemissGrid, 'FRAGETEXT'), i];
    LocalItem.Anamnes := RemissGrid.Cells
      [FieldByName(RemissGrid, 'ANAMNES'), i];

    // Heter olika i GetRemiss och GetTidbok men �r samma tror jag!
    LocalItem.BestDatum :=
      StrTodateTime(RemissGrid.Cells[FieldByName(RemissGrid, 'RDATUM'), i]);

    LocalItem.BestId := RemissGrid.Cells[FieldByName(RemissGrid, 'BEST'), i];
    LocalItem.BestLak := RemissGrid.Cells
      [FieldByName(RemissGrid, 'BESTLAK'), i];
    LocalItem.Prodkod := RemissGrid.Cells
      [FieldByName(RemissGrid, 'PRODKOD'), i];

    NewItemToWaitlist(LocalItem);

  end;

  // finally
  if LocalItem <> nil then
    LocalItem.Free
    // end;
    // Tidbok.Destroy

end;

procedure TMainForm.Table1AfterInsert(DataSet: TDataSet);
begin
  Update;
end;

function TMainForm.TBHeaderToPlace(H: String): Integer;
var
  S: String;
begin
  Result := -1;
  S := Trim(H);
  if S = 'EKO-1' then
    Result := 0;
  if S = 'EKO-2' then
    Result := 1;
  if S = 'EKO-3' then
    Result := 2;
  if S = 'EKO-4' then
    Result := 3;
  if S = 'DUPL-1' then
    Result := 4;
  if S = 'DUPL-2' then
    Result := 5;
  if S = 'PCU' then
    Result := 6;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  MyPAFPlanner1.Caption.Title := '   ' + FormatDateTime('HH:mm:ss', now);
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin

  // DBActiveDaySource1.SynchDBItems
  // DBDaySource1.ReadDBItem

end;

end.
