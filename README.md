Projekt zaliczeniowy
=========================
Opis
-------------------------
Projekt ten stanowi narzędzie służące do przetwarzania obrazów poprzez wykorzystanie transformaty Fouriera oraz filtrów operujących w dziedzinie częstotliwości.

Głównym elementem projektu jest klasa `ProcessImage`, która zawiera metody umożliwiające manipulację obrazem. Konstruktor `ProcessImage` pozwala na wczytanie obrazu oraz zastosowanie na nim transformaty Fouriera. Dodatkowo klasa implementuje cztery główne rodzaje filtrów:
- filtr górnoprzepustowy (`highPassFilter`);
- filtr dolnoprzepustowy (`lowPassFilter`);
- filtr środkowo-przepustowy (`passBandFilter`);
- filtr środkowo-zaporowy (`passStopFilter`).

Każdy z tych filtrów można zastosować na obrazie za pomocą odpowiednich metod. Przefiltrowany obraz może być wyświetlony za pomocą metody `showFilteredImage`.

Autor
-------------------------
Radosław Pławecki
