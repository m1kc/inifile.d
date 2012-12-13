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

import std.string;

public class IniFile
{
	private string[string][string] data;
	private string last;

	public void setGroup(string w)
	{
		last = w;
	}

	public void removeGroup(string w)
	{
		data.remove(w);
	}

	public void setItem(string key, string value)
	{
		data[last][key] = value;
	}

	public void setItem(string group, string key, string value)
	{
		data[group][key] = value;
	}

	public void removeItem(string key)
	{
		data[last].remove(key);
	}

	public void removeItem(string group, string key)
	{
		data[group].remove(key);
	}

	public string get(string key)
	{
		return data[last][key];
	}

	public string get(string group, string key)
	{
		return data[group][key];
	}

	public string serialize()
	{
		string result = "";
		foreach (string name, string[string] items; data)
		{
			result ~= ("[" ~ name ~ "]\n");
			foreach(string key, string value; items)
			{
				result ~= (key ~ "=" ~ value ~ "\n");
			}
		}
		return result;
	}

	public void parse(string input)
	{
		foreach (string s; splitLines(input))
		{
			if (s[0]==';') continue; // a comment

			if (s[0]=='[' && s[$-1]==']')
			{
				setGroup(s[1..$-1]);
				continue;
			}

			if (s.indexOf('=')==-1) continue; // blank line

			// key-value pair
			auto tmp = s.split("=");
			setItem(tmp[0], tmp[1]);
		}
	}
}
