# An Open Source Rail Dataset For Africa - progress report

## Summary

The aim of this project was to extend previous work to create a routable rail network for East Africa (Kenya, Uganda, Tanzania, and Zambia) to further countries on the African continent. Work started with the rail networks of North Africa. Due to the extensive nature of the existing networks (including light rail, subway and tram), and large number of construction schemes and scheme proposals, the decision was made to primarily concentrate on creating an accurate routable network of the existing heavy rail lines currently in use in each country. The countries processed have been thoroughly researched based on information available via web-based sources. This has been more challenging for some countries where source material is limited and/or where information is not provided in English (for example, only in Arabic and French). A document summarising findings and with links to key sources has been created for each country or group of countries and key documents and maps have been downloaded (documents and files are available in the [GitHub repository](https://github.com/trg-rail/africa_rail_network)).

The rail network created identifies the track gauge (including dual gauge where applicable) and whether lines are used for passenger and/or freight services. In general it has been assumed that lines are used for both freight and passenger services (mixed) unless information indicates that they are freight or (rarely) passenger only. Where branch lines or spurs are clearly only servicing industrial locations (such as ports, mines, chemical plants etc.) they have been recorded as freight only.

As with the previous work in East Africa, a single line is used to represent the network irrespective of the number of physical tracks (unless alternate gauges exist) and where possible an existing line mapped in OpenStreetMap has been used. It has sometimes been necessary to insert fictitious edges to simplify the network (for example when routing in/out of stations on alternative branches).

Countries processed to-date include all of North Africa and West Africa (excluding Nigeria).  In total the created network is 18,329 km in length with 1,154 stations and 233 identified lines. This compares to 12,372 km, 423 stations and 69 lines for the network in East Africa. Further information about the progress for each country is detailed below, along with a map showing the network created.

## Breakdown by country processed

### Morocco

![](/images/morocco.png)

- [x] Open and disused lines - passenger and freight - including line names and gauge
- [x] Stations, ports and freight destinations
- [ ] Tram/light rail (deferred)
- [ ] Identify closed/missing stations (deferred)
- [ ] Speed cost (deferred)
- [ ] Abandoned lines (deferred)
- [ ] Proposed lines (deferred)
- [ ] Under Construction lines (deferred)

### Algeria

Algeria has a complex network of existing lines, lines under construction or upgrade and planned lines. See [this map](https://github.com/trg-rail/africa_rail_network/blob/main/algeria/carte-rseau-ferr-national.jpg) from the infrastructure company Anesrif.

![](/images/algeria.png)

- [x] Open lines - passenger and freight - including line names and gauge
- [x] Stations, ports and major freight destinations
- [x] Station names additionally in Latin script where Arabic only
- [ ] Tram/light rail (deferred)
- [ ] Identify closed/missing stations (deferred)
- [ ] Speed cost (deferred)
- [ ] Disused lines (deferred)
- [ ] Abandoned lines (deferred)
- [ ] Proposed lines (deferred)
- [ ] Under Construction lines (deferred)

### Tunisia

![](/images/tunisia.png)

- [x] Open lines - passenger and freight - including line names and gauge
- [x] Stations, ports and major freight destinations
- [x] Station names additionally in Latin script where Arabic only
- [ ] Tram/light rail (deferred)
- [ ] Identify closed/missing stations (deferred)
- [ ] Speed cost (deferred)
- [x] Disused lines (some)
- [ ] Abandoned lines (deferred)
- [ ] Proposed lines (deferred)
- [ ] Under Construction lines (deferred)

### Libya 

There are not thought to be any operational lines in Libya currently. Some construction has taken place for a proposed line parallel to the coast that would form part of a North African link between Tunisia and Egypt. 

- [ ] Under construction (deferred)

### Egypt

![](/images/egypt.png)

- [x] Open lines - passenger and freight - including line names and gauge
- [x] Stations, ports and major freight destinations
- [x] Station names additionally in Latin script where Arabic only
- [ ] Subway/Tram/light rail (deferred)
- [ ] Identify closed/missing stations (deferred)
- [ ] Speed cost (deferred)
- [x] Disused lines (some)
- [ ] Abandoned lines (deferred)
- [ ] Proposed lines (deferred)
- [ ] Under Construction lines (deferred)

### West Africa (excluding Nigeria) 

This includes: Mauritania, Senegal, Mali, Guinea, Sierra Leone, Liberia, Burkina Faso, Côte d'Ivoire, Ghana, Togo, Benin, and Niger.

![West Africa](/images/west_africa.png)

- [x] Mauritania (single line)
- [x] Senegal - new standard gauge and metre gauge (open/rehabilitation/disused)
- [x] Mali - disused metre gauge (single line - Mali portion of Dakar-Niger railway)
- [x] Guinea - standard gauge and metre gauge lines (open). Primarily mining lines.
- [x] Sierra Leone - single 1067mm freight line between Pepel Port and iron ore mines in Tonkolili
- [x] Liberia - two standard gauge freight lines: Bong Mine Railway (believed to be disused) and Buchanan Port to Tokadeh mine (open)
- [x] Côte d'Ivoire and Burkina Faso (metre gauge Abidjan-Ouagadougou railway)
- [x] Ghana - added parts of 1067 narrow gauge thought to be operational (some disused added). Standard gauge under construction (defer).
- [x] Togo - several lines that are freight only currently (1067mm and 1000mm).
- [x] Benin - single 1000mm line in use for freight only.
- [x] Niger - 1000mm line between Niamey-Dosso built 2014-16 intended to connect into Benin network. Project stalled and this is disused (services have never run).

## Next steps

Further work is needed to create the existing heavy rail network for the remaining countries, incorporate lines that are disused, under construction or proposed, incorporate other rail systems (light rail, subway, tram and monorail) and to generate cost attributes. Further details are provided in the sections below, along with an estimate of the time required to complete.  In total it is estimated that at least three months FTE work would be required to complete all outstanding components. 

### Remaining countries

The countries where the heavy rail network currently in use remains to be created are listed below, grouped by the estimated extent of the network low, moderate or high):

* High (20-25 days)
  * South Africa (accounts for one-third of OSM mapped railway length in Africa and nearly 50% of edges)
* Moderate (12 days)
  * Congo (DR)
  * Nigeria
  * Sudan
  * Zimbabwe
  * Angola
  * Mozambique
  * Namibia
  * Ethiopia
* Low (4 days)
  * Cameroon
  * Botswana
  * Malawi
  * Madagascar
  * Congo-Brazzaville
  * Gabon
  * Eswatini
  * Eritrea
  * South Sudan
  * Djibouti
  * Mauritius
  * Reunion

### Other networks

In addition to the heavy rail network, a number of the countries have light rail, tram, subway and monorail networks that have not yet been created, as detailed below: 

#### Light Rail

Countries with significant light rail network (2 days):

* Congo (DR)
* Ethiopia
* Mauritius
* Nigeria
* South Africa
* Tunisia

#### Tram

Countries with significant tram network (1.5 days):

* Algeria
* Egypt
* Morocco
* South Africa
* Tunisia

#### Subway 

Countries with significant subway network (1 day):

* Algeria
* Egypt

#### Monorail

Countries with significant monorail network (0.5 day):

* Egypt
* Nigeria
* Senegal
* South Africa

### Additional lines

Work completed to date has focussed on lines that are believed to be currently in use. Some disused lines have been incorporated (primarily where these were marked as open in the OSM data). Further work would be needed to incorporate the following:

* Lines recorded in OSM as disused (15 days). This will not include abandoned lines (where, under the OSM guidance for this tag, the track no longer exists and usually only non-contiguous remnants of old routes are mapped).

* Lines under construction (5 days).

* Lines that are proposed (depends on requirements).

The recording of lines that are proposed or under construction may require digitisation from published documents and open data sources (using, for example, Google Earth to digitize lines under construction to augment this dataset is probably against Google's Terms of Service). There is likely to be considerable work researching proposed new lines and a decision would need to be made on what basis to include them (for example, only those with confirmed funding in place).

### Additional Attribution

Work is still required to research and complete additional attribution of the network, including:

* Number of tracks (partly recorded already where information was readily available) 
* Cost attributes (5 days)
  * Freight speed
  * Passenger speed
  * Time (freight)
* Status of stations - whether currently served by passenger services (depends on accurate data on passenger services which is tricky to obtain for many countries). 
