# infection-tracking


## problem statement
* over the last two decades several novel viral respiratory epidemics have rocked the world: [SARS Coronavirus](https://en.wikipedia.org/wiki/Severe_acute_respiratory_syndrome) (2002-2003), [H1N1 Influenza](https://en.wikipedia.org/wiki/Influenza_A_virus_subtype_H1N1), [MERS Coronavirus](https://en.wikipedia.org/wiki/Middle_East_respiratory_syndrome-related_coronavirus) (2012), [Wuhan Coronavirus](https://en.wikipedia.org/wiki/Coronavirus_disease_2019) (2019-2020), etc.
* collectively these viruses have causes thousands of deaths and billions of dollars in lost productivity: the [world bank estimates](https://www.weforum.org/agenda/2018/05/how-epidemics-infect-the-global-economy-and-what-to-do-about-it/) that each of these epidemics has resulted in loss of 0.7% of worldwide GDP (or approximately $570B annually)
* any of these viral epidemics can potentially become a ***_worldwide pandemic_*** like the Spanish Flu of 1919-1920, which infected approximately 27% of all people on Earth and killed 50-100m people worldwide.
* because of widespread air travel, these modern viral infections have spread throughout the world, as illustrated by the rapid spread of Wuhan coronovirus in 2019-2020:

![wuhan coronavirus spread, source: wikipedia](https://upload.wikimedia.org/wikipedia/commons/b/b3/COVID-19-outbreak-timeline.gif)

_worldwide spread of Wuhan Coronavirus December 2019 to February 2020, source: wikipedia_

* For novel viruses few treatment options exist. Developing vaccines and antiviral therapeis can take years, at which point a virus could have become a pandemic. The most effective (and sometimes only) strategy is ***_containment_***.
* Because these infections have a latent period and can spread readily from one person to another, ***_the central challenge of containing infection is to identifying who has been exposed to infected individuals._*** 
  * Historically this has been a labor intensive process requiring public health officials to laboriously identify anyone who might have been in proximity to an infected person (e.g. who are their neigbhoors, who sat next to them on an airplane, etc). Unfortunatly these approaches are slow, labor-intensive, and often fail to promptly identify many people who were exposed.
  * Identifying where infected people have been is the key to finding those who are at risk for infection.
* A novel approach for rapidly identifying individuals who may have been exposed to infected hosts is desperately needed.



## proposed solution
* ***Our mobile app and associated platform takes advantage of the fact that modern smartphones are ubiquitous, able to collect geospatial data, and able to share it over secure networks. By developing a privacy preserving algorithm, we enable users to immediately see if they have been exposed to infected individuals without risking exposure of thier location data.***
 * individuals can download an app to see information about where infections have been reported
 * this app also securely tracks users locations
 * this information can be used to identify if a user has been in the same location as an infected person

## [design of app and platform](https://github.com/nickmmark/infection-tracking/blob/master/DESIGN.md)
* there are two core pieces of the platform
  * a mobile app that can provide information about outbreaks and securely track locations
  * a platform that can identify exposure between infected individuals and other users
  

## [enabling technology](https://github.com/nickmmark/infection-tracking/blob/master/TECHNOLOGY.md)
* for a detailed description see [here]
* the key to privacy preserving geospatial data is encoding the users coordinates as a geohash and combining that with time series data to create a fully deidentified encrypted geotemporal database.
* if an infected person is found, the platform can identify what other users were in the same locations at the same times (e.g. who was exposed). The exposed individuals receive notifications via the mobile app.
* importantly, the database is tied to anonymous identifiers

## [business case]()
* the app provides a free service to users, which encourages them to download it
* the app also enables privacy preserving tracking, which is a valuable service to the government
* the app is presumably free to download; most of the revenues are from a ***B2G*** payment model; maybe there is also a ***fremium*** set of features that is sold with a ***B2C*** model.
 * paid advertising?

## competitors
* [several mobile apps have been developed to track infections](https://jglobalbiosecurity.com/articles/10.31646/gbio.39/), however none has been especially successful.
 * [healthMap](https://healthmap.org/en/) - essentially a geo news aggregator; mobile and web clients, allows users to 'report' local outbreaks
 * [sickWeather](http://www.sickweather.com/) - illness forcasting and mapping; has a slick UX for iOS and watchOS and gives a "SickScore®" to predict the local risk
 * [fluView](https://apps.apple.com/us/app/fluview/id507807044) - a CDC app that shares influenza data
 * [fluTracker](https://apps.apple.com/us/app/fluview/id507807044) - 
 * [flu near you 2](https://flunearyou.org/#!/) - 

## references
* [BARDA ENACT program AOI#1](https://drive.hhs.gov/files/DRIVe%20EZBAA%20Pre-Proposal%20Conference%20Slides%20Final_v2.pdf)
