{
	Export Script
  export dat pro mapu kesi. vyexportuje do souboru data_cachi.txt a otevre mapu v prohlizeci

  author: mikrom, http://mikrom.cz
  webpage: http://geoget.ararat.cz/doku.php/user:skript:cachemap
}

{$INCLUDE cachemap.config.pas}

function ExportExtension: string;
begin
  Result := '';
end;

function ExportDescription: string;
begin
  Result := 'Export do mapy keší';
end;

function ExportHint: string;
begin
	Result := 'Exportuje seznam a zobrazí ho na mapì keší';
end;


function ExportBefore(value: string): string;
begin
  Result := '';
end;

function ExportPoint: string;
var
  n: Integer;
  owner, found, cachetype: String;
begin
  {Datova struktura vypada takto:  1 - 2 souradnice
  3 GC kod, u waypointu GC kod rodice.
  4 druh bodu. Anglicky (!), zpravidla prvni slovo z nazvu typu. Viz nazvy ikonek v podadresarich s ikonkami. od 2.5.13 jeste "solved" u vylustenych mysterek.
  5 Nazev bodu (u waypointu tzv. plny nazev vcetne nazvu rodice)
  6 autor
  7 datum nalezeni (nikoliv zalozeni...)
  8 velikost schranky
  9 obtiznost terenu
  10 obtiznost hledani
  11 0=cache, 1=waypoint
  12 status 0=ok, 1= disabled, 2=archived, 3=unknown
  13 1=moje vlastni cache}

  //keše
  if GC.IsListed then
  begin
    if GC.IsOwner then owner := '1' else owner := '0';
    if GC.IsFound then found := formatdatetime('dd"."mm"."yyyy',GC.Found) else found := '';

    //workaround pro osklivy nazvy ikonek kesmapy
    if RegexFind('^GC',GC.ID) then // pustime jen kese
    begin
      if GC.CacheType = 'Cache In Trash Out Event' then cachetype := 'cito'
      else if GC.CacheType = 'Earthcache' then cachetype := 'earth'
      else if GC.CacheType = 'Letterbox Hybrid' then cachetype := 'letter'
      else if (GC.CacheType = 'Unknown Cache') and GC.HaveFinal then cachetype := 'solved' // pro vylusteny mysterky
      else cachetype := RegexExtract('^[^\s\-]+',GC.CacheType);
    end
    else cachetype := 'point'; // waymarky a podobnej balast

    Result := Result + Copy(GC.Lat,0,9) + '|'                                                // 50.563533|
                 + Copy(GC.Lon,0,9) + '|'                                                // 15.91255|
                 + GC.ID + '|'                                                 // GC29AD8|
                 + AnsiLowercase(cachetype) + '|'                              // traditional|
                 + UtfToAscii(GC.Name) + '|'                                   // Hraci na nabrezi|
                 + UtfToAscii(GC.Author) + '|'                                 // Jikos|
                 + found + '|'                                                 // 22.07.2010|
                 + GC.Size + '|'                                               // Micro|
                 + GC.Difficulty + '|'                                         // 2|
                 + GC.Terrain + '|'                                            // 1.5|
                 + '0|'                                                        // 0|
                 + IntToStr(GC.CacheStatus) + '|'                              // 0|
                 + owner + CRLF;                                               // 0

    //waypointy
    for n := 0 to GC.Waypoints.Count - 1 do
      if (GC.Waypoints[n].Lat <> '0') and (GC.Waypoints[n].Lon <> '0') then
      begin
        Result := Result + Copy(GC.Waypoints[n].Lat,0,9) + '|'                                              // 50.562866|
                     + Copy(GC.Waypoints[n].Lon,0,9) + '|'                                              // 15.91305|
                     + GC.ID + '|'                                                            // GC29AD8|
                     + AnsiLowercase(RegexExtract('^[^\s\-]+',GC.Waypoints[n].WptType)) + '|' // parking|
                     + UtfToAscii(GC.Waypoints[n].FullName) + '|'                             // Parking (Hraci na nabrezi)|
                     + UtfToAscii(GC.Author) + '|'                                            // Jikos||
                     + found + '|'                                                            // 22.07.2010|
                     + GC.Size + '|'                                                          // Micro|
                     + GC.Difficulty + '|'                                                    // 2|
                     + GC.Terrain + '|'                                                       // 1.5|
                     + '1|'                                                                   // 1|
                     + IntToStr(GC.CacheStatus) + '|'                                         // 0|
                     + owner + CRLF;                                                          // 0
      end;

  end;
end;

function ExportAfter(value: string): string;
var
  s: string;
begin
  s := FileToString(value);
  s := UtfToCharset(s,'cp1250');
  StringToFile(s,GEOGET_DATADIR+'\map\data_cachi.txt');

  if (open_browser = '0') then
		exit
  else if (open_browser = '2') then
    BrowseURL(GEOGET_DATADIR+'\map\mapa.html')
  else if (open_browser = '1') then
		RunShell(GEOGET_DATADIR+'\map\mapa.html') //?lat='+GEOGET_REFX+'&lon='+GEOGET_REFY+'&name='+EncodeUrlElement(GEOGET_REFNAME) // nejde pres RunShell()
  else
  begin
    if FileExists(open_browser) then
			RunExecNoWait('"'+open_browser+'" "'+EncodeUrlElement(GEOGET_DATADIR+'\map\mapa.html?lat='+GEOGET_REFX+'&lon='+GEOGET_REFY+'&name='+GEOGET_REFNAME)+'"')
    else
			ShowMessage('Chyba: '+open_browser+' neexistuje!');
  end;
end;
