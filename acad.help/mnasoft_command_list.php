<HTML>
  <HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=1251">
    <TITLE>�������� ������ ������ MNAS_acad_utils ������� �� ����������</TITLE>
    <META NAME="AUTHOR" CONTENT="������� �������">
    <META NAME="CREATED" CONTENT="20120511;23010779">
  </HEAD>

  <BODY LANG="ru-RU" DIR="LTR">
  <H1>
    <P>�������� ������ ������ MNAS_acad_utils ������� �� ����������<P>
  </H1>
  <BR />
  <script>
    <!--
    function show_hide(id)
    {
      var id = document.getElementById(id) ;
      if (id.style.display == "none")
      {
        id.style.display = "block";
      }
      else
      {
        id.style.display = "none";
      }
    }
    -->
  </script>

  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('not defined')" ><H2>not defined</H2></A>
  </DIV>
  <DIV Name='not defined' ID='not defined' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./acad_pgp/acad_pgp.php"	NAME="command_acad_pgp"> acad_pgp </A>
        - ���������� ����� � ������ ����� acad.pgp, �������������� ��� ������� ���������� ������ � ������� ������ ACAD ��� �������� ������������. ������� �� ����� ���������� ������������ pgp �����. ����� ������ ������������, ��������� � �������� �����, ����������� ����������� ��������� �� ��� �� �������� �� � ������� ���������. �������� pgp ���� �� ����������. ���������, ��� �������������, ������� ������� �������, ������� ��������� ������ ��������� ������ ����������� ��������� pgp �����.</P>
    <P>
      <A HREF="./add_3d_prefix/add_3d_prefix.php"	NAME="command_add_3d_prefix"> add_3d_prefix </A>
        - ���������� � ������ ������ �������� ��������� "3d_", ����� ������ ������������ � "am_*", "sol_*", "dwg_*", "3d_*".</P>
    <P>
      <A HREF="./atoms/atoms.php"	NAME="command_atoms"> atoms </A>
        - ������� ��� ��������� ����������� ������ ������� � ������.</P>
    <P>
      <A HREF="./bl_pur/bl_pur.php"	NAME="command_bl_pur"> bl_pur </A>
        - not defined</P>
    <P>
      <A HREF="./ck/ck.php"	NAME="command_ck"> ck </A>
        - not defined</P>
    <P>
      <A HREF="./ck_cl/ck_cl.php"	NAME="command_ck_cl"> ck_cl </A>
        - not defined</P>
    <P>
      <A HREF="./clock_off/clock_off.php"	NAME="command_clock_off"> clock_off </A>
        - ���������� �����.</P>
    <P>
      <A HREF="./clock_on/clock_on.php"	NAME="command_clock_on"> clock_on </A>
        - ��������� �����.</P>
    <P>
      <A HREF="./culc_co_nox/culc_co_nox.php"	NAME="command_culc_co_nox"> culc_co_nox </A>
        - not defined</P>
    <P>
      <A HREF="./dwg_get/dwg_get.php"	NAME="command_dwg_get"> dwg_get </A>
        - not defined</P>
    <P>
      <A HREF="./dwg_put/dwg_put.php"	NAME="command_dwg_put"> dwg_put </A>
        - not defined</P>
    <P>
      <A HREF="./find_arc_by_cir_and_points/find_arc_by_cir_and_points.php"	NAME="command_find_arc_by_cir_and_points"> find_arc_by_cir_and_points </A>
        - not defined</P>
    <P>
      <A HREF="./find_arc_by_points/find_arc_by_points.php"	NAME="command_find_arc_by_points"> find_arc_by_points </A>
        - ���������� ����� ����������, ���������� ����� ��������� �����.</P><P>���������� �� ������� �� �������������</P>
    <P>
      <A HREF="./im/im.php"	NAME="command_im"> im </A>
        - not defined</P>
    <P>
      <A HREF="./pipe/pipe.php"	NAME="command_pipe"> pipe </A>
        - ���������� ������������ �� ������.</P>
    <P>
      <A HREF="./prj_main/prj_main.php"	NAME="command_prj_main"> prj_main </A>
        - ������ ������������</P><P>��� �������������� ���� ������ �������� � ������</P><P>� ��������� � ������� ��� ��������� �� ������� ��������� � ���������</P><P>� ���������� ����� � ������ ������� � ������������� ����.</P><P></P><P>�������� � ����������.</P><P>1) ��������� ��������� ������� Shell ��� ��������, ����������� ����� ��������:</P><P>DIR /S /B *.prj >list_prj</P><P>2) ��������� ������� prj_main. � ��������� ���� �������� ������������ ����� ���� list_prj.</P><P>� ���������� ���������� ������� �� ������� ACAD ����� ������� ������ ������,</P><P>���������� ������ ����� ������ ��������. ����� ������ ����� ��������� � �������.3) ���������� ����� ������ �������� �� ������� ACAD � ���� projects.lsp ������ ������������ ��� ������.����� �������� projects.lsp ����� ���������� ���������� g:fn_full_prj_lst ������ ��������� ������ ��������.</P><P>4) ��������� ��� ����� ������� rename_vl_prj.prj.</P><P>5) ��������� � ������� Visual Lisp ������� (make_lst g:fn_full_prj_lst).</P>
    <P>
      <A HREF="./prv_main/prv_main.php"	NAME="command_prv_main"> prv_main </A>
        - ��������� ������ ��� ������� � ���� C:/Acad.mnu/acad_setup/VLISP_make_prv.js,</P><P>�������� ��� �������� �������������� prv-�������� prv.</P><P>�������� � ����������.</P><P>1) ��������� ��������� ������� Shell ��� ��������, ����������� ����� prv-��������:</P><P>DIR /S /B *.prv >list_prv</P><P>2) ��������� ������� prv_main. � ��������� ���� �������� ������������ ����� ���� list_prv.</P><P>� ���������� ���������� ������� �� ������� ACAD ����� ������� ������ ������,</P><P>���������� ������ ����� ������ ��������. ����� ������ ����� ��������� � ������� � ��������� ��� ����� �������.</P><P>3) ���������� ��������� ������ �� ������� ACAD � ���� C:/Acad.mnu/acad_setup/VLISP_make_prv.js.4) ��������� �� ���������� C:/Acad.mnu/acad_setup/VLISP_make_prv.js.5) ��������� � ������� Visual Lisp ������� (make_lst g:fn_full_prj_lst).</P>
    <P>
      <A HREF="./ptt/ptt.php"	NAME="command_ptt"> ptt </A>
        - ������� �� ������������� �� �����</P>
    <P>
      <A HREF="./read_dat/read_dat.php"	NAME="command_read_dat"> read_dat </A>
        - not defined</P>
    <P>
      <A HREF="./ren/ren.php"	NAME="command_ren"> ren </A>
        - �������������� ���� ����� � ������ �� ���������� �������.</P>
    <P>
      <A HREF="./rezba_in/rezba_in.php"	NAME="command_rezba_in"> rezba_in </A>
        - not defined</P>
    <P>
      <A HREF="./rezba_out/rezba_out.php"	NAME="command_rezba_out"> rezba_out </A>
        - not defined</P>
    <P>
      <A HREF="./sc_sl/sc_sl.php"	NAME="command_sc_sl"> sc_sl </A>
        - not defined</P>
    <P>
      <A HREF="./scr/scr.php"	NAME="command_scr"> scr </A>
        - ��������� ��� ���������� ������������� �������� � ������.</P><P>������ ����������� ���������� ������������� �������� � ������� ��������.</P>
    <P>
      <A HREF="./sech/sech.php"	NAME="command_sech"> sech </A>
        - not defined</P>
    <P>
      <A HREF="./sort_shp/sort_shp.php"	NAME="command_sort_shp"> sort_shp </A>
        - C��������� �������� ����������� � shp - �����.</P>
    <P>
      <A HREF="./test/test.php"	NAME="command_test"> test </A>
        - not defined</P>
    <P>
      <A HREF="./tr_inch/tr_inch.php"	NAME="command_tr_inch"> tr_inch </A>
        - not defined</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('������������')" ><H2>������������</H2></A>
  </DIV>
  <DIV Name='������������' ID='������������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./a/a.php"	NAME="command_a"> a </A>
        - ����� ������� _.arc</P>
    <P>
      <A HREF="./ar/ar.php"	NAME="command_ar"> ar </A>
        - ����� ������� _.array</P>
    <P>
      <A HREF="./arr/arr.php"	NAME="command_arr"> arr </A>
        - ����� ������� _.list</P>
    <P>
      <A HREF="./b/b.php"	NAME="command_b"> b </A>
        - ����� ������� _.block</P>
    <P>
      <A HREF="./bo/bo.php"	NAME="command_bo"> bo </A>
        - ����� ������� _.boundary</P>
    <P>
      <A HREF="./br/br.php"	NAME="command_br"> br </A>
        - ����� ������� _.break</P>
    <P>
      <A HREF="./c/c.php"	NAME="command_c"> c </A>
        - ����� ������� _.circle</P>
    <P>
      <A HREF="./ch/ch.php"	NAME="command_ch"> ch </A>
        - ����� ������� _.chamfer.</P>
    <P>
      <A HREF="./chd/chd.php"	NAME="command_chd"> chd </A>
        - ����� ������� _.chamfer � ����������� ��������� ����� ��� ����� ����� �����.</P>
    <P>
      <A HREF="./co/co.php"	NAME="command_co"> co </A>
        - ����� ������� _.copy</P>
    <P>
      <A HREF="./cp/cp.php"	NAME="command_cp"> cp </A>
        - ����� ������� _.copy</P>
    <P>
      <A HREF="./di/di.php"	NAME="command_di"> di </A>
        - ����� ������� _.dist</P>
    <P>
      <A HREF="./dt/dt.php"	NAME="command_dt"> dt </A>
        - ����� ������� _.dtext</P>
    <P>
      <A HREF="./e/e.php"	NAME="command_e"> e </A>
        - ����� ������� _.erase</P>
    <P>
      <A HREF="./el/el.php"	NAME="command_el"> el </A>
        - ����� ������� _.ellipse</P>
    <P>
      <A HREF="./ex/ex.php"	NAME="command_ex"> ex </A>
        - ����� ������� _.extend</P>
    <P>
      <A HREF="./f/f.php"	NAME="command_f"> f </A>
        - ����� ������� _.fillet � ����������� ��������� ����� ��� ����� �������.</P>
    <P>
      <A HREF="./fr/fr.php"	NAME="command_fr"> fr </A>
        - ����� ������� _.fillet � ����������� ��������� ����� ��� ����� �������.</P>
    <P>
      <A HREF="./gr_on_off/gr_on_off.php"	NAME="command_gr_on_off"> gr_on_off </A>
        - ���������|���������� ������ ����� �������� (��. ��������� ���������� pickstyle).</P>
    <P>
      <A HREF="./h/h.php"	NAME="command_h"> h </A>
        - ����� ������� _.bhatch</P>
    <P>
      <A HREF="./id/id.php"	NAME="command_id"> id </A>
        - ����� ������� _.id</P>
    <P>
      <A HREF="./j/j.php"	NAME="command_j"> j </A>
        - ����� ������� _.join</P>
    <P>
      <A HREF="./l/l.php"	NAME="command_l"> l </A>
        - ����� ������� _.line</P>
    <P>
      <A HREF="./le/le.php"	NAME="command_le"> le </A>
        - ����� ������� _.qleader</P>
    <P>
      <A HREF="./m/m.php"	NAME="command_m"> m </A>
        - ����� ������� _.move</P>
    <P>
      <A HREF="./ma/ma.php"	NAME="command_ma"> ma </A>
        - ����� ������� _.matchprop</P>
    <P>
      <A HREF="./mi/mi.php"	NAME="command_mi"> mi </A>
        - ����� ������� _.mirror</P>
    <P>
      <A HREF="./o/o.php"	NAME="command_o"> o </A>
        - ����� ������� _.offset</P>
    <P>
      <A HREF="./oops/oops.php"	NAME="command_oops"> oops </A>
        - ����� ������� _.oops</P>
    <P>
      <A HREF="./op/op.php"	NAME="command_op"> op </A>
        - ����� ������� _.options</P>
    <P>
      <A HREF="./pe/pe.php"	NAME="command_pe"> pe </A>
        - ����� ������� _.pedit</P>
    <P>
      <A HREF="./pur/pur.php"	NAME="command_pur"> pur </A>
        - ������� ���� �������������� ��������� �� ������ ������.</P>
    <P>
      <A HREF="./ra/ra.php"	NAME="command_ra"> ra </A>
        - ����������� ���� ������� �������.</P>
    <P>
      <A HREF="./rec/rec.php"	NAME="command_rec"> rec </A>
        - ����� ������� _.rectangle</P>
    <P>
      <A HREF="./rg/rg.php"	NAME="command_rg"> rg </A>
        - ����������� �������.</P>
    <P>
      <A HREF="./rga/rga.php"	NAME="command_rga"> rga </A>
        - ����������� ���� ������� ������� � �������.</P>
    <P>
      <A HREF="./ro/ro.php"	NAME="command_ro"> ro </A>
        - ����� ������� _.rotate</P>
    <P>
      <A HREF="./s/s.php"	NAME="command_s"> s </A>
        - ����� ������� _.stretch</P>
    <P>
      <A HREF="./sc/sc.php"	NAME="command_sc"> sc </A>
        - ����� ������� _.scale</P>
    <P>
      <A HREF="./sk/sk.php"	NAME="command_sk"> sk </A>
        - ��������� �������� ��������� (����� ������).</P>
    <P>
      <A HREF="./tm/tm.php"	NAME="command_tm"> tm </A>
        - ���������|���������� ������ ��������� ������.</P>
    <P>
      <A HREF="./tr/tr.php"	NAME="command_tr"> tr </A>
        - ����� ������� _.trim</P>
    <P>
      <A HREF="./u/u.php"	NAME="command_u"> u </A>
        - ����� ������� _.u</P>
    <P>
      <A HREF="./undo/undo.php"	NAME="command_undo"> undo </A>
        - ����� ������� _.undo</P>
    <P>
      <A HREF="./vs/vs.php"	NAME="command_vs"> vs </A>
        - ����� ������� _.vports, ����������� ������� ���������.</P>
    <P>
      <A HREF="./x/x.php"	NAME="command_x"> x </A>
        - ����� ������� _.explode</P>
    <P>
      <A HREF="./z/z.php"	NAME="command_z"> z </A>
        - ����� ������� _.zoom, ����������� ���������� ������� ���������.</P>
    <P>
      <A HREF="./za/za.php"	NAME="command_za"> za </A>
        - ��������� ������� ��������� ����� �������, ����� ���� ���������� ��� ����������������� ��������� ������� + ������� ����������� �������� �������.</P>
    <P>
      <A HREF="./zc/zc.php"	NAME="command_zc"> zc </A>
        - ��������� ������� ��������� �� ���������� ����� � ������.</P>
    <P>
      <A HREF="./zd/zd.php"	NAME="command_zd"> zd </A>
        - ��������� ������� ��������� ��� ������ ������������� ����.</P>
    <P>
      <A HREF="./ze/ze.php"	NAME="command_ze"> ze </A>
        - ��������� ������� ��������� ����� �������, ����� ���� ���������� ��� ����������������� ��������� �������.</P>
    <P>
      <A HREF="./zp/zp.php"	NAME="command_zp"> zp </A>
        - �������� ���������� ������������ �������.</P>
    <P>
      <A HREF="./zv/zv.php"	NAME="command_zv"> zv </A>
        - ��������� ������� ��������� ����� �������, ����� ����� ������������ ������������ �������, �� ��������� �����������.</P>
    <P>
      <A HREF="./zw/zw.php"	NAME="command_zw"> zw </A>
        - ��������� ������� ���������, ������������ �����.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('������� �����')" ><H2>������� �����</H2></A>
  </DIV>
  <DIV Name='������� �����' ID='������� �����' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./draw_font/draw_font.php"	NAME="command_draw_font"> draw_font </A>
        - ��������� �������� ������ (256 ��������).</P>
    <P>
      <A HREF="./ins_lit/ins_lit.php"	NAME="command_ins_lit"> ins_lit </A>
        - not defined</P>
    <P>
      <A HREF="./ins_lit/ins_lit.php"	NAME="command_ins_lit"> ins_lit </A>
        - ��������� �������� �������� ������, ��������� � ������������ �������� ��� ���� ���������� ��������.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('������')" ><H2>������</H2></A>
  </DIV>
  <DIV Name='������' ID='������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./block_block/block_block.php"	NAME="command_block_block"> block_block </A>
        - �������������� ����� � ����.</P>
    <P>
      <A HREF="./block_point/block_point.php"	NAME="command_block_point"> block_point </A>
        - �������������� ����� � �����.</P>
    <P>
      <A HREF="./ch_wid/ch_wid.php"	NAME="command_ch_wid"> ch_wid </A>
        - ������� ����������. �������� : ���������� ������� ���������� ���������� ����������� � ���������� ��������. ����� ���������� ��������� ���� ����������: LINE ARC CIRCLE SPLINE PLINE LWPLINE ��� �������� ��������� ���������� "delobj"=1 ��������� �������� ��������� ����� : LINE; ARC; CIRCLE; SPLINE. ��� �������� ��������� ���������� "delobj"=0 �������� ��������� �� ���������. ��� ������� ���������� ���� SPLINE ����� ���������� ����� ���������, ���� ����� ��������� SPLINE ����� ��������� ��� ��� ���� �� ��� ���������.</P>
    <P>
      <A HREF="./chh/chh.php"	NAME="command_chh"> chh </A>
        - ������� ��� ��������� ������� ��������� ����������� �� DXF �����.</P>
    <P>
      <A HREF="./cr/cr.php"	NAME="command_cr"> cr </A>
        - ������������� ������� � ������������ ������ �����.</P>
    <P>
      <A HREF="./dch/dch.php"	NAME="command_dch"> dch </A>
        - ��������� ���������� ���������� ��������.</P>
    <P>
      <A HREF="./exl/exl.php"	NAME="command_exl"> exl </A>
        - ���������|������������ ������� � ���� ������� �� dl.</P>
    <P>
      <A HREF="./mcp/mcp.php"	NAME="command_mcp"> mcp </A>
        - ����������� � �����������.</P>
    <P>
      <A HREF="./mr/mr.php"	NAME="command_mr"> mr </A>
        - ����������� � �������.</P>
    <P>
      <A HREF="./ofd/ofd.php"	NAME="command_ofd"> ofd </A>
        - ������� offset � ���������� ������� �������� � ������� � ������ ����������� ��������.</P>
    <P>
      <A HREF="./off/off.php"	NAME="command_off"> off </A>
        - ������� offset � ���������� ����, ����� � ���� ����� �������� � �������.</P>
    <P>
      <A HREF="./point_block/point_block.php"	NAME="command_point_block"> point_block </A>
        - �������������� ����� � ����.</P>
    <P>
      <A HREF="./prov/prov.php"	NAME="command_prov"> prov </A>
        - ���������� ���������� ��� ���������� ����������� ����������� ���������.</P>
    <P>
      <A HREF="./spl-proj/spl-proj.php"	NAME="command_spl-proj"> spl-proj </A>
        - ������������� 3d ������� �� ��������� XY.</P>
    <P>
      <A HREF="./xt/xt.php"	NAME="command_xt"> xt </A>
        - ���������|������������ ��������� �������� � ��� ����� �� dl.</P>
    <P>
      <A HREF="./z0/z0.php"	NAME="command_z0"> z0 </A>
        - ������������ ������������� ��������� ����� �� ��������� Z=0.</P><P>����������� ��� ������������� � ������ ����� ����������</P><P>��� ����� ���������.(������� ���).</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('���������')" ><H2>���������</H2></A>
  </DIV>
  <DIV Name='���������' ID='���������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./MNASoft-registry-install/MNASoft-registry-install.php"	NAME="command_MNASoft-registry-install"> MNASoft-registry-install </A>
        - ������� MNASoft-registry-uninstall () ��������� ���������� ������, ����������� ��� �������� �� ���������� ������, ���������� � �������������� OARX �� ������ MNAS_acad_utils.</P>
    <P>
      <A HREF="./MNASoft-registry-uninstall/MNASoft-registry-uninstall.php"	NAME="command_MNASoft-registry-uninstall"> MNASoft-registry-uninstall </A>
        - ������� MNASoft-registry-uninstall () ��������� ������� ���������� ������� �� ������� ���������� MNASoft.</P>
    <P>
      <A HREF="./la_dhv/la_dhv.php"	NAME="command_la_dhv"> la_dhv </A>
        - ��������� ���� "d", "h", "v".</P>
    <P>
      <A HREF="./ltp/ltp.php"	NAME="command_ltp"> ltp </A>
        - �������� ������� �����.</P>
    <P>
      <A HREF="./mnas_arx_dbx_registry_16/mnas_arx_dbx_registry_16.php"	NAME="command_mnas_arx_dbx_registry_16"> mnas_arx_dbx_registry_16 </A>
        - ��������� reg-����, ��������������� ��� �������� � ������ Visual Studio Net ���������� � �������� ������ MNAS_cad_utils.</P>
    <P>
      <A HREF="./mnas_arx_dbx_registry_17/mnas_arx_dbx_registry_17.php"	NAME="command_mnas_arx_dbx_registry_17"> mnas_arx_dbx_registry_17 </A>
        - ��������� reg-����, ��������������� ��� �������� � ������ Visual Studio Net ���������� � �������� ������ MNAS_cad_utils.</P>
    <P>
      <A HREF="./mnas_arx_dirs/mnas_arx_dirs.php"	NAME="command_mnas_arx_dirs"> mnas_arx_dirs </A>
        - ���������� ���������� � ��������� ARX, ������������� � ������� �������� AutoCAD, �� ��������� ������ �� ���������� �������.</P>
    <P>
      <A HREF="./mnas_dbx_dirs/mnas_dbx_dirs.php"	NAME="command_mnas_dbx_dirs"> mnas_dbx_dirs </A>
        - ���������� ���������� � ��������� DBX, ������������� � ������� �������� AutoCAD, �� ��������� ������ �� ���������� �������.</P>
    <P>
      <A HREF="./pd/pd.php"	NAME="command_pd"> pd </A>
        - ��������� �������� � ����� ����������� �����.</P>
    <P>
      <A HREF="./stl/stl.php"	NAME="command_stl"> stl </A>
        - ������������� � ����������� �� ��������� ����� ������ T �� ��������� �������:</P><P>"es_***,my_b_f".</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�����')" ><H2>�����</H2></A>
  </DIV>
  <DIV Name='�����' ID='�����' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./eml/eml.php"	NAME="command_eml"> eml </A>
        - ������� ��������, ���������� � dat ����� � ������� entmake.</P>
    <P>
      <A HREF="./ems/ems.php"	NAME="command_ems"> ems </A>
        - ���������� �������� �� ������� dat ����� � �������, ��������� �������� entmake.</P>
    <P>
      <A HREF="./exel_read/exel_read.php"	NAME="command_exel_read"> exel_read </A>
        - ������ ������ �� Exel</P>
    <P>
      <A HREF="./exelread/exelread.php"	NAME="command_exelread"> exelread </A>
        - ���������� ������ �� Exel.</P>
    <P>
      <A HREF="./kompas_in/kompas_in.php"	NAME="command_kompas_in"> kompas_in </A>
        - ������ �� �������� ������ V4.</P>
    <P>
      <A HREF="./kompas_out/kompas_out.php"	NAME="command_kompas_out"> kompas_out </A>
        - ������� � ������� ������ V4.</P>
    <P>
      <A HREF="./read_exel/read_exel.php"	NAME="command_read_exel"> read_exel </A>
        - ������ �� Exel.</P>
    <P>
      <A HREF="./read_mea/read_mea.php"	NAME="command_read_mea"> read_mea </A>
        - �������������� �����, �������� � ������� mea (������������� ������ MISTRAL).</P>
    <P>
      <A HREF="./write_exel/write_exel.php"	NAME="command_write_exel"> write_exel </A>
        - ������ � ������� Exel.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�������')" ><H2>�������</H2></A>
  </DIV>
  <DIV Name='�������' ID='�������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./make_ublock/make_ublock.php"	NAME="command_make_ublock"> make_ublock </A>
        - ������� �������������� ����</P>
    <P>
      <A HREF="./nobj/nobj.php"	NAME="command_nobj"> nobj </A>
        - ���������� ������ ���������� ������������.</P>
    <P>
      <A HREF="./nobjxd/nobjxd.php"	NAME="command_nobjxd"> nobjxd </A>
        - ���������� ������ � ����������� ������ ���������� ������������.</P>
    <P>
      <A HREF="./obj/obj.php"	NAME="command_obj"> obj </A>
        - ���������� ������ ���������� ���������.</P>
    <P>
      <A HREF="./obj_data/obj_data.php"	NAME="command_obj_data"> obj_data </A>
        - ���������� ldata ������, ��������� � ��������� ����������, �� ������������ �������.</P>
    <P>
      <A HREF="./objxd/objxd.php"	NAME="command_objxd"> objxd </A>
        - ���������� ������ � ����������� ������ ���������� ���������.</P>
    <P>
      <A HREF="./vla-obj/vla-obj.php"	NAME="command_vla-obj"> vla-obj </A>
        - ���������� ��� vla �������.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('���������')" ><H2>���������</H2></A>
  </DIV>
  <DIV Name='���������' ID='���������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./ax_a/ax_a.php"	NAME="command_ax_a"> ax_a </A>
        - ���������� ���� � �����.</P>
    <P>
      <A HREF="./ax_c/ax_c.php"	NAME="command_ax_c"> ax_c </A>
        - ���������� ���������� � �����.</P>
    <P>
      <A HREF="./ax_ca/ax_ca.php"	NAME="command_ax_ca"> ax_ca </A>
        - ���������� ���������� � ���� � �����.</P>
    <P>
      <A HREF="./c_axis/c_axis.php"	NAME="command_c_axis"> c_axis </A>
        - ���������� ���� ��� ���������� ����������� � ���.</P>
    <P>
      <A HREF="./c_d/c_d.php"	NAME="command_c_d"> c_d </A>
        - ���������� ���������� �� �������� � ����������� �����.</P>
    <P>
      <A HREF="./c_el/c_el.php"	NAME="command_c_el"> c_el </A>
        - ���������� �������� ����������.</P>
    <P>
      <A HREF="./c_ex/c_ex.php"	NAME="command_c_ex"> c_ex </A>
        - ���������� ���������� ���� ����������� ������� ��������.</P>
    <P>
      <A HREF="./c_r/c_r.php"	NAME="command_c_r"> c_r </A>
        - ���������� ���������� �� ������� � ����������� �����.</P>
    <P>
      <A HREF="./cl_els/cl_els.php"	NAME="command_cl_els"> cl_els </A>
        - ���������� ��������� ����������� �� �������� ���.</P>
    <P>
      <A HREF="./cl_s/cl_s.php"	NAME="command_cl_s"> cl_s </A>
        - ���������� ������ �����������, ������� ���� �����.</P>
    <P>
      <A HREF="./d_chamf/d_chamf.php"	NAME="command_d_chamf"> d_chamf </A>
        - ��������� � ������.</P>
    <P>
      <A HREF="./d_off/d_off.php"	NAME="command_d_off"> d_off </A>
        - ����� � ����������� (ang+dir_0) �� �����, ������� �� ������������� � dir_0</P><P>���������� ����� p0 �� ���������� rad, �������� ����� �� ����������� dir_0</P><P>����� off ; ���������� � ��� ; � ����� ���������� ����� ���� �����.</P>
    <P>
      <A HREF="./d_otv/d_otv.php"	NAME="command_d_otv"> d_otv </A>
        - ��������� ��� �����.</P>
    <P>
      <A HREF="./d_rez/d_rez.php"	NAME="command_d_rez"> d_rez </A>
        - ���������� ���������� ���������</P>
    <P>
      <A HREF="./p_axis/p_axis.php"	NAME="command_p_axis"> p_axis </A>
        - ���������� ���� ��� ���������� ����������� � ���.</P>
    <P>
      <A HREF="./r_off/r_off.php"	NAME="command_r_off"> r_off </A>
        - ����� � ����������� (ang+dir_0) �� �����, ������� �� ������������� � dir_0</P><P>���������� ����� p0 �� ���������� rad, �������� ����� �� ����������� dir_0</P><P>����� off.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�������')" ><H2>�������</H2></A>
  </DIV>
  <DIV Name='�������' ID='�������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./bas/bas.php"	NAME="command_bas"> bas </A>
        - ����������� ���.</P>
    <P>
      <A HREF="./bot/bot.php"	NAME="command_bot"> bot </A>
        - ����������� ������ ��� ������.</P>
    <P>
      <A HREF="./cut/cut.php"	NAME="command_cut"> cut </A>
        - ���������� ����������� ������� ��� �������.</P>
    <P>
      <A HREF="./d_up/d_up.php"	NAME="command_d_up"> d_up </A>
        - ���������� ������� �������� �� ��������� ������, � ������� ��� ���� �������.</P>
    <P>
      <A HREF="./dop/dop.php"	NAME="command_dop"> dop </A>
        - ���������� � ������ ���������� ��������� ����������� ��������� � �������� ���������� ����������.</P>
    <P>
      <A HREF="./edpos/edpos.php"	NAME="command_edpos"> edpos </A>
        - ������ ��� �������������� �������. ������ MNASPozition.</P><P>   Select  - ����� ������� ��� ��������������;</P><P>   Apply   - ���������� ��� ������� ������������ ������� ���������, ����������� � �������;</P><P>   M_ApplY - ��������� ��������� �������� ������� ������� � ��������� ��������;</P><P>   On      - �������� ������� ���� ������� ��� ��������, ����������� �� M_Apply;</P><P>   Off     - ��������� ������� ���� ������� ��� ��������, ����������� �� M_Apply. ���������� M_Apply ����� ����� Off �� ���������� ������� ������� ���������.</P><P>   Default - ���������� ���� ������, ������� ������, ��������� ������, ��������� ��� ���������� �������� M_Aplly � �������� �� ���������.</P>
    <P>
      <A HREF="./format/format.php"	NAME="command_format"> format </A>
        - ���������� ��������� �����.</P>
    <P>
      <A HREF="./index/index.php"	NAME="command_index"> index </A>
        - ������� �� ����� ���������� ����, ����������� ������ ������ � ������ ��� ������������ ������������ ����������� ���, ����������� �������, �������.</P>
    <P>
      <A HREF="./index_en/index_en.php"	NAME="command_index_en"> index_en </A>
        - ����������� ������� ��� ���, ����������� ������� � �������� �� ���������� �������.</P>
    <P>
      <A HREF="./index_ru/index_ru.php"	NAME="command_index_ru"> index_ru </A>
        - ����������� ������� ��� ���, ����������� ������� � �������� �� ������� �������.</P>
    <P>
      <A HREF="./ins_blk/ins_blk.php"	NAME="command_ins_blk"> ins_blk </A>
        - ������� ����� � ��������� ������ �������� ��������.</P>
    <P>
      <A HREF="./look/look.php"	NAME="command_look"> look </A>
        - ���������� ����������� ����.</P>
    <P>
      <A HREF="./pos_export/pos_export.php"	NAME="command_pos_export"> pos_export </A>
        - ���������� �������� ������ ������� � ����.</P>
    <P>
      <A HREF="./poz/poz.php"	NAME="command_poz"> poz </A>
        - ����������� �������, ����������� ���� ���������, ����������, ����������� �����.</P>
    <P>
      <A HREF="./rou/rou.php"	NAME="command_rou"> rou </A>
        - ����������� ����������� �������������.</P>
    <P>
      <A HREF="./rou_i2/rou_i2.php"	NAME="command_rou_i2"> rou_i2 </A>
        - ����������� ����������� �������������.</P>
    <P>
      <A HREF="./spec/spec.php"	NAME="command_spec"> spec </A>
        - ������� ����������� �������.</P>
    <P>
      <A HREF="./up/up.php"	NAME="command_up"> up </A>
        - ����������� ����� ��� ��������� ������.</P><P>1) �������� ����� ����������� �������� ���� �����.</P><P>2) ������������ ����� �� ��������� ���������� ��� ���� ������.</P><P>����������:</P><P>1) ����� ������� � ���������� ����.</P><P>2) ������ ��������� ������������ ������.</P><P>2.1) ���������� �� �����.</P><P>2.2) ������������� ������������ ��������� �����.</P>
    <P>
      <A HREF="./welding/welding.php"	NAME="command_welding"> welding </A>
        - ���������� ����������� ��������� ����. �� ���������.</P>
    <P>
      <A HREF="./welding/welding.php"	NAME="command_welding"> welding </A>
        - ���������� ����������� ��������� ����. �� ���������.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�������')" ><H2>�������</H2></A>
  </DIV>
  <DIV Name='�������' ID='�������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./f_kolca/f_kolca.php"	NAME="command_f_kolca"> f_kolca </A>
        - ���������� ������� ������.</P>
    <P>
      <A HREF="./for_proect/for_proect.php"	NAME="command_for_proect"> for_proect </A>
        - ���������������� ������ �������������� ��������.</P>
    <P>
      <A HREF="./for_prov/for_prov.php"	NAME="command_for_prov"> for_prov </A>
        - ����������� ������ �������������� ������������ ������ ����������� � ���������� ������.</P>
    <P>
      <A HREF="./for_prover/for_prover.php"	NAME="command_for_prover"> for_prover </A>
        - ����������� ������ �������������� ��������.</P>
    <P>
      <A HREF="./lo/lo.php"	NAME="command_lo"> lo </A>
        - ���������� ������� �������.</P>
    <P>
      <A HREF="./pr1/pr1.php"	NAME="command_pr1"> pr1 </A>
        - ������ ������.</P>
    <P>
      <A HREF="./pr2/pr2.php"	NAME="command_pr2"> pr2 </A>
        - ������ ������.</P>
    <P>
      <A HREF="./ras_har_gas/ras_har_gas.php"	NAME="command_ras_har_gas"> ras_har_gas </A>
        - ���������� ��������� �������������� ������� ��������.</P>
    <P>
      <A HREF="./ras_har_lic/ras_har_lic.php"	NAME="command_ras_har_lic"> ras_har_lic </A>
        - ���������� ��������� �������������� ���������� ��������.</P>
    <P>
      <A HREF="./rep/rep.php"	NAME="command_rep"> rep </A>
        - ������� ����������.</P>
    <P>
      <A HREF="./�����������/�����������.php"	NAME="command_�����������"> ����������� </A>
        - not defined</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('����')" ><H2>����</H2></A>
  </DIV>
  <DIV Name='����' ID='����' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./am_la/am_la.php"	NAME="command_am_la"> am_la </A>
        - not defined</P>
    <P>
      <A HREF="./bl_all_on/bl_all_on.php"	NAME="command_bl_all_on"> bl_all_on </A>
        - �������� ��� ����, �������� � ������ �����.</P>
    <P>
      <A HREF="./bl_all_th/bl_all_th.php"	NAME="command_bl_all_th"> bl_all_th </A>
        - ������������� ��� ����, �������� � ������ �����.</P>
    <P>
      <A HREF="./bl_fr/bl_fr.php"	NAME="command_bl_fr"> bl_fr </A>
        - ������������ ����, �������� � ����, ��� �������� �� ������ � ������� �����.</P>
    <P>
      <A HREF="./bl_off/bl_off.php"	NAME="command_bl_off"> bl_off </A>
        - ��������� ����, �������� � ����, ��� �������� �� ������ � ������� �����.</P>
    <P>
      <A HREF="./cl_s_d/cl_s_d.php"	NAME="command_cl_s_d"> cl_s_d </A>
        - �������� � (���) ��������� � ������� �������� ����� ������ ����, ����������� ��������� + "_d".</P>
    <P>
      <A HREF="./cl_sw_d/cl_sw_d.php"	NAME="command_cl_sw_d"> cl_sw_d </A>
        - ��������� � ������� �������� ���� � ������ ����,</P><P>����������� ��������� ��� ��������� "_d".</P>
    <P>
      <A HREF="./lay/lay.php"	NAME="command_lay"> lay </A>
        - ������� ���������� ������</P><P> � ����������� �� ����� ���������:</P><P> 1)  Set - ������������� ������� ����;</P><P> 2)  OFF - ��������� ���������� ���� ����,</P><P> 3)  WO - ��������� ��� ���� �� ����������� ����������;</P><P> 4)  FR - ������������ ���������� ����;</P><P> 5)  WFr - ������������ ��� ���� �� ����������� ����������;</P><P> 6)  LO - ����������� ���������� ����;</P><P> 7)  WL  - ����������� ��� ���� �� ����������� ����������;</P><P> 8)  Un - �������������� ���������� ����;</P><P> 9)  Col - �������� ���� ��� ���������� �����;</P><P> 10) AO  - �������� ��� ����;</P><P> 11) AT - ������������� ��� ����;</P><P> 12) AU - �������������� ��� ����;</P><P> 13) Exit - �������� �� ������� ���������� ������.</P>
    <P>
      <A HREF="./llay/llay.php"	NAME="command_llay"> llay </A>
        - not defined</P>
    <P>
      <A HREF="./ml_off/ml_off.php"	NAME="command_ml_off"> ml_off </A>
        - ��������� ���� �� ���������������� ����������,</P><P> ���������������� �� "*work".</P>
    <P>
      <A HREF="./ml_off_c/ml_off_c.php"	NAME="command_ml_off_c"> ml_off_c </A>
        - not defined</P>
    <P>
      <A HREF="./ml_on/ml_on.php"	NAME="command_ml_on"> ml_on </A>
        - �������� ���� �� ���������������� ����������,</P><P> ���������������� �� "*work".</P>
    <P>
      <A HREF="./ml_on_c/ml_on_c.php"	NAME="command_ml_on_c"> ml_on_c </A>
        - not defined</P>
    <P>
      <A HREF="./rgb/rgb.php"	NAME="command_rgb"> rgb </A>
        - ������� ��������� �����.</P>
    <P>
      <A HREF="./sl_fr/sl_fr.php"	NAME="command_sl_fr"> sl_fr </A>
        - ������������� ����� �� �������.</P>
    <P>
      <A HREF="./sl_lo/sl_lo.php"	NAME="command_sl_lo"> sl_lo </A>
        - ���������� ����� �� �������.</P>
    <P>
      <A HREF="./sl_off/sl_off.php"	NAME="command_sl_off"> sl_off </A>
        - ���������� ����� �� �������.</P>
    <P>
      <A HREF="./sl_on/sl_on.php"	NAME="command_sl_on"> sl_on </A>
        - ��������� ����� �� �������.</P>
    <P>
      <A HREF="./sl_th/sl_th.php"	NAME="command_sl_th"> sl_th </A>
        - �������������� ����� �� �������.</P>
    <P>
      <A HREF="./sl_un/sl_un.php"	NAME="command_sl_un"> sl_un </A>
        - ���������� ����� �� �������.</P>
    <P>
      <A HREF="./svl_fr/svl_fr.php"	NAME="command_svl_fr"> svl_fr </A>
        - ������������� ����� �� ������� ��� ������� ����� ���������.</P>
    <P>
      <A HREF="./svl_th/svl_th.php"	NAME="command_svl_th"> svl_th </A>
        - �������������� ����� �� ������� ��� ������� ����� ���������.</P>
    <P>
      <A HREF="./vl_fr/vl_fr.php"	NAME="command_vl_fr"> vl_fr </A>
        - ��������� ���������� ����� ��� ������� ����� ���������.</P>
    <P>
      <A HREF="./vl_fr_w/vl_fr_w.php"	NAME="command_vl_fr_w"> vl_fr_w </A>
        - ������������� ���� �� ����������� ��������� ����� ��� ������� �����.</P>
    <P>
      <A HREF="./vl_fr_w+_d/vl_fr_w+_d.php"	NAME="command_vl_fr_w+_d"> vl_fr_w+_d </A>
        - ���������� ��� ������������� ����� ��������� ����������� ����</P><P>� ����, ������������� � ��� �� �������� ��� � � ����������� ����,</P><P>� ��������������� �� "_d".</P>
    <P>
      <A HREF="./vl_s_d/vl_s_d.php"	NAME="command_vl_s_d"> vl_s_d </A>
        - �������� ������������� �� ���� ������ ��������� � (���)</P><P>��������� � ������� �������� ����,</P><P>� ������ ���� ����������� ��������� + "_d".</P>
    <P>
      <A HREF="./vl_th/vl_th.php"	NAME="command_vl_th"> vl_th </A>
        - ���������� ���������� ����� ��� ������ ����� ���������.</P>
    <P>
      <A HREF="./vl_th_all/vl_th_all.php"	NAME="command_vl_th_all"> vl_th_all </A>
        - ���������� ���� ����� ��� ������� ����� ���������.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('���������')" ><H2>���������</H2></A>
  </DIV>
  <DIV Name='���������' ID='���������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./clear:sm/clear:sm.php"	NAME="command_clear:sm"> clear:sm </A>
        - ������ ������� �������� ������ ������� smesitel_vla.</P><P>������� ���������� ������� ������, ��������� � ����������� smesitel_vla.</P><P>� �������� �������� ���������� ������������ ������� ���������� ��������� ������ �� ������������ ������� smesitel_vla.</P><P>��� ������ ������������ ������ �� ����� ��������, �������������� ���������� ���������.</P><P>���� � ���������� ������ �������������� ������� ����� ���������� ���� ����� ��� ������ ������� prep:sm -� ����� ������ ��� ����� ���������� ��� �������� ����������.��. ������� dr:sm.</P>
    <P>
      <A HREF="./dr:sech/dr:sech.php"	NAME="command_dr:sech"> dr:sech </A>
        - ���������� ���������� ������� ���������.</P>
    <P>
      <A HREF="./dr:sm/dr:sm.php"	NAME="command_dr:sm"> dr:sm </A>
        - ������ Smesitel_vla.</P><P>������ ������������ ��� �������������� ����������� ������� ��������� ������� �����.</P><P>������ ���������� ��������� �������:</P><P>prep:sm    - ���������� ������ ��� ���������� ��������;</P><P>dr:sm      - ��������� ��������� �� �������������� ������;</P><P>dr:sech    - ��������� ���������� ������� �� �����;</P><P>clear:sm   - ������� ������ ����������, ����������� � ����������� �������;vla-obj    - ������������� ��� ������ ����� �� ���������� ���������.</P><P></P><P>������ ���������� ��������� ����������, ������������ ��� �������� ���������� � �������������� ���������� ���������:</P><P>v_pl_axis      - ��� ���������;</P><P></P><P>v_spl_top      - ������� ���������� ���������;</P><P>v_spl_bot      - ������ ���������� ���������;</P><P></P><P>v_l_axis       - ��� ������� ��� ������������ ��������� ����;</P><P></P><P>v_spl_l_bok    - ������� ���������� ���������;</P><P>v_spl_r_top    - ������ ������� ����������;</P><P>v_spl_kr_bot   - �������� ������ ����������;</P><P>v_spl_r_kt     - ������ �������� �� ������� ���������� � ������� ����������;</P><P>v_spl_r_kb     - ������ �������� �� ������� ���������� � ������ ����������;</P><P>v_spl_alfa_bok - ����������� ����, ���������� � ��������, ����� ���� ������� ������� � ���������������, ��������� �� ������ ��������� ������� �� ������� ����������.</P><P></P><P>������� ���������� ������� ��������� ��������� � ���������� area_lst.</P><P>����� �������������� ���������� ������� ��������� � ���������� length_lst.</P><P>��� ���������� �������� ������������ ������� ����������� ������� � �������������� ������� ��������������� �������� a1.</P><P></P>
    <P>
      <A HREF="./prep:sm/prep:sm.php"	NAME="command_prep:sm"> prep:sm </A>
        - ���������� ������ ��� ���������� ���������. ��. ������� dr:sm.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�������')" ><H2>�������</H2></A>
  </DIV>
  <DIV Name='�������' ID='�������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./check_command_category_list/check_command_category_list.php"	NAME="command_check_command_category_list"> check_command_category_list </A>
        - ��������� ������������ ��������� ������� � lsp-������. ������� �������� ������������ ��������.</P>
    <P>
      <A HREF="./man/man.php"	NAME="command_man"> man </A>
        - ������� ����������� ���������� ���������� �� ��������, ������������ �������������.</P><P>   Command  - ��������� ���������� ����� ������� �� ������� � ����� � ������� ���������� ���������� ���;</P><P>   Keywords - ��������� ���������� ����� ������� �� ������� � �������� ������� � ������� ���������� ���������� ���;</P><P>   List     - ������� �������� �����, ������������ �������������;</P><P>   Rebuild  - ��������� ���������� ���������� �� lsp - ������, ������������ ���� ������ ������;</P><P>   ����������: ��� ������������� ����� Rebuild � ������ ������ ������: (malform-list) ���������� ����� � ����� prj/man/man_data_base.lsp ��������� ��������� ������ � ����� ��������������� ��� ������ � ����� prj/man/man_data.txt ������ ����� ����.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('������')" ><H2>������</H2></A>
  </DIV>
  <DIV Name='������' ID='������' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./&A&B&C/&A&B&C.php"	NAME="command_&A&B&C"> &A&B&C </A>
        - ��������� � ������ ���������� ��������� ����������� ���������� ����������.</P>
    <P>
      <A HREF="./ate/ate.php"	NAME="command_ate"> ate </A>
        - �������������� ��������.</P>
    <P>
      <A HREF="./de/de.php"	NAME="command_de"> de </A>
        - �������� ������ ��� �������������� ������ ���������� ��������� �����:MTEXT, TEXT, DIMENSION.</P>
    <P>
      <A HREF="./l_text/l_text.php"	NAME="command_l_text"> l_text </A>
        - ������� ��������� ��������, ��������� �������� �������� ��� ����,</P><P>�� ������� ��������� ��������� ��������.</P>
    <P>
      <A HREF="./pos_export/pos_export.php"	NAME="command_pos_export"> pos_export </A>
        - ���������� �������� ������ ������� � ����.</P>
    <P>
      <A HREF="./te/te.php"	NAME="command_te"> te </A>
        - ���������� �������������� ������� � ������� ��������� ����������.</P>
    <P>
      <A HREF="./te%%c/te%%c.php"	NAME="command_te%%c"> te%%c </A>
        - ��������� ���� �������� ����� ������� ���������� ���������.</P>
    <P>
      <A HREF="./te+/te+.php"	NAME="command_te+"> te+ </A>
        - ��������� ������� ������ ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te+/te+.php"	NAME="command_te+"> te+ </A>
        - ��������� ������� ������ ������������ ������� ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te++kvsk/te++kvsk.php"	NAME="command_te++kvsk"> te++kvsk </A>
        - ��������� ���������� ������ ������������ ������� ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te+kvsk/te+kvsk.php"	NAME="command_te+kvsk"> te+kvsk </A>
        - ��������� ���������� ������ ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te-/te-.php"	NAME="command_te-"> te- </A>
        - ������� ������� ������, ������������ ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te-%%c/te-%%c.php"	NAME="command_te-%%c"> te-%%c </A>
        - ������� ���� ��������, ������������ ����� ������� ���������� ���������.</P>
    <P>
      <A HREF="./te-kvsk/te-kvsk.php"	NAME="command_te-kvsk"> te-kvsk </A>
        - ������� ���������� ������, ������������ ������ ������ ���������� ���������.</P>
    <P>
      <A HREF="./te_*/te_*.php"	NAME="command_te_*"> te_* </A>
        - ��������� � ������ ���������� ��������� ������ ���������.</P>
    <P>
      <A HREF="./te_<>_/te_<>_.php"	NAME="command_te_<>_"> te_<>_ </A>
        - ��������� ��� ����������� ������� ������ ������ �������.</P>
    <P>
      <A HREF="./text_export/text_export.php"	NAME="command_text_export"> text_export </A>
        - ������������ ����� ���������� �� ������� ����.</P>
    <P>
      <A HREF="./text_extract/text_extract.php"	NAME="command_text_extract"> text_extract </A>
        - not defined</P>
    <P>
      <A HREF="./to_15/to_15.php"	NAME="command_to_15"> to_15 </A>
        - ��������� ��������� �������� �� ���� � 15 ���.</P>
    <P>
      <A HREF="./x45%%d/x45%%d.php"	NAME="command_x45%%d"> x45%%d </A>
        - ��������� ���� "�� 45 ��������" ����� ������ ���������� ���������.</P>
    <P>
      <A HREF="./z_text/z_text.php"	NAME="command_z_text"> z_text </A>
        - ������� �����, ��������� �������� �������� ���������� z.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�����')" ><H2>�����</H2></A>
  </DIV>
  <DIV Name='�����' ID='�����' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./rot_p/rot_p.php"	NAME="command_rot_p"> rot_p </A>
        - ����� ���������� � ���������.</P>
    <P>
      <A HREF="./xy/xy.php"	NAME="command_xy"> xy </A>
        - ����� �� �����������.</P>
    <P>
      <A HREF="./xy_sc/xy_sc.php"	NAME="command_xy_sc"> xy_sc </A>
        - ����� �� ����������� � ���������.</P>
  </DIV>
  <DIV>
    <A href='javascript: show_hide(id)' onclick="show_hide('�����')" ><H2>�����</H2></A>
  </DIV>
  <DIV Name='�����' ID='�����' Style='text-indent:15pt;display:none'>
    <P>
      <A HREF="./a1/a1.php"	NAME="command_a1"> a1 </A>
        - ���������� ��������� � ����������� ���� ����. ��������: 1) ��� �; 2) ��� Y; 3) ��� ����������, ������� �������� ������ �����.</P>
    <P>
      <A HREF="./a2/a2.php"	NAME="command_a2"> a2 </A>
        - ���������� ����� � ����������� �����. ��������: 1) ��� �; 2) ���������� X.</P>
    <P>
      <A HREF="./a2t/a2t.php"	NAME="command_a2t"> a2t </A>
        - ���������� ����� � ����������� ����� � ��������� ������. ��������: 1) ��� �; 2) ���������� X.</P>
    <P>
      <A HREF="./a2xy_t/a2xy_t.php"	NAME="command_a2xy_t"> a2xy_t </A>
        - ���������� ����� � ����������� ����� � ��������� ������. ��������: 1) ��� �; 2) ��� Y; 3) ���������� X.</P>
    <P>
      <A HREF="./a2xyn_t/a2xyn_t.php"	NAME="command_a2xyn_t"> a2xyn_t </A>
        - ���������� ����� � ����������� 2-� ���� � ��������� ������. ��������: 1) ��� �; 2) ��� Y; 3) ���������� X.</P>
    <P>
      <A HREF="./a4/a4.php"	NAME="command_a4"> a4 </A>
        - ���������� ����� � ����������� ���� ���� ��������: 1) ��� �; 2) ��� Y; 3) ����� � ����������� ���� X-Y.</P>
    <P>
      <A HREF="./a5/a5.php"	NAME="command_a5"> a5 </A>
        - ������� ����� �� ��������� ���� ���� � ���������� ������ ��������: 1) ��� �; 2) ��� Y; 3) ����� � ����������� ���� X-Y.</P>
    <P>
      <A HREF="./a6/a6.php"	NAME="command_a6"> a6 </A>
        - ������� ����� �� ��������� ����� ���� ���� � ���������� ������ ���� ���� ��������: 1) ��� � �� ������� ������� �����; 2) ��� Y �� ������� ������� �����; 3) ��� � � ������� �������� �����; 4) ��� Y � ������� �������� �����; 5) ����� � ����������� ���� X-Y.</P>
    <P>
      <A HREF="./ax/ax.php"	NAME="command_ax"> ax </A>
        - not defined</P>
    <P>
      <A HREF="./ax_shcala/ax_shcala.php"	NAME="command_ax_shcala"> ax_shcala </A>
        - ���������� ������� �����.</P>
    <P>
      <A HREF="./c1/c1.php"	NAME="command_c1"> c1 </A>
        - ���������� ����� �� ����� �� ��������.</P>
    <P>
      <A HREF="./c2/c2.php"	NAME="command_c2"> c2 </A>
        - ����������� �������� �� ����� �� �����.</P>
    <P>
      <A HREF="./c3/c3.php"	NAME="command_c3"> c3 </A>
        - ���������� ����� � ����������� 2-� ����.</P>
    <P>
      <A HREF="./c4/c4.php"	NAME="command_c4"> c4 </A>
        - ������� ���������� ���������� �����.</P>
    <P>
      <A HREF="./ea/ea.php"	NAME="command_ea"> ea </A>
        - ���������� �������������� ���������� ���� LINE � �������� � ������������ ������� ���� "SHCKALA".</P><P> ����������� ����� ����� ��������� ���:</P><P>(-3  ("SHCKALA"      ; - ��� ����������</P><P>    (1002 . "{")    (1040 . 0.0)    ; - �������� �� ����� � ��������� ����� �������</P><P>    (1040 . 100.0)  ; - �������� �� ����� � �������� ����� �������</P><P>    (1070 . 0)      ; - ��� �����: 0-����������������; 1-���������������</P><P>    (1000 . "xx") ; - ��� �����</P><P>    (1002 . "}")  ))</P>
    <P>
      <A HREF="./gr/gr.php"	NAME="command_gr"> gr </A>
        - ��������� ��� ���������� �������.</P>
    <P>
      <A HREF="./graf/graf.php"	NAME="command_graf"> graf </A>
        - ���������� �������.</P>
  </DIV>