inifile.d
=========

INI parsing, editing and generating library.

Requirements
------------
* dmd (version 2)

Building
--------
None needed. inifile.d is distributed in source code, so it's ready to use right after download.

Building test and HTML docs
---------------------------
Requirements:
* dmd (version 2)
* make

Everything is built using make. Available targets are:
* `all` (default) &mdash; build everything including documentation.
* `nodocs` &mdash; build everything except documentation.
* `clean` &mdash; clean up the working dir.

Simple typing `make` in project dir is enough if you don't need something specific.

Usage
-----
inifile.d is simple and intuitive. Let's see an example:

```d
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
```

Output will be:
```ini
[Инструменты]
Кусачки=Острые
Разводник=Тяжёлый
Отвёртка=Железная
[Фрукты]
Персик=Шерстяной
Апельсин=Оранжевый
Банан=Жёлтый
[Овощи]
Огурец=Зелёный
Помидор=Красный
Картофель=Жёлтый
```

You see? Using inifile.d is very similar to composing an actual INI file, so writing code would be simple and fast.

Capabilities
------------
It supports blank lines; semicolon (;) and the number sign (#) comments; colon (:) as a key-value delimitier; implicit [global] section; duplicate sections are merged; implementation is case sensitive; invalid lines are simply ignored.
