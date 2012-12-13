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
import std.file;

import inifile;

int main(string[] args)
{
	IniFile f = new IniFile();
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
	writeln(f.serialize());
	writeln("---");
	std.file.write("test.ini",f.serialize());

	IniFile f2 = new IniFile();
	f2.parse(readText("test.ini"));
	writeln(f2.serialize());
	writeln("---");
	return 0;
}

