import requests
from bs4 import BeautifulSoup
import re
from collections import Counter

def haal_pagina_inhoud_op(url):
    # Verkrijg de inhoud van de webpagina
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Verwijder scripts en stylesheets
    for script in soup(["script", "style"]):
        script.decompose()

    # Haal de tekst uit de HTML
    tekst = soup.get_text()
    return tekst

def tel_woorden_in_tekst(tekst):
    # Splits de tekst in woorden
    woorden = re.findall(r'\w+', tekst)
    # Tel de woorden
    aantal_woorden = len(woorden)
    return aantal_woorden

def tel_specifieke_woorden_in_tekst(tekst, zoekpatronen):
    tekst = tekst.lower()  # Maak de tekst klein geschreven
    woorden_telling = Counter(re.findall(r'\b(?:' + '|'.join(zoekpatronen) + r')\b', tekst, flags=re.IGNORECASE))
    return woorden_telling

# Voorbeeld URL
url = 'https://www.reddit.com/r/Klussers/comments/15ptow2/welk_merk_electrisch_gereedschap_heeft_jullie/'

tekst = haal_pagina_inhoud_op(url)
aantal_woorden = tel_woorden_in_tekst(tekst)

# Lijst van merken, inclusief merken met meerdere woorden
zoekpatronen = [
    'makita', 'dewalt', 'bosch', 'festool', 'stihl',
    'black and decker', 'parkside performance', 'parkside'
]

woord_frequenties = tel_specifieke_woorden_in_tekst(tekst, zoekpatronen)

print(f'Aantal woorden op {url}: {aantal_woorden}')
print("Frequentie van specifieke woorden:", woord_frequenties)
