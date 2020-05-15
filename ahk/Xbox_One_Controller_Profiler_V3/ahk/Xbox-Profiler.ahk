#SingleInstance,Force
#Persistent

DetectHiddenWindows,On
SetBatchLines,-1
CoordMode,Mouse,Screen
global settings,program,v:=[]
if((A_PtrSize=8&&A_IsCompiled="")||!A_IsUnicode){
	SplitPath,A_AhkPath,,dir
	if(!FileExist(correct:=dir "\AutoHotkeyU32.exe")){
		m("Requires AutoHotkey 1.1 to run")
		ExitApp
	}
	Run,"%correct%" "%A_ScriptName%",%A_ScriptDir%
	ExitApp
	return
}
settings:=new XML("settings"),v.gui:=[]
new xbox(0)
xbox.Edit()
Gui()
Add_Radius_Constraint(){
	top:=Top(),Deselect(),settings.Under(top,"Radius",{Center:"RightThumb",Dead:1,Distance:5,Read:"RThumb",select:1,X:A_ScreenWidth/2,Y:A_ScreenHeight/2}),LV(2)
}
Add_Alternate_Commands(info:=""){
	if(info){
		if(SSN(program,"descendant::Alt[@name='" info.1 "']"))
			return m("Alternate already assigned.")
		Deselect()
		return ea:=xml.EA(program),settings.Under(program,"Alt",{name:info.1,select:1}),program:=settings.SSN("//game[@name='" ea.name "']"),LV(1)
	}else
		xbox.Edit("Press either a Button or Trigger",A_ThisFunc,"Buttons","Triggers")
}
Add_Game(){
	KeyWait,%A_ThisHotkey%,U
	InputBox,name,New Game,Enter the name for the new game.
	if (ErrorLevel||name="")
		return
	select:=settings.SN("//*[@select='1']"),game:=settings.Add("game",{name:name,expand:1,select:1},,1),settings.Under({under:game,node:"DirectInput",att:{name:"Direct Input",on:1}}),settings.Under({under:game,node:"Alt",att:{name:"Main",main:1}}),settings.Add("last",{game:name}),LV_Update()
	return
}
Add_Group(){
	current:=Top(),Deselect()
	InputBox,name,Add Group,Enter a group name
	if(ErrorLevel||name="")
		return
	settings.Under(current,"Group",{name:name,select:1}),LV(2)
}
Add_Held_Key(){
	node:=settings.SSN("//*[@tv='" TV_GetSelection() "']")
	if(!node)
		node:=settings.SSN("//*[@tv='" TV_GetParent(TV_GetSelection()) "']")
	v.current:=SSN(node,"ancestor-or-self::KeyPress|ancestor-or-self::Mouse|ancestor-or-self::Radius")
	InputBox,key,Enter the name of the key to be held,Key name
	if(ErrorLevel||key="")
		return
	Deselect()
	v.current.SetAttribute("select",1)
	settings.Under(v.current,"Hold",{Hold:key})
	LV(2)
}
Add_Keypress(info){
	Deselect()
	hotkey:=v.hotkey
	StringUpper,Hotkey,Hotkey
	parent:=Top()
	top:=settings.Under(parent,"KeyPress",{Key:hotkey,select:1,Expand:1})
	if(info.3="axis")
		next:=settings.Under(top,"Axis",{Axis:info.1}),settings.Under(next,"Direction",{Direction:info.2})
	else if(info.3="Buttons")
		settings.Under(top,"Button",{Button:info.1})
	else if(info.3="Triggers")
		settings.Under(top,"Trigger",{Trigger:info.1})
	SetTimer,updateprog,-1
	LV(2)
}
Add_Mouse_Assignment(info:=""){
	static current
	if(info){
		top:=Top(),Deselect()
		next:=settings.Under(top,"Mouse",{select:1,expand:1})
		head:=settings.Under(next,"Read",{Read:SubStr(info.1,1,-1),expand:1})
		for a,b in {Dead:3,Speed:3}
			att:=[],att[a]:=b,settings.Under(head,a,att)
		LV(2)
		return
	}
	xbox.Edit("Move an analog stick","Add_Mouse_Assignment","Axis")
}
Add_XBox_Assignment(info:=""){
	v.current:=settings.SSN("//*[@tv='" TV_GetSelection() "']/ancestor-or-self::KeyPress")
	if !v.current
		return m("Please Select a KeyPress Assignment")
	xbox.Edit("Press either a Button or Trigger or Axis","Set_Info","Buttons","Triggers","Axis")
}
Class GuiKeep{
	static keep:=[]
	__New(win,info="",menu=""){
		static
		con:=[]
		for a,b in {border:32,caption:4}{
			SysGet,%a%,%b%
			this[a]:=%a%
		}
		for a,b in info{
			opt:=StrSplit(b,","),RegExMatch(opt.2,"iO)\bv(\w+)",found)
			if(found.1)
				this.var[found.1]:=1
			hwnd:=this.Add(opt)
			if(opt.4){
				ControlGetPos,x,y,w,h,,ahk_id%hwnd%
				for a,b in {x:x,y:y,w:w,h:h}
					con[hwnd,a]:=b-(a="x"?this.border*2:a="y"?(this.caption+this.border):a="h"?this.border:0)
				con[hwnd,"pos"]:=opt.4
			}
		}
		Gui,%win%:Menu,% Menu(menu)
		Gui,Show,Hide
		this.win:=win,pos:=Winpos()
		WinGetPos,xx,yy,,,% hwnd([1])
		VarSetCapacity(size,16,0),DllCall("GetClientRect","uint",hwnd(win),"uint",&size),w:=NumGet(size,8),h:=NumGet(size,12)
		flip:={x:"w",y:"h"}
		for control,b in con{
			obj:=this.gui[control]:=[]
			for c,d in StrSplit(b.pos){
				if(d~="w|h")
					obj[d]:=b[d]-%d%
				if(d~="x|y")
					val:=flip[d],obj[d]:=b[d]-%val%
			}
		}
		GuiKeep.keep[win]:=this
	}
	Add(opt:=""){
		static
		if(!opt){
			var:=[]
			Gui,% this.win ":Submit",Nohide
			for a,b in this.var
				var[a]:=%a%
			return var
		}
		Gui,Add,% opt.1,% opt.2 " hwndhwnd",% opt.3
		return hwnd
	}
	__Get(){
		return this.Add()
	}
	Current(win){
		return GuiKeep.keep[win]
	}
}
class xbox{
	static mousekeys:={LButton:"left",RButton:"right",MButton:"Middle",WheelDown:"WheelDown",WheelUp:"WheelUp"}
	,Buttons:={Up:1,Down:2,Left:4,Right:8,Start:16,Back:32,LeftThumb:64,RightThumb:128,LeftShoulder:256,RightShoulder:512,A:0x1000,B:0x2000,X:0x4000,Y:0x8000}
	,axis:={LThumbX:8,LThumbY:10,RThumbX:12,RThumbY:14},triggers:={LTrigger:6,RTrigger:7},mode:="",keys:=[],this:=[],ad:={x:["Right","Left"],y:["Up","Down"]}
	,keystroke:={22528:"A",22529:"B",22549:"Back",22545:"Down",22546:"Left",22547:"Right",22544:"Up",22533:"LeftShoulder",22561:"LThumbY_Down",22563:"LThumbX_Left",22550:"LeftThumb",22562:"LThumbX_Right",22560:"LThumbY_Up",22534:"LTrigger",22532:"RightShoulder",22577:"RThumbY_Down",22579:"RThumbX_Left",22551:"RightThumb",22578:"RThumbX_Right",22576:"RThumbY_Up",22535:"RTrigger",22548:"Start",22530:"X",22531:"Y"}
	,flip:={up:"Down",down:"Up",left:"Right",right:"Left"}
	,data:=[],all:=[]
	__New(count:=0){
		static
		for a,b in xbox.buttons
			xbox.All[a]:="Buttons"
		for a,b in xbox.triggers
			xbox.all[a]:="Triggers"
		for a,b in xbox.axis
			xbox.All[a]:="Axis"
		xbox.delta:=[],xbox.delta.x:=0,xbox.delta.y:=0
		this.library:=DllCall("LoadLibrary","str",InStr(A_OSVersion,8)?"Xinput1_4":"Xinput1_3"),this.ctrl:=[],VarSetCapacity(move,28,0),this.count:=count,main:=this,xbox.move:=&move,VarSetCapacity(State,16),xbox.state:=&state
		main.ctrl:=[],NumPut(1,move,16)
		if !(this.library){
			m("Error loading the DLL")
			ExitApp
		}
		for a,b in {xGetState:"XInputGetState",xBattery:"XInputGetBatteryInformation",xSetState:"XInputSetState",xkeystroke:"XInputGetKeystroke"}
			this[a]:=DllCall("GetProcAddress","ptr",this.library,"astr",b)
		xbox.main:=this,down:=hold:=value:=[]
		gosub,updateprog
		Return this
		updateprog:
		rel:=SN(program,"descendant::*[@pressed='1']")
		while,rl:=rel.item[A_Index-1]
			xbox.send(rl,"Up"),rl.RemoveAttribute("pressed")
		xbox.input:=SSN(program,"descendant::DirectInput/@on").text,mn:=SSN(program,"Alt[@main='1']"),alts:=SN(program,"Alt[@name!='Main']"),alt:=[]
		while,aa:=alts.item[A_Index-1],ea:=xml.EA(aa)
			Alt[ea.name]:=aa
		return
		getstate:
		DllCall(main.xGetState,"uint",0,uptr,&State),buttons:=NumGet(state,4)
		xbox.currentstate:=&state,xbox.buttonstate:=buttons,alts:=xbox.KS(SN(program,"Alt[@name!='Main']")),current:=alts?SSN(program,"Alt[@name='" alts "']"):mn
		if(current.xml!=last.xml){
			rel:=SN(last,"descendant::*[@pressed='1']")
			while,rl:=rel.item[A_Index-1]
				xbox.send(rl,"Up"),rl.RemoveAttribute("pressed")
		}
		last:=current,list:=SN(current,"descendant::KeyPress|descendant::Mouse|descendant::Radius")
		while,ll:=list.item[A_Index-1],ea:=xml.EA(ll){
			if(ll.nodename="radius"),value:=[]{
				for c,d in ["x","y"]
					value[d]:=Floor(NumGet(state,xbox.axis[ea.read d],"short")/3276*10)
				if(xbox.KS(SN(ll,"descendant-or-self::*"))&&ea.pressed!=1){
					MouseGetPos,x,y
					for a,b in {X:x,Y:y}
						ll.SetAttribute(a,b)
					ll.SetAttribute("pressed",1)
					while,child:=TV_GetChild(ea.tv)
						TV_Delete(child)
					for a,b in ["Center","Dead","Distance","Read","X","Y"]
						TV_Add(b " = " ea[b],ea.tv)
					return
				}
				centerx:=ea.x?ea.x:A_ScreenWidth/2,centery:=ea.y?ea.y:A_ScreenHeight/2
				if(Abs(value.x)>ea.dead*15||Abs(value.y)>ea.dead*15)
					MouseMove,% (centerx+(value.x*(ea.distance/5))),% (centery-(value.y*(ea.distance/5)))
			}
			if(ll.nodename="keypress"){
				if(xbox.GS(SN(ll,"*"))){
					if(ea.pressed!=1)
						ll.SetAttribute("pressed",1),xbox.send(ll,"Down")
				}else if(ea.pressed)
					xbox.send(ll,"Up"),ll.RemoveAttribute("pressed")
			}
			if(ll.nodename="mouse"){
				value:=xbox.GS(SN(ll,"descendant::Read")),dead:=SSN(ll,"descendant::Dead/@Dead").text
				if(Abs(value.x)>dead||Abs(value.y)>dead){
					if(ea.pressed!=1)
						ll.SetAttribute("pressed",1),xbox.send(ll,"Down")
					value.y:=a.invert?value.y:value.y*-1,NumPut(value.x,xbox.move,4),NumPut(value.y,xbox.move,8),speed:=Abs(value.x)>Abs(value.y)?Abs(value.x):Abs(value.y),speed:=speed?speed:1,movey:=a.yinvert?movey:movey*-1,speed1:=SSN(ll,"descendant::Speed/@Speed").text
					Loop,% Abs(speed/(speed1/2))
						DllCall("User32\SendInput",uint,1,uptr,xbox.move,uint,28)
				}else if(ea.pressed)
					xbox.send(ll,"Up"),ll.RemoveAttribute("pressed")
			}
		}
		return
	}
	KS(info){
		while,ii:=info.item[A_Index-1],ea:=xml.EA(ii){
			name:=ea.center?ea.center:ea.name
			if(value:=xbox.buttonstate&xbox.buttons[name])
				return xbox.buttonstate&value?name:""
			if(number:=xbox.triggers[name])
				if(NumGet(xbox.currentstate,xbox.triggers[name],"uchar")/255*10>2?1:0)
					return NumGet(xbox.currentstate,value,"uchar")/255*10>2?name:0
		}
	}
	Edit(msg,func,type*){
		static
		Gui,3:Destroy
		Gui,3:Default
		Gui,3:+hwndInputRequired +ToolWindow
		Gui,Add,Text,w200 h100 Center,`n`n%msg%`n`nOr press Escape to cancel
		Gui,Show,,Input Required
		Hotkey,IfWinActive,% hwnd([1])
		Hotkey,Escape,stop,On
		type1:=type,function:=func
		VarSetCapacity(state,4)
		SetTimer,edit,50
		return
		stop:
		3GuiClose:
		3GuiEscape:
		Gui,3:Destroy
		SetTimer,Edit,Off
		Hotkey,IfWinActive,% hwnd([1])
		Hotkey,Escape,stop,Off
		return
		edit:
		DllCall(xbox.main.xkeystroke,int,0,int,0,"ptr",&state)
		if(NumGet(state,4)=1){
			pressed:=StrSplit(xbox.keystroke[NumGet(state)],"_")
			for a,b in type1{
				if(xbox[b,pressed.1]){
					SetTimer,Edit,Off
					Gui,3:Destroy
					%function%([pressed.1,pressed.2,b])
				}
			}
		}
		return
	}
	Send(key,state){
		keys:=SN(key,"descendant-or-self::*/@Hold|@Key")
		while,kk:=keys.Item[A_Index=keys.length?0:A_Index]{
			if this.mousekeys[kk.text]{
				if InStr(kk.text,"wheel")&&state="Down"
					MouseClick,% this.mousekeys[kk.text]
				Else if !InStr(kk.text,"wheel")
					MouseClick,% this.mousekeys[kk.text],,,,,%state%
			}
			else{
				if(xbox.input){
					DllCall("keybd_event","int",GetKeyVK(kk.text),"int",0,"int",state="down"?0:2,"int",0)
				}else{
					key:=kk.text
					ControlSend,,{%key% %state%},A
				}
			}
		}
	}
	GS(info){
		obj:=[]
		while,ii:=info.item[A_Index-1]{
			if(ii.nodename="hold")
				Continue
			all:=SN(ii,"descendant-or-self::*/@*")
			while,aa:=all.item[A_Index-1]
				obj[aa.NodeName]:=aa.text
			if(obj.button)
				if(!check:=xbox.buttonstate&xbox.Buttons[obj.button])
					return
			if(obj.axis&&obj.direction){
				val:=Round(NumGet(xbox.currentstate,xbox.axis[obj.axis],"short")/32767*10)
				if(!check:=Abs(val)>3&&xbox.ad[SubStr(obj.axis,0),val>=0?1:2]=obj.direction?1:0)
					return
			}else if(obj.trigger){
				if(!check:=NumGet(xbox.currentstate,xbox.triggers[obj.trigger],"uchar")/255*10>3?1:0)
					return
			}
			if(obj.read){
				p:=[]
				for a,b in ["x","y"]
					p[b]:=Round(NumGet(xbox.currentstate,xbox.axis[obj.read b],"short")/32767*10)
				return p
			}
		}
		if(check)
			return check
	}
}
class XML{
	keep:=[]
	__New(param*){
		if !FileExist(A_ScriptDir "\lib")
			FileCreateDir,%A_ScriptDir%\lib
		root:=param.1,file:=param.2
		file:=file?file:root ".xml"
		temp:=ComObjCreate("MSXML2.DOMDocument"),temp.setProperty("SelectionLanguage","XPath")
		this.xml:=temp
		if FileExist(file){
			FileRead,info,%file%
			if(info=""){
				this.xml:=this.CreateElement(temp,root)
				FileDelete,%file%
			}else
				temp.loadxml(info),this.xml:=temp
		}else
			this.xml:=this.CreateElement(temp,root)
		this.file:=file
		xml.keep[root]:=this
	}
	CreateElement(doc,root){
		return doc.AppendChild(this.xml.CreateElement(root)).parentnode
	}
	Add(path,att:="",text:="",dup:=0,list:=""){
		p:="/",dup1:=this.SSN("//" path)?1:0,next:=this.SSN("//" path),last:=SubStr(path,InStr(path,"/",0,0)+1)
		if !next.xml{
			next:=this.SSN("//*")
			Loop,Parse,path,/
				last:=A_LoopField,p.="/" last,next:=this.SSN(p)?this.SSN(p):next.appendchild(this.xml.CreateElement(last))
		}
		if(dup&&dup1)
			next:=next.parentnode.appendchild(this.xml.CreateElement(last))
		for a,b in att
			next.SetAttribute(a,b)
		for a,b in StrSplit(list,",")
			next.SetAttribute(b,att[b])
		if(text!="")
			next.text:=text
		return next
	}
	Under(under,node:="",att:="",text:="",list:=""){
		if(node="")
			node:=under.node,att:=under.att,list:=under.list,under:=under.under
		new:=under.appendchild(this.xml.createelement(node))
		for a,b in att
			new.SetAttribute(a,b)
		for a,b in StrSplit(list,",")
			new.SetAttribute(b,att[b])
		if text
			new.text:=text
		return new
	}
	SSN(path){
		return this.xml.SelectSingleNode(path)
	}
	SN(path){
		return this.xml.SelectNodes(path)
	}
	__Get(x=""){
		return this.xml.xml
	}
	Transform(){
		static
		if !IsObject(xsl){
			xsl:=ComObjCreate("MSXML2.DOMDocument")
			style=
			(
			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
			<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
			<xsl:template match="@*|node()">
			<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:for-each select="@*">
			<xsl:text></xsl:text>		
			</xsl:for-each>
			</xsl:copy>
			</xsl:template>
			</xsl:stylesheet>
			)
			xsl.loadXML(style),style:=null
		}
		this.xml.transformNodeToObject(xsl,this.xml)
	}
	Save(x*){
		if x.1=1
			this.Transform()
		filename:=this.file?this.file:x.1.1,encoding:=ffff.pos=3?"UTF-8":ffff.pos=2?"UTF-16":"CP0",enc:=RegExMatch(this[],"[^\x00-\x7F]")?"utf-16":"utf-8"
		if(encoding!=enc)
			FileDelete,%filename%
		file:=fileopen(filename,"rw",encoding),file.seek(0),file.write(this[]),file.length(file.position)
	}
	EA(path){
		list:=[]
		if nodes:=path.nodename
			nodes:=path.SelectNodes("@*")
		else if path.text
			nodes:=this.SN("//*[text()='" path.text "']/@*")
		else if !IsObject(path)
			nodes:=this.SN(path "/@*")
		else
			for a,b in path
				nodes:=this.SN("//*[@" a "='" b "']/@*")
		while,n:=nodes.item(A_Index-1)
			list[n.nodename]:=n.text
		return list
	}
}
SSN(node,path){
	return node.SelectSingleNode(path)
}
SN(node,path){
	return node.SelectNodes(path)
}
Collapse_All_Assignments(){
	all:=settings.SN("//game[@name='" GetGame() "']/descendant::KeyPress[@Expand='1']")
	while(aa:=all.item[A_Index-1],ea:=XML.EA(aa))
		TV_Modify(ea.tv,"-Expand"),aa.RemoveAttribute("Expand")
}
Delete(){
	ControlGetFocus,Focus,% hwnd([1])
	if(Focus="SysListView321"){
		if(!LV_GetNext())
			return
		LV_GetText(Profile,LV_GetNext())
		if(m("Delete Profile: " Profile,"btn:ync","","Warning!!! Can Not Be Undone","ico:!","def:2")!="Yes")
			return
		node:=settings.SSN("//game[@name='" Profile "']"),node.ParentNode.RemoveChild(node),LV_Update()
		return
	}
	node:=SSN(program,"//*[@tv='" TV_GetSelection() "']"),ea:=xml.EA(node),Deselect()
	if(node.nodename~="i)game|directinput")
		return
	if(ea.main)
		return m("Can not delete the main section")
	if(A_ThisHotkey="Delete"){
		MsgBox,52,Are you sure?,Can not be undone. (Press Shift+Delete to bypass this)
		IfMsgBox,No
			return
	}
	if(sel:=node.nextsibling)
		sel.SetAttribute("select",1)
	else if(sel:=node.previoussibling)
		sel.SetAttribute("select",1)
	else
		node.ParentNode.SetAttribute("select",1)
	node.ParentNode.RemoveChild(node)
	LV(2)
}
Deselect(){
	rem:=SN(program,"descendant::*[@select='1']")
	while,rr:=rem.item[A_Index-1]
		rr.RemoveAttribute("select")
}
Exit(){
	GuiClose:
	LV_GetText(text,LV_GetNext()),next:=0
	if(LV_GetNext())
		settings.Add("last",{game:text})
	while,next:=TV_GetNext(next,"F"){
		node:=SSN(program,"descendant::*[@tv='" next "']")
		if(TV_Get(next,"Expand"))
			node.SetAttribute("Expand",1)
		else
			node.RemoveAttribute("Expand")
	}
	select:=SN(program,"descendant::*[@select='1']")
	while,ss:=select.item[A_Index-1]
		ss.RemoveAttribute("select")
	if(!select:=SSN(program,"descendant::*[@tv='" TV_GetSelection() "']"))
		select:=SSN(program,"descendant::*[@tv='" TV_GetParent(TV_GetSelection()) "']")
	select.SetAttribute("select",1),tv:=settings.SN("//*[@tv!='']")
	while,tt:=tv.item[A_Index-1]
		tt.RemoveAttribute("tv")
	WinGetPos,x,y,,,% hwnd([1])
	pos:=Winpos()
	if(pos.w&&pos.h)
		settings.Add("gui",{pos:"x" x " y" y " w" pos.w " h" pos.h})
	settings.save(1)
	ExitApp
	return
}
Expand_All_Assignments(){
	all:=settings.SN("//game[@name='" GetGame() "']/descendant::*")
	while(aa:=all.item[A_Index-1],ea:=XML.EA(aa))
		if(aa.HasChildNodes())
			TV_Modify(ea.tv,"Expand"),aa.SetAttribute("Expand",1)
}
Export(){
	info:=program
	FileSelectFile,filename,S
	if ErrorLevel
		return
	filename:=SubStr(filename,-3)=".xml"?filename:filename ".xml"
	temp:=new xml("temp",filename),temp.xml.loadxml(info.xml),remtv:=temp.SN("//*[@tv]")
	while,rem:=remtv.Item[A_Index-1]
		rem.RemoveAttribute("tv")
	temp.save(1)
}
GetGame(){
	if(!LV_GetNext())
		Exit
	LV_GetText(Profile,LV_GetNext())
	return Profile
}
Gui(){
	static
	Gui,Color,0xCCCCCC,0xCCCCCC
	Gui,+hwndmain +Resize
	hwnd(1,main),OnMessage(5,"Resize")
	Hotkey,IfWinActive,% hwnd([1])
	for a,b in {"+Escape":"Exit",Delete:"Delete","+Delete":"Delete","^Up":"move","^Down":"move","^Left":"move","^Right":"move"}
		Hotkey,%a%,%b%,On
	newwin:=new GuiKeep(1,["ListView,w200 h500 glv AltSubmit,Profile,h","TreeView,x+5 w250 h500 gtv AltSubmit,,wh","Hotkey,xm vhotkey gadd,,y","Edit,x+5 guphot w200 vuphot,,wy","Button,xm w455 gadd Default,Add,wy","Button,w455 gstart,&Start,wy"],"main")
	LV_Update(),LV(1)
	Gui,Show,% settings.SSN("//gui/@pos").text
	return
	start:
	if(A_GuiControl="&start"){
		SetTimer,updateprog,-1
		SetTimer,getstate,30
		ControlSetText,%A_GuiControl%,&Stop,% hwnd([1])
	}else if(A_GuiControl="&Stop"){
		ControlSetText,%A_GuiControl%,&Start,% hwnd([1])
		SetTimer,updateprog,Off
		SetTimer,getstate,Off
	}
	return
	add:
	var:=newwin[]
	ControlGetFocus,Focus,% hwnd([1])
	if(Focus="Edit1"||focus="msctls_hotkey321"){
		if !RegExMatch(var.hotkey,"\w")
			return
		v.hotkey:=var.hotkey
		xbox.Edit("Press a Button, Trigger, or Axis","add_keypress","Buttons","Axis","Triggers")
	}
	return
	uphot:
	Gui,Submit,Nohide
	GuiControl,,msctls_hotkey321,% newwin[].uphot
	return
}
hwnd(win,hwnd=""){
	static window:=[]
	if win=get
		return window
	if (win.rem){
		if !window[win.rem]
			Gui,% win.rem ":Destroy"
		Else
			DllCall("DestroyWindow",uptr,window[win.rem])
		window[win.rem]:=""
	}
	if IsObject(win)
		return "ahk_id" window[win.1]
	if !hwnd
		return window[win]
	window[win]:=hwnd
}
Import(filename:=""){
	if !filename
		FileSelectFile,filename,,,,*.xml
	FileRead,file,%filename%
	temp:=new XML("temp")
	temp.xml.loadxml(file)
	if !game:=temp.SSN("//game")
		return m("Incompatible file.  Sorry.")
	name:=SSN(game,"@name").text
	if(settings.SSN("//game[@name='" name "']")){
		InputBox,name,Game Exists,Please enter a new name for this game,,,,,,,,%name%
		if(ErrorLevel)
			return
		if settings.SSN("//game[@name='" name "']")
			return m("game exists")
		SSN(game,"@name").text:=name
	}
	settings.SSN("//Settings").AppendChild(game),LV_Update()
	return
	GuiDropFiles:
	for a,b in StrSplit(A_GuiEvent,"`n")
		Import(b)
	return
}
LV(lv){
	if(lv=2){
		while,next:=TV_GetNext(next,"F"){
			node:=SSN(program,"descendant::*[@tv='" next "']")
			if(TV_Get(next,"Expand"))
				node.SetAttribute("Expand",1)
			else
				node.RemoveAttribute("Expand")
		}
	}
	if(A_GuiEvent="I"||lv=2||lv=1){
		GuiControl,1:-Redraw,SysTreeView321
		TV_Delete(),LV_GetText(text,LV_GetNext()),program:=settings.SSN("//game[@name='" text "']"),list:=SN(program,"descendant-or-self::*")
		while,ll:=list.item[A_Index-1],ea:=xml.EA(ll){
			if(ll.nodename="directinput")
				text:=ea.name " - " (ea.on?"On":"Off")
			if(ll.nodename="Alt")
				text:=ea.main?"Main Assignment":"Alt Assignment: " ea.name
			if(ll.nodename="Group")
				text:=ea.name
			if(ll.nodename="Mouse")
				text:="Mouse"
			if(ll.nodename="keypress")
				text:=ll.nodename " = " ea.key
			if(ll.nodename~="i)Button|Axis|Direction|Read|Dead|Speed|Trigger|Hold")
				text:=ll.nodename " = " ea[ll.nodename]
			if(ll.nodename="Radius"){
				ll.SetAttribute("tv",(tv:=TV_Add("Radius",SSN(ll.ParentNode,"@tv").text,(ea.expand?"Expand":""))))
				for a,b in ["Center","Dead","Distance","Read","X","Y"]
					TV_Add(b " = " ea[b],tv)
				tv:=""
			}
			if(ll.nodename="Group")
				text:=ea.name
			if(text)
				ll.SetAttribute("tv",TV_Add(text,SSN(ll.ParentNode,"@tv").text,(ea.expand?"Expand":"")))
			text:=""
		}
		GuiControl,1:+Redraw,SysTreeView321
		TV_Modify(SSN(program,"descendant::*[@select='1']/@tv").text,"Select Vis Focus")
		SetTimer,updateprog,-1
	}
	return
}
LV_Update(){
	LV_Delete()
	pro:=settings.SN("//game"),last:=settings.EA("//last")
	while,pp:=pro.item[A_Index-1],ea:=xml.EA(pp)
		LV_Add(ea.name==last.game?"Select Vis Focus":"",ea.name)
	return
}
m(x*){
	active:=WinActive("A")
	ControlGetFocus,Focus,A
	ControlGet,hwnd,hwnd,,%Focus%,ahk_id%active%
	static list:={btn:{oc:1,ari:2,ync:3,yn:4,rc:5,ctc:6},ico:{"x":16,"?":32,"!":48,"i":64}},msg:=[],msgbox
	list.title:="AHK Studio",list.def:=0,list.time:=0,value:=0,msgbox:=1,txt:=""
	for a,b in x
		obj:=StrSplit(b,":"),(vv:=List[obj.1,obj.2])?(value+=vv):(list[obj.1]!="")?(List[obj.1]:=obj.2):txt.=b "`n"
	msg:={option:value+262144+(list.def?(list.def-1)*256:0),title:list.title,time:list.time,txt:txt}
	Sleep,120
	MsgBox,% msg.option,% msg.title,% msg.txt,% msg.time
	msgbox:=0
	for a,b in {OK:value?"OK":"",Yes:"YES",No:"NO",Cancel:"CANCEL",Retry:"RETRY"}
		IfMsgBox,%a%
		{
			WinActivate,ahk_id%active%
			ControlFocus,%Focus%,ahk_id%active%
			return b
		}
}
Menu(name){
	static menu:={Main:[{"&File":["Rena&me Current Game","&Export","&Import","E&xit"]},{"&Add":["Add &Game","Add &Alternate Commands","Add &XBox Assignment","Add Gr&oup","Add &Held Key","Add &Mouse Assignment","Add &Radius Constraint"]},{"&Edit":["&Collapse All Assignments","&Expand All Assignments"]},{"A&bout":["Show Available Assignments","Version"]}]}
	for a,b in Menu[name]{
		for c,d in b{
			for e,f in d
				Menu,%c%,Add,%f%,menu
			Menu,%name%,Add,%c%,:%c%
		}
	}
	return name
	menu:
	menu:=RegExReplace(RegExReplace(A_ThisMenuItem," ","_"),"&")
	%menu%()
	return
}
Move(){
	current:=SSN(program,"descendant::*[@tv='" TV_GetSelection() "']")
	if(A_ThisHotkey="^Right"){
		if(current.nodename~="i)KeyPress|Mouse|Radius"=0)
			while,current:=current.ParentNode
				if(current.nodename~="i)KeyPress|Mouse|Radius")
					break
		if(group:=SN(current,"following-sibling::Group").item[0])
			Deselect(),current.SetAttribute("select",1),group.AppendChild(current),LV(2)
	}if(A_ThisHotkey="^Left"){
		if(current.nodename~="i)KeyPress|Mouse|Radius"=0)
			while,current:=current.ParentNode
				if(current.nodename~="i)KeyPress|Mouse|Radius")
					break
		if(current.ParentNode.nodename!="Group")
			return
		parent:=current.ParentNode
		if(parent.ParentNode.nodename="Alt")
			Deselect(),current.SetAttribute("select",1),parent.ParentNode.AppendChild(current),LV(2)
	}if(A_ThisHotkey="^Up"){
		if(!prev:=current.previoussibling)
			return
		Deselect(),current.SetAttribute("select",1),prev.ParentNode.InsertBefore(current,prev),LV(2)
	}if(A_ThisHotkey="^Down"){
		if(!next:=current.nextsibling)
			return
		Deselect(),current.SetAttribute("select",1),next.ParentNode.InsertBefore(next,current),LV(2)
	}
}
Rename_Current_Game(){
	if !LV_GetNext()
		return m("Please select a game to rename")
	LV_GetText(current,LV_GetNext())
	InputBox,new,New Game Name,Please enter a new name for this game,,,,,,,,%current%
	if(ErrorLevel||new="")
		return
	if (new==current)
		return m("Please enter a different name")
	if settings.SSN("//game[@name='" new "']")
		return m("Game name already exists")
	name:=SSN(program,"@name"),name.text:=new,LV_Delete()
	while,nn:=settings.SN("//game/@name").Item[A_Index-1]
		LV_Add(_:=nn.text=new?"Select Vis Focus":"",nn.text)
	if !LV_GetNext()
		LV_Modify(1,"Select Vis Focus")
	filename:="",LV_GetText(profile,LV_GetNext()),settings.Add("last",{game:profile}),LV_Update()
}
Resize(a,b){
	static width,height
	info:=GuiKeep.Current(A_Gui)
	if(b>>16)
		height:=b>>16?b>>16:height,width:=b&0xffff?b&0xffff:width
	static flip:={x:"w",y:"h"}
	for a,b in info.gui{
		for c,d in b{
			if(c~="y|h")
				GuiControl,MoveDraw,%a%,% c height+d
			else
				GuiControl,MoveDraw,%a%,% c width+d
		}
	}
}
Set_Info(info){
	static switch:={Buttons:"Button",Axis:"Axis",Triggers:"Trigger"}
	Deselect()
	att:=[],node:=switch[info.3]
	att[node]:=info.1
	if(info.2)
		att["expand"]:=1
	v.current.SetAttribute("select",1)
	top:=settings.Under(v.current,node,att)
	if(info.2)
		settings.Under(top,"Direction",{Direction:info.2,expand:1})
	LV(2)
	return
}
t(x*){
	for a,b in x
		list.=b "`n"
	Tooltip,% list
}
Top(){
	node:=SSN(program,"descendant::*[@tv='" TV_GetSelection() "']")
	for a,b in ["ancestor-or-self::Group","ancestor-or-self::Alt"]
		if((test:=SSN(node,b)).xml)
			break
	return parent:=(test.nodename~="Group|Alt")?test:SSN(program,"descendant::*[@main='1']")
}
tv(info){
	static switch:={RThumb:"LThumb",LThumb:"RThumb"},node
	if(info.1){
		Deselect(),node.SetAttribute("select",1)
		if(node.nodename="radius")
			node.SetAttribute("Center",info.1)
		else if(node.nodename="alt"){
			node.SetAttribute("name",info.1)
		}else{
			top:=node.ParentNode,node.ParentNode.RemoveChild(node)
			if(info.3="axis")
				next:=settings.Under(top,"Axis",{Axis:info.1}),settings.Under(next,"Direction",{Direction:info.2})
			else if(info.3="Buttons")
				settings.Under(top,"Button",{Button:info.1})
			else if(info.3="Triggers")
				settings.Under(top,"Trigger",{Trigger:info.1})
		}
		SetTimer,updateprog,-1
		LV(2)
		return
	}
	if(A_GuiEvent="RightClick"){
		node:=settings.SSN("//*[@tv='" A_EventInfo "']"),ea:=xml.EA(node)
		if(node.nodename="read"){
			node.SetAttribute("Read",switch[ea.read]?switch[ea.read]:"LThumb")
		}else if(node.nodename~="i)dead|speed"){
			InputBox,new,Enter a new value,Enter a new value,,,,,,,,% ea[node.nodename]
			if(ErrorLevel||new="")
				return
			node.SetAttribute(node.nodename,new)
		}else if(node.nodename~="i)button|axis|trigger"){
			xbox.Edit("Press a Button, Axis, or Trigger","tv","Buttons","Triggers","Axis")
		}else if(node.nodename="Alt"&&ea.main!=1){
			xbox.Edit("Press a Button or Trigger","tv","Buttons","Triggers")
		}else if(!node){
			node:=settings.SSN("//*[@tv='" TV_GetParent(A_EventInfo) "']"),TV_GetText(value,A_EventInfo),ea:=xml.EA(node)
			if(InStr(value,"read"))
				node.SetAttribute("Read",switch[ea.read]?switch[ea.read]:"LThumb")
			else if(RegExMatch(value,"Oi)(X|Y|Dead|Distance)",found)){
				InputBox,new,Enter a new value,Enter a new value for %found1%,,,,,,,,% ea[found.1]
				if(ErrorLevel||new="")
					return
				if new is not number
					return m("Must be an integer")
				node.SetAttribute(found.1,new)
			}else if(InStr(value,"Center"))
				xbox.Edit("Press a Button or Trigger","tv","Buttons","Triggers")
		}
		Deselect(),node.SetAttribute("select",1),LV(2)
	}
}
Winpos(){
	VarSetCapacity(rect,16),DllCall("GetClientRect",ptr,hwnd(1),ptr,&rect)
	return {w:NumGet(rect,8),h:NumGet(rect,12)}
}
