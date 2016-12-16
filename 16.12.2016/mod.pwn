#include <a_samp>
#include <dof2>
#include <dudb>

#define Hesla "/Profily/%s.txt"
#define MAX_PLAYERS_EX 100
#define COLOR_DARKGOLD 0x808000AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA


#define COLOR_SEDA #85898c

#define NEZAMESTNANY 0
#define AUTOBUSAK    1

#define DIALOG_AUTOBUSAK 50

new Zamestnani[MAX_PLAYERS];
new PizzaJob[MAX_PLAYERS]; //pizza práce

new PickupAutobusak;

new Text:TDEditor_TD0;
new Text:TDEditor_TD1;
new Text:TDEditor_TD2;

new NahranyCas[MAX_PLAYERS];
new Sekundy[MAX_PLAYERS_EX];
new Minuty[MAX_PLAYERS_EX];
new Hodiny[MAX_PLAYERS_EX];

new IP[16];

new Float:poziceX;
new Float:poziceY;
new Float:poziceZ;

new zabiti[MAX_PLAYERS];
new umrti[MAX_PLAYERS];

new SampvehName[][] =
{
"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
"Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
"Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
"Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
"Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
"Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
"Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
"Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
"Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
"Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
"Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
"Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
"Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
"Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
"Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
"Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
"Boxville", "Tiller", "Utility Trailer"
};

forward Cas();

main()
{
	print("\n----------------------------------");
	print(" MOD NAÈTEN");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    UsePlayerPedAnims();
	SetTimer("ukladani", 60000, 0);
	print("Úèty byly úspìšnì uloženy!");
	SetGameModeText("Nazev modu");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
 TDEditor_TD0 = TextDrawCreate(291.405975, -1.333245, "_");
    TextDrawLetterSize(TDEditor_TD0, 0.384538, 7.911665);
    TextDrawTextSize(TDEditor_TD0, 8.760105, 1072.000000);
    TextDrawAlignment(TDEditor_TD0, 2);
    TextDrawColor(TDEditor_TD0, -1);
    TextDrawUseBox(TDEditor_TD0, 1);
    TextDrawBoxColor(TDEditor_TD0, 255);
    TextDrawSetShadow(TDEditor_TD0, 87);
    TextDrawSetOutline(TDEditor_TD0, 212);
    TextDrawBackgroundColor(TDEditor_TD0, 255);
    TextDrawFont(TDEditor_TD0, 1);
    TextDrawSetProportional(TDEditor_TD0, 0);
    TextDrawSetShadow(TDEditor_TD0, 87);

    TDEditor_TD1 = TextDrawCreate(280.630065, 375.500213, "_");
    TextDrawLetterSize(TDEditor_TD1, 0.384538, 7.911665);
    TextDrawTextSize(TDEditor_TD1, 8.760105, 1072.000000);
    TextDrawAlignment(TDEditor_TD1, 2);
    TextDrawColor(TDEditor_TD1, -1);
    TextDrawUseBox(TDEditor_TD1, 1);
    TextDrawBoxColor(TDEditor_TD1, 255);
    TextDrawSetShadow(TDEditor_TD1, 87);
    TextDrawSetOutline(TDEditor_TD1, 212);
    TextDrawBackgroundColor(TDEditor_TD1, 255);
    TextDrawFont(TDEditor_TD1, 1);
    TextDrawSetProportional(TDEditor_TD1, 0);
    TextDrawSetShadow(TDEditor_TD1, 87);

    TDEditor_TD2 = TextDrawCreate(227.218048, 24.916673, "NAZEV_SERVERU");
    TextDrawLetterSize(TDEditor_TD2, 0.648784, 3.349999);
    TextDrawAlignment(TDEditor_TD2, 1);
    TextDrawColor(TDEditor_TD2, -1);
    TextDrawSetShadow(TDEditor_TD2, 0);
    TextDrawSetOutline(TDEditor_TD2, 0);
    TextDrawBackgroundColor(TDEditor_TD2, 255);
    TextDrawFont(TDEditor_TD2, 2);
    TextDrawSetProportional(TDEditor_TD2, 1);
    TextDrawSetShadow(TDEditor_TD2, 0);
    
   	    //vozidla k povolání rozvážky pizzy
		AddStaticVehicle(425,-2583.8850,628.4520,27.6202,359.4565,95,16); // Hunter
		AddStaticVehicle(448,-2578.6665,628.5787,27.6192,358.9873,95,16); // PizzaBoy
		AddStaticVehicle(448,-2573.6130,628.3272,27.6137,0.5855,95,16); // PizzaBoy
		//konec vozidel k povolání pizzy

AddStaticVehicle(502,-1418.1409,-299.9531,13.9642,44.9779,51,75); // Hotring1
AddStaticVehicle(502,-1413.0009,-305.2311,13.9546,43.8722,51,75); // Hotring2
AddStaticVehicle(502,-1405.8573,-314.4231,13.9593,38.3017,51,75); // Hotring3
AddStaticVehicle(502,-1400.4066,-322.9341,13.9620,29.1471,51,75); // Hotring4

PickupAutobusak = CreatePickup(1275,1,-2593.9373,670.9897,27.8125,-1);




    return 1;
}

public OnGameModeExit()
{
    DOF2_Exit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    GetPlayerIp(playerid, IP, sizeof(IP));

    NahranyCas[playerid] = SetTimer("Cas",1000,1);

    new nick[MAX_PLAYER_NAME],  soubor[64], string[128];
    GetPlayerName(playerid, nick, sizeof(nick));
    format(soubor, sizeof(soubor), Hesla, nick);
    if (DOF2_FileExists(soubor))
    {
    format(string,sizeof(string),"{00B6FF}Vítej zpátky na serveru, {016BC3}%s!\n{FFFFFF}Zadej svoje heslo:",nick);
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD,"Pøihlašování...",string, "HOTOVO","ODEJIT");
    PlayAudioStreamForPlayer(playerid, "http://teocz.8u.cz/m/login.mp3");

    TextDrawShowForPlayer(playerid,TDEditor_TD0);
    TextDrawShowForPlayer(playerid,TDEditor_TD1);
    TextDrawShowForPlayer(playerid,TDEditor_TD2);
    }
    else
    {
    format(string,sizeof(string),"{00B6FF}Vítej na serveru, {016BC3}%s!\n{FFFFFF}Zadej svoje nové heslo:",nick);
    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD,"Registrace...",string, "HOTOVO","ODEJIT");
    PlayAudioStreamForPlayer(playerid, "http://teocz.8u.cz/m/login.mp3");
    TextDrawShowForPlayer(playerid,TDEditor_TD0);
    TextDrawShowForPlayer(playerid,TDEditor_TD1);
    TextDrawShowForPlayer(playerid,TDEditor_TD2);
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(NahranyCas[playerid]);

    new Float:x;
    new Float:y;
    new Float:z;

    GetPlayerPos(playerid,x,y,z);
    poziceX = x;
    poziceY = y;
    poziceZ = z;

    new nick[MAX_PLAYER_NAME], soubor[64];
    GetPlayerName(playerid, nick, sizeof(nick));
    format(soubor, sizeof(soubor), Hesla, nick);
    DOF2_SetInt(soubor, "hodiny", Hodiny[playerid]);
    DOF2_SetInt(soubor, "minuty", Minuty[playerid]);
    DOF2_SetInt(soubor, "sekundy", Sekundy[playerid]);
    DOF2_SetInt(soubor, "penize", GetPlayerMoney(playerid));
    DOF2_SetInt(soubor, "poziceX", floatround(poziceX));
    DOF2_SetInt(soubor, "poziceY", floatround(poziceY));
    DOF2_SetInt(soubor, "poziceZ", floatround(poziceZ));
    DOF2_SetInt(soubor, "zabil", zabiti[playerid]);
    DOF2_SetInt(soubor, "umrel", umrti[playerid]);
    DOF2_SetInt(soubor, "skin", GetPlayerSkin(playerid));
    DOF2_SetInt(soubor, "Zamestnani", Zamestnani[playerid]);
    DOF2_SaveFile();
	return 1;
}

public OnPlayerSpawn(playerid)
{
    new nick[MAX_PLAYER_NAME], soubor[64];
    GetPlayerName(playerid, nick, sizeof(nick));
    format(soubor, sizeof(soubor), Hesla, nick);
    if( DOF2_GetFloat( soubor , "poziceX" ) == 0.0 )
    {
        SetPlayerSkin(playerid, 0);
        SetPlayerPos(playerid, -1423.7137,-290.5623,14.1484); //NASTAVENÍ POZICE NA KTERÉ SE SPAWNE NOVÝ HRÁÈ
        }else{
        SetPlayerPos(playerid, DOF2_GetFloat(soubor, "poziceX"), DOF2_GetFloat(soubor, "poziceY"), DOF2_GetFloat(soubor,"poziceZ"));
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    zabiti[killerid] ++;
    umrti[playerid] ++;
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
//job pizza
  if (strcmp("/pizza", cmdtext, true, 10) == 0)
    {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
        {
            PizzaJob[playerid] = 1;
            SetPlayerCheckpoint(playerid,-2589.2896,570.9557,14.2340,10);
            SendClientMessage(playerid,COLOR_YELLOW,"Následujte èervené body, pro získání penìz!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_RED,"Musíte sedìt na pizza motorce, aby jste mohli vykonávan práci pizzaøe!");
    }
//konec pizza

	
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
		//job pizza
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
		     {
		         SendClientMessage(playerid, COLOR_RED, "Pøíkazem /pizza zaènete pracovat!");
		     }
		     
		     //konec
        return true;
        
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
		//job pizza
		if(PizzaJob[playerid] > 0)
		    {
		        PizzaJob[playerid] = 0;
		        SendClientMessage(playerid, COLOR_RED, "* Právì jste odešel z práce.");
		        DisablePlayerCheckpoint(playerid);
		    }
		    //konec pizza job
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
new str[80];
   if (newstate == 2 || newstate == 3)
{
   format(str, sizeof(str), "~g~%s",SampvehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
}   GameTextForPlayer(playerid, str, 3000, 1);
    return 1;                                     
}

public OnPlayerEnterCheckpoint(playerid)
{

//pizza job
 if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
     {
        if(PizzaJob[playerid] == 1){
            PizzaJob[playerid] = 2;
            SetPlayerCheckpoint(playerid,-2568.0029,706.3096,27.5819,10);
            SendClientMessage(playerid,COLOR_YELLOW,"* Jedtì na další èervenì vyznaèené místo!");
            return 1;
         }
        if(PizzaJob[playerid] == 2){
            PizzaJob[playerid] = 3;
            SetPlayerCheckpoint(playerid,-2381.8220,789.1605,34.7907,10);
            return 1;
         }
        if(PizzaJob[playerid] == 3){
            PizzaJob[playerid] = 4;
            SetPlayerCheckpoint(playerid,-2109.3062,806.0510,69.1873,10);
            return 1;
         }
        if(PizzaJob[playerid] == 4){
            PizzaJob[playerid] = 5;
            SetPlayerCheckpoint(playerid,-2008.8770,699.7689,45.0697,10);
            return 1;
         }
        if(PizzaJob[playerid] == 5){
            PizzaJob[playerid] = 6;
            SetPlayerCheckpoint(playerid,-2008.8451,463.0404,34.7853,10);
            return 1;
         }
        if(PizzaJob[playerid] == 6){
            PizzaJob[playerid] = 7;
            SetPlayerCheckpoint(playerid,-1993.2448,151.0671,27.3117,10);
            return 1;
         }
        if(PizzaJob[playerid] == 7){
            PizzaJob[playerid] = 8;
            SetPlayerCheckpoint(playerid,-2147.6550,132.7353,34.9449,10);
            return 1;
         }
        if(PizzaJob[playerid] == 8){
            PizzaJob[playerid] = 9;
            SetPlayerCheckpoint(playerid,-2203.3977,324.0729,34.9449,10);
            return 1;
         }
        if(PizzaJob[playerid] == 9){
            PizzaJob[playerid] = 10;
            SetPlayerCheckpoint(playerid,-2360.4490,486.9513,30.4269,10);
            return 1;
         }
         
        if(PizzaJob[playerid] == 10){
            PizzaJob[playerid] = 0;
            DisablePlayerCheckpoint(playerid);
            SendClientMessage(playerid,COLOR_YELLOW,"* Za rozvoz pizzy dostáváš 400$.");
            GivePlayerMoney(playerid,400);
         }
     }
     //konec pizza

	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
 if(pickupid == PickupAutobusak)
 {
 SetPlayerPos(-2591.1758,671.1385,27.8125);
 ShowPlayerDialog(playerid,DIALOG_AUTOBUSAK,DIALOG_STYLE_LIST,"Autobusák","Zamìstnat se","OK","Konec");
 }
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == 1)
    {
            new nick[MAX_PLAYER_NAME], soubor[64], string[128];
            GetPlayerName(playerid, nick, sizeof(nick));
            format(soubor, sizeof(soubor), Hesla, nick);
            if(!response)
            return Kick(playerid);
            if (!strlen(inputtext)) return

            format(string,sizeof(string),"{00B6FF}Vítej na serveru, {016BC3}%s!\n{FFFFFF}Zadej svoje nové heslo:",nick);
            ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD,"Registrace...",string, "HOTOVO","ODEJIT");

            TextDrawShowForPlayer(playerid,TDEditor_TD0);
            TextDrawShowForPlayer(playerid,TDEditor_TD1);
            TextDrawShowForPlayer(playerid,TDEditor_TD2);

            DOF2_CreateFile(soubor);
            DOF2_SetInt(soubor, "Heslo", udb_hash(inputtext));
            DOF2_SetInt(soubor, "hodiny", Hodiny[playerid]);
            DOF2_SetInt(soubor, "minuty", Minuty[playerid]);
            DOF2_SetInt(soubor, "sekundy", Sekundy[playerid]);
            DOF2_SetInt(soubor, "penize", GetPlayerMoney(playerid));
            DOF2_SetString(soubor, "IP adresa", IP);
            DOF2_SetInt(soubor, "skin", 0);
            DOF2_SetInt(soubor, "zabil", 0);
            DOF2_SetInt(soubor, "umrel", 0);
            DOF2_SetInt(soubor, "Zamestnani", 0);
            DOF2_SaveFile();

            format(string, 128, "Byl jsi úspìšnì zaregistrovaný na jméno %s. Tvoje heslo je %s.", nick, inputtext);
            SendClientMessage(playerid, 0x66F2BEFF, string);
            TextDrawHideForPlayer(playerid,TDEditor_TD0);
            TextDrawHideForPlayer(playerid,TDEditor_TD1);
            TextDrawHideForPlayer(playerid,TDEditor_TD2);

            StopAudioStreamForPlayer(playerid);
			GivePlayerMoney(playerid, 10000);
    }

    if (dialogid == 2)
    {
        new nick[MAX_PLAYER_NAME], soubor[64], string[128];
        GetPlayerName(playerid, nick, sizeof(nick));
        format(soubor, sizeof(soubor), Hesla, nick);
        if(!response)
        return Kick(playerid);
        new tmp;
        tmp = DOF2_GetInt(soubor, "Heslo");
        if(udb_hash(inputtext) != tmp)
        {
            format(string,sizeof(string),"{00B6FF}Vítej zpátky na serveru, {016BC3}%s!\n{FF4848}Zadal jsi špatné heslo!",nick);
            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD,"Pøihlašování...",string, "HOTOVO","ODEJIT");

            TextDrawShowForPlayer(playerid,TDEditor_TD0);
            TextDrawShowForPlayer(playerid,TDEditor_TD1);
            TextDrawShowForPlayer(playerid,TDEditor_TD2);
        }
        else
        {
            SendClientMessage(playerid,0x66F2BEFF, "Byl jsi úspìšnì pøihlášený!!");
            DOF2_SetInt(soubor, "hodiny", Hodiny[playerid]);
            DOF2_SetInt(soubor, "minuty", Minuty[playerid]);
            DOF2_SetInt(soubor, "sekundy", Sekundy[playerid]);
            DOF2_SetString(soubor, "IP adresa", IP);
            SetPlayerSkin(playerid, DOF2_GetInt(soubor, "skin"));
            GivePlayerMoney(playerid, DOF2_GetInt(soubor, "penize"));
            DOF2_GetInt(soubor, "zabil");
            DOF2_GetInt(soubor, "umrel");
            DOF2_GetInt(soubor, "Zamestnani");
            TextDrawHideForPlayer(playerid,TDEditor_TD0);
            TextDrawHideForPlayer(playerid,TDEditor_TD1);
            TextDrawHideForPlayer(playerid,TDEditor_TD2);

            StopAudioStreamForPlayer(playerid);
        }
    }
    if(dialogid == 3)
    {
    new nick[MAX_PLAYER_NAME], slozka[64];
    GetPlayerName(playerid, nick, sizeof(nick));
    format(slozka, sizeof(slozka), Hesla, nick);
    if(response)
    {
    if(udb_hash(inputtext) != DOF2_GetInt(slozka, "Heslo"))
    {
    ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Zmìna hesla","{00B6FF}Zadej prosím svoje staré heslo\n{FF4848}Zadal jsi špatné heslo!","Další","Zavøít");
    }
    else
    {
    ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Zmìna hesla","{00B6FF}Zadej prosím svoje nové heslo","Hotovo","Zavøít");
    }
    }
    }
    if(dialogid == 4)
    {
    new nick[MAX_PLAYER_NAME], slozka[64];
    GetPlayerName(playerid, nick, sizeof(nick));
    format(slozka, sizeof(slozka), Hesla, nick);
    if(response)
    {
    DOF2_SetInt(slozka, "Heslo", udb_hash(inputtext));
    DOF2_SaveFile();
    SendClientMessage(playerid,0x66F2BEFF,"Heslo bylo úspìšnì zmìnìho! Svoje heslo si zapamatuj pro další pøihlášení.");
    }
    }
if(dialogid == DIALOG_AUTOBUSAK)
	{
	if(response == 1)
	{
	if(Zamestnani[playerid] == 1) {
    SendClientMessage(playerid,0x66F2BEFF,"Zde už jsi zamìstnaný");
	} else {
    SendClientMessage(playerid,0x66F2BEFF,"Zamìstnal si se jako autobusák");
	GivePlayerWeapon(playerid,22,100);
	SetPlayerSkin(playerid, 253);
	}
	}
	}
    
    return 0;
}

public Cas()
{
    for(new i;i<MAX_PLAYERS_EX;i++)
    {
    Sekundy[i] ++;
    if
    (Sekundy[i] == 60)
    {
    Minuty[i] ++;
    Sekundy[i] = 0;
    }
    else if
    (Minuty[i] == 60)
    {
    Hodiny[i] ++;
    Minuty[i] = 0;
    Sekundy[i] = 0;
    }
    else if
    (Minuty[i] == 60 && Sekundy[i] == 60)
    {
    Hodiny[i] ++;
    Minuty[i] = 0;
    Sekundy[i] = 0;
    }
    }
    return true;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
