# 1T final work

Финальная работа Соколовского Б.Л.

сsv - папка в которую  следует разместить изначальный файл yellow_tripdata_2020-01.csv (не представлен в GitHub)

doc - папка с документами по проекту: ТЗ.docx - описание задания из LMS.  taxi.pptx - презентация PowerPoint по проекту.

MART - папка используемая для выгрузки готовых витрин из ClickHouse. Используется как volume к Docker-контейнеру с ClickHouse.

taxi_script - папка, содержащя в себе файл init.sql - в котором содержатся скрипты для создания и манипуляций над таблицами в ClickHouse.

docker-compose.yml - файл для создания и запуска Docker-контейнера с СlickHouse и его GUI "Tabix"(в проекте не используется).

MART.sql - файл, содержащий в себе 2 скрипта для создания витрин в ClickHouse.

taxi.ipynb - основной Jupyter notebook, использованный для задания по аналитике.



ИНСТРУКЦИЯ:

Выполннение позволяет сформировать требуемые в ТЗ витрины даных".

   •  развернуть Docker-контейнер с помощью файла docker-compose.yml
   
   •  подключиться к ClickHouse c помощью DBeaver и выполнить скрипт из файла "init.sql"  - '--создание raw таблицы'
   
   •	с помощью терминала в созданном и запущенном Docker-контейнере запустить скрипт 'загрузка данных в raw таблицу' из файла "init.sql"
   
   •	c помощью DBeaver  выполнить скрипт из файла "init.sql" -'удаление лишних столбцов'
   
   •	c помощью DBeaver  выполнить скрипты из файла MART.sql для формирования 2 видов витрин.
   
   •	c помощью DBeaver  выполнить скрипт из файла "init.sql" - 'сохранение витрины в parquet',а также скрипт 'сохранение таблицы для дальнейшей аналитики'

В результате выполнения последнего пункта в папке MART сохраняются 2 файла parquet с требуемыми витринами, а в папке сsv сохраняется таблица taxi.csv - необходимая для дальнейшей аналитический работы в Jupyter-ноутбуке taxi.ipynb