clear all
close all
clc

%%%----dane----------------------------------------------------------------
dane

disp("Masa wahadla: "+num2str(m)+"kg")
disp("Masa wozka: "+num2str(M)+"kg")
disp("Odleglosc sr. ciezkosci: "+num2str(L)+"m")
disp("Wspol. tarcia wiskotycznego: "+num2str(b)+"Ns/m")
disp(" ")
%%%---odczyt wag strojenia-------------------------------------------------
waga=load('wagi.mat');
global wp wk wf
wp=waga.wp; %waga przemieszczenia
wk=waga.wk; %waga k�ta
wf=waga.wf; %waga si�y generowanej przez nap�d uk�adu

disp("Wagi regulatora strojonego numerycznie")
disp("przemieszczenie liniowe: "+num2str(wp))
disp("przemieszczenie katowe: "+num2str(wk))
disp("sila napedu: "+num2str(wf))
disp(" ")
%%%---model w przestrzeni stan�w-------------------------------------------
rownania_stanu_wahadla_odw

%%%---sprawdzenie sterowalnosci i obserwowalnosci--------------------------

rz_sterowalnosci = rank(ctrb(A,B));
if rz_sterowalnosci==4
    disp("uklad sterowalny")
else
    disp("uklad niesterowalny")
end
disp(" ")

%%%---bieguny poczatkowe uk�adu zamkni�tego--------------------------------

bieguny_zam0(1)=-15*rand+5*rand*i;
bieguny_zam0(2)=real(bieguny_zam0(1))-imag(bieguny_zam0(1))*i;
bieguny_zam0(3)=-15*rand+5*rand*i;
bieguny_zam0(4)=real(bieguny_zam0(3))-imag(bieguny_zam0(3))*i;

%%%---sterowanie symulacj�-------------------------------------------------
global T_symulacji t_krok
T_symulacji=10; %czas symulacji
t_krok=0.01; %krok czasowy
czas=(0:t_krok:T_symulacji)'; %wektor czasu

%%%---zaklocenia-----------------------------------------------------------
zaklocenia;

%przygotowanie F_zaklocajacej do bloczka ToWorkspace i optymalizacji
F_zaklocajaca_sim = [czas, F_zaklocajaca];

%%%---optymalizacja--------------------------------------------------------

global K J iterator minJ K_best J_best
%K - wektor wzmocnie�
%J - wska�nik jako�ci
%iterator - liczba iteracji optymalizowanej funkcji

K0=acker(A,B,bieguny_zam0);%pocz�tkowa macierz wzmocnie�
K=K0;
iterator=0;
minJ=inf;

disp("Strojenie wahadla. Zaczekaj oko�o 1 min")
disp("W przypadku bledu programu sprobuj jeszcze raz. Algorytm nie jest w pelni stabilny")

K_opt = fminsearch('opt_itae_wahadlo_ackerman',K);

bieguny_zam=eig(A-B*K_opt);%kontrolne sprawdzenie biegun�w uk�adu zamkni�tego

disp("Zoptymalizowana macierz wzmocnien K: "+num2str(K_opt))

%%%---odczyt poprzednich nastaw z pliku nastawy.mat------------------------
nastawy=load('nastawy.mat');%odczyt zoptymalizowanego wektora wzmocnien z pliku nastawy.mat
J_old=nastawy.J_best;

%%%---zapis nastaw K_opt do pliku mat je�li s� lepsze od poprzednich-------
K_best = K_opt;
if(J_best<J_old)
    save('nastawy.mat','K_best','J_best')
    disp("Zapisano do pliku optymalnielsza macierz wzmocnien K")
else
    disp("Nie znaleziono bardziej optymalniejne warto�ci macierzy wzmocnien K w tej probie")
end

disp("Losowe punkty startowe. Kazde kolejne strojenie moze dac lepsze wyniki")
