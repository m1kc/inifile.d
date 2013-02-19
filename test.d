/*
 * inifile.d
 *
 * Copyright 2012 m1kc <m1kc@yandex.ru>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 */

import std.stdio;

import inifile;

void newTest(string s)
{
	write("Testing: ",s,"... ");
}

int main(string[] args)
{
	{
		newTest("general test"); scope(exit) writeln("ok");
		scope IniFile f = new IniFile();
		f.setGroup("Фрукты");
		f.setItem("Апельсин", "Оранжевый");
		f.setItem("Персик", "Шерстяной");
		f.setItem("Банан", "Жёлтый");
		f.setGroup("Овощи");
		f.setItem("Помидор", "Красный");
		f.setItem("Картофель", "Жёлтый");
		f.setItem("Огурец", "Зелёный");
		f.setGroup("Инструменты");
		f.setItem("Отвёртка", "Железная");
		f.setItem("Разводник", "Тяжёлый");
		f.setItem("Кусачки", "Острые");
		string ini = f.serialize();
		//writeln("<<");
		//writeln(ini);
		//writeln(">>");
		scope IniFile f2 = new IniFile();
		f2.parse(ini);
		//writeln("<<");
		//writeln(f2.serialize());
		//writeln(">>");
	}
	
	{
		newTest("keys and values"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo=bar";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
		f.setGroup("foobar");
		assert(f.get("foo")=="bar");
	}
	
	{
		newTest("comments (;)"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo=bar
;foo=wall";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("comments (#)"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo=bar
#foo=wall";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("blank lines"); scope(exit) writeln("ok");
		string ini = "

[foobar]

foo=bar

";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("overriding duplicate names"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo=sail
foo=bar";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("merging sections"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo=sail
[kkk]
foo=too
[foobar]
foo=bar";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("implicit [global] section"); scope(exit) writeln("ok");
		string ini = "foo=bar";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("global", "foo")=="bar");
	}

	{
		newTest("colon (:) as a key-value delimitier"); scope(exit) writeln("ok");
		string ini = "[foobar]
foo:bar";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("foobar", "foo")=="bar");
	}

	{
		newTest("invalid lines"); scope(exit) writeln("ok");
		string ini = "foo=bar
fdjfskkfladsjfksljsadfkldfsjkl
rar=war";
		scope IniFile f = new IniFile();
		f.parse(ini);
		assert(f.get("global", "foo")=="bar");
		assert(f.get("global", "rar")=="war");
	}
	return 0;
}

