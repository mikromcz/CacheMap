{
	General Plugin Script
  export dat pro mapu kesi. vyexportuje do souboru data_cachi.txt a otevre mapu v prohlizeci
  
  author: mikrom, http://mikrom.cz
  webpage: http://geoget.ararat.cz/doku.php/user:skript:cachemap
}

{$INCLUDE cachemap.config.pas}

var
  data: String;
  counter: Integer;

{Name of plugin}
function PluginCaption: string;
begin
  Result := 'Export do mapy keší';
end;

{What will be displayed as hint in case of icon on the toolbar?}
function PluginHint: string;
begin
  Result := 'Exportuje seznam a zobrazí ho na mapì keší';
end;

{Icon data.}
function PluginIcon: string;
begin
  Result := DecodeBase64('Qk02BQAAAAAAADYEAAAoAAAAEAAAABAAAAABAAgAAAAAAAAAAAASCwAAEgsAAAABAAAAAQAAjo59/9+/eP/lrmr/5bFq/+OzbP/ls23/4bdv/+C7cv/luXH/4b92/+XCeP/lxn7//8x8/9wA//9ok43/Y52J/26Lk/9uiZX/b4uV/22QlP9jpYn/Z6uN/2itj/9tspP/a7OU/3G5mf91uJv/dr6f/3y+o/9/v6X/fMSl/3fIpP9+z6v/gICA/4WFhf+bm4r/kJCQ/5KSkv+dnZ3/np6e/6mpmP+vr57/qKio/6mpqf+zs6H/tral/7m5p/+8vKv/v7+u/7Kysv+9vb3/v7+//4LDqv+Fxa7/hcqv/43Juv+Nzrn/hNWx/4bXtP+H17T/jdy7/47cu/+Q0b//kN6+/77Nrv+30br/vdW9/9vCgP/fy4v/0MeT/+DGgv/kyYT//9KA///Vg///2on//t2N//njnf/U06T/19eo/8HBsP/ExLP/xsa1/8jIuP/Kyrn/y8u7//Lnqf/056j/6eu5/5TUxP+W1cb/ntDI/5nXyv+d1Mz/rNDC/6HTzP+r183/ttnJ/7rczP+i2NL/pdzV/5nkyf+g6dP/ourV/6nu3/+t8OT/r/Hm/7Dz6P+z8+n/vfbt/7737v/ExMT/0NDQ/9nz1v/g78j/4e/I/8z04//C9er/xvbr/+Tk5P/p6en/8/Pi//T05P/19eb/9vbp//f36//5+en/+Pju//f39//5+fH/+/v0//z89//6+vr/+/v7//39+f/9/f3//v78/////v8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAA/w0NDQ0NDQ0NDQ0NDQ0NDQ0NAAAAAAAAAAAAAAAAAAAADSN9eHh4eHh4eHh4eHh9Iw0oeREQDg8UFRcaHTdaeSgNKXoSIiEfHyA7HGVrXXopDSx7EyKHJjk5PTVodEB7LCUlJSQkdoMzNDRZXkFFfC0niIiIiIiEf2ZmXHNXQ34uKysrKip3hm9paV9xTAGALw0wgRYxiG5nZ2xCVUsHgTANT4IYMTI+PmJgTkYJBoJPDVCFGTo/OGp1ckRKSASFUA1Rhxs8ZFttcFYLSQwDh1ENUogeNlhjYU1HCggFAohSDVOIiIiIiIiIiIiIiIiIUw1UVFRUVFRUVFRUVFRUVFQ=');
end;

{How Geoget can handle this plugin?}
function PluginFlags: string;
begin
  Result := 'toolbar,list';
end;

{Called when plugin is started}
procedure PluginStart;
begin
  GeoBusyCaption('Exportuji seznam...');
end;

{Called for each processed point}
procedure PluginWork;
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
    Inc(counter);
    GeoBusyProgress(counter,GEOGET_MAXCOUNT);
    
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

    data := data + Copy(GC.Lat,0,9) + '|'                                                // 50.563533|
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
        data := data + Copy(GC.Waypoints[n].Lat,0,9) + '|'                                              // 50.562866|
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

{Called on the end}
procedure PluginStop;
begin
  StringToFile(data,GEOGET_DATADIR+'\map\data_cachi.txt');
  
  if (open_browser = '0') then
		exit
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
