﻿Функция ПолучитьТекстИзФайла(ИмяФайла)
	Текст = Новый ЧтениеТекста(ИмяФайла, КодировкаТекста.ANSI);
	Данные = Текст.Прочитать();
	Текст.Закрыть();
	возврат Данные;
КонецФункции

Функция ЗаписатьРезультатВФайл(ИмяФайла,Данные)
	Текст = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.ANSI); 
	Текст.Записать(Данные); 
	Текст.Закрыть();		
КонецФункции // ЗаписатьРезультатВФайл(ИмяФайла,Данные)


Функция УбратьЛишниеПробелыСправа(Данные)
	Регулярка = новый РегулярноеВыражение("[ \t]+\r*\n");
	Возврат Регулярка.Заменить(Данные,Символы.ПС);
КонецФункции

Функция ФайлУбратьЛишниеПробелыСправа(ИмяФайла)
	Данные = ПолучитьТекстИзФайла(ИмяФайла);
	Данные = УбратьЛишниеПробелыСправа(Данные);
	возврат Данные;
КонецФункции


Функция ВыравнитьПоЗначению(ИмяФайла,ЗначениеВыравнивания)
	
	Источник = ИмяФайла;
	
	Текст = Новый ЧтениеТекста(Источник, КодировкаТекста.ANSI); 
	Стр = "";
	МассивСтрок = Новый Массив;
	Данные = "";
	ПозицияРавно = 0;	
	Пока Стр <> Неопределено Цикл 
		Стр = Текст.ПрочитатьСтроку();
		
		Если Лев(СокрЛП(Стр),2) = "//" Тогда
			МассивСтрок.Добавить(Стр);
		Иначе
			ТекПозицияРавно = Найти(Стр,ЗначениеВыравнивания);
			ПозицияРавно = Макс(ПозицияРавно,ТекПозицияРавно);
			МассивСтрок.Добавить(Стр);
		КонецЕсли
		
	КонецЦикла;
	Текст.Закрыть();
	
	для каждого стр из МассивСтрок цикл
		ТекПозицияРавно = Найти(Стр,ЗначениеВыравнивания);
		Разница = ПозицияРавно - ТекПозицияРавно;
		Пробелы = "";
		для А = 0 по Разница цикл
			Пробелы = Пробелы + " ";
		конеццикла;
		НоваяСтр = Сред(Стр,1,ТекПозицияРавно-1) + Пробелы + Сред(Стр,ТекПозицияРавно);
		Данные = Данные + Символы.ПС + НоваяСтр;
	конеццикла;

	возврат УбратьЛишниеПробелыСправа(Данные) + Символы.ПС;
КонецФункции

Функция ВыравнитьПоВведеномуСимволу(ИмяФайла)
	ЗапуститьПриложение("system\inputbox.exe tmp\app.txt",,true);

	Стр = ПолучитьТекстИзФайла("tmp\app.txt");
	Если СокрЛП(Стр) = "" Тогда
		возврат "";
	Иначе
		возврат ВыравнитьПоЗначению(ИмяФайла,Стр);
	КонецЕсли;
КонецФункции

Процедура Выполнить(Параметры)
	
	ИмяФайла = "tmp\module.txt";
	Если Параметры.Количество() > 1 Тогда
		ИмяФайла = Параметры[1];
	КонецЕсли;
	Приемник = ИмяФайла;

	Если Параметры.Количество() > 2 Тогда
		Приемник = Параметры[2];
	КонецЕсли;

	Если Параметры.Количество() > 0 Тогда
		
		ВариантОбработки = Параметры[0];
		Результат = "";

		Если ВариантОбработки = "align-equal-sign" Тогда
			Результат = ВыравнитьПоЗначению(ИмяФайла,"=");
		ИначеЕсли ВариантОбработки = "align-first-comma" Тогда
			Результат = ВыравнитьПоЗначению(ИмяФайла,",");
		ИначеЕсли ВариантОбработки = "align-user-symbol" Тогда
			Результат = ВыравнитьПоВведеномуСимволу(ИмяФайла);
		ИначеЕсли ВариантОбработки = "rtrim" Тогда
			Результат = ФайлУбратьЛишниеПробелыСправа(ИмяФайла);
		КонецЕсли;

		ЗаписатьРезультатВФайл(Приемник, Результат);

	КонецЕсли;

КонецПроцедуры

Выполнить(АргументыКоманднойСтроки);

//МассивПарамеров = новый Массив;
//МассивПарамеров.Добавить("align-first-comma");
//МассивПарамеров.Добавить("c:\work\portable\v8CfgAddsAhk\tmp\module.txt");
//МассивПарамеров.Добавить("c:\work\portable\v8CfgAddsAhk\tmp\new.module.txt");

//Выполнить(МассивПарамеров);