# infection-tracking


## background
* over the last two decades several novel viral respiratory epidemics have rocked the world: [SARS Coronavirus](https://en.wikipedia.org/wiki/Severe_acute_respiratory_syndrome) (2002-2003), [H1N1 Influenza](https://en.wikipedia.org/wiki/Influenza_A_virus_subtype_H1N1), [MERS Coronavirus](https://en.wikipedia.org/wiki/Middle_East_respiratory_syndrome-related_coronavirus) (2012), [Wuhan Coronavirus](https://en.wikipedia.org/wiki/Coronavirus_disease_2019) (2019-2020), etc.
* collectively these viruses have causes thousands of deaths and billions of dollars in lost productivity.
 * the [world bank estimates](https://www.weforum.org/agenda/2018/05/how-epidemics-infect-the-global-economy-and-what-to-do-about-it/) that each of these epidemics has resulted in loss of 0.7% of worldwide GDP (or approximately $570B annually)
* because of widespread air travel, these infections have  spread throughout the world, as illustrated by the rapid spread of Wuhan coronovirus in 2019-2020

![wuhan coronavirus spread, source: wikipedia](https://upload.wikimedia.org/wikipedia/commons/b/b3/COVID-19-outbreak-timeline.gif)

* these infections can spread readily from one person to another. ***_The central challenge of containing infection is to identifying who has been exposed to infected individuals._***
* [several mobile apps have been developed to track infections](https://jglobalbiosecurity.com/articles/10.31646/gbio.39/), however none has been especially successful.

## concept
* individuals can download an app to see information about where infections have been reported
* this app also securely tracks users locations
* this information can be used to identify if a user has been in the same location as an infected person

## app and platform design
* 
* there are two core pieces of the platform
  * a mobile app that can provide information about outbreaks and securely track locations
  * a platform that can identify exposure between infected individuals and other users

## underlying technology
* for a detailed description see [here](https://github.com/nickmmark/infection-tracking/blob/master/TECHNOLOGY.md)
* the key to privacy preserving geospatial data is encoding the users coordinates as a geohash and combining that with time series data to create a fully deidentified encrypted geotemporal database.
* if an infected person is found, the platform can identify what other users were in the same locations at the same times (e.g. who was exposed). The exposed individuals receive notifications via the mobile app.
* importantly, the database is tied to anonymous identifiers

## business case
* the app provides a free service to users, which encourages them to download it
* the app also enables privacy preserving tracking, which is a valuable service to the government
* 

## competitors
*

## references
* 
