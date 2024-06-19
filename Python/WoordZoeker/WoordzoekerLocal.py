import re
from collections import Counter
import matplotlib.pyplot as plt

def analyseer_tekst(tekst, merken):
    # Maak de tekst klein geschreven om hoofdletterongevoeligheid te garanderen
    tekst = tekst.lower()

    # Verwijder storende leestekens die merknamen kunnen splitsen
    tekst = re.sub(r'[\!\,\-\/\:\(\)]', ' ', tekst)

    # Voeg extra ruimte toe voor en na haakjes voor betere woordscheiding
    # tekst = re.sub(r'[\(\)]', ' ', tekst)

    # Tellen van elk merk in de tekst
    merk_telling = Counter()
    for merk in merken:
        # Match exacte woorden en woordcombinaties, rekening houdend met hele woorden
        pattern = r'\b' + re.escape(merk) + r'\b'
        matches = re.findall(pattern, tekst, flags=re.IGNORECASE)
        merk_telling[merk] += len(matches)

    # Verwijder merken met een telling van 0
    merk_resultaten = {merk: count for merk, count in merk_telling.items() if count > 0}

    # Tel alle woorden in de tekst
    woorden = re.findall(r'\b\w+\b', tekst)
    totaal_woorden = len(woorden)

    return merk_resultaten, totaal_woorden

# Voorbeeldtekst
tekst = """
Welk merk electrisch gereedschap heeft jullie voorkeur?

Vraag
Sinds kort ben ik zeer actief aan het klussen en ik heb nu mijn centen geïnvesteerd in het Makita LXT 18v platform. Super fijne machines. Ik ben bij Makita terecht gekomen door mijn zwager, hij werkt al sinds zijn 16e als timmerman en heeft met van alles gewerkt. Hij benoemde dat hij Makita de fijnste machines vind hebben vanwege de handgrepen en dat de accu's erg lang mee gaan (als in, dat ze na jaren nog steeds hetzelfde vermogen geven als wanneer ze nieuw waren)

Ik heb veel met Black and Decker en Bosch (blauw) gewerkt in het verleden en deze machines gingen met een paar jaar stuk.

Nu de vraag: welk merk machines gebruiken jullie en hoe hebben jullie deze keuze gemaakt?

Doe-het-zelver

Ik gebruik de Adam Savage tactiek: de eerste keer dat ik gereedschap koop ga ik voor goedkope meuk (Parkside). Gebruikt ik het zoveel dat het kapot gaat, ga ik voor een duurder merk. In het geval van accu's ga ik dan ook voor Makita. Met een snoer maakt het merk mij wat minder uit.

Voor handgereedschap ben ik het hier helemaal mee eens, maar voor elektrisch eigenlijk niet, of in ieder geval niet altijd.

Een paar voorbeelden:

Een goedkope schuurmachine trilt zo erg dat hij je handen verneukt. Op het moment dat je daar halverwege het schuren van je kozijnen achter komt en toch maar een duurdere gaat kopen is het al te laat.

Een goedkope decoupeerzaag zaagt scheef omdat het zaagje niet goed ondersteunt wordt.

Een goedkope boormachine boort geen ronde gaten omdat er teveel speling in de kop zit.

Bij handgereedschap heb je meestal dat de goedkopere opties minder lang meegaan (een schroevendraaier waarvan de kop vervormd raakt, een steeksleutel die gaat slippen) en/of minder snel werken (een goedkope vijl heeft een minder goed profiel en is minder hard, waardoor je 2x zo lang bezig bent). Maar zolang je nog aan het begin van de levensduur zit kan er hetzelfde resultaat mee behalen als met duurder gereedschap, hoogstens kost het langer.

Maar dat is bij elektrisch gereedschap niet zo. Daar duurt het ook langer, want de motor van goedkoop gereedschap is minder krachtig, maar is het resultaat vaak ook daadwerkelijk slechter. Al bij de eerste keer gebruik zaagt die decoupeerzaag scheef. Al bij de eerste keer boort die boormachine een niet-rond gat. Etc.

Bij handgereedschap kan je meestal voor het gebrek aan kwaliteit compenseren met tijd en eigen vaardigheid. Bij elektrisch gereedschap kan dat veel minder vaak.

Uiteraard zijn er ook gereedschappen waarbij het wel kan, meestal dingen waarbij precisie niet zo uitmaakt. Bijv. een schroefmachine, lijmpistool, cirkelzaag als je er alleen maar grof mee werkt, flex (bij licht gebruik).

Daarnaast kan het, als je accugereedschap wil, heel fijn zijn om het van hetzelfde merk te hebben, in plaats van de goedkoopste van 6 verschillende merken.


Klopt helemaal. Parkside is leuk op het eerste gezicht. Veel functies/opties voor een lage prijs.

Kijk je wat beter dan is het ellende. Ronde schuurmachine, trilt meer je hand dan het schuurpapier... na een paar klussen kapot. Daarna DeWalt uitgekozen. Want die publiceren wel netjes de gegevens over trillingen. Echt een verademing. Stofafvoer ook veel beter.

Maargoed, carpaal tunnelsyndroom en stoflongen merk je vaak pas op lange termijn. Dus mensen blijven Parkside kopen.

Ik heb ook wel parkside. Dat ik hun accu al heb en de lage prijs van het spul haalt me wel over. Bijv. een reciprozaag in de sale voor 35,-. Accu heb ik al. Dan is het erg verleidelijk.


Ik merk toch echt wel verschil tussen de groene en zwarte lijn parkside producten. Ik heb gereedschap van beide en moet zeggen dat de peformance lijn (zwart gereedschap) qua kwaliteit en functionaliteit echt heel goed in de markt zit. Het alternatief zijn vaak de budget lijnen van de "A-merken" en die zijn vaak vele malen slechter. Uiteraard is het profi gereedschap van een "A-merk" wel stukken beter, maarja die zijn ook vaak 5x zo duur.


Stel ik toch de kritische vraag. Is dat allemaal echt zo een ramp? Als professional zeker weten, als startende doe-het-zelver denk ik dat het wel meevalt. Je schuurt niet de hele dag, je bouwt geen hele complexe of super mooi afgewerkte dingen, etc. De kans dat je last krijgt bij schuren of niet ronde gaten is überhaupt aannemelijk, je bent nog zoekende naar hoe doe je dat makkelijk, hoe verspil ik niet veel energie, bent krampachtig bezig en meer van dat soort dingen.


Ik gebruik mijn parkside schuurmachine al jaren en heb daar eigenlijk nooit problemen mee. Juist de stofafvoer daar ben ik heel tevreden over. Maar ja, het gaat hier om een paar dagen per jaar dat ik iets moet schuren. Als profi snap ik volledig dat je iets comfortabeler wil.


Ik heb van Parkside Performance (zwarte lijn) een accuboormachine, een accu decoupeerzaag, een accu invalzaag en een accu haakse slijper. Als ik de producten vergelijk met Makita- en DeWalt gereedschap van vrienden ben ik echt zeer tevreden met de parkside performance series. Zeker gezien de prijs die ik heb betaald. De boorkop op mijn parkside boormachine is ook een Röhm boorkop. Komt uit dezelfde fabriek als de DeWalt boorkoppen. Het enige probleem dat ik tot nu toe gehad heb is een doorgebrande zekering in een haakse slijper na urenlang leegtrekken en opladen met de haakse slijper. Dit betreft echter een oud model accu, welke gratis vervangen werd.


Dit! Onze parkside slagboor doet al jaren trouwe dienst.


Mijn parkside schroefmachine gaat al langer mee dan mn pa zn makita (en ik denk dat ze ongeveer evenveel gebruikt worden). Vind dat parkside spul echt top voor de prijs.


Koop wel de echte Makita. Niet de consumentenversies die Gamma/Karwei/Praxis liever verkopen. Die herken je aan de accu's met een wit lipje.

Parkside is oke voor de consument en doe-het-zelfer. Maar als je dagelijks er flink mee gaat schroeven omdat dat je baan is. Dan ben je beter af met Makita.


Het prijsverschil tussen de "echte" makitia en parkside is dan ook wel enorm. Parkside zit in de categorie doe-het-zelf gereedschap en daar doen ze het enorm goed in. De witte accu makita machines zijn naar mijn mening slechtere kwaliteit dan de peformance schroeftolletjes van parkside.

Dus nee, parkside is niet voor de prof, maar voor de (prijs-)categorie doe-het-zelf erg goed.


Precies dit!


Bij mij precies hetzelfde, maar: als het accuraat moet zijn (m.n. zagen, boorhamer, accutol) dan koop ik meteen de dure en dan is de keuze eigenlijk altijd Makita, ongeacht accu of snoer.

Ben zelf van de Makita.

Alle grote merken (Milwaukee, Makita, DeWalt, Bosch, Metabo) zijn allemaal uitstekend. Dus kies de kleur die je voorkeur heeft en ga los.

Festool is de keus als je professioneel spul wil maar het is enorm hoog geprijsd voor wat je krijgt en dat is het in mijn ogen niet waard als hobbyklusser.

Ikzelf vind Makita oerdegelijk, goed betaalbaar en de turquoise kleur is overduidelijk enorm superieur aan andere kleuren.


turquoise kleur is overduidelijk enorm superieur aan andere kleuren.

Hahaha I couldn't agree more


Ik heb ook met alles gewerkt en elk merk heeft sterke punten. Van Festool hou ik de schuurmachine en die hou ik 😊. Bosch ook blauw proffesional en Metabo heb ik verkocht dat is gewoon niet goed genoeg voor dagelijks gebruik. Ze boren ruim minder dan makita of milwaukee. Milwaukee heeft perfecte slagboor machines maar de opladers gaan aan de lopende band stuk. Qua totaal plaatje heb ik gekozen voor 18v makita. Perfect spul en de beste prijs kwaliteit verhouding van alles. Het blijft heel en zelfs in gegoten beton moeiteloos terwijl de meeste merken het wel redden maar een stuk trager. Dat is voor een paar gaatjes ok. Maar als je dagje moet boren wil je er geen 2 dagen van maken. Dus gewoon makita.


Festool is ook heel goed. Vooral heel nauwkeurig en goed ecosysteem. Ze hebben goed schuurpapier en goede stofzuigers. Vooral meubelmakers en schilders zijn er gek op. Maar is wel minder robuust en krachtig dan een Makita voor minder geld.


Festool maakt de mercedes onder het gereedschap. Ik denk dat je de waarde daarvan pas echt ziet (tov Makita, bosch profi) als je het dagelijks gebruikt.


Toen ik mijn huis kocht heb in een voordeelpakket een lading makita aangeschaft. Erg blij mee maar achteraf misschien beetje overkill. Met de aanbiedingsprijs was het een goede deal.

Makita is een goed merk en ik doe al 6 jaar met dezelfde accu's. Heb wel een verlanglijstje voor meer maar het is niet een goedkoop merk.

Daarnaast heb ik wat Bosch ter aanvulling zoals schuurmachine/slijptol met draad.


Parkside (professional) gebruik ik zelf en is echt zeer hoog kwaliteit.


Hoe herken je parkside profi tov de normale?


Staat er op en de koffers zijn zwarter de normale zijn rood. Eventueel foto in dm als je wil


De standaard machines zijn groen met een zwarte kist. De peformancelijn heeft zwart gereedschap met een Zwart/rode kist, owja en er staat groot performance op.


Gereedschap is net zo goed als de handen die het bedienen. Mijn stelregel: gebruik ik het om geld mee te verdienen: Hilti, Festo, Metabo. Voor tuus krijgen de huismerken van Gamma, Lidl of andere toko’s het ook prima voor elkaar. Kosten vs baten.

Elektricien

+1 voor Makita met LXT accu’s. Ik ben een hobbyklusser.


Ik ben voor het Ryobi One+ platform gegaan en ben er echt enorm blij mee. Veel met DeWalt, Makita en Festool gewerkt en is ook allemaal goed.


Parkside!


De accuzaken heb ik allemaal van DeWalt. Maar met de oude klassieke grote zoals Makita en Milwaukee kun je ook nooit mis. Ryobi heeft ook een sterk accuplatform voor wat minder geld vind ik. Bosch vind ik het minste bekende merk. Dan kun je net zo goed voor de Parkside van de Lidl gaan in mijn optiek.

Gereedschap met een stekker maakt het merk me niet uit. Het moet gewoon goed zijn.


Dewalt en Still zijn ook fijne machines, maar voor hoeveel ik ermee werk is Makita een goed compromis. Gewoon hele fijne machines voor best een schappelijke prijs.

Voor dingen die ik zelden gebruik zijn die va de Lidl ook niet slecht. Heb er bijvoorbeeld een reprozaag van die ik een weekje nodig had om te slopen, was een stuk goedkoper dan een zaag te huren en dat ding werkte ook best goed.


Hoe bedoel je dat je Makita een compromis is? Ik hoor inderdaad goede dingen over Parkside!


Makita is wat goedkoper dan DeWalt en Stihl, maar nog steeds een hele fijne machine. Als je een beetje naar de aanbiedingen kijkt kun je al een Makita schroefmachine met 2 batterijen voor onder de 150 Euro vinden.

Ik heb ook Parkside, en zijn best fijne machines, zeker voor die prijs, maar een Makita, DeWalt of Stihl zijn toch echt fijner. Het is een kwestie van hoe vaak je iets gebruikt en hoeveel je over hebt voor dat beetje extra gemak voor die keren dat je het gebruikt.

Dus ik heb een schroefmachine van Makita, klopboormachine van Stihl (die had ik een tijd veel nodig en die lijden best wel wat bij intensief gebruik, dus een goede zorgt dat je je niet druk hoeft te maken over kapot gaan), parkside voor reprozaag en decoupeerzaag. Voor decoupeerzaag had ik liever een beter merk gehad want ik gebruik hem best veel, maar had die Parkside al en ik ga geen nieuwe kopen tot hij kapot gaat.


Ik heb een Dewalt accu boormachine. Echt een fantastisch apparaat. Maar ja, de rest is allemaal erg duur. Ik heb een invalzaag gekocht van Makita met snoer, apparaten op accu zal ik dewalt blijven overwegen. Denk in de trant van schuurmachine etc. De zwaardere zaken blijf ik aan de snoer.

Overigens wilde ik het Makita platform toen kopen, maar werd mij afgeraden door vriend bij de Gamma omdat Makita overging op een nieuw accuplatform.


Heb ook een Still. De oplader maakt wel veel geluid maar verder is het een prima heftruck


Engelse spelling check had daar een mening over...


Precies dit! Dewalt stihl en parkside


Ik heb een boorhamer van dewalt met draad en 1 van makita met batterijen en deze is vele malen beter. Boort sneller en maakt ook veel minder herrie.


En ik ben Hilti helemaal vergeten. Ook ontzettend mooi spul, maar ook wat prijzig.

Doe-het-zelver

Milwaukee voor kwaliteit en langere duur, en Vonroc/Skil als ik iets nodig heb maar nog niet weet of ik het vaker gebruik. Ik heb bijvoorbeeld een Vonroc multitool voor 40 euro, maar als die ooit 'op' is omdat ik hem zo vaak gebruik, dan vervang ik hem voor een Milwaukee.


Ik ben zelf erg blij met mijn Milwaukee gereedschap, maar eigenlijk kan je bij de grote merken niet verkeerd gaan. Misschien is op dit moment de boor van de een 10% sterker dan die van de ander, maar ze zijn allemaal twee keer zo goed als 10 jaar geleden. Ik ben wel wat afgeschrikt door het accu beleid van makita, maar ook daar zal je waarschijnlijk gewoon tevreden mee zijn als je het koopt. Ik ben vooral met milwaukee begonnen omdat het een goede aanbieding was, en een relatief zeldzaam kleurtje hebben heeft ook nog wel eens zijn voordelen


Als ik vragen mag, waar schrok jij van mbt accubeleid van makita?


Mijn eerste introductie met de accu problematiek was er achter komen dat makita dus twee 18v platformen heeft, en dat de machines die je bij de gemiddelde bouwmarkt koopt niet compatibel zijn met de rest. Daarnaast is er ook nog wat gekkigheid binnen bijvoorbeeld het lxt platform, waarbij ook binnen dat platform niet iedere accu compatibel is met iedere machine. Meestal gaat het goed, het speelt vooral bij oudere accu’s met nieuwe machines, maar dat dat uberhaupt een ding is zegt al wel wat, makita heeft dus duidelijk grenzen met hoeverre ze voor compatibiliteit gaan, en dat zet bij mij dus echt twijfels over de toekomstvastheid. Bij Milwaukee weet je tenminste zeker dat als er op zowel machine als accu M18 staat het gewoon werkt. Natuurlijk zijn sommige accu’s dan te licht voor bepaalde apparaten, maar dan is je slijptol simpelweg wat minder sterk, het werkt gewoon wel.


Ik ben het wel eens met je wat betreft de compatibiliteit van LXT en G. Daarin zijn ze niet heel erg duidelijk. Wat betreft de compatibiliteit van oudere accu's/machines kan ik niet echt over meepraten omdat ik die problemen nooit gehad heb. Het mag trouwens wel in perspectief geplaatst worden: LXT bestaat sinds 2005 en Fuel pas sinds 2012.


Ja, achteraf gezien staat het natuurlijk op de doos dat het om het ‘G’ platform gaat, maar als consument denk je dan alleen “18 volt makita, dat zit goed!”.

Het milwaukee m18 platform stamt trouwens uit 2008, die fuel lijn is leuke marketing voor beter dan het vorige model, maar alles binnen het m18 platform is dus nog volledig compatibel met elkaar.

Ik had het verder andersom, het gaat bij makita om oude machines en nieuwe batterijen, sommige machines van voor 2015 zijn dus niet meer compatibel met nieuwe batterijen.


Ik klus niet vaak, maar als ik iets koop, is het meestal van dewalt. Zowel de monteur die altijd onze auto's doet, als de klusjesman die hier de hele bende heeft verbouwd zweren erbij. Ik heb een blind vertrouwen in hun oordeel, dus als ik iets koop is het ook dat.


VonRoc is een betaalbare optie en prima spul voor de doe het zelver, uiteraard zal een Makita of DeWalt een langere levensduur hebben maar daar is de prijs ook naar. VonRoc voelt in ieder geval heel degelijk aan en tot op heden blij mee.


Heb de 6j breekhamer van vonroc gekocht. Lomp maar degelijk apparaat, tot nu toe ook zeer content mee


DeWalt vind ik het fijnste merk. Hoewel ik geen kenner ben vind ik het een sympathiek merk.

    Ze maken kwaliteit

    Ze hebben ietsje minder sektarische fanboys zoals bijv. Festool en Makita.

    Ze maken geen goedkope bagger waar ze hun naam op plakken om meer winst te maken. Bijv. Makita maakt ook goedkoop gereedschap met matige accu's waarmee ze hun naam gebruiken om de eenvoudige consument te lokken.

Hierdoor heb ik het idee dat bij DeWalt iets minder de aandeelhouders en boekhouders de lakens uitdelen en het gewoon om techniek gaat.


    Makita maakt ook goedkoop gereedschap met matige accu's waarmee ze hun naam gebruiken om de eenvoudige consument te lokken.

Dit deden ze speciaal op verzoek van de bouwmarkten (Gamma/Karwei/Praxis enzo). Want eerst wilde Makita het niet produceren en alleen de goede Makita-lijn verkopen. Maar toen dreigden de bouwmarkten Makita niet meer te verkopen. Dus kozen ze eieren voor hun geld.

Toen de bouwmarkten dit zo'n 14-15 jaar geleden allemaal omschakelden, heb ik nog een T-model decoupeerzaag met een Makita Systainer (met rode clips) met 50% korting weten te scoren. Echt een fijne en superkrachtige machine.


Mijn voorkeur gaat uit naar Bosch. Met Parkside op de tweede plek.


Festool: schuurmachine en invalzaag Dewalt:hakhamer (of bosch profi lijn) Rest makita


Festool en milwaukee


Voor mij hangt het heel erg van je gebruik, budget, en skill level af.

Als je een matige klusser bent dan kan je beter eerst je geld uitgeven aan een cursusje houtbewerking dan duur gereedschap.

Zelf (een redelijk handige doe het zelfer) heb ik Makita. Voornamelijk gekozen omdat er veel keuze binnen het accuplatform is en het een goede prijs/kwaliteit verhouding heeft. Ik ben er erg tevreden mee, maar volgens mij kan je met andere merken in dezelfde prijsklasse net zo goed uit de voeten.

Als ik een apparaat ga kopen dat ik nauwelijks verwacht te gaan gebruiken dan koop ik meestal wat goedkopers, zoals Black en Decker.

Mijn vader heeft alles van Festools. Als ik geld over zou hebben zou ik dat ook graag willen, maar voor mij is de prijs/gebruik verhouding gewoon te hoog.


DeWalt


heb het hele assortiment van Park Side. verkrijgbaar bij lidl (onlineshop). scheelde me meer als de helft en de boormachine is als beste getest door consumenten bond. De andere apparaten werken ook allemaal stuk voor stuk heel goed! ze zijn 20V. echt een aanrader voor een kluns klusser of zelfs de ZZP-er.

Ik klus veel. het enige minpunt was de laser uitlijner die was niet goed geijkt toen ik m kreeg.


Parkside> Makita > Festool

Goed> Beter > Beste


Ik koop sinds een aantal jaar in principe altijd Makita. Gewoon de bekabelde variant, behalve voor de schroefmachine. Vind het prijs/kwaliteit de beste keus.

Moet zeggen dat ik een schroefmachine van DeWalt en een schuurmachine van Metabo heb die ook erg goed bevallen. Beide al flink wat jaren oud en voor ik op Makita overstapte.

Elektricien

Ik heb vanuit werk ook Makita en daar ben ik erg blij mee, het enige wat ik niet van Makita heb is de boormachine die is van Hilti en die is ook erg fijn moet ik zeggen maar sommige collega'e van mij hebben wel een boormachine van Makita en vind ze allebei zeer fijn werken


Bosch, Makita en Metabo hier. Merk geen grote verschillen en over alles wel tevreden. Twijfelde laatst om iets van Parkside te kopen, uiteindelijk toch maar iets meer uitgeven. Maar stiekem wel benieuwd naar. De kwaliteit.


Makita, ooit een boormachine gekocht met twee accu's en lader.
Later aangevuld met "Body only" machines al dan niet met koffer.
Makita heeft regelmatig acties met gratis accu, ook bij BO's. Zo heb ik inmiddels 6 accu's verzameld.
Met draad koop ik vooral (tweedehands) festool. Ik hou van gewoon van mooi en goed gereedschap.


Ik koop al het elektrisch gereedschap van hikoki (hitachi). Bevalt super goed en de accu's gaan ook lang mee. Heb een aantal setjes 18 en 36 v accu's. Veel van de zwaarste modellen, gebruik het soms vrij lomp aan de landbouw machines. Heb altijd goed gereedschap nodig, soms gaan mijn machines kapot op het land dan moet alles wel vuil, stof, water en olie kunnen.


Ik ben heel tevreden overr BOSCH blauw. Apparaten gaan echt heel lang mee, ook met laten vallen etc.

Makita is ook goed gereedschap, het heeft een hele goede prijs kwaliteit verhouding.


Ik heb zelf voor Ryobi gekozen. Het is enerzijds goedkoper dan de grotere merken en anderzijds bieden ze ook veel (goedkoop) tuin gereedschap wat voor ons ook handig is. Zo is het behapbaar om een apparaat te kopen die je weinig gebruikt omdat je er relatief weinig voor betaald.

Verder vind ik tot nu Ryobi prima werken. Boort, schroeft en zaagt prima voor klussen thuis en het klussen aan mijn motor. Mocht je vaker zwaarder werk doen zou ik de HP/Brushless lijn aanraden. Krachtig genoeg voor al het werk.


Op de bouwplaats veel makita/bosch en festool gereedschap vast gehad als stagaire.


Alleen de afkortzaag en liniaal cirkelzaag zijn van Metabo. De rest is van Bosch. Alleen de 18v schroefboor is laatst stuk gegaan, al was die de afgelopen jaren ernstig mishandeld. Voor €60 had ik een nieuwe. De (klop) boor gaat al bijna 30 jaar mee.

Voor thuis is Bosch prima. Voor dagelijks gebruik zou het echter niet aanraden.

Voor draaiende apparaten zou de tip zijn om te kijken of je zelf de koolborstels kan vervangen.


Ferm, vd Action, in de aanbieding.


Wat ik me altijd heb afgevraagd. Ik heb zelf 2 Makita apparaten met witte accus(ooit als set gekocht). Maar dat is dan de consumenten versie?


Ja, soms geven ze van de aparte sets uit waar dan specifieke 2ah accu's bij zitten. Zelfde motoren als de grotere schroef machines maar gewoon een product op zichzelf


De witte accu's zijn idd van de consumentenversie

Ga een keer naar de Hornbach of Bauhaus. Die hebben vaker de profi Makita versies, met zwarte accu's. Je voelt het verschil als je er eentje in je hand houdt


Makita heeft onze voorkeur. We hebben wel wat andere gereedschap, maar ook bij ons werd Makita door werklui (ingehuurd en vrienden) aangeraden. Dus als we nu iets moeten vervangen kopen we een Makita. Het is ook wel fijn dat de accus overal op passen nu.


Ik heb n makita schroevendraaier en handstofzuiger, allebei erg blij mee. Ik heb ook een Bosch draadloze stofzuiger die volgens mij veel duurder was. De bosch heeft minder batterij en kracht en ook ruimte. Dat ding is vol met 3 halen over de vloer. Makita all de way, alleen bij de stofzuiger was ik nog 120 extra kwijt om een accu en lader aan te schaffen. Ik doe er nu de onderverdieping mee, half uurtje laden en dan de bovenverdieping. Vind t prima zo, even pauze of klusjes over de dag verdelen.


De walt is de beste in alles

Doe-het-zelver

Dewalt 18v brushless! Totaal hoteldebotel


Ik ben enorm blij met mijn Hilti set. Met 1 nier is prima te leven.


Pwoah, mag hopen dat dat niet voor incidenteel gebruik is.


Mijn eigen huis en dat van een vriend volledig gerenoveerd, werd gunstiger om het zelf te kopen dan alles te huren :)


Ik heb het opgesplitst, voor gereedschap dat ik relatief vaak gebruik koop ik nu milwauke (accuboor, slagschroefmachine, multitool, etc). Voor spul wat ik denk van nah is fijn om te hebben maar gebruik ik niet supervaak haal ik nu skill (afstekzaag, zaagtafel, schuurmachine, decoupeerzaag, grasmaaier, heggenschaar, bladblazer). Zo houd ik het voor mezelf nog beetje betaalbaar zonder al teveel accuplatformen te moeten wisselen. Tot nu to zeer tevreden met die manier en blij verrast met de kwaliteit van skill. En als ik iets veel gebruik en kapot gaat kan ik altijd nog over op milwauke.

Doe-het-zelver

Koop de eerste keer een goedkoper merk (Parkside). Breekt het omdat je het vaak gebruikt heb? Dan koop je een duurder merk, kies een platform omdat accu's tegenwoordig uitwisselbaar zijn onder de meeste tools van hetzelfde merk. Breekt het omdat het ruk is, maar je gebruikt het weinig kijk dan over een paar jaar of het weer gebruikt. Accuboormachine kun je meteen beter een duurdere kopen, die gebruik je nagenoeg voor elke klus.

Zelf heb ik heel veel van Parkside behalve mijn accuboormachine (Makita) en mijn tafelzaag (Bosch); oh en de afkortzaag is van het duurdere broertje van Parkside, ben de naam even kwijt.

Op de bandschuurmachine na is er niets stuk gegaan, en de bandschuurmachine was mijn eigen schuld omdat ik de band niet goed afstelde en deze schuurband door de zijkant het binnenhuis sloopte.


Wat is het duurdere broertje van parkside? Dat is namelijk alleen een merknaam die op goedkoop gereedschap wordt geplakt, maar geen fabrikant

Doe-het-zelver

Ik heb m opgezocht, Einhell.

Zo is het mij verteld. Alleen of het echt zo is, heb ik niet gecheckt.


Ah, op die fiets. Parkside plakt alleen hun naam op het gereedschap van iemand anders, maar het kan dus overal vandaan komen. Einhell is daar in iets mindere mate schuldig aan, maar produceert dus ook nog het een en ander zelf.


Ik heb zelf alles van Bosch. Een oom van mij werkte daar en ik denk dat ik daarom onbewust m'n gereedschap van wilde hebben. Ik ben er zeer tevreden over, en voor mijn gevoel is de discussie Bosch versus Makita meer een gevoelskwestie dan dat ze elkaar in kwaliteit veel ontlopen. Alleen mijn afkortzaag heb ik van Metabo, daar ben ik ook heel blij mee.

HT&KK hier. Ben erg gecharmeerd van de Wesco lijn. Heb er inmiddels een behoorlijke collectie van. Schroef/boormachine, klopboor, slagschroefmachine, cirkelzaag en decoupeerzaag. Accu’s gaan voor mij lang genoeg mee en apparaten zijn voor mij krachtig genoeg.


Makita, altijd goede ervaringen mee gehad. Voor mij goede prijs/kwaliteit verhouding

Doe-het-zelver

Hikoki hier. Heb op mijn werk makita lxt en voel weinig verschil.

Klusjesman

Klusjesman hier. Ik gebruik alleen maar Makita LXT. Ik ben te gierig voor Festool.


Festool, Festool en Festool (16x)


Meeste merken zijn prima. Panasonic is geweldig maar erg duur en klein assortiment gereedschap.

Ik probeer het meeste bedraad te kopen als ik het toch maar af en toe gebruik.


Makita is een fijn merk. Al vind ik zelf Festool erg mooi. Is wel aan de prijs maar wel een top kwaliteit. Je ziet ook steeds meer milwaukee, maar heb daar geen ervaring mee.


Festool en Milwakee


Dewalt


Electrisch: Makita, Black en Decker was mijn starter maar na een keer Makita gebruikt te hebben toch heel snel geswitched

Niet electrisch: Beta


Niet elektrisch koop ik Stanley (MAX) vanwege de handgrepen. Ik heb erg grote handen en deze houden wel erg prettig vast.


Ik gebruik skil, tot nu toe heel tevreden mee


Ryobi door prijzen en hoeveelheid machines op 1 type accu (van welke het ontwerp niet veranderd)

Daarnaast gebruiken mijn favoriete youtubers het al vele jaren en ze zijn er erg positief over. Sinds kort worden ze gesponsord maar de 10 jaar daarvoor niet.

Helaas niet op veel plekken te koop. Alleen bij de Bauhaus of online shops. Gelukkig op marktplaats minder animo voor dus nog goedkoper met weinig concurrentie.

Overigens gebruik ik geen van mijn gereedschappen op een niveau dat ze stuk zouden gaan, huis uin en keuken- gebruik zegmaar.


Ik heb daar dus ook naar gekeken omdat de jongens van MCM ze altijd gebruiken en nu zelfs door ze gesponsord worden. De beschikbaarheid is alleen een stuk minder dan de grote merken Bosch, DeWalt en Makita, daarom niet gedaan.


Ik bedoelde MCM ook, maar dat had je al door :)

Beschikbaarheid hoeft toch niet perse een probleem te zijn? Online is genoeg te vinden (ook amazon).

Elektricien

Mijn accu gereedschap is allemaal van DeWalt. DeWalt heeft een hele fijne multitool op accu en in mijn ogen de beste slagschroevendraaiers op accu.

Mijn gereedschap met stekker is een mix van allerhande merken zoals WorX, Makita, DeWalt en Metabo.

Doe-het-zelver

Ligt er aan wat je wil doen. Zelf werk ik vooral met de Bosch 12v machines (schroefmachine, slijptol, cirkelzaag), deze zijn perfect als je vaak in krappe situaties moet werken. De Bosch GSR 12V-35 FC is mijn en ook mijn vaders favoriete schroefmachine door z'n kracht en de handige opzetstukken.

Voor de rest werken we voornamelijk met Makita 18v gereedschap.


Voor het werk jaren lang met makita 18V gewerkt. Eens in de 2 jaar ging de body van de slagtol of boor stuk en haalde je voor een paar tientjes een nieuwe. Voor thuis nu ook voor Makita gegaan, waar ik blij mee ben.
"""

# Specifieke zoekwoorden (klein geschreven)
merken = ['makita', 'dewalt', 'parkside performance', 'parkside', 'bosch', 'Bosch 12v','bosch profi', 
    'Black en Decker', 'Stanley (MAX)', 'stihl', 'festool', 'Milwaukee', 'Hitachi', 
    'Metabo', 'Ryobi', 'Hilti', 'Worx', 'Skil', 'AEG', 'Fein', 'Snap-on','Vonroc','Skil']

# Voer de functie uit
merk_resultaten, totaal_woorden = analyseer_tekst(tekst, merken)
print(f'Merkfrequenties: {merk_resultaten}')
print(f'Totaal aantal woorden: {totaal_woorden}')


# Sorting the dictionary by occurrence
sorted_tool_counts = dict(sorted(merk_resultaten.items(), key=lambda item: item[1], reverse=True))

# Creating the bar chart for the sorted data
plt.figure(figsize=(10, 8))
plt.barh(list(sorted_tool_counts.keys()), sorted_tool_counts.values(), color='skyblue')
plt.xlabel('Aantal stemmen')
plt.title('Gesorteerde Merkvoorkeur van Gereedschap')
plt.gca().invert_yaxis()  # Invert y-axis to show the highest count at the top
plt.show()