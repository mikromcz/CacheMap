{
	General Plugin Script
  export dat pro mapu kesi. vyexportuje do souboru data_cachi.txt a otevre mapu v prohlizeci
  
  author: mikrom, http://mikrom.cz
  webpage: http://geoget.ararat.cz/doku.php/user:skript:cachemap
}

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
  GeoExport(GEOGET_SCRIPTDIR+'\cachemap\cachemap.gge.pas','');
end;
