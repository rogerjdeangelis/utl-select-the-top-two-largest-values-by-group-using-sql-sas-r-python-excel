%let pgm=utl-select-the-top-two-largest-values-by-group-using-sql-sas-r-python-excel;

Select the top two largest values by group using sql sas r python excel

%stop_submission;

      CONTENTS

          1 sas sql
          2 r sql
            For python and excel solutions see
            https://tinyurl.com/4e6yaap8

github
https://tinyurl.com/4fwzwsxh
https://github.com/rogerjdeangelis/utl-select-the-top-two-largest-values-by-group-using-sql-sas-r-python-excel

communities.sas
https://tinyurl.com/fxt7rcwk
https://communities.sas.com/t5/SAS-Programming/How-to-find-largest-and-second-largest-values/m-p/812074#M320379

for python and excel solutions see
https://tinyurl.com/4e6yaap8
https://github.com/rogerjdeangelis/utl-identify-changes-in-all-variable-values-between-phase1-and-phase2-trials

for macros see
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

/**************************************************************************************************************************/
/*         INPUT             |  PROCESS                                              |       OUTPUT                       */
/*         =====             |  =======                                              |       ======                       */
/*                           |                                                       |                                    */
/* PRIMKEY     TYPE     PCT  | Select top two                                        |   TYPE     PCT    PARTITION        */
/*                           | pcts by type                                          |                                    */
/*     1      Locked      7  |                                                       |  Locked     77        1            */
/*     2      Locked     77  | 1 SAS SQL                                             |  Locked     57        2            */
/*     3      Locked     25  | =========                                             |                                    */
/*     4      Locked     57  |                                                       |  NonPro     18        1            */
/*     5      NonPro     18  | proc sql;                                             |  NonPro     16        2            */
/*     6      NonPro     16  |    create                                             |                                    */
/*     7      Promo      77  |        table want as                                  |                                    */
/*     8      Promo      25  |    select                                             |                                    */
/*     9      Promo      88  |        type                                           |                                    */
/*    10      Promo      79  |       ,pct                                            |                                    */
/*                           |       ,partition                                      |                                    */
/* options                   |    from                                               |                                    */
/*  validvarname=upcase;     |        %sqlpartitionx(                                |                                    */
/* libname sd1 "d:/sd1";     |          (select max(primkey),type,pct from sd1.have  |                                    */
/* data sd1.have;            |           group by type, pct)                         |                                    */
/*  input primkey type$ pct; |         ,by=type                                      |                                    */
/* cards4;                   |         ,minus=-1)                                    |                                    */
/* 01 Locked 07              |   where                                               |                                    */
/* 02 Locked 77              |        partition <= 2                                 |                                    */
/* 03 Locked 25              |   order                                               |                                    */
/* 04 Locked 57              |        by type, pct descending                        |                                    */
/* 05 NonPro 18              | ;quit;                                                |                                    */
/* 06 NonPro 16              |                                                       |                                    */
/* 07 Promo 77               |--------------------------------------------------------------------------------------------*/
/* 08 Promo 25               | 2 R SQL                                               |                                    */
/* 09 Promo 88               | For python and excel solutions see                    |  R                                 */
/* 10 Promo 79               | https://tinyurl.com/4e6yaap8                          |       type pct get2                */
/* ;;;;                      | ============================                          |                                    */
/* run;quit;                 |                                                       |  1  Locked  77    1                */
/*                           | %utl_rbeginx;                                         |  2  Locked  57    2                */
/*                           | parmcards4;                                           |  3  Locked  25    3                */
/*                           | library(haven)                                        |  4  Locked   7    4                */
/*                           | library(sqldf)                                        |  5  NonPro  18    1                */
/*                           | source("c:/oto/fn_tosas9x.R")                         |  6  NonPro  16    2                */
/*                           | options(sqldf.dll = "d:/dll/sqlean.dll")              |  7   Promo  88    1                */
/*                           | have<-read_sas("d:/sd1/have.sas7bdat")                |  8   Promo  79    2                */
/*                           | print(have)                                           |  9   Promo  77    3                */
/*                           | want<-sqldf('                                         |  10  Promo  25    4                */
/*                           |  select                                               |                                    */
/*                           |    type                                               |  SAS                               */
/*                           |   ,pct                                                |   TYPE     PCT    GET2             */
/*                           |   ,row_number() over                                  |                                    */
/*                           |     (partition by type order by pct desc) as get2     |  Locked     77      1              */
/*                           |  from                                                 |  Locked     57      2              */
/*                           |     have                                              |  Locked     25      3              */
/*                           | ')                                                    |  Locked      7      4              */
/*                           | want                                                  |  NonPro     18      1              */
/*                           | fn_tosas9x(                                           |  NonPro     16      2              */
/*                           |       inp    = want                                   |  Promo      88      1              */
/*                           |      ,outlib ="d:/sd1/"                               |  Promo      79      2              */
/*                           |      ,outdsn ="want"                                  |  Promo      77      3              */
/*                           |      )                                                |  Promo      25      4              */
/*                           | ;;;;                                                  |                                    */
/*                           | %utl_rendx;                                           |                                    */
/*                           | run;quit;                                             |                                    */
/*                           |                                                       |                                    */
/*                           | proc print data=sd1.want;                             |                                    */
/*                           | run;quit;                                             |                                    */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input primkey type$ pct;
cards4;
01 Locked 07
02 Locked 77
03 Locked 25
04 Locked 57
05 NonPro 18
06 NonPro 16
07 Promo 77
08 Promo 25
09 Promo 88
10 Promo 79
;;;;
run;quit;

/**************************************************************************************************************************/
/*         INPUT                                                                                                          */
/*         =====                                                                                                          */
/* PRIMKEY     TYPE     PCT                                                                                               */
/*                                                                                                                        */
/*     1      Locked      7                                                                                               */
/*     2      Locked     77                                                                                               */
/*     3      Locked     25                                                                                               */
/*     4      Locked     57                                                                                               */
/*     5      NonPro     18                                                                                               */
/*     6      NonPro     16                                                                                               */
/*     7      Promo      77                                                                                               */
/*     8      Promo      25                                                                                               */
/*     9      Promo      88                                                                                               */
/*    10      Promo      79                                                                                               */
/**************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

proc sql;
   create
       table want as
   select
       type
      ,pct
      ,partition
   from
       %sqlpartitionx(
         (select max(primkey),type,pct from sd1.have
          group by type, pct)
        ,by=type
        ,minus=-1)
  where
       partition <= 2
  order
       by type, pct descending
;quit;

/**************************************************************************************************************************/
/*    TYPE     PCT    PARTITION                                                                                           */
/*                                                                                                                        */
/*   Locked     77        1                                                                                               */
/*   Locked     57        2                                                                                               */
/*   NonPro     18        1                                                                                               */
/*   NonPro     16        2                                                                                               */
/*   Promo      88        1                                                                                               */
/*   Promo      79        2                                                                                               */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
 select
   type
  ,pct
  ,row_number() over
    (partition by type order by pct desc) as get2
 from
    have
')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;
run;quit;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                    |  SAS                                                                                            */
/*      TYPE PCT GET2   |  ROWNAMES     TYPE     PCT    GET2                                                              */
/*                      |                                                                                                 */
/* 1  Locked  77    1   |      1       Locked     77      1                                                               */
/* 2  Locked  57    2   |      2       Locked     57      2                                                               */
/* 3  Locked  25    3   |      3       Locked     25      3                                                               */
/* 4  Locked   7    4   |      4       Locked      7      4                                                               */
/* 5  NonPro  18    1   |      5       NonPro     18      1                                                               */
/* 6  NonPro  16    2   |      6       NonPro     16      2                                                               */
/* 7   Promo  88    1   |      7       Promo      88      1                                                               */
/* 8   Promo  79    2   |      8       Promo      79      2                                                               */
/* 9   Promo  77    3   |      9       Promo      77      3                                                               */
/* 10  Promo  25    4   |     10       Promo      25      4                                                               */
/**************************************************************************************************************************/

/*____            _       _           _
|___ /   _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
  |_ \  | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
 ___) | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|____/  |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/

RELATED REPOS
https://github.com/rogerjdeangelis/utl-select-the-top-n-and-bottom-n-by-group-sql-r-python-excel
https://github.com/rogerjdeangelis/utl-top-four-seasonal-precipitation-totals--european-cities-sql-partitions-in-wps-r-python
https://github.com/rogerjdeangelis/utl-create-table-with-the-top-three-values-by-group-proc-summary
https://github.com/rogerjdeangelis/utl-find-top-and-bottom-ten-persent-of-records-by-group
https://github.com/rogerjdeangelis/utl-flag-second-duplicate-using-base-sas-and-sql-sas-python-and-r-partitioning-multi-language
https://github.com/rogerjdeangelis/utl-adding-sequence-numbers-and-partitions-in-SAS-sql-without-using-monotonic
https://github.com/rogerjdeangelis/utl-how-to-get-the-top-n-largest-values-with-associated-IDs
https://github.com/rogerjdeangelis/utl-macro-to-enable-sql-partitioning-by-groups-montonic-first-and-last-dot
https://github.com/rogerjdeangelis/utl-create-primary-key-for-duplicated-records-using-sql-partitionaling-and-pivot-wide-sas-python-r
https://github.com/rogerjdeangelis/utl-incrementing-by-one-for-each-new-group-of-records-sas-r-python-sql-partitioning
https://github.com/rogerjdeangelis/utl-maintaining-the-orginal-order-while-partitioning-groups-using-sql-partitioning
https://github.com/rogerjdeangelis/utl-top-n-values-by-patient-using-proc-univariate_and_means-
https://github.com/rogerjdeangelis/utl-using-sql-in-wps-r-python-select-the-four-youngest-male-and-female-students-partitioning

LOSELY RELATED
https://github.com/rogerjdeangelis/utl-create-table-with-the-top-three-values-by-group-proc-summary
https://github.com/rogerjdeangelis/utl-find-top-and-bottom-ten-persent-of-records-by-group
https://github.com/rogerjdeangelis/utl-select-the-top-n-most-frequent-ages-and-ecucation-levels
https://github.com/rogerjdeangelis/utl-select-the-top-ten-rows-from-excel-table-without-importing-to-sas

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
