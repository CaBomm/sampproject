#include <a_samp>
#include <dof2>
#include <dudb>

#define Hesla "/Profily/%s.txt"
#define MAX_PLAYERS_EX 100

#define COLOR_SEDA #85898c

#define NEZAMESTNANY 0
#define AUTOBUSAK    1

#define DIALOG_AUTOBUSAK 50

new Zamestnani[MAX_PLAYERS];

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

forward Cas();

main()
{
	print("\n----------------------------------");
	print(" MOD NAČTEN");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    UsePlayerPedAnims();
	SetTimer("ukladani", 60000, 0);
	print("Účty byly úspěšně uloženy!");
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
    AddStaticVehicle(437,-2583.8850,628.4520,27.6202,359.4565,95,16); // Coach1
AddStaticVehicle(437,-2578.6665,628.5787,27.6192,358.9873,95,16); // Coach2
AddStaticVehicle(437,-2573.6130,628.3272,27.6137,0.5855,95,16); // Coach3
AddStaticVehicle(437,-2568.3865,628.1733,27.6139,359.6959,95,16); // Coach4
AddStaticVehicle(437,-2563.0215,628.1688,27.6148,0.2910,95,16); // Coach5
AddStaticVehicle(437,-2557.9053,628.3286,27.6157,358.3734,95,16); // Coach6

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
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD,"Přihlašování...",string, "HOTOVO","ODEJIT");
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
        SetPlayerPos(playerid, -1423.7137,-290.5623,14.1484); //NASTAVENÍ POZICE NA KTERÉ SE SPAWNE NOVÝ HRÁČ
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
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new IDModelu;
	IDModelu = GetVehicleModel(vehicleid);
	if(!ispassenger)
	{
	    if(IDModelu == 431 || IDModelu == 437)
	    {
	        {
	            new Float:x, Float:y, Float:z;
	            GetPlayerPos(playerid,x,y,z);
	            SetPlayerPos(playerid,x,y,z);
	            SendClientMessage(playerid,0xFFFFFFAA,"Toto vozidlo je pouze pro povolání Autobusák!");
	        }
	    }

	    if(IDModelu == 502 || IDModelu == 520)
	    {
	        if(Zamestnani[playerid] != 0)
	        {
	            new Float:x, Float:y, Float:z;
	            GetPlayerPos(playerid,x,y,z);
	            SetPlayerPos(playerid,x,y,z);
	            SendClientMessage(playerid,0xFF0000FF,"Toto vozidlo je pouze pro povolání 0!");
	        }
	    }
        }
        return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
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
 ShowPlayerDialog(playerid,DIALOG_AUTOBUSAK,DIALOG_STYLE_LIST,"Autobusák","Zaměstnat se","OK","Konec");
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

            format(string, 128, "Byl jsi úspěšně zaregistrovaný na jméno %s. Tvoje heslo je %s.", nick, inputtext);
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
            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD,"Přihlašování...",string, "HOTOVO","ODEJIT");

            TextDrawShowForPlayer(playerid,TDEditor_TD0);
            TextDrawShowForPlayer(playerid,TDEditor_TD1);
            TextDrawShowForPlayer(playerid,TDEditor_TD2);
        }
        else
        {
            SendClientMessage(playerid,0x66F2BEFF, "Byl jsi úspěšně přihlášený!!");
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
    ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"Změna hesla","{00B6FF}Zadej prosím svoje staré heslo\n{FF4848}Zadal jsi špatné heslo!","Další","Zavřít");
    }
    else
    {
    ShowPlayerDialog(playerid,4,DIALOG_STYLE_INPUT,"Změna hesla","{00B6FF}Zadej prosím svoje nové heslo","Hotovo","Zavřít");
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
    SendClientMessage(playerid,0x66F2BEFF,"Heslo bylo úspěšně změněho! Svoje heslo si zapamatuj pro další přihlášení.");
    }
    }
if(dialogid == DIALOG_AUTOBUSAK)
	{
	if(response == 1)
	{
	if(Zamestnani[playerid] == 1) {
    SendClientMessage(playerid,0x66F2BEFF,"Zde už jsi zaměstnaný");
	} else {
    SendClientMessage(playerid,0x66F2BEFF,"Zaměstnal si se jako autobusák");
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
