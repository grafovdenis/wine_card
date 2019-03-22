# Винная карта - учебный проект по базам данных.
## Содержание
* [Общая информация](#общая-информация)
* [Структура](#Структура)

## Общая информация
На данный момент проект содержит 10 таблиц: 5 основных и 5 для связей [n-n](https://en.wikipedia.org/wiki/Many-to-many_(data_model)).
А так же тип drink_type.
```sql
CREATE TYPE drink_type AS ENUM (
  'пиво и сидр',
  'водка и настойки',
  'ром',
  'текила',
  'виски',
  'биттеры',
  'вино',
  'бренди и коньяк',
  'шоты',
  'коктейли',
  'безалкогольные'
  );
```
* components - ингредиенты для напитков. Имеет поля, в которых указывается название и процент алкоголя.
* drinks - напитки. Поля: название, рейтинг, объём, процнт алкоголя, средняя цена, тип напитка.
* places - заведения. Поля: название, адрес, рейтинг, средний счёт.
* food - еда. Поля: название, рейтинг, объём, средняя цена.
* discounts - скидки. Поля: заведение(внешний ключ), тип напитка, процент скидки, описание, день недели, время начала, время конца.
* supplies_drinks.
* supplies_food.
* Вспомогательные:
    * components_drinks
    * places_drinks
    * places_food


## Структура
<a>
  <img src="http://gitlab.icc.spbstu.ru/grafa/wine_card/raw/master/structure.png"  width="1000"/>
</a>

